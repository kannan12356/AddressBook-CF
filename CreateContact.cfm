    <cfset userId = "#session.userId#">

    <cfif structKeyExists(form, "submit")>
        <cfif form.userImg != "">
            <cffile action="upload"
                fileField="userImg"
                destination="E:\ColdFusion\cfusion\wwwroot\AddressBook\userImage"
                result="imgName">
            <cfset img = "userImage/#imgName.clientFile#">
        <cfelse>
            <cfset img = "">
        </cfif>
    
        <cftransaction>
            <cfset CreateContact = entityNew("contact_list", {UserId : form.userId, FirstName : form.fName, LastName : form.lName,
            Title : form.title, Gender : form.gender, DOB : form.DOB, Photo : img, Address : form.address, Street : form.street,
            EmailId : form.emailId, PhoneNumber : form.phoneNumber})>
            <cfset entitySave(CreateContact)>
        </cftransaction>      
        <cflocation url="ContactList.cfm" addtoken="no">
    </cfif>
    
    <div class="modal-content">
        <div class="contact">
            <div class="modal-head">
                <p class="title" style="font-weight: bold;">Create Contact</p>
            </div>
            <div class="personal-contact">
                <p class="modal-sub-head">Personal Contact</p>
            </div>
            <div class="modal-contact">
                <form action="CreateContact.cfm" enctype="multipart/form-data" method="post">  
                    <cfoutput>
                        <input type="hidden" name="userId" value="#userId#">
                    </cfoutput>
                    <div class="first-div">
                        <select class="form-control" id="title" name="title" style="margin-top: 13px;">
                            <option selected value="">Select Title *</option>
                            <option value="Home">Home</option>
                            <option value="Friend">Friend</option>
                        </select>
                        <input type="text" class="form-control" id="fName" name="fName" placeholder="First Name *">
                        <input type="text" class="form-control" id="lName" name="lName" placeholder="Last Name *">
                    </div>
                        
                    <div class="second-div">
                        <div class="gender" style="margin-right: 10px;">
                            <label>Gender  *</label>
                            <select class="form-control" id="gender" name="gender" style="margin-top: 13px;">
                                <option selected value="">Select</option>
                                <option value="Male">Male</option>
                                <option value="feMale">Female</option>
                                <option value="transgender">Transgender</option>
                            </select>
                        </div>
                        <div class="dob">
                            <label>Date of Birth *</label>
                            <input type="date" class="form-control" id="dob" name="DOB">
                        </div>
                    </div>
                            
                    <label>Upload Photo</label>
                    <input type="file" class="form-control" name="userImg">
                            
                    <p class="modal-sub-head">Contact Details</p>
                    <div class="contact-div">
                        <textarea id="address" name="address" cols="20" rows="5" class="form-control" placeholder="Address *"></textarea>
                        <input type="text" class="form-control" id="street" name="street" placeholder="Street *">
                    </div>                        
                    <div class="contact-div">
                        <input type="text" class="form-control" id="phoneNumber" name="phoneNumber" placeholder="Phone number *">
                        <input type="text" class="form-control" id="emailId" name="emailId" placeholder="Email ID *">
                    </div>                        
                    <button type="submit" class="btn" name="submit" id="submit">Submit</button>                                    
                </form>
            </div>
        </div>
        
        <div class="contact-img">
            <i class="fa fa-user-circle-o" aria-hidden="true"></i>
        </div>
    </div>