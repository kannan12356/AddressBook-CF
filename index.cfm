<cfif structKeyExists(session, "userId")>
    <cfset structDelete(session, "userId")>
    <cfset structDelete(session, "name")>    
</cfif>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/login.css">
    <title>Address Book</title>
</head>
<body>
    
    <cfinclude  template="header.cfm">
    
    <div class="login-card">
        <div class="book-img">
            <img src="assets/AddressBookIcon.png" alt="Address Book">
        </div>

        <div class="login-details">
            <p class="title">LOGIN</p>

            <form class="form" action="cfc/Users.cfc?method=login" method="post">
                <input type="text" class="form-control" id="userName" name="userName" placeholder="User Name">
                <input type="password" class="form-control" id="password" name="password" placeholder="Password">
                <p id="message"></p>
                <button class="btn" name="login" id="loginBtn">LOGIN</button>
            </form>

            <div class="social-btn">
                <a href="javascript:void(0);" onclick="FbLogin();" id="fbLink">
                    <button class="rnd-btn fb" name="fb">f</button>
                </a>
                <a href="cfc/Users.cfc?method=googleLogin">
                    <button class="rnd-btn google" name="google">G</button>
                </a>
            </div>

            <p class="sub-head">Or Sign In Using</p>
            <p class="sub-head">Don't have an account? <a href="register.cfm">Register Here</a></p>
        </div>
    </div>  

    <script>

        document.getElementById("loginBtn").disabled = true;

        function userEnter(){
            var userName = document.getElementById("userName").value;
            var password = document.getElementById("password").value;

            if(userName != "" && password != ""){
                document.getElementById("loginBtn").disabled = false;
                document.getElementById("message").innerHTML = ""
            }
            else{
                document.getElementById("loginBtn").disabled = true;
                document.getElementById("message").innerHTML = "Please fill username and password"
            }
        }

        document.getElementById("password").addEventListener("change", userEnter);
        document.getElementById("userName").addEventListener("change", userEnter);

        //login with fb
        window.fbAsyncInit = function() {
            FB.init({
            appId      : '2505849812882244',
            xfbml      : true,
            version    : 'v12.0'
            });
            FB.AppEvents.logPageView();
        };

        (function(d, s, id){
            var js, fjs = d.getElementsByTagName(s)[0];
            if (d.getElementById(id)) {return;}
            js = d.createElement(s); js.id = id;
            js.src = "https://connect.facebook.net/en_US/sdk.js";
            fjs.parentNode.insertBefore(js, fjs);
        }(document, 'script', 'facebook-jssdk'));
      
        function FbLogin() {
            FB.login(function (response) {
                if (response.authResponse) {
                    getFbUserData();
                } else {
                    document.getElementById('status').innerHTML = 'User cancelled login or did not fully authorize.';
                }
            }, {scope: 'email'});
        }
      
        function getFbUserData(){
            FB.api('/me', {locale: 'en_US', fields: 'id,first_name,last_name,email,link,gender,locale,picture'},
            function (response) {                
                saveUserData(response);                
            });
        }

        // Save user data to the database
        function saveUserData(userData){
            var data = JSON.stringify(userData);

            const xhttp = new XMLHttpRequest();
            xhttp.onload = function(){
                window.location.href = "ContactList.cfm"
            }
            xhttp.open("POST", "cfc/Users.cfc?method=fbLogin&emailId="+userData.email+"&firstName="+userData.first_name+"&lastName="+userData.last_name, true);
            xhttp.send();
        }        
    </script>
    
</body>
</html>