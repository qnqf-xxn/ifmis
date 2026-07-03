begin

--busui
--ui表注册
delete from p#busfw_t_uitable where key = '/pmkpi/program/trace/keytask/send' ;
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('DBA939C5921434B0E0533315A8C0C99E', '/pmkpi/program/trace/keytask/send', 'V_PERF_ADJUSTPROJECT_INFO', 100, 1, 0, 't.pro_code', null, 'pmkpi', null);
--展示列注册
delete from p#busfw_t_uicolumn where  key = '/pmkpi/program/trace/keytask/send';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('DBA939C5920D34B0E0533315A8C0C99E', '/pmkpi/program/trace/keytask/send', 'PRO_CODE', '项目编码', 1, 1, 0, null, null, null, null, null, null, null, null, 150, 0, 's', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('DBA939C5920E34B0E0533315A8C0C99E', '/pmkpi/program/trace/keytask/send', 'PRO_NAME', '项目名称', 2, 1, 0, null, null, null, 1, null, null, null, null, 200, 0, 's', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('DBA939C5920F34B0E0533315A8C0C99E', '/pmkpi/program/trace/keytask/send', 'AGENCY_CODE', '预算单位', 3, 1, 0, null, null, null, null, null, '#code-#name', null, null, 200, 1, 'tree', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('DBA939C5921034B0E0533315A8C0C99E', '/pmkpi/program/trace/keytask/send', 'DEPT_CODE', '主管部门', 4, 1, 0, null, null, null, null, null, '#name', null, null, 150, 1, 'tree', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('DBA939C5921134B0E0533315A8C0C99E', '/pmkpi/program/trace/keytask/send', 'FININTORGGUID', '业务科室', 5, 0, 0, null, null, null, null, null, '#name', null, null, 150, 1, 'tree', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('DBA939C5921234B0E0533315A8C0C99E', '/pmkpi/program/trace/keytask/send', 'YEAR', '预算年份', 6, 0, 0, null, null, null, null, null, null, null, null, 100, 0, 's', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('DBA939C5921334B0E0533315A8C0C99E', '/pmkpi/program/trace/keytask/send', 'CREATE_TIME', '创建时间', 7, 0, 0, null, null, null, null, null, 'yyyy-MM-dd hh:mm:ss', null, null, 100, 0, 'd', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('DA61946DC9E9101EE0533315A8C0D73D', '/pmkpi/program/trace/keytask/send', 'MONIGUID', '监控项目GUID', 8, 0, 0, null, null, null, null, null, null, null, null, 100, 0, 's', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('DA61946DC9EC101EE0533315A8C0D73D', '/pmkpi/program/trace/keytask/send', 'TASKGUID', '监控任务GUID', 9, 0, 0, null, null, null, null, null, null, null, null, 100, 0, 's', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('DA61946DC9EB101EE0533315A8C0D73D', '/pmkpi/program/trace/keytask/send', 'PROGUID', '项目GUID', 10, 0, 0, null, null, null, null, null, null, null, null, 100, 0, 's', '{}', null);
--按钮注册
delete from p#busfw_t_uifunction where key = '/pmkpi/program/trace/keytask/send';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('DBA939C5920234B0E0533315A8C0C99E', '/pmkpi/program/trace/keytask/send', '任务下达', 1, 1, null, 'keytasksend.sendtask', null, '任务下达', 'pmkpi', 'sendtask', null, null);
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('DBA939C5920334B0E0533315A8C0C99E', '/pmkpi/program/trace/keytask/send', '取消下达', 1, 2, null, 'keytasksend.cencelsend', null, '取消下达', 'pmkpi', 'cencelsend', null, null);
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('DBF99E964C08287EE0533315A8C06D33', '/pmkpi/program/trace/keytask/send', '查看明细', 1, 3, 'searchicon', 'keytasksend.detailed', null, '查看明细', 'pmkpi', 'detailed', null, '{}');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('DBF99E964C09287EE0533315A8C06D33', '/pmkpi/program/trace/keytask/send', '查看项目', 1, 4, null, 'keytasksend.showProjView', null, '查看项目', 'pmkpi', 'showProjView', null, null);
--查询区注册
delete from p#busfw_t_uiqueryform where key = '/pmkpi/program/trace/keytask/send';
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, REQUIREMENT)
values ('DBA939C5920B34B0E0533315A8C0C99E', '/pmkpi/program/trace/keytask/send', 'PRO_CODE', '项目编码', 1, 1, 's', null, null, null, 'pmkpi', 'V_PERF_PROJECT_INFO', '{}', null, null);
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, REQUIREMENT)
values ('DBA939C5920C34B0E0533315A8C0C99E', '/pmkpi/program/trace/keytask/send', 'PRO_NAME', '项目名称', 2, 1, 's', null, null, null, 'pmkpi', 'V_PERF_PROJECT_INFO', '{}', null, null);
--页签注册
delete from p#busfw_t_uitabpage where key = '/pmkpi/program/trace/keytask/send';
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('DBA939C5920034B0E0533315A8C0C99E', 'pmkpi', '/pmkpi/program/trace/keytask/send', '未下达', 'waitsend', 1, 1, 'choosed', 'keytasksend.clickTabpage', null, '未下达', null, '取消下达', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('DBA939C5920134B0E0533315A8C0C99E', 'pmkpi', '/pmkpi/program/trace/keytask/send', '已下达', 'alreadysend', 1, 2, 'nomal', 'keytasksend.clickTabpage', null, '已下达', null, '任务下达', '{}', null, '0', null, null, null, null, null, null, null);

