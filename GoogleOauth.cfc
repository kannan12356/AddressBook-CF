<cfcomponent>
    <cffunction  name="googleMethod">
        <cfset var loggedIn = false>
        <cfoauth
            Type="Google"
            clientid="584866817060-4orjhchr1l6acg6ai2aq5531l3vgj3i9.apps.googleusercontent.com" 
            scope="https://www.googleapis.com/auth/userinfo.email+https://www.googleapis.com/auth/userinfo.profile"
            secretkey="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" 
            result="googleLoginResult"  
            redirecturi="http://127.0.0.1:8500/AddressBook/GoogleLogin.cfm">
            
            <cfset login_check = ormExecuteQuery( "FROM Users WHERE EmailId = '#googleLoginResult.other.email#'" ) />

            <cfif arrayIsEmpty(login_check) eq "yes">
                <cftransaction>
                    <cfset addUser = entityNew("Users", {FullName : "#googleLoginResult.other.given_name#", UserName : "#googleLoginResult.other.given_name#",
                    EmailId : "#googleLoginResult.other.email#", Password : ""})>        
                    <cfset entitySave(addUser)>
                </cftransaction>
                <cfset session.name = "#addUser.FullName#">
                <cfset session.userId = "#addUser.UserId#"> 
                <cfset var loggedIn = true>
            <cfelse>
                <cfset Users = entityLoad("Users", {EmailId : "#googleLoginResult.other.email#"}, true)>
                <cfset session.name = "#Users.FullName#">
                <cfset session.userId = "#Users.UserId#">
                <cfset var loggedIn = true>
            </cfif>
    </cffunction>
</cfcomponent>