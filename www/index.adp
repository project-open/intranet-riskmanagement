<master>
<property name="doc(title)">@page_title;literal@</property>
<property name="context">@context_bar;literal@</property>
<property name="main_navbar_label">@main_navbar_label;literal@</property>
<property name="sub_navbar">@sub_navbar;literal@</property>
<property name="left_navbar">@left_navbar_html;literal@</property>
<property name="show_context_help">@show_context_help_p;literal@</property>


<!-- Show calendar on start- and end-date -->
<script type="text/javascript" <if @::__csp_nonce@ not nil>nonce="@::__csp_nonce;literal@"</if>>
window.addEventListener('load', function() { 
     document.getElementById('start_date_calendar').addEventListener('click', function() { showCalendar('start_date', 'y-m-d'); });
     document.getElementById('end_date_calendar').addEventListener('click', function() { showCalendar('end_date', 'y-m-d'); });
});
</script>

<%= [im_box_header $page_title] %>
@risk_html;noquote@
<%= [im_box_footer] %>

