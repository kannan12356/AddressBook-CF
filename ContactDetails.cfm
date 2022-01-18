<cfif structKeyExists(url, "Id")>
    <cfset personId = url.Id>
    
    <cfinvoke  
        component="cloud"
        method="contactDetails"
        returnVariable="Details">
        <cfinvokeargument  name="personId"  value="#personId#">
    </cfinvoke>

    <div class="modal-content">
        <div class="contact">
            <div class="modal-head">
                <p class="title" style="font-weight: bold;">Contact Details</p>
            </div>
            
            <cfoutput>
                <div class="person-details">
                    <div class="person-div">
                        <p class="contact-label">Name</p>
                         : 
                        <p class="detail">#Details.FirstName# #Details.LastName#</p>
                    </div>
                    <div class="person-div">
                        <p class="contact-label">Gender</p>
                        :
                        <p class="detail">#Details.Gender#</p>
                    </div>
                    <div class="person-div">
                        <p class="contact-label">Date of Birth</p>
                         : 
                        <p class="detail">#Details.DOB#</p>
                    </div>
                    <div class="person-div">
                        <p class="contact-label">Address</p>
                         : 
                        <p class="detail">#Details.Address#</p>
                    </div>
                    <div class="person-div">
                        <p class="contact-label">Email Id</p>
                         : 
                        <p class="detail">#Details.EmailId#</p>
                    </div>
                    <div class="person-div">
                        <p class="contact-label">Phone</p>
                         : 
                        <p class="detail">#Details.PhoneNumber#</p>
                    </div>
                </div>
            </cfoutput>
            
        </div>

        <div class="contact-img">
            <cfif Details.Photo != "">
                <cfoutput>
                    <img src="#Details.Photo#" alt="user image" style="width: 120px; height: 130px">
                </cfoutput>
            <cfelse>
                <i class="fa fa-user-circle-o" aria-hidden="true"></i>
            </cfif>
        </div>
    </div>

</cfif>
