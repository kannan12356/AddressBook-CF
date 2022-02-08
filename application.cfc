<cfcomponent>
    <cfset this.name = "AddressBook">
    <cfset this.sessionManagement = "true">
    <cfset this.loginStorage = "session">
    <cfset this.sessionTimeout = "#createTimespan(0,0,45,0)#">
    <cfset this.datasource = "AddressBook">
    <cfset this.ormEnabled = true>
    <cfset this.ormsettings = {}>
    <cfset this.invokeImplicitAccessor = true>
    
    <cffunction name="onRequest" returnType="void"> 
        <cfargument name="targetPage" type="String" required=true/> 
        <cfif !structKeyExists(session, 'userId')>
            <cfif arguments.targetPage eq "/AddressBook/index.cfm">
                <cfinclude  template="index.cfm">
            <cfelse>
                <cfinclude  template="register.cfm">
            </cfif>
            
        <cfelse>
            <cfinclude  template="#arguments.targetPage#">
        </cfif>
    </cffunction>

    <cffunction  name="onError">
        <cfargument  name="exception">
        <cfargument  name="eventName">

        <cfset writeOutput("<h2>An unexpected error occurred.</h2>
		    <p>Please provide the following information to technical support:</p>
		    <p>Error Event: #eventName#</p>
		    <p>Error details: #exception.message#<br>'")>

    </cffunction>

    <cffunction  name="onMissingTemplate">
        <cfset writeOutput("<h2>Page not found</h2>")>
    </cffunction>
</cfcomponent>