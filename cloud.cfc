<cfcomponent>
    <cffunction name="register" returnType="any">
        <cfargument  name="form">

        <cfquery datasource="AddressBook" name="selectEmailId">
            SELECT EmailId FROM users WHERE EmailId="#form.emailId#"
        </cfquery>
        <cfset noOfRecords = selectEmailId.recordcount>

        <cfif noOfRecords eq 0>
            <cfset password = form.password>
            <cfquery datasource="AddressBook" name="register" result="regResult">
                INSERT INTO users (FullName, UserName, EmailId, Password) 
                VALUES 
                ('#form.FullName#', '#form.userName#', '#form.emailId#', '#hash(form.password)#')
            </cfquery>
            <cfset session.name = "#form.FullName#">
            <cfset session.userId = "#regResult.generatedKey#">
        </cfif>
        
        <cfreturn noOfRecords>
    </cffunction>

    <cffunction  name="login" returnType="any">
        <cfargument name="userName">
        <cfargument name="password">
        
        <cfquery datasource="AddressBook" name="loginResult">
            SELECT * FROM users WHERE UserName = "#arguments.userName#" AND Password = "#hash(arguments.password)#"
        </cfquery>
        <cfset noOfRecords = "#loginResult.recordCount#">

        <cfif noOfRecords neq 0>
            <cfset session.name = "#loginResult.FullName#">
            <cfset session.userId = "#loginResult.UserId#">
        </cfif>
        <cfreturn noOfRecords>
    </cffunction>

    <cffunction name="createContact" returnType="any">
        <cfargument name="form">

        <cfif form.userImg != "">
            <cffile action="upload"
                fileField="userImg"
                destination="E:\ColdFusion\cfusion\wwwroot\AddressBook\userImage"
                result="imgName">
            <cfset img = "userImage/#imgName.clientFile#">
        <cfelse>
            <cfset img = "">
        </cfif>
        
        <cfquery datasource="AddressBook" name="createContact" result="createContact">
            INSERT INTO contact_list (UserId, FirstName, LastName, Title, Gender, DOB, Photo, 
            Address, Street, EmailId, PhoneNumber)
            VALUES
            ("#form.userId#", "#form.fName#", "#form.lName#", "#form.title#", "#form.gender#", "#form.DOB#", "#img#", 
            "#form.address#", "#form.street#", "#form.emailId#", "#form.phoneNumber#")
        </cfquery>    
    </cffunction>

    <cffunction  name="listContact" returnType="any">
        <cfargument  name="userId">
        <cfquery datasource="AddressBook" name="contactList">
            SELECT * FROM contact_list WHERE userId = "#userId#"
        </cfquery>
        <cfreturn contactList>
    </cffunction>

    <cffunction  name="contactDetails" returnType="any">
        <cfargument  name="personId">
        <cfquery datasource="AddressBook" name="personDetails">
            SELECT * FROM contact_list WHERE personId = "#personId#"
        </cfquery>
        <cfreturn personDetails>
    </cffunction>

    <cffunction  name="updateContact" returnType="any">
        <cfargument name="form">
        
        <cfif form.userImg != "">
            <cffile action="upload"
                fileField="userImg"
                destination="E:\ColdFusion\cfusion\wwwroot\AddressBook\userImage"
                result="imgName">
            <cfset userImg = "userImage/#imgName.clientFile#">
        <cfelse>
            <cfset userImg = form.userPhoto>
        </cfif>
        
        <cfquery datasource="AddressBook" name="contactUpdate">
            UPDATE contact_list set userId = "#form.userId#", FirstName="#form.fName#", LastName="#lName#", Title="#title#",
            Gender="#form.gender#", DOB="#form.dob#", Photo="#userImg#", Address="#address#", Street="#form.street#",
            EmailId="#form.emailId#", PhoneNumber="#form.phoneNumber#" WHERE PersonId = "#form.PersonId#"
        </cfquery>
    </cffunction>

    <cffunction  name="deleteContact" returnType="any">
        <cfargument  name="personId">
        <cfargument  name="userImg">
        <cfif form.userImg != "">
            <cffile action="delete"
	            file="E:\ColdFusion\cfusion\wwwroot\AddressBook\#userImg#">            
        </cfif>
        
        <cfquery datasource="AddressBook" name="deleteContact">
            DELETE FROM contact_list WHERE PersonId = "#personId#"
        </cfquery>
    </cffunction>
</cfcomponent>