# /packages/intranet-riskmanagement/www/action.tcl
#
# Copyright (C) 2003-2011 ]project-open[
#
# All rights reserved. Please check
# https://www.project-open.com/license/ for details.

ad_page_contract {
    Perform bulk actions on risks
    
    @action_id	One of "Intranet Risk Action" categories.
    		Determines what to do with the list of "tid"
		risk ids.
		The "aux_string1" field of the category determines
		the page to be called for pluggable actions.

    @param return_url the url to return to
    @author frank.bergmann@project-open.com
} {
    risk_id:array
    { action_id:integer ""}
    { action "" }
    return_url
}

set user_id [auth::require_login]
set user_name [im_name_from_user_id [ad_conn user_id]]

if {"" != $action_id} { set action [im_category_from_id -translate_p 0 $action_id] }
set action_forbidden_msg [lang::message::lookup "" intranet-riskmanagement.Action_Forbidden "<b>Unable to execute action</b>:<br>You don't have the permissions to execute the action '%action%'."]


foreach rid [array names risk_id] {
    # Write Audit Trail before update, just in case
    im_audit -object_id $rid -action before_update
}


switch [string tolower $action] {
    delete {
	# Delete
	foreach rid [array names risk_id] {
	    im_risk_permissions $user_id $rid view read write admin
	    if {!$write} {
		ad_return_complaint 1 $action_forbidden_msg
		ad_script_abort
	    }
	    set value [string tolower $risk_id($rid)]
	    if {"on" == $value} {
		im_risk::delete -risk_id $rid
	    }
	}
    }
    default {
	# Check if we've got a custom action to perform
	set redirect_base_url [db_string redir "select aux_string1 from im_categories where category_id = :action_id" -default ""]
	if {"" != [string trim $redirect_base_url]} {
	    # Redirect for custom action
	    set redirect_url [export_vars -base $redirect_base_url {action_id return_url}]
	    foreach risk_id $risk_id { append redirect_url "&risk_id=$risk_id"}
	    ad_returnredirect $redirect_url
	} else {
	    ad_return_complaint 1 "Unknown Risk action: $action_id='$action'"
	}
    }
}

ad_returnredirect $return_url
