<cfif structKeyExists(url, "id")>
    <cfset personId = url.Id>
    <cfinvoke
        component="cloud"
        method="contactDetails"
        returnVariable="personDetails">
        <cfinvokeargument  name="personId"  value="#personId#">
    </cfinvoke>
    <cfset userId = "#session.userId#">
    <div class="modal-content">
        <div class="contact">
            <div class="modal-head">
                <p class="title" style="font-weight: bold;">Edit Contact</p>
            </div>
            <div class="personal-contact">
                <p class="modal-sub-head">Personal Contact</p>
            </div>
            <cfoutput query="personDetails">
                <div class="modal-contact">
                    <form action="EditContact.cfm" method="post" enctype="multipart/form-data">                        
                        <cfoutput>
                            <input type="hidden" name="userId" value="#userId#">
                            <input type="hidden" name="personId" value="#personId#">
                        </cfoutput>
                        <div class="first-div">
                            <select class="form-control" id="title" name="title" style="margin-top: 13px;">
                                <option selected value="#personDetails.title#">#personDetails.title#</option>
                                <option value="Home">Home</option>
                                <option value="Friend">Friend</option>
                            </select>
                            <input type="text" class="form-control" name="fName" placeholder="First Name *" value="#personDetails.FirstName#">
                            <input type="text" class="form-control" name="lName" placeholder="Last Name *" value="#personDetails.LastName#">
                        </div>
                            
                        <div class="second-div">
                            <div class="gender" style="margin-right: 10px;">
                                <label>Gender  *</label>
                                <select class="form-control" name="gender" style="margin-top: 13px;">
                                    <option selected  value="#personDetails.gender#">#personDetails.gender#</option>
                                    <option value="Male">Male</option>
                                    <option value="feMale">Female</option>
                                    <option value="transgender">Transgender</option>
                                </select>
                            </div>
                            <div class="dob">
                                <label>Date of Birth *</label>
                                <input type="date" class="form-control" name="DOB" value="#personDetails.dob#">
                            </div>
                        </div>
                            
                        <label>Upload Photo</label>
                        <input type="file" class="form-control" name="userImg">
                        <input type="hidden" name="userPhoto" value="#personDetails.Photo#">
                            
                        <p class="modal-sub-head">Contact Details</p>
                        <div class="contact-div">
                            <textarea name="address" cols="20" rows="5" class="form-control" placeholder="Address *">
                                #personDetails.address#
                            </textarea>
                            <input type="text" class="form-control" name="street" placeholder="Street *"  value="#personDetails.street#">
                        </div>                        
                        <div class="contact-div">
                            <input type="text" class="form-control" id="phoneNumber" name="phoneNumber" placeholder="Phone number *" value="#personDetails.phoneNumber#">
                            <input type="text" class="form-control" id="emailId" name="emailId" placeholder="Email ID *" value="#personDetails.emailId#">
                        </div>                                                
                        <button class="btn" name="submit">Submit</button>                        
                    </form>
                </div>
            </cfoutput>
        </div>

        <cfoutput>
            <div class="contact-img">
                <cfif persondetails.photo != "">
                    <img src="#personDetails.photo#" alt="user image" style="width: 120px; height: 150px">
                <cfelse>
                    <i class="fa fa-user-circle-o" aria-hidden="true"></i>
                </cfif>            
            </div>
        </cfoutput>
        
    </div>
</cfif>


<cfif structKeyExists(form, "submit")>
    <cfinvoke
        component="cloud"
        method="updateContact"
        returnVariable="contactUpdate">
        <cfinvokeargument  name="form"  value="#form#">
    </cfinvoke>
    <cflocation  url="ContactList.cfm" addToken="no">
</cfif>