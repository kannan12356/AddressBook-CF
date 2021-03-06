<cfset userId = "#session.userId#">
<cfset userName = "#session.name#">

<cfinvoke
    component="cfc/contact_list"
    method="getUserContactList"
    returnVariable="contactList">
    <cfinvokeargument  name="userId"  value="#userId#">
</cfinvoke>

<cfsavecontent  variable="contactList">
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
                    <cfif photo != "">
                        <img class="userImg" src="#photo#" alt="user photo">
                    <cfelse>
                        <i class="fa fa-user-circle-o" aria-hidden="true"></i>
                    </cfif>
                </td>
                <td>#FirstName# #LastName#</td>
                <td>#EmailId#</td>
                <td>#PhonenUmber#</td>
                <td><button class="btn" onclick="editContact(#personId#)">EDIT</button></td>
                <td><button class="btn" onclick="deleteContact(#personId#)">DELETE</button></td>
                <td><button class="btn" onclick="viewContact(#personId#)">VIEW</button></td>
            </tr>
        </cfoutput>
    </table>
</cfsavecontent>

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
        <cfoutput>
            <div class="converter">
                <a href="cfc/contact_list.cfc?method=createPdf&userId=#userId#">
                    <p class="pdf-icon"><i class="fa fa-file-pdf-o" aria-hidden="true"></i></p>
                </a>
                <a href="cfc/contact_list.cfc?method=createExcel&userId=#userId#">
                    <p class="excel-icon"><i class="fa fa-file-excel-o" aria-hidden="true"></i></p>
                </a>
                <a href="cfc/contact_list.cfc?method=print&userId=#userId#">
                    <p class="print-icon"><i class="fa fa-print" aria-hidden="true"></i></p>
                </a>
            </div>
            <div class="contact-details">
                <div class="user">
                    <p><i class="fa fa-user-circle-o" aria-hidden="true"></i></p>
                    <p>#userName#</p>
                    <button class="createBtn" onclick="createContact()">Create Contact</button>
                </div>      
                <div class="Address-details">
                    #contactList#        
                </div>      
            </div>
        </cfoutput>
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