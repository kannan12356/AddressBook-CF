<cfcomponent>
	<cffunction name="addUserData" access='remote' returnformat='plain' returntype='any' output='true'>
		<cfargument name="emailId">
		<cfargument name="firstName">
		<cfargument name="lastName">
			<cfset login_check = ormExecuteQuery( "FROM Users WHERE EmailId = '#arguments.emailId#'" ) />
			
			<cfset FullName = "#firstName# #lastName#">
			<cfif arrayIsEmpty(login_check) eq "yes">
                <cftransaction>
                    <cfset addUser = entityNew("Users", {FullName : "#FullName#", UserName : "#arguments.firstName#",
                    EmailId : "#arguments.emailId#", Password : ""})>        
                    <cfset entitySave(addUser)>
                </cftransaction>
                <cfset session.name = "#addUser.FullName#">
                <cfset session.userId = "#addUser.UserId#"> 
                <cfset var loggedIn = true>
            <cfelse>
                <cfset Users = entityLoad("Users", {EmailId : "#arguments.emailId#"}, true)>
                <cfset session.name = "#Users.FullName#">
                <cfset session.userId = "#Users.UserId#">
                <cfset var loggedIn = true>
            </cfif>
	</cffunction>
</cfcomponent>