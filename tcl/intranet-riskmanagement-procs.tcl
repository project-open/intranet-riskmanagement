# /packages/intranet-riskmanagement/tcl/intranet-riskmanagement-procs.tcl
#
# Copyright (C) 2003-2011 ]project-open[
#
# All rights reserved. Please check
# http://www.project-open.com/license/ for details.

ad_library {
    Procs used in riskmanagement module

    @author frank.bergmann@project-open.com
}


# ----------------------------------------------------------------------
# Constants
# ---------------------------------------------------------------------

# Risk Status
ad_proc -public im_risk_status_open {} { return 75000 }
ad_proc -public im_risk_status_closed {} { return 75002 }
ad_proc -public im_risk_status_deleted {} { return 75098 }

# Risk Type
ad_proc -public im_risk_type_risk {} { return 75100 }
ad_proc -public im_risk_type_issue {} { return 75102 }

# Risk Action
ad_proc -public im_risk_action_delete {} { return 75210 }


# ----------------------------------------------------------------------
# Components
# ---------------------------------------------------------------------

ad_proc -public im_risk_project_component {
    -project_id
} {
    Returns a HTML component to show all project related risks
} {
    set params [list [list project_id $project_id]]
#    set project_type_id [db_string ptype "select project_type_id from im_projects where project_id = :project_id" -default ""]
    set result [ad_parse_template -params $params "/packages/intranet-riskmanagement/lib/risk-project-component"]
    return [string trim $result]
}



# -----------------------------------------------------------
# Permissions
# -----------------------------------------------------------

ad_proc -public im_risk_permissions {user_id risk_id view_var read_var write_var admin_var} {
    Fill the "by-reference" variables read, write and admin
    with the permissions of $user_id on $risk_id.<br>
} {
    upvar $view_var view
    upvar $read_var read
    upvar $write_var write
    upvar $admin_var admin

    set perm_proc [parameter::get_from_package_key -package_key "intranet-riskmanagement" -parameter "RiskPermissionFunction" -default ""]
    if {"" ne $perm_proc} {
	$perm_proc $user_id $risk_id view read write admin
    }

    # set user_is_admin_p [im_is_user_site_wide_or_intranet_admin $user_id]
    set risk_project_id [util_memoize [list db_string risk_project "select risk_project_id from im_risks where risk_id = $risk_id" -default ""]]

    # Just use project permissions...
    im_project_permissions $user_id $risk_project_id view read write admin
}



# -----------------------------------------------------------
# 
# -----------------------------------------------------------

namespace eval im_risk {
    
    ad_proc -public audit {
	{-action "after_update" }
	-risk_id:required
    } {
	Write the audit trail
    } {
	im_audit -object_id $risk_id -action $action
    }

    ad_proc -public delete {
	-risk_id:required
    } {
	Set to status deleted
    } {
	db_dml del_risk "update im_risks set risk_status_id = [im_risk_status_deleted] where risk_id = :risk_id"
	im_risk::audit -risk_id $risk_id
    }

}
