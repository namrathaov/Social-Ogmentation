from flask import Flask, redirect, url_for, request, render_template, session, make_response
from datetime import datetime as dt
import os
from flaskext.mysql import MySQL
from flask_cors import CORS, cross_origin
from OpenSSL import SSL,crypto
import json,requests
app = Flask(__name__)

# Database Config parameters
mysql = MySQL()
app.config['MYSQL_DATABASE_USER'] = 'root'
app.config['MYSQL_DATABASE_PASSWORD'] = 'root123'
app.config['MYSQL_DATABASE_DB'] = 'app'
app.config['MYSQL_DATABASE_HOST'] = 'localhost'

# Enable Cross Origin
app.config['CORS_HEADERS'] = 'Content-Type'

cors = CORS(app, resources={r"/*": {"origins": "*"}})

mysql.init_app(app)

# Endpoint for application welcome page
@app.route('/index', methods=['GET', 'POST'])
def index():
    error = None
    return render_template('signup.html', error=error)

# Endpoint for application signup page
@app.route('/signup', methods=['GET', 'POST'])
def signup():   
    error = None
    session['id']=-1
    if request.method == 'POST':
        if request.form['username']=="" or request.form['password']=="":
            error = "Username and Password cannot be null"
            return render_template('signup.html', error=error)
        conn = mysql.connect()
        cursor =conn.cursor()
        cursor.execute("SELECT * from users where name='"+request.form['username']+"'")
        data = cursor.fetchone()
        cursor.execute("SELECT max(id) from users")
        maxkey = cursor.fetchone()
        if data == []:
            session['logged_in']=True
            return redirect(url_for('home',name=request.form['username']))
        else:
            q ="INSERT INTO users(id,name,password,last_login_date,account_created) values("+str(maxkey[0]+1)+",'"+request.form['username']+"', '"+request.form['password']+"',now(),now())"
            cursor.execute(q)
            cursor.execute("commit")
            q ="INSERT INTO login_history(id,login_date) values("+str(maxkey[0]+1)+", now())"
            cursor.execute(q)
            cursor.execute("commit")
            Flag = True
            session['logged_in']=True
            return render_template('home.html', name=request.form['username'])
    return render_template('login.html', error=error)

# Endpoint for application login page
@app.route('/login', methods=['GET', 'POST'])
def login():
    if 'logged_in' in session and session['logged_in'] == True and 'username' in session:
        return redirect(url_for('home',name=session['username']))
    error = None
    Flag = False
    if request.method == 'POST':
        conn = mysql.connect()
        cursor =conn.cursor()
        cursor.execute("SELECT * from users")
        data = cursor.fetchall()
        for row in data:
            if request.form['username'] == row[1] and request.form['password'] == row[2]:
                Flag = True
                session['logged_in']=True
                conn = mysql.connect()
                cursor =conn.cursor()
                cursor.execute("SELECT id,last_login_date from users where name='"+row[1]+"'")
                user_info = cursor.fetchone()
                session['last_login']=user_info[1]
                cursor.execute("UPDATE users SET last_login_date=now() where id="+str(user_info[0]))
                cursor.execute("commit")
                session['id']=user_info[0]
                session['username']=request.form['username']
                q ="INSERT INTO login_history(id,login_date) values("+str(user_info[0])+",now())"
                cursor.execute(q)
                cursor.execute("commit")
                return redirect(url_for('home',name=request.form['username']))
            elif request.form['username'] == row[1] and request.form['password'] != row[2]:
                Flag = False
                error = 'Invalid Credentials. Please try again.'
                return render_template('login.html', error=error)
            elif request.form['username'] != row[1] and request.form['password'] != row[2]:
                Flag = False
                error = 'New User'
        if not Flag and error=='New User':
            return render_template('signup.html')
    return render_template('login.html', error=error)

# Endpoint for User home page
@app.route('/home/<name>', methods=['GET', 'POST'])
def home(name):
    if not session.get('logged_in'):
        return render_template('login.html')
    return render_template('home.html', name=name, id=session['id'], last_login_date = session['last_login'])

# Endpoint for user logout
@app.route("/logout")
def logout():
    session['logged_in'] = False
    return redirect(url_for('login'))

# Endpoint to track clicks
@app.route("/postClickCount", methods=['POST'])
def postClickCount():
    conn = mysql.connect()
    cursor =conn.cursor()
    cursor.execute("SELECT id from login_history order by login_date desc")
    userid = cursor.fetchone()
    cursor.execute("INSERT INTO user_activity values("+str(userid[0])+",now(),'linksvisited',1,'')")
    cursor.execute("commit")
    return 'success'

# Endpoint to track highlight texts
@app.route("/postSelectedText", methods=['GET','POST'])
def postSelectedText():
    clicked=(request.data)
    clicked = clicked.decode('utf-8')
    clicked = json.loads(clicked)
    conn = mysql.connect()
    cursor =conn.cursor()
    cursor.execute("SELECT id from login_history order by login_date desc")
    userid = cursor.fetchone()
    cursor.execute("INSERT INTO user_activity values("+str(userid[0])+", now(),'highlight',0,'"+clicked['text']+"')")
    cursor.execute("commit")
    return 'success'

# Endpoint to track number of questions and answers posted by user
@app.route("/postLinkCount", methods=['POST'])
def postLinkCount():
    conn = mysql.connect()
    cursor =conn.cursor()
    cursor.execute("SELECT id from login_history order by login_date desc")
    userid = cursor.fetchone()
    cursor.execute("INSERT INTO user_activity values("+str(userid[0])+",now(),'questionsandanswers',1,'')")
    cursor.execute("commit")
    return 'success'

# Endpoint to track total upvotes of a user
@app.route("/postVote", methods=['POST'])
def postVote():
    conn = mysql.connect()
    cursor =conn.cursor()
    cursor.execute("SELECT id from login_history order by login_date desc")
    userid = cursor.fetchone()
    cursor.execute("INSERT INTO user_activity values("+str(userid[0])+",now(),'upvotecount',1,'')")
    cursor.execute("commit")
    return 'success'

# endpoint to track total time logged by the user in the application
@app.route("/postTimeLogged/<seconds>", methods=['POST'])
def postTimeLogged(seconds):
    conn = mysql.connect()
    cursor =conn.cursor()
    cursor.execute("SELECT id from login_history order by login_date desc")
    userid = cursor.fetchone()
    cursor.execute("INSERT INTO user_activity values("+str(userid[0])+",now(),'activetime','"+seconds+"','')")
    cursor.execute("commit")
    return 'success'

# Endpoint to view user behaviour
@app.route("/profile",methods=['POST','GET'])
def profile():
    if request.method == 'POST':
        if request.form['fromtime']!='':
            fromtime = (request.form['fromtime'])
            totime = (request.form['totime'])
            conn = mysql.connect()
            cursor =conn.cursor()
            cursor.execute("SELECT id from login_history order by login_date desc")
            userid = cursor.fetchone()
            q = "select activity_type, sum(activity_result) from user_activity where id="+str(userid[0])+" and HOUR(time_logged)>='"+fromtime+"' and HOUR(time_logged)<= '"+totime+"' group by activity_type"
            cursor.execute(q)
            res={}
            for item in cursor.fetchall():
                res[item[0]]=int(item[1])
            cursor.execute("SELECT sum(activity_result) from user_activity where id="+str(userid[0])+" and activity_type='activetime'")
            activetime = cursor.fetchone()
            if activetime==None:
                activetime = 0
            q = "select activity_type, sum(activity_result) from user_activity where id="+str(userid[0])+" and HOUR(time_logged)>='"+fromtime+"' and HOUR(time_logged)<= '"+totime+"' group by activity_type"
            cursor.execute(q)
            return render_template('profile.html',res=res,activetime=int(activetime[0]))
    else:
        conn = mysql.connect()
        cursor =conn.cursor()
        cursor.execute("SELECT id from login_history order by login_date desc")
        userid = cursor.fetchone()
        cursor.execute("select activity_type, sum(activity_result) from user_activity where id="+str(userid[0])+" group by activity_type")
        res={}
        for item in cursor.fetchall():
            res[item[0]]=int(item[1])
        cursor.execute("SELECT sum(activity_result) from user_activity where id="+str(userid[0])+" and activity_type='activetime'")
        activetime = cursor.fetchone()
        if activetime==None:
            activetime = 0
        return render_template('profile.html',res=res,activetime=int(activetime[0]))

# Endpoint to view all user text highlights
@app.route("/highlights", methods=['GET','POST'])
def highlights():
    conn = mysql.connect()
    cursor =conn.cursor()
    cursor.execute("SELECT id from login_history order by login_date desc")
    userid = cursor.fetchone()
    reading = '<ul>'
    cursor.execute("SELECT highlight_text from user_activity where id="+str(userid[0])+" and activity_type='highlight'")
    rec = cursor.fetchall()
    for i in rec:
        reading+='<li>'
        reading += (''.join(i[0]))+'</li><br>'
    return '<a href="/logout">Logout here! </a> <h3>Your reading highlights: </h3>'+reading+'</ul>'

# SSL Certificate and Key required for https
# Run app with secret key
if __name__ == '__main__':
   app.secret_key = os.urandom(12)
   sslcert='C:/Users/ovnam/Courses/Fall 18/591- Assign1-py3/static/host.cert'
   sslkey='C:/Users/ovnam/Courses/Fall 18/591- Assign1-py3/static/host.key'
   app.run(debug = True,host='127.0.0.1',port='8443',ssl_context=(sslcert,sslkey))