# ]po[ Risk Management
This package is part of ]project-open[, an open-source enterprise project management system.

For more information about ]project-open[ please see:
* [Documentation Wiki](http://www.project-open.com/en/)
* [V5.0 Download](https://sourceforge.net/projects/project-open/files/project-open/V5.0/)
* [Installation Instructions](http://www.project-open.com/en/list-installers)

About ]po[ Risk Management:

<p><p>This package allows to associated a number of &quot;risks&quot; with a project. 

# Online Reference Documentation

## Procedure Files

<table cellpadding="0" cellspacing="0"><tr valign="top"><td style="width:35%"><b><a href="http://www.project-open.net/api-doc/content-page-view?version_id=1342670&amp;path=packages/intranet-riskmanagement/lib/risk-project-component.adp">lib/risk-project-component.adp</a></b></td><td></td><td></td></tr><tr valign="top"><td style="width:35%"><b><a href="http://www.project-open.net/api-doc/content-page-view?version_id=1342670&amp;path=packages/intranet-riskmanagement/lib/risk-project-component.tcl">lib/risk-project-component.tcl</a></b></td><td></td><td></td></tr><tr valign="top"><td style="width:35%"><b><a href="http://www.project-open.net/api-doc/procs-file-view?version_id=1342670&amp;path=packages/intranet-riskmanagement/tcl/intranet-riskmanagement-procs.tcl">tcl/intranet-riskmanagement-procs.tcl</a></b></td><td></td><td>Procs used in riskmanagement module </td></tr></table>

## Procedures

<table cellpadding="0" cellspacing="0"><tr valign="top"><td style="width:35%"><b><a href="http://www.project-open.net/api-doc/proc-view?version_id=1342670&amp;proc=im_risk::audit">im_risk::audit</a></b></td><td></td><td>Write the audit trail </td></tr><tr valign="top"><td style="width:35%"><b><a href="http://www.project-open.net/api-doc/proc-view?version_id=1342670&amp;proc=im_risk::delete">im_risk::delete</a></b></td><td></td><td>Set to status deleted </td></tr><tr valign="top"><td style="width:35%"><b><a href="http://www.project-open.net/api-doc/proc-view?version_id=1342670&amp;proc=im_risk_action_delete">im_risk_action_delete</a></b></td><td></td><td></td></tr><tr valign="top"><td style="width:35%"><b><a href="http://www.project-open.net/api-doc/proc-view?version_id=1342670&amp;proc=im_risk_permissions">im_risk_permissions</a></b></td><td></td><td>Fill the &quot;by-reference&quot; variables read, write and admin with the permissions of $user_id on $risk_id.&lt;br&gt; </td></tr><tr valign="top"><td style="width:35%"><b><a href="http://www.project-open.net/api-doc/proc-view?version_id=1342670&amp;proc=im_risk_project_component">im_risk_project_component</a></b></td><td></td><td>Returns a HTML component to show all project related risks </td></tr><tr valign="top"><td style="width:35%"><b><a href="http://www.project-open.net/api-doc/proc-view?version_id=1342670&amp;proc=im_risk_status_closed">im_risk_status_closed</a></b></td><td></td><td></td></tr><tr valign="top"><td style="width:35%"><b><a href="http://www.project-open.net/api-doc/proc-view?version_id=1342670&amp;proc=im_risk_status_deleted">im_risk_status_deleted</a></b></td><td></td><td></td></tr><tr valign="top"><td style="width:35%"><b><a href="http://www.project-open.net/api-doc/proc-view?version_id=1342670&amp;proc=im_risk_status_open">im_risk_status_open</a></b></td><td></td><td></td></tr><tr valign="top"><td style="width:35%"><b><a href="http://www.project-open.net/api-doc/proc-view?version_id=1342670&amp;proc=im_risk_type_issue">im_risk_type_issue</a></b></td><td></td><td></td></tr><tr valign="top"><td style="width:35%"><b><a href="http://www.project-open.net/api-doc/proc-view?version_id=1342670&amp;proc=im_risk_type_risk">im_risk_type_risk</a></b></td><td></td><td></td></tr></table>

## SQL Files

<table cellpadding="0" cellspacing="0"><tr valign="top"><td><b><a href="http://www.project-open.net/api-doc/display-sql?package_key=intranet-riskmanagement&amp;url=postgresql/intranet-riskmanagement-create.sql&amp;version_id=1342670">sql/postgresql/intranet-riskmanagement-create.sql</a></b></td><td></td><td></td></tr><tr valign="top"><td><b><a href="http://www.project-open.net/api-doc/display-sql?package_key=intranet-riskmanagement&amp;url=postgresql/intranet-riskmanagement-drop.sql&amp;version_id=1342670">sql/postgresql/intranet-riskmanagement-drop.sql</a></b></td><td></td><td></td></tr><tr valign="top"><td><b><a href="http://www.project-open.net/api-doc/display-sql?package_key=intranet-riskmanagement&amp;url=postgresql/upgrade/upgrade-5.0.2.4.2-5.0.2.4.3.sql&amp;version_id=1342670">sql/postgresql/upgrade/upgrade-5.0.2.4.2-5.0.2.4.3.sql</a></b></td><td></td><td></td></tr><tr valign="top"><td><b><a href="http://www.project-open.net/api-doc/display-sql?package_key=intranet-riskmanagement&amp;url=postgresql/upgrade/upgrade-5.0.2.4.3-5.0.2.4.4.sql&amp;version_id=1342670">sql/postgresql/upgrade/upgrade-5.0.2.4.3-5.0.2.4.4.sql</a></b></td><td></td><td></td></tr></table>

## Content Pages

<table cellpadding="0" cellspacing="0"><tr valign="top"><td><b>www/</b></td></tr><tr valign="top"><td style="width:35%"><b><a href="http://www.project-open.net/api-doc/content-page-view?version_id=1342670&amp;path=packages/intranet-riskmanagement/www/action.tcl">action.tcl</a></b></td><td>Perform bulk actions on risks</td></tr><tr valign="top"><td style="width:35%"><b><a href="http://www.project-open.net/api-doc/content-page-view?version_id=1342670&amp;path=packages/intranet-riskmanagement/www/delete.tcl">delete.tcl</a></b></td><td>Delete a risk.</td></tr><tr valign="top"><td style="width:35%"><b><a href="http://www.project-open.net/api-doc/content-page-view?version_id=1342670&amp;path=packages/intranet-riskmanagement/www/graph.tcl">graph.tcl</a></b></td><td>Displays a graph representing all the risks corresponding to one project.</td></tr><tr valign="top"><td style="width:35%"><b><a href="http://www.project-open.net/api-doc/content-page-view?version_id=1342670&amp;path=packages/intranet-riskmanagement/www/index.adp">index.adp</a></b></td><td></td></tr><tr valign="top"><td style="width:35%"><b><a href="http://www.project-open.net/api-doc/content-page-view?version_id=1342670&amp;path=packages/intranet-riskmanagement/www/index.tcl">index.tcl</a></b></td><td></td></tr><tr valign="top"><td style="width:35%"><b><a href="http://www.project-open.net/api-doc/content-page-view?version_id=1342670&amp;path=packages/intranet-riskmanagement/www/new-typeselect.adp">new-typeselect.adp</a></b></td><td></td></tr><tr valign="top"><td style="width:35%"><b><a href="http://www.project-open.net/api-doc/content-page-view?version_id=1342670&amp;path=packages/intranet-riskmanagement/www/new-typeselect.tcl">new-typeselect.tcl</a></b></td><td>We get redirected here from the risk&#39;s &quot;New&quot; page if there are DynFields per object subtype and no type is specified.</td></tr><tr valign="top"><td style="width:35%"><b><a href="http://www.project-open.net/api-doc/content-page-view?version_id=1342670&amp;path=packages/intranet-riskmanagement/www/new.adp">new.adp</a></b></td><td></td></tr><tr valign="top"><td style="width:35%"><b><a href="http://www.project-open.net/api-doc/content-page-view?version_id=1342670&amp;path=packages/intranet-riskmanagement/www/new.tcl">new.tcl</a></b></td><td></td></tr><tr valign="top"><td style="width:35%"><b><a href="http://www.project-open.net/api-doc/content-page-view?version_id=1342670&amp;path=packages/intranet-riskmanagement/www/project-risks-report.tcl">project-risks-report.tcl</a></b></td><td>Lists risks per project, taking into account DynFields.</td></tr></table>
