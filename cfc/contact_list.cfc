<cfcomponent persistent="true">
    <cfproperty  name="PersonId" column="PersonId" fieldType="id" generator="increment">
    <cfproperty  name="UserId" column="UserId">
    <cfproperty  name="FirstName" column="FirstName">
    <cfproperty  name="LastName" column="LastName">
    <cfproperty  name="Title" column="Title">
    <cfproperty  name="Gender" column="Gender">
    <cfproperty  name="DOB" column="DOB">
    <cfproperty  name="Photo" column="Photo">
    <cfproperty  name="Address" column="Address">
    <cfproperty  name="Street" column="Street">
    <cfproperty  name="EmailId" column="EmailId">
    <cfproperty  name="PhoneNumber" column="PhoneNumber"> 

    <cffunction name="createContact" access="remote">
        <cfif form.userImg != "">
            <cffile action="upload"
                fileField="userImg"
                destination="E:\ColdFusion\cfusion\wwwroot\AddressBook\userImage"
                result="imgName">
            <cfset img = "userImage/#imgName.clientFile#">
        <cfelse>
            <cfset img = "">
        </cfif>

        <cfquery datasource="AddressBook" name="addContact" result="addContactResult">
            Insert into contact_list (UserId, FirstName, LastName, Title, Gender, DOB, Photo, Address, Street, EmailId, PhoneNumber)
            Values
            (<cfqueryparam value="#form.userId#" cfSqlType="CF_SQL_INTEGER">,
            <cfqueryparam value="#form.fName#" cfSqlType="CF_SQL_LONGVARCHAR">,
            <cfqueryparam value="#form.lName#" cfSqlType="CF_SQL_LONGVARCHAR">,
            <cfqueryparam value="#form.title#" cfSqlType="CF_SQL_LONGVARCHAR">,
            <cfqueryparam value="#form.gender#" cfSqlType="CF_SQL_LONGVARCHAR">,
            <cfqueryparam value="#form.dob#" cfSqlType="CF_SQL_LONGVARCHAR">,
            <cfqueryparam value="#img#" cfSqlType="CF_SQL_LONGVARCHAR">,
            <cfqueryparam value="#form.address#" cfSqlType="CF_SQL_LONGVARCHAR">,
            <cfqueryparam value="#form.street#" cfSqlType="CF_SQL_LONGVARCHAR">,
            <cfqueryparam value="#form.emailId#" cfSqlType="CF_SQL_LONGVARCHAR">,
            <cfqueryparam value="#form.phoneNumber#" cfSqlType="CF_SQL_LONGVARCHAR">)
        </cfquery>
        <cflocation url="../ContactList.cfm" addtoken="no">
    </cffunction>
</cfcomponent>