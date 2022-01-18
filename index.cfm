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
            <img
                src="assets/AddressBookIcon.png"
                alt="Address Book"
                >
        </div>
        <div class="login-details">
            <p class="title">LOGIN</p>

            <form class="form" action="" method="post">
                <input type="text" class="form-control" id="userName" name="userName" placeholder="User Name">
                <input type="password" class="form-control" id="password" name="password" placeholder="Password">
                <p id="message" style="color: red; font-size: 12px"></p>

                <button class="btn" name="login" id="loginBtn">LOGIN</button>

                <p class="sub-head">Or Sign In Using</p>

                <div class="social-btn">
                    <button class="rnd-btn fb">f</button>
                    <button class="rnd-btn google">G</button>
                </div>

                <p class="sub-head">Don't have an account? <a href="register.cfm">Register Here</a></p>
            </form>
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
    </script>
    
</body>
</html>

<cfif structKeyExists(form, "login")>
    <cfinvoke
        component="cloud"
        method="login"
        returnVariable="loginResult">
        <cfinvokeargument name="userName" value="#form.userName#">
        <cfinvokeargument  name="password"  value="#form.password#">
    </cfinvoke>
    <cfif loginResult neq 0>
        <cflocation  url="ContactList.cfm" addToken="no">
    <cfelse>
        <p style="color: red; text-align: center">Invalid user name or password</p>
    </cfif>
</cfif> 