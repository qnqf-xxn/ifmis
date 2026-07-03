begin

--1、整改列表查询
delete from p#busfw_t_uifunction where key = '/pmkpi/rectification/query' and code = 'proDetail';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/rectification/query', '查看项目明细', 1, 12, 'addaction', 'rectifyquery.proDetail', null, '查看项目明细', 'pmkpi', 'proDetail', null, null, null, null);
--部门整体左侧页签隐藏按钮-查看项目明细
delete from perf_t_treetab where key = '/pmkpi/rectification/query' and code = 'dept';
insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values ('CF3C5CCB439F3375E0533315A8C0E114', '/pmkpi/rectification/query', 'dept', '部门整体', 1, '查看项目,查看项目明细', 2, '2016', '87', '{rectifytrace:''D7F6D15AB0E37ECFE0533315A8C04610'',rectifyperfself:''D7F6D15AB0E17ECFE0533315A8C04610'',rectifyfinancialeval:''D7F6D15AB0E57ECFE0533315A8C04610'',rectifydepteval:''D7F6D15AB0E77ECFE0533315A8C04610''}', 'deptrectifyqueryhide');

--2、整改通知审核
delete from p#busfw_t_uifunction where key = '/pmkpi/rectification/audit/index' and code = 'proDetail';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/rectification/audit/index', '查看项目明细', 1, 12, 'addaction', 'rectificationaudit.proDetail', null, '查看项目明细', 'pmkpi', 'proDetail', null, null, null, null);
--部门整体左侧页签隐藏按钮-查看项目明细
delete from perf_t_treetab where key = '/pmkpi/rectification/audit/index' and code = 'dept';
insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values ('CF3C5CCB439E3375E0533315A8C0E108', '/pmkpi/rectification/audit/index', 'dept', '部门整体', 1, '查看项目,查看项目明细', 2, '2016', '87', '{rectifytrace:''D7F6D15AB0E37ECFE0533315A8C04610'',rectifyperfself:''D7F6D15AB0E17ECFE0533315A8C04610'',rectifyfinancialeval:''D7F6D15AB0E57ECFE0533315A8C04610'',rectifydepteval:''D7F6D15AB0E77ECFE0533315A8C04610''}', 'deptrectiaudithide');

--3、整改情况反馈
delete from p#busfw_t_uifunction where key = '/pmkpi/rectification/feedback/index' and code = 'proDetail';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/rectification/feedback/index', '查看项目明细', 1, 12, 'addaction', 'feedback.proDetail', null, '查看项目明细', 'pmkpi', 'proDetail', null, null, null, null);
--部门整体左侧页签隐藏按钮-查看项目明细
delete from perf_t_treetab where key = '/pmkpi/rectification/feedback/index' and code = 'dept';
insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values ('CF3C5CCB439E3375E0533315A8C0E110', '/pmkpi/rectification/feedback/index', 'dept', '部门整体', 1, '查看项目,查看项目明细', 2, '2016', '87', '{rectifytrace:''D7F6D15AB0E37ECFE0533315A8C04610'',rectifyperfself:''D7F6D15AB0E17ECFE0533315A8C04610'',rectifyfinancialeval:''D7F6D15AB0E57ECFE0533315A8C04610'',rectifydepteval:''D7F6D15AB0E77ECFE0533315A8C04610''}', 'deptfeedbackhide');

--4、整改情况审核
delete from p#busfw_t_uifunction where key = '/pmkpi/rectification/feedback/audit/index' and code = 'proDetail';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/rectification/feedback/audit/index', '查看项目明细', 1, 12, 'addaction', 'feedbackAudit.proDetail', null, '查看项目明细', 'pmkpi', 'proDetail', null, null, null, null);
--部门整体左侧页签隐藏按钮-查看项目明细
delete from perf_t_treetab where key = '/pmkpi/rectification/feedback/audit/index' and code = 'dept';
insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values ('CF3C5CCB439E3375E0533315A8C0E112', '/pmkpi/rectification/feedback/audit/index', 'dept', '部门整体', 1, '查看项目,查看项目明细', 2, '2016', '87', '{rectifytrace:''D7F6D15AB0E37ECFE0533315A8C04610'',rectifyperfself:''D7F6D15AB0E17ECFE0533315A8C04610'',rectifyfinancialeval:''D7F6D15AB0E57ECFE0533315A8C04610'',rectifydepteval:''D7F6D15AB0E77ECFE0533315A8C04610''}', 'deptfeedaudithide');





