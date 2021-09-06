-- upgrade-5.0.3.0.4-5.1.0.0.0.sql

SELECT acs_log__debug('/packages/intranet-riskmanagement/sql/postgresql/upgrade/upgrade-5.0.3.0.4-5.1.0.0.0.sql','');



delete from im_view_columns where column_id = 21000;

-- Add a "select all" checkbox to select all risks in the list
insert into im_view_columns (
        column_id, view_id, sort_order,
	column_name,
	column_render_tcl,
        visible_for
) values (
        21000, 210, 0,
        '<input id=list_check_all_risks type=checkbox name=_dummy>',
        '"<input type=checkbox name=risk_id.$risk_id id=risk.$risk_id>"',
        ''
);
