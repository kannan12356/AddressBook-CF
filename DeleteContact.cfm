<cfif structKeyExists(url, "Id")>
    <cfset personId = url.Id>

    <cfinvoke 
        component="cloud" 
        method="contactDetails"
        returnVariable="contactDetails">
        <cfinvokeargument  name="personId"  value="#personId#">
    </cfinvoke>
    
    <div class="modal-content">        
        <cfoutput query="contactDetails">
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

<cfif structKeyExists(form, "submit")>
    <cfinvoke
        component="cloud"
        method="deleteContact"
        returnVariable="dleteResult">
        <cfinvokeargument  name="personId"  value="#personId#">
        <cfinvokeargument  name="userImg"  value="#form.userImg#">
    </cfinvoke>
    <cflocation  url="ContactList.cfm" addToken="no">
</cfif>
<cfif structKeyExists(form, "no")>
    <cflocation  url="ContactList.cfm" addToken="no">
</cfif>
