<cfcomponent persistent="true">
    <cfproperty  name="UserId" coloumn="UserId" fieldType="Id" generator="increment">
    <cfproperty  name="FullName" column="FullName" ormType="string">
    <cfproperty  name="UserName" column="UserName" ormType="string">
    <cfproperty  name="EmailId" column="EmailId" ormType="string">
    <cfproperty  name="Password" column="Password" ormType="string">
</cfcomponent>