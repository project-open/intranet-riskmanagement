<div class="risk_outer">

<script type="text/javascript" <if @::__csp_nonce@ not nil>nonce="@::__csp_nonce;literal@"</if>>
window.addEventListener('load', function() { 
     document.getElementById('list_check_all_risks').addEventListener('click', function() { acs_ListCheckAll('risk', this.checked) });
});
</script>


<table cellpadding="0" cellspacing="0" border="0" width="100%">

<if @risk_chart_html@ ne "">
<tr>
<td valign="top"></td>
<td valign="top">

	<table align="right" border="0" cellpadding="0" cellspacing="0">
	<tr valign="bottom">
		<td>
		<div style="float: left; position: relative; -moz-transform: rotate(270deg); -o-transform: rotate(270deg); -webkit-transform: rotate(270deg); filter: progid:DXImageTransform.Microsoft.BasicImage(rotation=3); -ms-filter: "progid:DXImageTransform.Microsoft.BasicImage(rotation=3);"><%= [lang::message::lookup "" intranet-riskmanagement.Impact Impact] %></div>
		</td>
		<td>
			<div class="risk_matrix">
			@risk_chart_html;noquote@
			</div>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td align="center"><%= [lang::message::lookup "" intranet-riskmanagement.Probability Probability] %></td>
	</tr>
	</table>
</td>
</tr>
</if>

<tr>
<td colspan="2">
	<div class="risk_table">
                <form action="/intranet-riskmanagement/action" method=GET>
                <%= [export_vars -form {return_url}] %>
                <table width="100%">
                @table_header_html;noquote@
                @table_body_html;noquote@
                @table_footer_html;noquote@
                </table>
                </form>
	</div>
</td>
</tr>
</table>
</div>





