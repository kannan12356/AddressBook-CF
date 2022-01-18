<cfcomponent>
    <cffunction name="contactValidator">
        <cfargument name="form">

        <cfif form.title == "">
            <cfreturn 0>
        <cfelseif form.fName == "">
            <cfreturn 0>
        <cfelseif form.lName == "">
            <cfreturn 0>
        <cfelseif form.gender == "">
            <cfreturn 0>
        <cfelseif form.DOB == "">
            <cfreturn 0>
        <cfelseif form.address == "">
            <cfreturn 0>
        <cfelseif form.street == "">
            <cfreturn 0>
        <cfelseif form.phoneNumber == "">
            <cfreturn 0>
        <cfelseif form.emailId == "">
            <cfreturn 0>
        <cfelse>
            <cfreturn 1>
        </cfif>
    </cffunction>
</cfcomponent>