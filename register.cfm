<cfif structKeyExists(form, 'register')>

    <cfset Users = entityLoad("Users", {EmailId : form.emailId})>

    <cfset arrayLength = arrayLen(Users)>
    
    <cfif arrayLength eq 0>
        <cftransaction>
            <cfset User = entityNew("Users", {fullName : form.FullName, userName : form.userName, emailId : form.emailId, password : hash(form.password)})>
            <cfset entitySave(User)>
        </cftransaction>  
        
        <cfset session.name = "#User.FullName#">
        <cfset session.userId = "#User.UserId#">  
        <cflocation  url="ContactList.cfm" addToken="no">
    <cfelse>
        <cflocation  url="index.cfm" addtoken="no">
    </cfif>
</cfif>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/register.css">
    <title>Register</title>
</head>
<body>

    <cfinclude  template="header.cfm">    
    
    <div class="register-card">
        <div class="book-img">
            <img 
                src="assets/AddressBookIcon.png"
                alt="Address Book"
                >
        </div>
        <div class="register-details">
            <p class="title">SIGN UP</p>

            <form class="form" action="" method="post">
                <input type="text" class="form-control" name="fullName" placeholder="Full Name">
                <input type="text" class="form-control" name="emailId" placeholder="Email ID">
                <input type="text" class="form-control" name="userName" placeholder="User Name">
                <input type="password" class="form-control" id="password" name="password" placeholder="Password">
                <input type="password" class="form-control" id="cPassword" name="confirmPassword" placeholder="Confirm Password">

                <p id="message" style="color: red; font-size: 12px"></p>

                <button class="btn" name="register" id="registerBtn">REGISTER</button>
            </form>
        </div>
    </div>

    <script>
        document.getElementById("registerBtn").disabled = true

        function checkPassword(){
            var password = document.getElementById("password").value;
            var cPassword = document.getElementById("cPassword").value
            
            if(password == cPassword){
                document.getElementById("registerBtn").disabled = false
                document.getElementById("message").innerHTML = ""
            }
            else{
                document.getElementById("registerBtn").disabled = true
                document.getElementById("message").innerHTML = "Password not matched"
            }
        }

        document.getElementById("cPassword").addEventListener("change", checkPassword);
        
    </script>

</body>
</html>