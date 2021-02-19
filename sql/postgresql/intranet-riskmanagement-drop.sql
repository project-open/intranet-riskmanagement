-- /package/intranet-forum/sql/intranet-riskmanagement-drop.sql
--
-- Copyright (c) 2003-2006 ]project-open[
--
-- All rights reserved. Please check
-- https://www.project-open.com/license/ for details.
--
-- @author frank.bergmann@project-open.com


-- Drop plugins and menus for the module
--
select  im_component_plugin__del_module('intranet-riskmanagement');
select  im_menu__del_module('intranet-riskmanagement');


-----------------------------------------------------------
-- Drop main structures info

-- Drop functions
drop function im_risk__name(integer);
drop function im_risk__new (
	integer, varchar, timestamptz,
	integer, varchar, integer,
	varchar, integer, integer, integer
);
drop function im_risk__new (
	integer, character varying, timestamp with time zone, 
	integer, character varying, integer, 
	integer, integer, integer, character varying 
);
drop function im_risk__delete(integer);


-- Drop the main table
drop table im_risks;

-- Delete entries from acs_objects
delete from acs_objects where object_type = 'im_risk';

-- Completely delete the object type from the object system
delete from im_dynfield_layout where attribute_id in (
	select attribute_id from im_dynfield_attributes where acs_attribute_id in (
		select attribute_id from acs_attributes where object_type = 'im_risk'
	)
);
delete from im_dynfield_attributes where acs_attribute_id in (
	select attribute_id from acs_attributes where object_type = 'im_risk'
);
delete from acs_attributes where object_type = 'im_risk';
delete from im_dynfield_layout_pages where object_type = 'im_risk';
delete from acs_object_type_tables where object_type = 'im_risk';
delete from im_rest_object_types where object_type = 'im_risk';
SELECT acs_object_type__drop_type ('im_risk', 't');


-----------------------------------------------------------
-- Drop Categories
--
drop view im_risk_status;
drop view im_risk_types;

delete from im_categories where category_type = 'Intranet Risk Status';
delete from im_categories where category_type = 'Intranet Risk Type';


