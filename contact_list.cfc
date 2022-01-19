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
</cfcomponent>