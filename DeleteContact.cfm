<cfif structKeyExists(form, "submit")>
    <cfif form.userImg != "">
        <cffile action="delete"
	        file="E:\ColdFusion\cfusion\wwwroot\AddressBook\#userImg#">            
    </cfif>
    
    <cftransaction>
        <cfset deletePerson = entityLoad("contact_list", {PersonId : form.personId}, true)>
        <cfset entityDelete(deletePerson)>
    </cftransaction>
    <cflocation  url="ContactList.cfm" addToken="no">
</cfif>

<cfif structKeyExists(form, "no")>
    <cflocation  url="ContactList.cfm" addToken="no">
</cfif>



<cfif structKeyExists(url, "Id")>
    <cfset personId = url.Id>

    <cfset contactDetails = entityLoad("contact_list", {PersonId : personId}, true)>

    <div class="modal-content">        
        <cfoutput>
            <div class="delete-confirmation">
                <p>Are you sure you want to delete this record</p>
                <form action="DeleteContact.cfm" method="post">
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