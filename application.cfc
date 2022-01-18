<cfcomponent>
    <cfset this.name = "AddressBook">
    <cfset this.sessionManagement = "true">
    <cfset this.loginStorage = "session">
    <cfset this.sessionTimeout = "#createTimespan(0,0,45,0)#">
    <cfset this.datasource = "AddressBook">
    <cfset this.ormEnabled = true>
    <cfset this.ormSettings = {logsql : true}>
</cfcomponent>