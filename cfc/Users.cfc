<cfcomponent persistent="true">
    <cfproperty  name="UserId" coloumn="UserId" fieldType="Id" generator="increment">
    <cfproperty  name="FullName" column="FullName" ormType="string">
    <cfproperty  name="UserName" column="UserName" ormType="string">
    <cfproperty  name="EmailId" column="EmailId" ormType="string">
    <cfproperty  name="Password" column="Password" ormType="string">

    <cffunction name="login" access="remote">
        <cfargument  name="userName" required="true">
        <cfargument  name="password" required="true">

        <cfquery datasource="AddressBook" name="login" result="loginResult">
            SELECT * FROM Users WHERE UserName = <cfqueryparam value="#arguments.userName#" cfSqlType="CF_SQL_LONGVARCHAR"> AND
            Password = <cfqueryparam value="#hash(arguments.password)#" cfSqlType="CF_SQL_LONGVARCHAR">
        </cfquery>
        
        <cfset recordCount = loginResult.recordCount>

        <cfif recordCount neq 0>
            <cfset session.name = "#login.FullName#">
            <cfset session.userId = "#login.UserId#">
            <cflocation  url="../ContactList.cfm" addtoken="no">
        <cfelse>
            <script>
                alert('Invalid username or password');
                window.location.href='../index.cfm';
            </script>
        </cfif>
    </cffunction>

    <cffunction  name="logout" access="remote">
        <cfset structDelete(session, "userId")>
        <cfset structDelete(session, "name")>    

        <cflocation  url="../index.cfm" addtoken="no">
    </cffunction>

    <cffunction name="addUser" access="private">
        <cfargument name="fullName" default="">
        <cfargument name="userName" default="">
        <cfargument name="emailId" default="">
        <cfargument name="password" default="">

        <cfquery datasource="AddressBook" name="addUser" result="addUserResult">
            Insert into Users (FullName, UserName, EmailId, Password)
            Values
            (<cfqueryparam value="#arguments.fullName#" cfSqlType="CF_SQL_LONGVARCHAR">,
            <cfqueryparam value="#arguments.userName#" cfSqlType="CF_SQL_LONGVARCHAR">,
            <cfqueryparam value="#arguments.emailId#" cfSqlType="CF_SQL_LONGVARCHAR">,
            <cfqueryparam value="#hash(arguments.password)#" cfSqlType="CF_SQL_LONGVARCHAR">)
        </cfquery>

        <cfreturn addUserResult.generatedkey>
    </cffunction>

    <cffunction name="loginCheck" access="private">
        <cfargument name="emailId">

        <cfquery datasource="AddressBook" name="loginCheck" result="loginCheckResult">
            SELECT * FROM Users WHERE EmailId = <cfqueryparam value="#arguments.emailId#" cfSqlType="CF_SQL_LONGVARCHAR">
        </cfquery>
        <cfset recordCount = loginCheckResult.recordCount>

        <cfreturn recordCount>
    </cffunction>

    <cffunction name="getUser" access="private">
        <cfargument name="emailId">
        <cfquery datasource="AddressBook" name="getUser" result="getUserResult">
            SELECT * FROM Users WHERE EmailId = <cfqueryparam value="#arguments.emailId#" cfSqlType="CF_SQL_LONGVARCHAR">        
        </cfquery>

        <cfreturn getUser>
    </cffunction>

    <cffunction name="googleLogin" access="remote">
        <cfset var loggedIn = false>
        <cfoauth
            Type="Google"
            clientid="584866817060-4orjhchr1l6acg6ai2aq5531l3vgj3i9.apps.googleusercontent.com" 
            scope="https://www.googleapis.com/auth/userinfo.email+https://www.googleapis.com/auth/userinfo.profile"
            secretkey="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" 
            result="googleLoginResult"  
            redirecturi="http://127.0.0.1:8500/AddressBook/cfc/Users.cfc?method=googleLogin">
            
            <cfset recordCount = loginCheck(googleLoginResult.other.email)>
            
            <cfif recordCount eq 0>
                <cfset userId = addUser(googleLoginResult.other.given_name, googleLoginResult.other.given_name, googleLoginResult.other.email)>
                
                <cfset session.name = "#googleLoginResult.other.given_name#">
                <cfset session.userId = "#userId#"> 
                <cfset var loggedIn = true>
            <cfelse>
                <cfset getUser = getUser(googleLoginResult.other.email)>

                <cfset session.name = getUser.FullName>
                <cfset session.userId = getUser.UserId>
                <cfset var loggedIn = true>
            </cfif>            
            <cflocation  url="../ContactList.cfm" addToken="no">
    </cffunction>

    <cffunction name="fbLogin" access="remote" returnformat='plain' returntype='any' output='true'>
        <cfargument name="emailId">
		<cfargument name="firstName">
		<cfargument name="lastName">

        <cfset FullName = "#firstName# #lastName#">

        <cfset recordCount = loginCheck(arguments.emailId)>

        <cfif recordCount eq 0>
            <cfset userId = addUser(FullName, arguments.firstName, arguments.emailId)>
            
            <cfset session.name = FullName>
            <cfset session.userId = userId> 
        <cfelse>
            <cfset getUser = getUser(arguments.emailId)>
            <cfset session.name = getUser.FullName>
            <cfset session.userId = getUser.UserId>
        </cfif>
    </cffunction>

    <cffunction name="regUser" access="remote">
        <cfargument name="fullName">
        <cfargument  name="emailId">
        <cfargument  name="userName">
        <cfargument  name="password">

        <cfset recordCount = loginCheck(arguments.emailId)>

        <cfif recordCount eq 0>
            <cfset userId = addUser(arguments.fullName, arguments.userName, arguments.emailId, arguments.password)>
            <cfset session.name = arguments.fullName>
            <cfset session.userId = userId> 
        <cfelse>
            <cfset getUser = getUser(arguments.emailId)>
            <cfset session.name = getUser.FullName>
            <cfset session.userId = getUser.UserId>
        </cfif>
        <cflocation  url="../ContactList.cfm" addToken="no">
    </cffunction>
</cfcomponent>