<cfif structKeyExists(session, "userId")>
    <cfset userId = "#session.userId#">
    <cfset userName = "#session.name#">
<cfelse>
    <cflocation  url="index.cfm" addToken="no">
</cfif>

<cfset ContactList = entityLoad("contact_list", {UserId : userId})>

<cfset ContactList=QueryExecute("SELECT Photo, FirstName, LastName, EmailId, PhoneNumber FROM contact_list 
WHERE UserId = '#userId#'",[],{datasource="AddressBook"})>

<cfset spObj = spreadsheetNew("AddressBook", true)>

<cfset spreadsheetAddRows(spObj, ContactList, 1, 1, true, [""], true)>

<cfheader name="Content-Disposition" value="inline;filename=addressBook.xlsx">
<cfcontent type="application/vnd.ms-excel" variable="#SpreadSheetReadBinary(spObj)#">
