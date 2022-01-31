<cfif structKeyExists(url, "Id")>
    <cfset personId = url.Id>

    <cfset contactDetails = entityLoad("contact_list", {PersonId : personId}, true)>

    <div class="modal-content">        
        <cfoutput>
            <div class="delete-confirmation">
                <p>Are you sure you want to delete this record</p>
                <form action="cfc/contact_list.cfc?method=deleteContact" method="post">
                    <input type="hidden" name="personId" value="#personId#">
                    <input type="hidden" name="userImg" value="#contactDetails.photo#">
                    <div class="dlt-btn">
                        <button class="btn" name="submit">Yes</button>
                        <button class="btn" name="no">No</button>
                    </div>
                </form>
            </div>            
        </cfoutput>
    </div>
</cfif>