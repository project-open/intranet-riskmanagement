# /intranet-riskmanagement/lib/risk-project-component.tcl
#
# Variables from page:
#
# project_id
# risk_status_id
# risk_type_id
# start_date
# end_date
# risk_ids
# extra_sql_list
# view_name

# ad_return_complaint 1 $extra_sql_list

if {![info exists view_name] || "" == $view_name} { set view_name "im_risk_list_short" }

set view_id [im_view_id_from_name $view_name]
set bgcolor(0) " class=roweven "
set bgcolor(1) " class=rowodd "
set cell_width 15
set return_url [im_url_with_query]

# ---------------------------------------------------------
# Define constants for classifying risks
# ---------------------------------------------------------

# Classifiers for impact and probability.
# Each classified starts with 0 and ends at "ininite"
set impact_classifier [list 0 5 10 20 30 100]
set probab_classifier [list 0 5 10 20 30 100]


ad_proc im_risk_chart_classify {
    -value:required
    -classifier:required
} {
    Classifies value into the range of values in classifier.
    @param value The value to classify
    @classifier A list of values excluding "0" at the beginning and "infinite" at the end
    @returns Integer in the range of 0 .. end, indicating the position of value in the classified
} {
    # Append start and end of scale
    set result ""
    for {set i 0} {$i <= [llength $classifier]} {incr i} {
	set low [lindex $classifier $i]
	set high [lindex $classifier $i+1]
	if {$value >= $low && $value <= $high} { 
	    set result $i
	    break
	}
    }
    
    if {"" == $result} {
	if {$value >= $high} { 
	    set result [expr {[llength $classifier]-2}]
	}
    }

    return $result
}

ad_proc im_risk_chart_bg_color {
    -x:required
    -y:required
    -max:required
} {
    Returns a suitable background color for x/y coordinates
} {
    set sum [expr {$x + $y}]
    switch $sum {
	0 { return "#00FF00" }
	1 { return "#80FF80" }
	2 { return "#C0FFC0" }
	6 { return "#FFC0C0" }
	7 { return "#FF8080" }
	8 { return "#FF0000" }
	default {return "#FFFFFF" }
    }
}

# ---------------------------------------------------------
# View Columns
# ---------------------------------------------------------

set column_headers [list]
set column_vars [list]
set admin_links [list]
set extra_selects [list]
set extra_froms [list]
set extra_wheres [list]

set column_sql "
	select	*
	from	im_view_columns
	where	view_id = :view_id
		and group_id is null
	order by sort_order
"
set col_span 0
set table_header_html ""
db_foreach column_list_sql $column_sql {
    if {"" == $visible_for || [eval $visible_for]} {
	lappend column_headers "$column_name"
	lappend column_vars "$column_render_tcl"
	lappend admin_links "<a href=[export_vars -base "/intranet/admin/views/new-column" {return_url column_id {form_mode edit}}] target=\"_blank\"><span class=\"icon_wrench_po\">[im_gif wrench]</span></a>"

	set admin_url [export_vars -base "/intranet/admin/views/new-column" {column_id return_url {form_mode edit}}]
	set admin_html "<a href='$admin_url'>[im_gif wrench]</a>"
	append table_header_html "<td class=rowtitle>$column_name $admin_html</td>\n"
	
	if {"" != $extra_select} { lappend extra_selects $extra_select }
	if {"" != $extra_from} { lappend extra_froms $extra_from }
	if {"" != $extra_where} { lappend extra_wheres $extra_where }
    }
    incr col_span
}

set table_header_html "<tr class=rowtitle>$table_header_html</tr>\n"



# ---------------------------------------------------------
# Write local variables into form_vars
# ---------------------------------------------------------

set form_vars [ns_set create]
foreach varname [info locals] {

    # Don't consider variables that start with a "_", that
    # contain a ":" or that are array variables:
    if {"_" == [string range $varname 0 0]} { continue }
    if {[regexp {:} $varname]} { continue }
    if {[array exists $varname]} { continue }

    # Get the value of the variable and add to the form_vars set
    set value [expr "\$$varname"]
    ns_set put $form_vars $varname $value
}

# ---------------------------------------------------------
# List the risks
# and format the risk chart
# ---------------------------------------------------------

set criteria {}
if {[info exists project_id] && "" != $project_id && 0 != $project_id} { 
    lappend criteria "
	(r.risk_project_id = :project_id OR
	r.risk_project_id in (select pp.project_id from im_projects pp where pp.program_id = :project_id)
	)
    " 
} else {
    lappend criteria "r.risk_project_id in (
	select	project_id
	from	im_projects
	where	parent_id is null and 
		project_status_id not in ([join [im_sub_categories [im_project_status_closed]] ","])
    )"
}


if {[info exists risk_status_id] && "" != $risk_status_id && 0 != $risk_status_id} { 
    lappend criteria "r.risk_status_id in ([join [im_sub_categories $risk_status_id] ","])" 
} else {
    lappend criteria "r.risk_status_id not in ([join [im_sub_categories [im_risk_status_deleted]] ","])" 
}

if {[info exists risk_type_id] && "" != $risk_type_id && 0 != $risk_type_id} { lappend criteria "r.risk_type_id = :risk_type_id" }
if {[info exists start_date] && "" != $start_date && 0 != $start_date} { lappend criteria "o.creation_date >= :start_date" }
if {[info exists end_date] && "" != $end_date && 0 != $end_date} { lappend criteria "o.creation_date <= :end_date" }
if {[info exists risk_ids] && "" != $risk_ids && 0 != $risk_ids} { lappend criteria "r.risk_id in ([join $risk_ids ","])" }



# Deal with DynField Vars and add constraint to SQL
# Add the DynField variables to $form_vars
set dynfield_extra_where ""
if {[info exists extra_sql_list]} {
    array set extra_sql_array $extra_sql_list
    set dynfield_extra_where $extra_sql_array(where)
    set ns_set_vars $extra_sql_array(bind_vars)
    set tmp_vars [util_list_to_ns_set $ns_set_vars]
    set tmp_var_size [ns_set size $tmp_vars]
    for {set i 0} {$i < $tmp_var_size} { incr i } {
	set key [ns_set key $tmp_vars $i]
	set value [ns_set get $tmp_vars $key]
	ns_set put $form_vars $key $value
    }
}

if {"" != $dynfield_extra_where} {
    lappend criteria "risk_id in $dynfield_extra_where"
}



set where_clause [join $criteria " and\n\t\t"]
if {[llength $criteria] > 0} { set where_clause "and $where_clause" }

set risk_sql "
	select	o.*,
		r.*,
		round( least(100.0 * r.risk_impact / greatest(coalesce(p.project_budget,0.0), 0.01), 100)) as risk_impact_percent,
		im_category_from_id(r.risk_type_id) as risk_type,
		im_category_from_id(r.risk_status_id) as risk_status,
		p.project_name as risk_project_name,
		coalesce(p.project_budget, 0.0) as project_budget,
		im_name_from_user_id(o.creation_user) as creation_user_name
	from	acs_objects o,
		im_risks r
		LEFT OUTER JOIN im_projects p ON (r.risk_project_id = p.project_id)
	where	r.risk_id = o.object_id 
		$where_clause
	order by
		p.project_name,
		risk_probability_percent * risk_impact DESC;
"

set project_budget ""
set ctr 0
set table_body_html ""
set risk_chart_html ""
array set chart_hash {}
array set chart_ids_hash {}
db_foreach risks $risk_sql -bind $form_vars {

    # Format columns for the list view
    set row_html "<tr$bgcolor([expr {$ctr % 2}])>\n"
    foreach column_var $column_vars {
        append row_html "\t<td valign=top>"
        set cmd "append row_html $column_var"
        eval "$cmd"
        append row_html "</td>\n"
    }
    append row_html "</tr>\n"
    append table_body_html $row_html

    # Classify risks for the 3x3 risk overview
    set impact_class [im_risk_chart_classify -value $risk_impact_percent -classifier $impact_classifier]
    set probab_class [im_risk_chart_classify -value $risk_probability_percent -classifier $probab_classifier]
    if {"" == $impact_class || "" == $probab_class} {
	ad_return_complaint 1 "impact=$impact_class, prob=$probab_class"
    }
    set key "$impact_class-$probab_class"

    # Chart Hash - Number of risks in the cell
    set v 0
    if {[info exists chart_hash($key)]} { set v $chart_hash($key) }
    set v [expr {$v + 1}]
    set chart_hash($key) $v

    # Chart risk_ids Hash - The IDs of the risks in the cell
    set v {}
    if {[info exists chart_ids_hash($key)]} { set v $chart_ids_hash($key) }
    lappend v $risk_id
    set chart_ids_hash($key) $v
    
    incr ctr
}

# Format the risk summary chart
set risk_chart_header "<td width=20></td>"
for {set x 0} {$x < [expr {[llength $probab_classifier]-1}]} {incr x} {
    set val [lindex $probab_classifier $x+1]
    append risk_chart_header "<td width=20 align=center>$val</td>\n"
}
set risk_chart_header "<tr>$risk_chart_header</tr>\n"

set risk_chart_html "<table id=risk_chart border=1 align=right style='border-collapse:separate'>\n"
for {set y [expr {[llength $impact_classifier]-2}]} {$y >= 0} {incr y -1} {
    set risk_chart_line ""
    set val [lindex $impact_classifier $y+1]
    append risk_chart_line "<tr>\n<td align=right width=$cell_width>$val</td>\n"
    for {set x 0} {$x < [expr {[llength $probab_classifier]-1}]} {incr x} {
	set key "$y-$x"
	set v ""
	if {[info exists chart_hash($key)]} { set v $chart_hash($key) }
	set v_ids {}
	if {[info exists chart_ids_hash($key)]} { set v_ids $chart_ids_hash($key) }
	set color [im_risk_chart_bg_color -x $x -y $y -max [llength $probab_classifier]]
	set v_url [export_vars -base "/intranet-riskmanagement/index" {return_url {risk_project_id $project_id} {risk_ids $v_ids}}]
	append risk_chart_line "<td align=center bgcolor=$color width=$cell_width><a href='$v_url'>$v</a></td>\n"
    }
    append risk_chart_line "</tr>\n"
    append risk_chart_html $risk_chart_line
}
append risk_chart_html $risk_chart_header
append risk_chart_html "</table>\n"

# Show a resonable message if no budget was specified
if {"" == $project_budget || 0 == $project_budget} {
    set risk_chart_html "
	<b>[lang::message::lookup "" intranet-riskmanagement.No_project_budget_specified "No project budget specified"]</b>:
	[lang::message::lookup "" intranet-riskmanagement.Without_budget_no_chart "Without the budget we can't calculate the risk chart."]<br>
	[lang::message::lookup "" intranet-riskmanagement.Please_set_the_project_budget "Please edit the project and set a budget"]
    "
}


if {"" eq $project_id} {
    set risk_chart_html ""
}


# ---------------------------------------------------------
# Format risk related reports
# ---------------------------------------------------------


# Add the <ul>-List of associated menus
set bind_vars [list project_id $project_id]
set menu_html [im_menu_li -bind_vars $bind_vars "reporting-project-risks"]

set import_exists_p [llength [info commands im_csv_import_object_fields]]
set import_html "<li><a href=[export_vars -base "/intranet-csv-import/index" {{object_type im_risk}}]>[lang::message::lookup "" intranet-timesheet2.Import_Risk_CSV "Import Risk CSV"]</a>"
if {!$import_exists_p} { set import_html "" }


set all_risks_html "<li><a href=[export_vars -base "/intranet-riskmanagement/index" {{risk_project_id $project_id}}]>[lang::message::lookup "" intranet-riskmanagement.See_all_risks "See all risks"]</a>"



# ---------------------------------------------------------
# Table footer
# with action box
# ---------------------------------------------------------

set new_risk_url [export_vars -base "/intranet-riskmanagement/new" {return_url {risk_project_id $project_id}}]
set new_risk_msg [lang::message::lookup "" intranet-riskmanagement.New_Risk "New Risk"]
set delete_risk_msg [lang::message::lookup "" intranet-riskmanagement.Delete_Risks "Delete Risks"]
set table_footer_html "
<tr>
<td colspan=99>
<select name=action>
<option value=delete>$delete_risk_msg<option>
</select>
<input type=submit>
<ul>
<li><a href='$new_risk_url'>$new_risk_msg</a>
$all_risks_html
$menu_html
$import_html
</ul>
</td>
</tr>
"

