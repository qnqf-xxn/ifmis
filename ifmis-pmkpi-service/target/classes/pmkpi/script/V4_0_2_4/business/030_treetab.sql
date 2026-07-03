begin
  --问题整改，左侧页签流程id
delete from perf_t_treetab where key in('/pmkpi/rectification/query','/pmkpi/rectification/index','/pmkpi/rectification/audit/index',
'/pmkpi/rectification/feedback/index','/pmkpi/rectification/feedback/audit/index');
insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values ('CF3C5CCB439E3375E0533315A8C0E106', '/pmkpi/rectification/index', 'dept', '部门整体', 1, '查看项目', 2, '2016', '87', '{rectifytrace:''D7F6D15AB0E37ECFE0533315A8C04610'',rectifyperfself:''D7F6D15AB0E17ECFE0533315A8C04610'',rectifyfinancialeval:''D7F6D15AB0E57ECFE0533315A8C04610'',rectifydepteval:''D7F6D15AB0E77ECFE0533315A8C04610''}', 'deptrectificationhide');
insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values ('CF3C5CCB439F3375E0533315A8C0E107', '/pmkpi/rectification/index', 'program', '项目支出', 1, null, 1, '2016', '87', '{rectifytrace:''D7F6D15AB0E27ECFE0533315A8C04610'',rectifyperfself:''D7F6D15AB0E07ECFE0533315A8C04610'',rectifyfinancialeval:''D7F6D15AB0E47ECFE0533315A8C04610'',rectifydepteval:''D7F6D15AB0E67ECFE0533315A8C04610''}', 'programrectificationhide');

insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values ('CF3C5CCB439E3375E0533315A8C0E108', '/pmkpi/rectification/audit/index', 'dept', '部门整体', 1, '查看项目', 2, '2016', '87', '{rectifytrace:''D7F6D15AB0E37ECFE0533315A8C04610'',rectifyperfself:''D7F6D15AB0E17ECFE0533315A8C04610'',rectifyfinancialeval:''D7F6D15AB0E57ECFE0533315A8C04610'',rectifydepteval:''D7F6D15AB0E77ECFE0533315A8C04610''}', 'deptrectiaudithide');
insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values ('CF3C5CCB439F3375E0533315A8C0E109', '/pmkpi/rectification/audit/index', 'program', '项目支出', 1, null, 1, '2016', '87', '{rectifytrace:''D7F6D15AB0E27ECFE0533315A8C04610'',rectifyperfself:''D7F6D15AB0E07ECFE0533315A8C04610'',rectifyfinancialeval:''D7F6D15AB0E47ECFE0533315A8C04610'',rectifydepteval:''D7F6D15AB0E67ECFE0533315A8C04610''}', 'programrectiaudithide');

insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values ('CF3C5CCB439E3375E0533315A8C0E110', '/pmkpi/rectification/feedback/index', 'dept', '部门整体', 1, '查看项目', 2, '2016', '87', '{rectifytrace:''D7F6D15AB0E37ECFE0533315A8C04610'',rectifyperfself:''D7F6D15AB0E17ECFE0533315A8C04610'',rectifyfinancialeval:''D7F6D15AB0E57ECFE0533315A8C04610'',rectifydepteval:''D7F6D15AB0E77ECFE0533315A8C04610''}', 'deptfeedbackhide');
insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values ('CF3C5CCB439F3375E0533315A8C0E111', '/pmkpi/rectification/feedback/index', 'program', '项目支出', 1, null, 1, '2016', '87', '{rectifytrace:''D7F6D15AB0E27ECFE0533315A8C04610'',rectifyperfself:''D7F6D15AB0E07ECFE0533315A8C04610'',rectifyfinancialeval:''D7F6D15AB0E47ECFE0533315A8C04610'',rectifydepteval:''D7F6D15AB0E67ECFE0533315A8C04610''}', 'programfeedbackhide');

insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values ('CF3C5CCB439E3375E0533315A8C0E112', '/pmkpi/rectification/feedback/audit/index', 'dept', '部门整体', 1, '查看项目', 2, '2016', '87', '{rectifytrace:''D7F6D15AB0E37ECFE0533315A8C04610'',rectifyperfself:''D7F6D15AB0E17ECFE0533315A8C04610'',rectifyfinancialeval:''D7F6D15AB0E57ECFE0533315A8C04610'',rectifydepteval:''D7F6D15AB0E77ECFE0533315A8C04610''}', 'deptfeedaudithide');
insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values ('CF3C5CCB439F3375E0533315A8C0E113', '/pmkpi/rectification/feedback/audit/index', 'program', '项目支出', 1, null, 1, '2016', '87', '{rectifytrace:''D7F6D15AB0E27ECFE0533315A8C04610'',rectifyperfself:''D7F6D15AB0E07ECFE0533315A8C04610'',rectifyfinancialeval:''D7F6D15AB0E47ECFE0533315A8C04610'',rectifydepteval:''D7F6D15AB0E67ECFE0533315A8C04610''}', 'programfeedaudithide');

insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values ('CF3C5CCB439F3375E0533315A8C0E114', '/pmkpi/rectification/query', 'dept', '部门整体', 1, '查看项目', 2, '2016', '87', '{rectifytrace:''D7F6D15AB0E37ECFE0533315A8C04610'',rectifyperfself:''D7F6D15AB0E17ECFE0533315A8C04610'',rectifyfinancialeval:''D7F6D15AB0E57ECFE0533315A8C04610'',rectifydepteval:''D7F6D15AB0E77ECFE0533315A8C04610''}', 'deptrectifyqueryhide');
insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values ('CF3C5CCB439F3375E0533315A8C0E115', '/pmkpi/rectification/query', 'program', '项目支出', 1, null, 1, '2016', '87', '{rectifytrace:''D7F6D15AB0E27ECFE0533315A8C04610'',rectifyperfself:''D7F6D15AB0E07ECFE0533315A8C04610'',rectifyfinancialeval:''D7F6D15AB0E47ECFE0533315A8C04610'',rectifydepteval:''D7F6D15AB0E67ECFE0533315A8C04610''}', 'programrectifyqueryhide');


--问题整改 选择项目页面，根据左侧树走不同的流程
delete from bus_t_pageconsolecomconfig where url ='/pmkpi/rectification/check/proj';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/check/proj', 'pmkpi_rectificationcheck', '{}', 'rectificationcheck', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/check/proj', 'buslefttree', '{rectifytrace:''D7F6D15AB0E27ECFE0533315A8C04610'',rectifyperfself:''D7F6D15AB0E07ECFE0533315A8C04610'',rectifyfinancialeval:''D7F6D15AB0E47ECFE0533315A8C04610'',rectifydepteval:''D7F6D15AB0E67ECFE0533315A8C04610''}', 'lefttree', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/check/proj', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/check/proj', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''table'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/check/proj', 'busuidatatable', '{name:''选择项目'',checkbox:false,tiptiptiptiptitle:''选择项目'',edit:false,addrow:false,radio:true,title:''选择项目''}', 'datatable', 'pmkpi', null);

delete from bus_t_pageconsolecomconfig where url ='/pmkpi/rectification/check/deptproj';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/check/deptproj', 'pmkpi_rectificationcheck', '{}', 'rectificationcheck', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/check/deptproj', 'buslefttree', '{rectifytrace:''D7F6D15AB0E37ECFE0533315A8C04610'',rectifyperfself:''D7F6D15AB0E17ECFE0533315A8C04610'',rectifyfinancialeval:''D7F6D15AB0E57ECFE0533315A8C04610'',rectifydepteval:''D7F6D15AB0E77ECFE0533315A8C04610''}', 'lefttree', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/check/deptproj', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/check/deptproj', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''table'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/check/deptproj', 'busuidatatable', '{name:''部门'',checkbox:false,title:''部门'',edit:false,addrow:false,radio:true}', 'datatable', 'pmkpi', null);

