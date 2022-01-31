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

    <cffunction name="updateContact" access="remote">
        <cfif form.userImg != "">        
            <cffile action="upload"
                fileField="userImg"
                destination="E:\ColdFusion\cfusion\wwwroot\AddressBook\userImage"
                result="imgName">
    
            <cfset userImg = "userImage/#imgName.clientFile#">
        <cfelse>
            <cfset userImg = form.userPhoto>
        </cfif>

        <cfquery datasource="AddressBook" name="update" result="updateReult">
            Update contact_list set 
            FirstName = <cfqueryparam value="#form.fName#">,
            LastName = <cfqueryparam value="#form.lName#">,
            Title = <cfqueryparam value="#form.title#">,
            Gender = <cfqueryparam value="#form.gender#">,
            DOB = <cfqueryparam value="#form.DOB#">,
            Photo = <cfqueryparam value="#userImg#">,
            Address = <cfqueryparam value="#form.address#">,
            Street = <cfqueryparam value="#form.street#">,
            EmailId = <cfqueryparam value="#form.emailId#">,
            PhoneNumber = <cfqueryparam value="#form.phoneNumber#">
            WHERE PersonId = <cfqueryparam value="#form.personId#">
        </cfquery>
        <cflocation  url="../ContactList.cfm" addToken="no">
    </cffunction>

    <cffunction name="deleteContact" access="remote">
        <cfif structKeyExists(form, "submit")>
            <cfif form.userImg != "">
                <cffile action="delete"
                    file="E:\ColdFusion\cfusion\wwwroot\AddressBook\#userImg#">            
            </cfif>

            <cfquery datasource="AddressBook" name="delete" result="deleteResult">
                DELETE from contact_list WHERE PersonId = <cfqueryparam value="#form.personId#">
            </cfquery>
            <cflocation url="../ContactList.cfm" addToken="no">
        </cfif>

        <cfif structKeyExists(form, "no")>
            <cflocation  url="../ContactList.cfm" addToken="no">
        </cfif>
    </cffunction>    

    <cffunction name="getUserContactList">
        <cfargument name="userId">

        <cfquery datasource="AddressBook" name="getContactList" result="getContactListResul">
            SELECT * FROM contact_list Where userId = <cfqueryparam value="#arguments.userId#">
        </cfquery>

        <cfreturn getContactList>
    </cffunction>

    <cffunction name="contactListContent" access="private">
        <cfargument  name="userId">
        <cfset contactList = getUserContactList(userId)>

        <cfsavecontent  variable="contactList">
            <table border="1" cellspacing="0" cellpadding="5" width="100%">
                <thead>
                    <th></th>
                    <th>Name</th>
                    <th>Email ID</th>
                    <th>Phone Number</th>
                </thead>
                <cfoutput query="contactList">
                    <tr>
                        <td>
                            <cfif photo != "">
                                <img class="userImg" src="../#photo#" alt="user photo">
                            <cfelse>
                                <i class="fa fa-user-circle-o" aria-hidden="true"></i>
                            </cfif>
                        </td>
                        <td>#FirstName# #LastName#</td>
                        <td>#EmailId#</td>
                        <td>#PhonenUmber#</td>
                    </tr>
                </cfoutput>
            </table>
        </cfsavecontent>

        <cfreturn contactList>
    </cffunction>

    <cffunction name="createPdf" access="remote">
        <cfargument  name="userId">

        <cfset contactList = contactListContent(userId)>

        <cfcontent type="application/pdf">
        <cfheader name="Content-Disposition" value="attachment;filename=AddressBook.pdf ">

        <cfdocument format="PDF">
            <cfoutput>
                <cfdocumentsection name="bookmark1">
                    <cfdocumentitem type="header">
                        <h1 style="text-align:center;">ADDRESS BOOK</h1>
                    </cfdocumentitem>
                        
                    <!DOCTYPE html>
                    <html lang="en">
                    <head>
                        <meta charset="UTF-8">
                        <meta http-equiv="X-UA-Compatible" content="IE=edge">
                        <meta name="viewport" content="width=device-width, initial-scale=1.0">
                        <link rel="stylesheet" href="../css/contactList.css">
                        <title>Pdf Document</title>
                    </head>
                    <body>
                        <div class="Address-details">#contactList#</div>      
                    </body>
                    </html>
                    
                    <cfdocumentitem type="footer">
                        <h1 style="text-align:center;">Page #cfdocument.currentPageNumber# of #cfdocument.totalPageCount#</h1>
                    </cfdocumentitem>
                </cfdocumentsection>
            </cfoutput>
        </cfdocument>
    </cffunction>

    <cffunction  name="createExcel" access="remote">
        <cfargument  name="userId">
        
        <cfset contactList = getUserContactList(userId)>

        <cfset spObj = spreadsheetNew("AddressBook", true)>

        <cfset spreadsheetAddRows(spObj, ContactList, 1, 1, true, [""], true)>

        <cfheader name="Content-Disposition" value="inline;filename=addressBook.xlsx">
        <cfcontent type="application/vnd.ms-excel" variable="#SpreadSheetReadBinary(spObj)#">
    </cffunction>

    <cffunction  name="print" access="remote">
        <cfargument  name="userId">

        <cfset contactList = contactListContent(userId)>

        <cfdocument format="PDF" name="AddressBook.pdf">
    
            <cfoutput>
                <cfdocumentitem type="header">
                    <h1 style="text-align:center;">ADDRESS BOOK</h1>
                </cfdocumentitem>
                    <!DOCTYPE html>
                    <html lang="en">
                    <head>
                        <meta charset="UTF-8">
                        <meta http-equiv="X-UA-Compatible" content="IE=edge">
                        <meta name="viewport" content="width=device-width, initial-scale=1.0">
                        <link rel="stylesheet" href="../css/contactList.css">
                        <title>Pdf Document</title>
                    </head>
                    <body>
                        <div class="Address-details">#contactList#</div>      
                    </body>
                </html>
                <cfdocumentitem type="footer">
                    <h1 style="text-align:center;">Page #cfdocument.currentPageNumber# of #cfdocument.totalPageCount#</h1>
                </cfdocumentitem>
            </cfoutput>

        </cfdocument>

        <cfprint type="pdf" source="AddressBook.pdf" printer="Microsoft Print to PDF">
    </cffunction>
</cfcomponent>