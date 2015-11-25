<master>
<property name="doc(title)">@page_title;literal@</property>
<property name="context">@context_bar;literal@</property>
<property name="main_navbar_label">@main_navbar_label;literal@</property>
<property name="sub_navbar">@sub_navbar;literal@</property>
<property name="left_navbar">@left_navbar_html;literal@</property>
<property name="show_context_help">@show_context_help_p;literal@</property>


<if @master_p@>
</if>

<%= [im_box_header $page_title] %>
@risk_html;noquote@
<%= [im_box_footer] %>

