//Calculate user active time on logout.
$("a[id^='logout']").click(function(){
if(typeof(Storage) !== "undefined") {
		localStorage.logoutTime = new Date();
		if (localStorage.logoutTime < localStorage.loginTime) {
			localStorage.logoutTime.setDate(localStorage.logoutTime.getDate() + 1);
		}
		var diff = (new Date()).getTime() - (new Date(localStorage.loginTime)).getTime();
		var msec = Math.floor(diff * 0.001);
		postTimeLogged(msec);
	}
});

// Log time when user enters StackOverflow
$("a[id^='stackoverflow']").click(function(){
if(typeof(Storage) !== "undefined") {
      localStorage.loginTime = new Date();
	}
});

// View number of questions and hyperlinks user visited.
$("div[id^='question-summary-']").click(function(){
	postClickCount();
});

//Track text that user finds interesting
window.onmouseup = mouseup;
function mouseup() {
	getHighlightedText();
}

// Track number of upvotes by a user
$(".vote-up-off").click(function(){
	postVote();
});

//Track number of questions and answers posted by a user
$("button[id^='submit-button']").click(function(){
        postLinkCount();
});

// Function to save user's highlighted text
function getHighlightedText() {
	var text = '';
	if (window.getSelection) {
		text =  window.getSelection().toString();
	}
	if (text != ''){
		var texturl = 'https://127.0.0.1:8443/postSelectedText';
		 $.ajax({
				type: 'POST',
				url: texturl,
				data:JSON.stringify({"text" : text}),
				contentType:'application/json;charset=utf-8',
				success: function(response) {
				},
				error: function(error) {
					console.log('Unable to track activity. ' + error );
				}
			});
		}
	else return;
}

// Function to save user's different behaviors
function postClickCount(){
	var linkurl = 'https://127.0.0.1:8443/postClickCount';
	 $.ajax({
            type: 'POST',
            url: linkurl,
			contentType:'application/x-www-form-urlencoded;charset=utf-8',
			success: function(response) {
			},
            error: function(error) {
				console.log('Unable to track activity. ' + error );
			}
		});
}

// Function to save user's different behaviors
function postLinkCount(){
	var posturl = "https://127.0.0.1:8443/postLinkCount"
	 $.ajax({
            type: "POST",
            url: posturl,
			contentType:'application/x-www-form-urlencoded;charset=utf-8',
            success: function(response) {
			},
            error: function(error) {
				console.log('Unable to track activity. ' + error );
            }
		});
}

// Function to save user's different behaviors
function postTimeLogged(seconds){
	var timeurl = "https://127.0.0.1:8443/postTimeLogged/"+seconds
	 $.ajax({
            type: "POST",
            url: timeurl,
			contentType:'application/x-www-form-urlencoded;charset=utf-8',
            success: function(response) {
			},
            error: function(error) {
				console.log('Unable to track activity. ' + error );
            }
		});
}
function postVote(){
	var voteurl = "https://127.0.0.1:8443/postVote"
	 $.ajax({
			type: "POST",
			url: voteurl,
			contentType:'application/x-www-form-urlencoded;charset=utf-8',
			success: function(response) {
			},
			error: function(error) {
				console.log('Unable to track activity. ' + error );
			}
		});
}
