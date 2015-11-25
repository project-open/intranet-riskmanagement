<master>
<property name="doc(title)">@page_title;literal@</property>
<property name="main_navbar_label"></property>

<%= [im_box_header $page_title] %>

<form action='@return_url;noquote@' method=POST>
<%= [export_vars -form {return_url risk_id risk_nr risk_name}] %>

<table cellspacing="2" cellpadding="2">

<if "" eq @risk_type_id@>
		<tr class=rowodd>
		<td>
			<table>
			@category_select_html;noquote@
			</table>
		</td>
		</tr>
</if>
<else>
	<%= [export_vars -form {risk_type_id}] %>
</else>

<tr class=roweven>
    <td></td>
    <td><input type="submit" value='<%= [lang::message::lookup "" intranet-core.Continue "Continue"] %>'></td>
</tr>

</table>
</form>
<%= [im_box_footer] %>

