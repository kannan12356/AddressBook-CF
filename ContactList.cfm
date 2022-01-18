<cfif structKeyExists(session, "userId")>
    <cfset userId = "#session.userId#">
    <cfset userName = "#session.name#">
<cfelse>
    <cflocation  url="index.cfm" addToken="no">
</cfif>

<cfinvoke 
    component="cloud"
    method="listContact"
    returnVariable="contactList">
    <cfinvokeargument  name="userId"  value="#userId#">
</cfinvoke>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/contactList.css">
    <title>Contact List</title>
</head>
<body>
    <cfinclude  template="header.cfm">
    <div class="contact-list">
        <div class="converter">
            <p style="color: red;"><i class="fa fa-file-pdf-o" aria-hidden="true"></i></p>
            <p style="color: green;"><i class="fa fa-file-excel-o" aria-hidden="true"></i></p>
            <p style="color: gray;"><i class="fa fa-print" aria-hidden="true"></i></p>
        </div>
        <div class="contact-details">
            <div class="user">
                <p><i class="fa fa-user-circle-o" aria-hidden="true"></i></p>
                <p>Kannan</p>
                <button class="createBtn" onclick="createContact()">Create Contact</button>
            </div>      
            <div class="Address-details">
                <table class="table">
                    <thead>
                        <th></th>
                        <th>Name</th>
                        <th>Email ID</th>
                        <th>Phone Number</th>
                    </thead>
                    
                    <cfoutput query="contactList">
                        <tr>
                            <td>
                                <cfif contactList.photo != "">
                                    <img
                                        class="userImg" 
                                        src="#contactList.photo#" 
                                        alt="user photo">
                                <cfelse>
                                    <i class="fa fa-user-circle-o" aria-hidden="true"></i>
                                </cfif>
                                
                            </td>
                            <td>
                                #contactList.FirstName# #contactList.LastName#
                            </td>
                            <td>
                                #contactList.EmailId#
                            </td>
                            <td>
                                #contactList.PhonenUmber#
                            </td>
                            <td>
                                <button class="btn" onclick="editContact(#contactList.personId#)">EDIT</button>
                            </td>
                            <td>
                                <button class="btn" onclick="deleteContact(#contactList.personId#)">DELETE</button>
                            </td>
                            <td>
                                <button class="btn" onclick="viewContact(#contactList.personId#)">VIEW</button>
                            </td>
                        </tr>
                    </cfoutput>
                </table>
            </div>      
        </div>
    </div>
    
    <div class="modal" id="modal">
        <span class="close" id="close">&times;</span>
        <div id="content"></div>
    </div>

    <script>
        function createContact(){
            document.getElementById("modal").style.display = "block";

            const xhttp = new XMLHttpRequest();
            xhttp.onload = function(){
                document.getElementById("content").innerHTML = this.responseText;
            }
            xhttp.open("GET", "CreateContact.cfm", true);
            xhttp.send();
        }

        function editContact(personId){
            document.getElementById("modal").style.display = "block";
            
            const xhttp = new XMLHttpRequest();
            xhttp.onload = function(){
                document.getElementById("content").innerHTML = this.responseText;
            }
            xhttp.open("GET", `EditContact.cfm?Id=${personId}`, true);
            xhttp.send();
        }

        function deleteContact(personId){
            document.getElementById("modal").style.display = "block";   

            const xhttp = new XMLHttpRequest();
            xhttp.onload = function(){
                document.getElementById("content").innerHTML = this.responseText;
            }
            xhttp.open("GET", `DeleteContact.cfm?Id=${personId}`, true);
            xhttp.send();
        }

        function viewContact(personId){
            document.getElementById("modal").style.display = "block";

            const xhttp = new XMLHttpRequest();
            xhttp.onload = function(){
                document.getElementById("content").innerHTML = this.responseText;
            }
            xhttp.open("GET", `ContactDetails.cfm?Id=${personId}`, true);
            xhttp.send();
        }

        function modalClose(){
            document.getElementById("modal").style.display = "none"
        }
        document.getElementById("close").addEventListener("click", modalClose);
    </script>
</body>
</html>