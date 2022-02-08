<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="css/header.css">
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="header">
        <div class="logo">
            <img src="assets/AddressBookIcon.png" class="address-book-icon" alt="Address book icon">
            <p>ADDRESS BOOK</p>
        </div>
        
        <div class="menu">
            <cfif structKeyExists(session, 'userId')>
                <cfoutput>
                    <p><i class="fa fa-user" aria-hidden="true"></i> #session.name#</p>
                </cfoutput>
                <a href="cfc/Users.cfc?method=logout">
                    <p><i class="fa fa-sign-out" aria-hidden="true"></i> Logout</p>
                </a>
            <cfelse>
                <a href="register.cfm">
                    <p><i class="fa fa-user" aria-hidden="true"></i> Sign Up</p>
                </a>
                <a href="index.cfm">
                    <p><i class="fa fa-sign-in" aria-hidden="true"></i> Login</p>
                </a>
            </cfif>
        </div>
    </div>
</body>
</html>