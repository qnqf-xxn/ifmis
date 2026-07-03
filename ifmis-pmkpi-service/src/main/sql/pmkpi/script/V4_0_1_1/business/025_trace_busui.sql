begin
delete from p#busfw_t_uifunction where key = '/pmkpi/program/tracemanage/taskcopy';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B6D01B5A13AA12B4E0530100007FB566', '/pmkpi/program/tracemanage/taskcopy', '复制', 1, 1, 'Keepicon', 'promanagetaskcopy.taskcopy', null, '复制', 'pmkpi', null, null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B6D01B5A13AB12B4E0530100007FB566', '/pmkpi/program/tracemanage/taskcopy', '取消', 1, 2, 'Nofinishicon', 'Ext.lt.ui.closeModalWindow', null, '取消', 'pmkpi', null, null, null);

delete from p#busfw_t_uieditform where key = '/pmkpi/program/tracemanage/taskcopy';
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B6D01B5A13AC12B4E0530100007FB566', '/pmkpi/program/tracemanage/taskcopy', 'V_PERF_T_PROMONITOR', 'tree', '任务阶段', 'TASKGUID', 1, null, 1, null, 1, 2, null, 'pmkpi', 1, null, '{format:''#name''}', null, null, null);



delete from p#busfw_t_uitable where key = '/pmkpi/program/trace/manage/prolist';
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('B5A085C812ED0888E0535164A8C0487E', '/pmkpi/program/trace/manage/prolist', 'V_PERF_PROJECT_INFO', 100, 1, 0, 'PRO_CODE', ' t.wfstatus=011 and exists(select 1 from pm_perf_goal_info gl where gl.mainguid=t.guid and gl.yearflag=0) ', 'pmkpi', null);


delete from p#busfw_t_uicolumn where key = '/pmkpi/program/trace/manage/prolist';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B5A085C812F10888E0535164A8C0487E', '/pmkpi/program/trace/manage/prolist', 'PRO_CODE', '项目编码', 1, 1, 0, null, null, null, null, null, null, null, null, 150, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B5A085C812EE0888E0535164A8C0487E', '/pmkpi/program/trace/manage/prolist', 'PRO_NAME', '项目名称', 2, 1, 0, null, null, null, null, null, null, null, null, 200, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B5A085C812EF0888E0535164A8C0487E', '/pmkpi/program/trace/manage/prolist', 'AGENCY_CODE', '预算单位', 3, 1, 0, null, null, null, null, null, '#code-#name', null, null, 200, 1, 'tree', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B5A085C812F40888E0535164A8C0487E', '/pmkpi/program/trace/manage/prolist', 'DEPT_CODE', '主管部门', 4, 1, 0, null, null, null, null, null, '#name', null, null, 150, 1, 'tree', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B5A085C812F30888E0535164A8C0487E', '/pmkpi/program/trace/manage/prolist', 'FININTORGGUID', '业务科室', 5, 1, 0, null, null, null, null, null, '#name', null, null, 150, 1, 'tree', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B5A085C812F00888E0535164A8C0487E', '/pmkpi/program/trace/manage/prolist', 'YEAR', '预算年份', 7, 1, 0, null, null, null, null, null, null, null, null, 100, 0, 's', '{}', null);



delete from p#busfw_t_uifunction where key = '/pmkpi/program/trace/manage/prolist';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B5A085C812F80888E0535164A8C0487E', '/pmkpi/program/trace/manage/prolist', '复制任务', 1, 1, 'searchicon', 'protaskprolist.copytask', null, '复制任务', 'pmkpi', 'copytask', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B5A085C812F90888E0535164A8C0487E', '/pmkpi/program/trace/manage/prolist', '纳入任务', 1, 2, 'searchicon', 'protaskprolist.addtask', null, '纳入任务', 'pmkpi', 'addtask', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B5A085C812FA0888E0535164A8C0487E', '/pmkpi/program/trace/manage/prolist', '取消任务', 1, 3, 'searchicon', 'protaskprolist.deltask', null, '取消任务', 'pmkpi', 'deltask', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B5A085C812FB0888E0535164A8C0487E', '/pmkpi/program/trace/manage/prolist', '查询', 1, 4, 'searchicon', 'protaskprolist.query', null, '查询', 'pmkpi', 'query', null, '{}');


delete from p#busfw_t_uiqueryform where key = '/pmkpi/program/trace/manage/prolist';
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('B5A085C812F70888E0535164A8C0487E', '/pmkpi/program/trace/manage/prolist', 'PRO_NAME', '项目名称', 1, 1, 's', null, null, null, 'pmkpi', 'V_PERF_PROJECT_INFO', '{}', null);


delete from p#busfw_t_uitabpage where key = '/pmkpi/program/trace/manage/prolist';
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('B5A085C812FE0888E0535164A8C0487E', 'pmkpi', '/pmkpi/program/trace/manage/prolist', '已纳入', 'alreadyaudit', 1, 2, 'nomal', 'protaskprolist.clickTabpage', 0, '已纳入', null, '复制任务,纳入任务', '{}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('B5A085C812FF0888E0535164A8C0487E', 'pmkpi', '/pmkpi/program/trace/manage/prolist', '未纳入', 'waitaudit', 1, 1, 'choosed', 'protaskprolist.clickTabpage', 0, '未纳入', null, '取消任务', '{}', null, '0', null, null, null, null, null, null, null);





delete from p#busfw_t_uitable where key = '/pmkpi/program/trace/manage/deptlist';
insert into  busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('172F9DAE8708472A9D13E6C6C0B4A725', '/pmkpi/program/trace/manage/deptlist', 'V_PERF_T_DEPTPERFDECLARE', 100, 1, 0, null, 't.wfstatus=011', 'pmkpi', null);

delete from p#busfw_t_uicolumn where key = '/pmkpi/program/trace/manage/deptlist';
insert into  busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('C3CFB702EEF1485285E719C62BC4DECC', '/pmkpi/program/trace/manage/deptlist', 'CODE', '单位编码', 1, 1, 0, null, null, null, null, null, null, null, null, 150, 0, 's', '{}', null);

insert into  busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D1E6E0A0610144209016F254E871FA17', '/pmkpi/program/trace/manage/deptlist', 'NAME', '预算单位', 2, 1, 0, null, null, null, null, null, null, null, null, 200, 0, 's', '{}', null);

insert into  busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('6ECEC48E2BC8426A8504B8510479E2C3', '/pmkpi/program/trace/manage/deptlist', 'FININTORGGUID', '业务科室', 5, 1, 0, null, null, null, null, null, '#name', null, null, 150, 1, 'tree', '{}', null);

insert into  busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('C6FF501A65C04A5EBC31468603EABFBC', '/pmkpi/program/trace/manage/deptlist', 'YEAR', '预算年份', 7, 1, 0, null, null, null, null, null, null, null, null, 100, 0, 's', '{}', null);


delete from p#busfw_t_uiqueryform where key = '/pmkpi/program/trace/manage/deptlist';
insert into  busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('1D47F123B7D64F059CFFD065303E75EC', '/pmkpi/program/trace/manage/deptlist', 'CODE', '单位编码', 1, 1, 's', null, null, null, 'pmkpi', 'V_PERF_PROJECT_INFO', '{}', null);


