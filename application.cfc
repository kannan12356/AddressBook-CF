<cfcomponent>
    <cfset this.name = "AddressBook">
    <cfset this.sessionManagement = "true">
    <cfset this.loginStorage = "session">
    <cfset this.sessionTimeout = "#createTimespan(0,0,45,0)#">
    <cfset this.datasource = "AddressBook">
    <cfset this.ormEnabled = true>
    <cfset this.ormsettings = {}>
    <cfset this.invokeImplicitAccessor = true>
    <cfset this.logPath = expandPath("Cferror.log")>
    <cfset this.errorTemplate = "errorPage.cfm">
    
    <cffunction name="onRequest" returnType="void"> 
        <cfargument name="targetPage" type="String" required=true/> 
        <cfif !structKeyExists(session, 'userId')>
            <cfinclude  template="index.cfm">
        <cfelse>
            <cfinclude  template="#arguments.targetPage#">
        </cfif>
    </cffunction>

    <cffunction  name="onMissingTemplate" returnType="boolean">
        <cfargument type="string" name="targetPage" required=true/>

        <cftry>
            <cfheader statusCode = "404" statusText = "Page Not Found">
            
            <cflock timeout="5" scope="application">
                <cfset errorTemplate = this.errorTemplate>
            </cflock>            

            <cfinclude template = "#errorTemplate#">
        
            <cfreturn true />
        <cfcatch>
            <cfreturn false />
        </cfcatch>
        </cftry>
    </cffunction>
</cfcomponent>