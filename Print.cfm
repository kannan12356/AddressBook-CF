<cfif structKeyExists(session, "userId")>
    <cfset userId = "#session.userId#">
    <cfset userName = "#session.name#">
<cfelse>
    <cflocation  url="index.cfm" addToken="no">
</cfif>

<cfset ContactList = entityLoad("contact_list", {UserId : userId})>
<cfset jsonContact = serializeJSON(ContactList)>

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
                <link rel="stylesheet" href="css/contactList.css">
                <title>Pdf Document</title>
            </head>
            <body>
                <div class="Address-details">
                    <table border="1" cellspacing="0" cellpadding="5" width="100%">
                        <thead>
                            <th></th>
                            <th>Name</th>
                            <th>Email ID</th>
                            <th>Phone Number</th>
                        </thead>
                        <cfset personArray = deserializeJSON(jsonContact)>
                        <cfoutput>
                            <cfloop array="#personArray#" index="person">
                                <tr>
                                    <td>
                                        <cfif person.photo != "">
                                            <img
                                                class="userImg" 
                                                src="#person.photo#" 
                                                alt="user photo">
                                        <cfelse>
                                            <i class="fa fa-user-circle-o" aria-hidden="true"></i>
                                        </cfif>
                                    </td>
                                    <td>
                                        #person.FirstName# #person.LastName#
                                    </td>
                                    <td>
                                        #person.EmailId#
                                    </td>
                                    <td>
                                        #person.PhonenUmber#
                                    </td>
                                </tr>
                            </cfloop>
                        </cfoutput>
                    </table>
                </div>      
            </body>
        </html>
        <cfdocumentitem type="footer">
            <h1 style="text-align:center;">Page #cfdocument.currentPageNumber# of #cfdocument.totalPageCount#</h1>
        </cfdocumentitem>
    </cfoutput>
</cfdocument>

<cfprint type="pdf" source="AddressBook.pdf" printer="Microsoft Print to PDF">
