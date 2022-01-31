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
            <cfinclude  template="index.cfm">
        <cfelse>
            <cfinclude  template="#arguments.targetPage#">
        </cfif>
    </cffunction>
</cfcomponent>