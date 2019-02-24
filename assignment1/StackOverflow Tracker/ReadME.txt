Pre-requisites:
1. Installed flask and modules - flask, datetime, os, MySQL, flask_cors, OpenSSL, json
2. Installed MySQL, Python3
3. Chrome Browser

Steps to Install and Setup Application:
1. Setup the database dump.
2. Path to SSL certificate and key to be changed in main.py ( Cert and Key placed in static folder of the project)
3. Install chrome extension by: 
	a) Switch Chrome developer tools 
	b) Click on 'Load unpacked' and select 'StackOverflow Tracker' folder in the project. 
4. Start flask application by navigating to main.py
5. On hitting index endpoint: https://localhost:8443/index, Click on Advanced and Proceed to unsafe option and accept certificate.

Insights on interactive behavior are below the visualization chart on the home page after user login.

aaa - 0 upvotes, 0 hyperlinks, timespent: long
bbb - 10 upvotes, 3 questions & answers, timespent: short
ccc - 5 upvotes, time spent between 2 am and 4am
