<cfset userId = "#session.userId#">

<div class="modal-content">
    <div class="contact">
        <div class="modal-head">
            <p class="title">Create Contact</p>
        </div>
        
        <div class="personal-contact">
            <p class="modal-sub-head">Personal Contact</p>
        </div>

        <cfoutput>            
            <div class="modal-contact">
                <form action="cfc/contact_list.cfc?method=createContact" enctype="multipart/form-data" method="post">  
                
                    <input type="hidden" name="userId" value="#userId#">
                
                    <div class="first-div">
                        <select class="form-control" id="title" name="title" required>
                            <option selected value="">Select Title *</option>
                            <option value="Home">Home</option>
                            <option value="Friend">Friend</option>
                        </select>
                        <input type="text" class="form-control" id="fName" name="fName" placeholder="First Name *" required>
                        <input type="text" class="form-control" id="lName" name="lName" placeholder="Last Name *" required>
                    </div>
                        
                    <div class="second-div">
                        <div class="gender">
                            <label>Gender  *</label>
                            <select class="form-control" id="gender" name="gender" required>
                                <option selected value="">Select</option>
                                <option value="Male">Male</option>
                                <option value="feMale">Female</option>
                                <option value="transgender">Transgender</option>
                            </select>
                        </div>

                        <div class="dob">
                            <label>Date of Birth *</label>
                            <input type="date" class="form-control" id="dob" name="DOB" required>
                        </div>
                    </div>
                            
                    <label>Upload Photo</label>
                    <input type="file" class="form-control" name="userImg">
                            
                    <p class="modal-sub-head">Contact Details</p>

                    <div class="contact-div">
                        <textarea id="address" name="address" cols="20" rows="5" class="form-control" placeholder="Address *" required></textarea>
                        <input type="text" class="form-control" id="street" name="street" placeholder="Street *" required>
                    </div>                        

                    <div class="contact-div">
                        <input type="text" class="form-control" id="phoneNumber" name="phoneNumber" placeholder="Phone number *" required>
                        <input type="text" class="form-control" id="emailId" name="emailId" placeholder="Email ID *" required>
                    </div>                        

                    <button type="submit" class="btn" name="submit" id="submit">Submit</button>                                    
                </form>
            </div>
        </cfoutput>
    </div>
        
    <div class="contact-img">
        <i class="fa fa-user-circle-o" aria-hidden="true"></i>
    </div>
</div>