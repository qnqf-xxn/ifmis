begin


--绩效任务布置
delete from p#busfw_t_uitable t where t.key in('/pmkpi/setting/taskset/list');
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('B5A085C812800888E0535164A8C0487E', '/pmkpi/setting/taskset/list', 'V_PERF_T_TASKSET', 0, 0, 0, null, null, 'pmkpi', null);

delete from p#busfw_t_uicolumn t where t.key in('/pmkpi/setting/taskset/list');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B5A085C8128F0888E0535164A8C0487E', '/pmkpi/setting/taskset/list', 'NAME', '任务名称', 1, 1, 0, null, null, null, null, null, null, null, null, 200, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B5A085C812900888E0535164A8C0487E', '/pmkpi/setting/taskset/list', 'BUSTYPE', '业务类型', 2, 1, 0, null, null, null, null, null, '#name', null, null, 150, 1, 'tree', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B5A085C812910888E0535164A8C0487E', '/pmkpi/setting/taskset/list', 'TASKTYPE', '任务类型', 3, 1, 0, null, null, null, null, null, '#name', null, null, 150, 1, 'tree', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B5A085C812920888E0535164A8C0487E', '/pmkpi/setting/taskset/list', 'TASKSTAGE', '任务阶段', 4, 1, 0, null, null, null, null, null, '#name', null, null, 120, 1, 'tree', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B5A085C812930888E0535164A8C0487E', '/pmkpi/setting/taskset/list', 'STARTDATE', '任务开始时间', 5, 1, 0, null, null, null, null, null, 'yyyy-MM-dd', null, null, 120, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B5A085C812940888E0535164A8C0487E', '/pmkpi/setting/taskset/list', 'ENDDATE', '任务结束时间', 6, 1, 0, null, null, null, null, null, 'yyyy-MM-dd', null, null, 120, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B5A085C812950888E0535164A8C0487E', '/pmkpi/setting/taskset/list', 'WARNDAYS', '提前预警天数', 7, 1, 0, null, null, null, null, null, null, null, null, 120, 0, 'i', '{}', null);

delete from p#busfw_t_uifunction t where t.key in('/pmkpi/setting/taskset/list');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B5A085C812960888E0535164A8C0487E', '/pmkpi/setting/taskset/list', '查询', 1, 4, 'searchicon', 'tasksetlist.query', null, '查询', 'pmkpi', 'query', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B5A085C812970888E0535164A8C0487E', '/pmkpi/setting/taskset/list', '新增', 1, 1, 'searchicon', 'tasksetlist.add', null, '新增', 'pmkpi', 'add', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B5A085C812980888E0535164A8C0487E', '/pmkpi/setting/taskset/list', '修改', 1, 2, 'searchicon', 'tasksetlist.mod', null, '修改', 'pmkpi', 'toEdit', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B5A085C812990888E0535164A8C0487E', '/pmkpi/setting/taskset/list', '删除', 1, 3, 'searchicon', 'tasksetlist.del', null, '删除', 'pmkpi', 'del', null, '{}');

delete from p#busfw_t_uiqueryform t where t.key in('/pmkpi/setting/taskset/list');
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('B5A085C8129A0888E0535164A8C0487E', '/pmkpi/setting/taskset/list', 'NAME', '任务名称', 1, 1, 's', null, null, null, 'pmkpi', 'PERF_T_TASKSET', '{}', null);


delete from p#busfw_t_uifunction t where t.key in('/pmkpi/setting/taskset/edit');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B5A085C812A40888E0535164A8C0487E', '/pmkpi/setting/taskset/edit', '取消', 1, 2, 'Nofinishicon', 'Ext.lt.ui.closeModalWindow', null, '取消', 'pmkpi', null, null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B5A085C812A50888E0535164A8C0487E', '/pmkpi/setting/taskset/edit', '保存', 1, 1, 'Keepicon', 'tasksetedit.infosave', null, '保存', 'pmkpi', null, null, null);

delete from p#busfw_t_uieditform t where t.key in('/pmkpi/setting/taskset/edit');
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B5A085C812AE0888E0535164A8C0487E', '/pmkpi/setting/taskset/edit', 'V_PERF_T_TASKSET', 's', '创建人', 'CREATER', 0, null, 0, null, 19, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B5A085C812BB0888E0535164A8C0487E', '/pmkpi/setting/taskset/edit', 'V_PERF_T_TASKSET', 'i', '预警天数', 'WARNDAYS', 1, null, 1, null, 7, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B5A085C812BA0888E0535164A8C0487E', '/pmkpi/setting/taskset/edit', 'V_PERF_T_TASKSET', 's', '修改时间', 'UPDATE_TIME', 0, null, 0, null, 14, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B5A085C812B10888E0535164A8C0487E', '/pmkpi/setting/taskset/edit', 'V_PERF_T_TASKSET', 's', '年度', 'FISCAL_YEAR', 0, null, 0, null, 13, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B5A085C812AC0888E0535164A8C0487E', '/pmkpi/setting/taskset/edit', 'V_PERF_T_TASKSET', 's', '单位', 'AGENCY_CODE', 0, null, 0, null, 18, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B5A085C812B50888E0535164A8C0487E', '/pmkpi/setting/taskset/edit', 'V_PERF_T_TASKSET', 's', '任务名称', 'NAME', 1, null, 1, null, 3, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B5A085C812AF0888E0535164A8C0487E', '/pmkpi/setting/taskset/edit', 'V_PERF_T_TASKSET', 's', '创建时间', 'CREATE_TIME', 0, null, 0, null, 20, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B5A085C812B60888E0535164A8C0487E', '/pmkpi/setting/taskset/edit', 'V_PERF_T_TASKSET', 'd', '任务开始时间', 'STARTDATE', 1, null, 1, null, 5, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B5A085C812AB0888E0535164A8C0487E', '/pmkpi/setting/taskset/edit', 'V_PERF_T_TASKSET', 's', '单位', 'AGENCYGUID', 0, null, 0, null, 17, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B5A085C812B70888E0535164A8C0487E', '/pmkpi/setting/taskset/edit', 'V_PERF_T_TASKSET', 'i', '状态', 'STATUS', 0, null, 0, null, 15, null, null, 'pmkpi', 0, null, '{"fromsource":0,"sourcelevelval":""}', 0, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B5A085C812B40888E0535164A8C0487E', '/pmkpi/setting/taskset/edit', 'V_PERF_T_TASKSET', 's', '区划', 'MOF_DIV_CODE', 0, null, 0, null, 16, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B5A085C812B30888E0535164A8C0487E', '/pmkpi/setting/taskset/edit', 'V_PERF_T_TASKSET', 'i', '是否删除', 'IS_DELETED', 0, null, 0, null, 11, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B5A085C812B20888E0535164A8C0487E', '/pmkpi/setting/taskset/edit', 'V_PERF_T_TASKSET', 's', '主建', 'GUID', 0, null, 0, null, 12, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B5A085C812B90888E0535164A8C0487E', '/pmkpi/setting/taskset/edit', 'V_PERF_T_TASKSET', 'tree', '任务类型', 'TASKTYPE', 1, null, 1, null, 2, null, null, 'pmkpi', 0, null, '{format:''#name''}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B5A085C812AD0888E0535164A8C0487E', '/pmkpi/setting/taskset/edit', 'V_PERF_T_TASKSET', 'tree', '业务类型', 'BUSTYPE', 1, null, 1, null, 1, null, null, 'pmkpi', 0, null, '{format:''#name''}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B5A085C812B80888E0535164A8C0487E', '/pmkpi/setting/taskset/edit', 'V_PERF_T_TASKSET', 'tree', '任务阶段', 'TASKSTAGE', 1, null, 1, null, 4, null, null, 'pmkpi', 1, null, '{format:''#name''}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B5A085C812B00888E0535164A8C0487E', '/pmkpi/setting/taskset/edit', 'V_PERF_T_TASKSET', 'd', '任务结束时间', 'ENDDATE', 1, null, 1, null, 6, null, null, 'pmkpi', 1, null, '{}', null, null, null);


--项目绩效监控下达
delete from p#busfw_t_uitable t where t.key in('/pmkpi/program/trace/manage/prolist');
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('B5A085C812ED0888E0535164A8C0487E', '/pmkpi/program/trace/manage/prolist', 'V_PERF_PROJECT_INFO', 100, 1, 0, 'PRO_CODE', null, 'pmkpi', null);

delete from p#busfw_t_uicolumn t where t.key in('/pmkpi/program/trace/manage/prolist');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B5A085C812F10888E0535164A8C0487E', '/pmkpi/program/trace/manage/prolist', 'PRO_CODE', '项目编码', 1, 1, 0, null, null, null, null, null, null, null, null, 150, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B5A085C812EE0888E0535164A8C0487E', '/pmkpi/program/trace/manage/prolist', 'PRO_NAME', '项目名称', 2, 1, 0, null, null, null, null, null, null, null, null, 200, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B5A085C812EF0888E0535164A8C0487E', '/pmkpi/program/trace/manage/prolist', 'AGENCY_CODE', '预算单位', 3, 1, 0, null, null, null, null, null, '#code-#name', null, null, 200, 1, 'tree', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B5A085C812F40888E0535164A8C0487E', '/pmkpi/program/trace/manage/prolist', 'MANAGE_DEPT_CODE', '主管部门', 4, 1, 0, null, null, null, null, null, '#name', null, null, 150, 1, 'tree', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B5A085C812F30888E0535164A8C0487E', '/pmkpi/program/trace/manage/prolist', 'MOF_DEP_CODE', '业务科室', 5, 1, 0, null, null, null, null, null, '#name', null, null, 150, 1, 'tree', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B5A085C812F00888E0535164A8C0487E', '/pmkpi/program/trace/manage/prolist', 'YEAR', '预算年份', 7, 1, 0, null, null, null, null, null, null, null, null, 100, 0, 's', '{}', null);

delete from p#busfw_t_uifunction t where t.key in('/pmkpi/program/trace/manage/tasklist','/pmkpi/program/trace/manage/prolist');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B5A085C812DC0888E0535164A8C0487E', '/pmkpi/program/trace/manage/tasklist', '查询', 1, 2, 'searchicon', 'protasklist.query', null, '查询', 'pmkpi', 'query', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B5A085C812DD0888E0535164A8C0487E', '/pmkpi/program/trace/manage/tasklist', '任务范围布置', 1, 1, 'searchicon', 'protasklist.tasktrace', null, '任务范围布置', 'pmkpi', 'add', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B5A085C812F80888E0535164A8C0487E', '/pmkpi/program/trace/manage/prolist', '复制任务', 1, 1, 'searchicon', 'protaskprolist.copytask', null, '复制任务', 'pmkpi', 'copytask', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B5A085C812F90888E0535164A8C0487E', '/pmkpi/program/trace/manage/prolist', '纳入任务', 1, 2, 'searchicon', 'protaskprolist.addtask', null, '纳入任务', 'pmkpi', 'addtask', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B5A085C812FA0888E0535164A8C0487E', '/pmkpi/program/trace/manage/prolist', '取消任务', 1, 3, 'searchicon', 'protaskprolist.deltask', null, '取消任务', 'pmkpi', 'deltask', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B5A085C812FB0888E0535164A8C0487E', '/pmkpi/program/trace/manage/prolist', '查询', 1, 4, 'searchicon', 'protaskprolist.query', null, '查询', 'pmkpi', 'query', null, '{}');

delete from p#busfw_t_uiqueryform t where t.key in('/pmkpi/program/trace/manage/prolist');
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('B5A085C812F70888E0535164A8C0487E', '/pmkpi/program/trace/manage/prolist', 'PRO_NAME', '项目名称', 1, 1, 's', null, null, null, 'pmkpi', 'V_PERF_PROJECT_INFO', '{}', null);

delete from p#busfw_t_uitabpage t where t.key in('/pmkpi/program/trace/manage/prolist');
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('B5A085C812FF0888E0535164A8C0487E', 'pmkpi', '/pmkpi/program/trace/manage/prolist', '未纳入', 'waitaudit', 1, 1, 'choosed', 'protaskprolist.clickTabpage', 0, '未纳入', null, '取消任务', '{}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('B5A085C812FE0888E0535164A8C0487E', 'pmkpi', '/pmkpi/program/trace/manage/prolist', '已纳入', 'alreadyaudit', 1, 2, 'nomal', 'protaskprolist.clickTabpage', 0, '已纳入', null, '复制任务,纳入任务', '{}', null, '0', null, null, null, null, null, null, null);

--复制任务
delete from p#busfw_t_uifunction t where key in('/pmkpi/program/tracemanage/taskcopy');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B6D01B5A13AA12B4E0530100007FB566', '/pmkpi/program/tracemanage/taskcopy', '复制', 1, 1, 'Keepicon', 'promanagetaskcopy.taskcopy', null, '复制', 'pmkpi', null, null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B6D01B5A13AB12B4E0530100007FB566', '/pmkpi/program/tracemanage/taskcopy', '取消', 1, 2, 'Nofinishicon', 'Ext.lt.ui.closeModalWindow', null, '取消', 'pmkpi', null, null, null);

delete from p#busfw_t_uieditform t where key in('/pmkpi/program/tracemanage/taskcopy');
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B6D01B5A13AC12B4E0530100007FB566', '/pmkpi/program/tracemanage/taskcopy', 'V_PERF_T_PROMONITOR', 'tree', '任务阶段', 'TASKGUID', 1, null, 1, null, 1, 2, null, 'pmkpi', 1, null, '{format:''#name''}', null, null, null);


--填报列表
delete from p#busfw_t_uitable t where key in('/pmkpi/program/trace/report');
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('B6FF9A5A131017AFE0530100007FC89C', '/pmkpi/program/trace/report', 'PERF_V_PROMONITOR', 100, 0, 0, null, null, 'pmkpi', null);

delete from p#busfw_t_uicolumn t where key in('/pmkpi/program/trace/report');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B6FF9A5A131517AFE0530100007FC89C', '/pmkpi/program/trace/report', 'WFSTATUS', '状态', 1, 1, 0, 0, null, 0, 6, null, '#name', null, null, 80, 1, 'tree', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B6FF9A5A131417AFE0530100007FC89C', '/pmkpi/program/trace/report', 'GUID', 'guid', 1, 0, 0, 0, null, 0, 6, null, null, null, null, null, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BF5EDC3A1D83A028E053B11FA8C0F75E', '/pmkpi/program/trace/report', 'TASKTYPE', '任务类型', 1, 0, 0, 0, null, 0, 6, null, '#name', null, null, 100, 1, 'tree', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B6FF9A5A131117AFE0530100007FC89C', '/pmkpi/program/trace/report', 'PRO_CODE', '项目编码', 2, 1, 0, 0, null, 0, 6, null, null, null, null, 150, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B6FF9A5A131217AFE0530100007FC89C', '/pmkpi/program/trace/report', 'PRO_NAME', '项目名称', 3, 1, 0, 0, null, 0, 6, null, null, null, null, 200, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B6FF9A5A131317AFE0530100007FC89C', '/pmkpi/program/trace/report', 'AGENCYGUID', '预算单位', 5, 1, 0, 0, null, 0, 6, null, '#code-#name', null, null, 180, 1, 'tree', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B6FF9A5A131617AFE0530100007FC89C', '/pmkpi/program/trace/report', 'TASKSTAGE', '监控阶段', 9, 1, 0, 0, null, 0, 6, null, '#name', null, null, 80, 1, 'tree', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B6FF9A5A131717AFE0530100007FC89C', '/pmkpi/program/trace/report', 'WARNDAYS', '预警截止天数', 10, 1, 0, 0, null, 0, 6, null, null, null, null, 80, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B6FF9A5A131D17AFE0530100007FC89C', '/pmkpi/program/trace/report', 'FININTORGGUID', '业务处室', 11, 1, 0, 0, null, 0, 6, null, '#name', null, null, 150, 1, 'tree', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B6FF9A5A131817AFE0530100007FC89C', '/pmkpi/program/trace/report', 'BGTWARN', '预算执行预警', 13, 1, 0, 0, null, 0, 6, null, null, null, null, 100, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B6FF9A5A131917AFE0530100007FC89C', '/pmkpi/program/trace/report', 'GOALWARN', '目标完成预警', 14, 1, 0, 0, null, 0, 6, null, null, null, null, 100, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B6FF9A5A131A17AFE0530100007FC89C', '/pmkpi/program/trace/report', 'DEPTTASK', '一般监控', 15, 1, 0, 0, null, 0, 6, null, '#name', null, null, 80, 1, 'tree', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B6FF9A5A131B17AFE0530100007FC89C', '/pmkpi/program/trace/report', 'PROVINCETASK', '重点监控', 16, 1, 0, 0, null, 0, 6, null, '#name', null, null, 80, 1, 'tree', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B7279B405D667EB4E0530100007FD738', '/pmkpi/program/trace/report', 'WARN', '预警', 17, 0, 0, 0, null, 0, 6, null, null, null, null, null, 0, 's', null, null);

delete from p#busfw_t_uitabpage t where t.key in('/pmkpi/program/trace/report');
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('B71F832B8AEA03B0E0530100007FA9FF', 'pmkpi', '/pmkpi/program/trace/report', '待送审', 'waitaudit', 1, 1, 'choosed', 'protaskreport.clickTabpage', null, '待送审', null, '取消送审', '{}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('B71F832B8AE903B0E0530100007FA9FF', 'pmkpi', '/pmkpi/program/trace/report', '已送审', 'alreadyaudit', 1, 2, 'nomal', 'protaskreport.clickTabpage', null, '已送审', null, '填报/修改,删除,送审', '{}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('B71F832B8AEB03B0E0530100007FA9FF', 'pmkpi', '/pmkpi/program/trace/report', '曾经办', 'alldeals', 1, 3, 'nomal', 'protaskreport.clickTabpage', null, '曾经办', null, '填报/修改,删除,送审,取消送审', '{}', null, '0', null, null, null, null, null, null, null);

delete from p#busfw_t_uifunction t where key in('/pmkpi/program/trace/report');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B71F832B8AF003B0E0530100007FA9FF', '/pmkpi/program/trace/report', '填报/修改', 1, 2, 'searchicon', 'protaskreport.addOredit', null, '填报/修改', 'pmkpi', 'save', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B71F832B8AEC03B0E0530100007FA9FF', '/pmkpi/program/trace/report', '送审', 1, 4, 'searchicon', 'protaskreport.wfAudit', null, '送审', 'pmkpi', 'sendaudit', null, '{remark:true}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B71F832B8AEE03B0E0530100007FA9FF', '/pmkpi/program/trace/report', '取消送审', 1, 5, 'searchicon', 'protaskreport.wfAudit', null, '取消送审', 'pmkpi', 'cancelsendaudit', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B71F832B8AED03B0E0530100007FA9FF', '/pmkpi/program/trace/report', '审核情况', 1, 6, 'searchicon', 'protaskreport.queryaudit', null, '审核情况', 'pmkpi', 'queryaudit', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B71F832B8AEF03B0E0530100007FA9FF', '/pmkpi/program/trace/report', '查询', 1, 7, 'searchicon', 'protaskreport.query', null, '查询', 'pmkpi', 'query', null, '{}');

delete from p#busfw_t_uiqueryform t where t.key in('/pmkpi/program/trace/report');
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('B71F832B8AF303B0E0530100007FA9FF', '/pmkpi/program/trace/report', 'PRO_NAME', '项目名称', 1, 1, 's', null, null, null, 'pmkpi', 'PERF_V_PROMONITOR', null, null);

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('B71F832B8AF403B0E0530100007FA9FF', '/pmkpi/program/trace/report', 'WFSTATUS', '状态', 2, 1, 'tree', null, null, null, 'pmkpi', 'PERF_V_PROMONITOR', null, null);

delete from p#busfw_t_uitable t where key in('/pmkpi/trace/report/dept');
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('BA6C49818FC006D6E053B11FA8C0AD20', '/pmkpi/trace/report/dept', 'PERF_V_PROMONITOR', 100, 0, 0, null, null, 'pmkpi', null);

delete from p#busfw_t_uicolumn t where key in('/pmkpi/trace/report/dept');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BA6C49818FDB06D6E053B11FA8C0AD20', '/pmkpi/trace/report/dept', 'WFSTATUS', '状态', 1, 1, 0, 0, null, 0, 6, null, '#name', null, null, 80, 1, 'tree', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BA6C49818FDA06D6E053B11FA8C0AD20', '/pmkpi/trace/report/dept', 'GUID', 'guid', 1, 0, 0, 0, null, 0, 6, null, null, null, null, null, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BA6C49818FE306D6E053B11FA8C0AD20', '/pmkpi/trace/report/dept', 'TASKTYPE', '任务类型', 1, 0, 0, 0, null, 0, 6, null, '#name', null, null, 100, 1, 'tree', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BA6C49818FD706D6E053B11FA8C0AD20', '/pmkpi/trace/report/dept', 'AGENCYGUID', '部门编码', 2, 1, 0, 0, null, 0, 6, null, null, null, null, 150, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BA6C49818FD806D6E053B11FA8C0AD20', '/pmkpi/trace/report/dept', 'NAME', '部门名称', 3, 1, 0, 0, null, 0, 6, null, null, null, null, 200, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BA6C49818FD906D6E053B11FA8C0AD20', '/pmkpi/trace/report/dept', 'AGENCYGUID', '预算单位', 5, 0, 0, 0, null, 0, 6, null, '#code-#name', null, null, 180, 1, 'tree', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BA6C49818FDC06D6E053B11FA8C0AD20', '/pmkpi/trace/report/dept', 'TASKSTAGE', '监控阶段', 9, 1, 0, 0, null, 0, 6, null, '#name', null, null, 80, 1, 'tree', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BA6C49818FDD06D6E053B11FA8C0AD20', '/pmkpi/trace/report/dept', 'WARNDAYS', '预警截止天数', 10, 1, 0, 0, null, 0, 6, null, null, null, null, 80, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BA6C49818FE206D6E053B11FA8C0AD20', '/pmkpi/trace/report/dept', 'FININTORGGUID', '业务处室', 11, 1, 0, 0, null, 0, 6, null, '#name', null, null, 150, 1, 'tree', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BA6C49818FE106D6E053B11FA8C0AD20', '/pmkpi/trace/report/dept', 'BGTWARN', '预算执行预警', 13, 1, 0, 0, null, 0, 6, null, null, null, null, 100, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BA6C49818FDE06D6E053B11FA8C0AD20', '/pmkpi/trace/report/dept', 'GOALWARN', '目标完成预警', 14, 1, 0, 0, null, 0, 6, null, null, null, null, 100, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BA6C49818FDF06D6E053B11FA8C0AD20', '/pmkpi/trace/report/dept', 'DEPTTASK', '自行监控', 15, 1, 0, 0, null, 0, 6, null, '#name', null, null, 80, 1, 'tree', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BA6C49818FE006D6E053B11FA8C0AD20', '/pmkpi/trace/report/dept', 'PROVINCETASK', '重点监控', 16, 1, 0, 0, null, 0, 6, null, '#name', null, null, 80, 1, 'tree', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BA6C49818FD606D6E053B11FA8C0AD20', '/pmkpi/trace/report/dept', 'WARN', '预警', 17, 0, 0, 0, null, 0, 6, null, null, null, null, null, 0, 's', null, null);

delete from p#busfw_t_uiqueryform t where t.key in('/pmkpi/trace/report/dept');
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('BA6C49818FC106D6E053B11FA8C0AD20', '/pmkpi/trace/report/dept', 'NAME', '单位名称', 1, 1, 's', null, null, null, 'pmkpi', 'PERF_V_PROMONITOR', null, null);

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('BA6C49818FC206D6E053B11FA8C0AD20', '/pmkpi/trace/report/dept', 'WFSTATUS', '状态', 2, 1, 'tree', null, null, null, 'pmkpi', 'PERF_V_PROMONITOR', null, null);

--编辑
--项目
delete from p#busfw_t_uitabpage t where t.key in('/pmkpi/program/trace/report/edit');
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('B7279B405D6A7EB4E0530100007FD738', 'pmkpi', '/pmkpi/program/trace/report/edit', '基本信息', 'traceinfo', 1, 1, 'choosed', 'tabfreamedit.clickTabpage', null, '基本信息', null, null, '{url:''/pmkpi/program/trace/report/edit/info.page'',busguid:''B7279B405D6C7EB4E0530100007FD738'',action:''protraceinfo.save''}', null, '0', 'taskinfoiframe', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('B74D29A870334446E0530100007F1A5A', 'pmkpi', '/pmkpi/program/trace/report/edit', '预算执行情况', 'tracefund', 1, 2, 'nomal', 'tabfreamedit.clickTabpage', null, '预算执行情况', null, null, '{url:''/pmkpi/program/trace/report/edit/fund.page'',busguid:''B74D29A870344446E0530100007F1A5A'',action:''tracefund.save''}', null, '0', 'taskfundiframe', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('B760B51D6F986B86E0530100007F27AE', 'pmkpi', '/pmkpi/program/trace/report/edit', '绩效指标完成情况', 'tracetarget', 1, 3, 'nomal', 'tabfreamedit.clickTabpage', null, '绩效目标完成情况', null, null, '{url:''/pmkpi/program/trace/report/edit/indextarget.page'',busguid:''B760B51D6FA06B86E0530100007F27AE'',action:''proindextrace.save''}', null, '0', 'targetiframe', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('B760B51D6F9A6B86E0530100007F27AE', 'pmkpi', '/pmkpi/program/trace/report/edit', '监控分析', 'traceanalysis', 1, 4, 'nomal', 'tabfreamedit.clickTabpage', null, '监控分析', null, null, '{busguid:''B760B51D6F9E6B86E0530100007F27AE''}', null, '0', 'analysisformaleditform', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('B760B51D6F9C6B86E0530100007F27AE', 'pmkpi', '/pmkpi/program/trace/report/edit', '附件上传', 'tracefile', 1, 5, 'nomal', 'tabfreamedit.clickTabpage', null, '附件上传', null, '保存', '{url:''/pmkpi/file/index.page''}', null, '0', 'manceiframe', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BA6668DFDF221167E053B11FA8C08965', 'pmkpi', '/pmkpi/program/trace/report/edit', '阶段监控填报', 'protracefund', 0, 12, 'nomal', 'tabfreamedit.clickTabpage', null, '阶段监控填报', null, null, '{url:''/pmkpi/trace/report/proedit/warn.page'',busguid:''BA6668DFDF231167E053B11FA8C08965'',action:''tracewarn.save''}', null, '0', 'taskfundiframe', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BA44382851FE1B71E053B11FA8C02F8C', 'pmkpi', '/pmkpi/program/trace/report/edit', '绩效目标调整', 'progoal', 0, 10, 'nomal', 'tabfreamedit.clickTabpage', null, '绩效目标调整', null, null, '{busguid:''B9B1886CA7A600A1E053B11FA8C0DBA4'',url:''/pmkpi/adjust/report/proedit/goal.page?istrace=1'',action:''adjustgoal.save''}', null, '0', 'progoaliframe', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BA44382851FF1B71E053B11FA8C02F8C', 'pmkpi', '/pmkpi/program/trace/report/edit', '绩效指标调整', 'proindex', 0, 11, 'nomal', 'tabfreamedit.clickTabpage', null, '绩效指标调整', null, null, '{busguid:''B9B1886CA7A700A1E053B11FA8C0DBA4'',url:''/pmkpi/adjust/report/proedit/index.page?istrace=1'',action:''adjustindex.save''}', null, '0', 'proindexiframe', null, null, null, null, null, null);

delete from p#busfw_t_uifunction t where key in('/pmkpi/program/trace/report/edit');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B7279B405D677EB4E0530100007FD738', '/pmkpi/program/trace/report/edit', '保存', 1, 1, 'Keepicon', 'tabfreamedit.infosave', null, '保存', 'pmkpi', null, null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B7279B405D687EB4E0530100007FD738', '/pmkpi/program/trace/report/edit', '取消', 1, 2, 'Nofinishicon', 'tabfreamedit.close', null, '取消', 'pmkpi', null, null, null);

delete from p#busfw_t_uieditform t where key in('/pmkpi/program/trace/report/edit/analysis');
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B775BB49040E289BE0530100007F7783', '/pmkpi/program/trace/report/edit/analysis', 'V_PERF_T_PROTRACEANALYSIS', 's', '创建人', 'CREATER', 0, null, 1, null, 1, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B775BB49040F289BE0530100007F7783', '/pmkpi/program/trace/report/edit/analysis', 'V_PERF_T_PROTRACEANALYSIS', 's', '创建时间', 'CREATE_TIME', 0, null, 0, null, 1, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B775BB49040C289BE0530100007F7783', '/pmkpi/program/trace/report/edit/analysis', 'V_PERF_T_PROTRACEANALYSIS', 's', '单位', 'AGENCYGUID', 0, null, 0, null, 1, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B775BB490410289BE0530100007F7783', '/pmkpi/program/trace/report/edit/analysis', 'V_PERF_T_PROTRACEANALYSIS', 'textarea', '绩效目标执行出现的偏差', 'DEVIATION', 1, null, 1, null, 2, 3, '2', 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B775BB49040D289BE0530100007F7783', '/pmkpi/program/trace/report/edit/analysis', 'V_PERF_T_PROTRACEANALYSIS', 's', '单位', 'AGENCY_CODE', 0, null, 0, null, 2, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B775BB490411289BE0530100007F7783', '/pmkpi/program/trace/report/edit/analysis', 'V_PERF_T_PROTRACEANALYSIS', 's', '年度', 'FISCAL_YEAR', 0, null, 0, null, 3, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B775BB490412289BE0530100007F7783', '/pmkpi/program/trace/report/edit/analysis', 'V_PERF_T_PROTRACEANALYSIS', 's', '主建', 'GUID', 0, null, 1, null, 4, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B775BB490413289BE0530100007F7783', '/pmkpi/program/trace/report/edit/analysis', 'V_PERF_T_PROTRACEANALYSIS', 's', '是否删除', 'IS_DELETED', 0, null, 0, null, 5, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B775BB490419289BE0530100007F7783', '/pmkpi/program/trace/report/edit/analysis', 'V_PERF_T_PROTRACEANALYSIS', 'textarea', '项目实施存在的问题', 'PROBLEMS', 1, null, 1, null, 6, 3, '2', 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B775BB490415289BE0530100007F7783', '/pmkpi/program/trace/report/edit/analysis', 'V_PERF_T_PROTRACEANALYSIS', 'textarea', '纠偏整改措施', 'MEASURES', 1, null, 1, null, 7, 3, '2', 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B775BB49041C289BE0530100007F7783', '/pmkpi/program/trace/report/edit/analysis', 'V_PERF_T_PROTRACEANALYSIS', 'textarea', '整改建议', 'SUGGESTIONS', 1, null, 1, null, 8, 3, '2', 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B775BB490414289BE0530100007F7783', '/pmkpi/program/trace/report/edit/analysis', 'V_PERF_T_PROTRACEANALYSIS', 's', '主单guid', 'MAINGUID', 0, null, 0, null, 9, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B775BB490416289BE0530100007F7783', '/pmkpi/program/trace/report/edit/analysis', 'V_PERF_T_PROTRACEANALYSIS', 's', '区划', 'MOF_DIV_CODE', 0, null, 0, null, 12, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B775BB49041A289BE0530100007F7783', '/pmkpi/program/trace/report/edit/analysis', 'V_PERF_T_PROTRACEANALYSIS', 's', '区划', 'PROVINCE', 0, null, 0, null, 14, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B775BB49041B289BE0530100007F7783', '/pmkpi/program/trace/report/edit/analysis', 'V_PERF_T_PROTRACEANALYSIS', 'textarea', '备注', 'REMARK', 0, null, 0, null, 15, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B775BB49041D289BE0530100007F7783', '/pmkpi/program/trace/report/edit/analysis', 'V_PERF_T_PROTRACEANALYSIS', 's', '修改时间', 'UPDATE_TIME', 0, null, 0, null, 17, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B775BB49041E289BE0530100007F7783', '/pmkpi/program/trace/report/edit/analysis', 'V_PERF_T_PROTRACEANALYSIS', 's', '年度', 'YEAR', 0, null, 0, null, 18, null, null, 'pmkpi', 0, null, '{}', null, null, null);


--基本信息
delete from p#busfw_t_uieditform t where key in('/pmkpi/program/trace/report/edit/info');
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B7279B405D6F7EB4E0530100007FD738', '/pmkpi/program/trace/report/edit/info', 'V_PERF_T_PROMONITOR', 's', 'GUID', 'GUID', 0, null, 1, null, 1, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B7279B405D707EB4E0530100007FD738', '/pmkpi/program/trace/report/edit/info', 'V_PERF_T_PROMONITOR', 's', '名称', 'NAME', 1, null, 1, null, 2, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B73465ACA41540FCE0530100007F9119', '/pmkpi/program/trace/report/edit/info', 'V_PERF_T_PROMONITOR', 'textarea', '制度建设', 'CONSTRUCTION', 1, null, 1, null, 11, 3, '2', 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B73465ACA41640FCE0530100007F9119', '/pmkpi/program/trace/report/edit/info', 'V_PERF_T_PROMONITOR', 'textarea', '项目管理', 'PROMANAGEMENT', 1, null, 1, null, 12, 3, '2', 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B73465ACA41740FCE0530100007F9119', '/pmkpi/program/trace/report/edit/info', 'V_PERF_T_PROMONITOR', 'textarea', '财务管理', 'FINMANAGEMENT', 1, null, 1, null, 13, 3, '2', 'pmkpi', 1, null, '{}', null, null, null);

--预算执行情况
delete from p#busfw_t_uitable t where key in('/pmkpi/program/trace/report/edit/fund');
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('B74D29A870794446E0530100007F1A5A', '/pmkpi/program/trace/report/edit/fund', 'V_PERF_T_PROBGTFUND', 0, 0, 0, null, null, 'pmkpi', null);

delete from p#busfw_t_uicolumn t where key in('/pmkpi/program/trace/report/edit/fund');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B74D29A870AB4446E0530100007F1A5A', '/pmkpi/program/trace/report/edit/fund', 'AMT1', '实际到位资金', 1, 1, 0, 0, null, 0, 6, '[''资金安排'']', null, null, null, 150, 0, 'amt', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B74D29A870AC4446E0530100007F1A5A', '/pmkpi/program/trace/report/edit/fund', 'AMT2', '计划投入资金', 2, 1, 0, 0, null, 0, 6, '[''资金安排'']', null, null, null, 100, 0, 'amt', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B74D29A870AD4446E0530100007F1A5A', '/pmkpi/program/trace/report/edit/fund', 'BGTGET', '资金到位率', 3, 1, 0, 0, null, 0, 6, '[''资金安排'']', null, null, null, 100, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B74D29A870AE4446E0530100007F1A5A', '/pmkpi/program/trace/report/edit/fund', 'AMT3', '年初预算', 5, 1, 0, 0, null, 0, 6, '[''预算执行情况'']', null, null, null, 100, 0, 'amt', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B74D29A870AF4446E0530100007F1A5A', '/pmkpi/program/trace/report/edit/fund', 'AMT4', '年度预算调整', 6, 1, 0, 0, null, 0, 6, '[''预算执行情况'']', null, null, null, 100, 0, 'amt', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B74D29A870B04446E0530100007F1A5A', '/pmkpi/program/trace/report/edit/fund', 'AMT5', '调整后的预算', 7, 1, 0, 0, null, 0, 6, '[''预算执行情况'']', null, null, null, 100, 0, 'amt', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B74D29A870B14446E0530100007F1A5A', '/pmkpi/program/trace/report/edit/fund', 'AMT6', '累计支出', 9, 1, 0, 0, null, 0, 6, '[''预算执行情况'']', null, null, null, 100, 0, 'amt', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B74D29A870B24446E0530100007F1A5A', '/pmkpi/program/trace/report/edit/fund', 'AMT7', '项目指标结余', 10, 1, 1, 0, null, 0, 6, '[''预算执行情况'']', null, null, null, 100, 0, 'amt', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B74D29A870B44446E0530100007F1A5A', '/pmkpi/program/trace/report/edit/fund', 'ISEDIT', '是否编辑', 20, 0, 0, 0, null, 0, 6, '[''预算执行情况'']', null, null, null, 100, 0, 'amt', null, null);

--绩效指标完成情况
delete from p#busfw_t_uitable t where key in('/pmkpi/program/trace/report/edit/indextarget');
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('B785109A5BB90EC1E0530100007FD5F2', '/pmkpi/program/trace/report/edit/indextarget', 'V_PERF_T_PROINDEXTRACE', 0, 0, 0, null, null, 'pmkpi', null);

delete from p#busfw_t_uicolumn t where key in('/pmkpi/program/trace/report/edit/indextarget');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B785109A5BCA0EC1E0530100007FD5F2', '/pmkpi/program/trace/report/edit/indextarget', 'FINDEX', '一级指标', 1, 0, 0, 0, null, 0, 6, null, '#name', null, null, 110, 1, 'tree', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B785109A5BCB0EC1E0530100007FD5F2', '/pmkpi/program/trace/report/edit/indextarget', 'SINDEX', '二级指标', 2, 0, 0, 0, null, 0, 6, null, '#name', null, null, 110, 1, 'tree', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B785109A5BCC0EC1E0530100007FD5F2', '/pmkpi/program/trace/report/edit/indextarget', 'NAME', '指标名称', 3, 1, 0, 0, null, 0, 6, null, null, null, null, 150, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B785109A5BCD0EC1E0530100007FD5F2', '/pmkpi/program/trace/report/edit/indextarget', 'TARGETVALUE', '年度指标值', 5, 1, 0, 0, null, 0, 6, null, null, null, null, 100, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B785109A5BCE0EC1E0530100007FD5F2', '/pmkpi/program/trace/report/edit/indextarget', 'INDEXVAL', '当前完成值', 6, 1, 1, 0, null, 0, 6, null, null, null, null, 100, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BF5EDC3A1D89A028E053B11FA8C0F75E', '/pmkpi/program/trace/report/edit/indextarget', 'COMPUTESIGN', '计算符号', 7, 0, 0, 0, null, 0, 6, null, null, null, null, 100, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B785109A5BD00EC1E0530100007FD5F2', '/pmkpi/program/trace/report/edit/indextarget', 'METERUNIT', '计量单位', 9, 0, 0, 0, null, 0, 6, null, null, null, null, 120, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B785109A5BD10EC1E0530100007FD5F2', '/pmkpi/program/trace/report/edit/indextarget', 'COMPLETEANALYSIS', '完成可能性分析', 10, 1, 1, 0, null, 0, 6, null, '#name', null, null, 120, 1, 'tree', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B785109A5BCF0EC1E0530100007FD5F2', '/pmkpi/program/trace/report/edit/indextarget', 'WARN', '序时进度预警', 11, 1, 0, 0, null, 0, 6, null, null, null, null, 100, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B785109A5BD20EC1E0530100007FD5F2', '/pmkpi/program/trace/report/edit/indextarget', 'DEVIATIONANALYSIS', '偏差原因分析', 14, 1, 1, 0, null, 0, 6, null, '#name', null, null, 120, 1, 'tree', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B785109A5BD30EC1E0530100007FD5F2', '/pmkpi/program/trace/report/edit/indextarget', 'OTHERREASONS', '其他原因', 15, 1, 1, 0, null, 0, 6, null, null, null, null, 150, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B785109A5BD40EC1E0530100007FD5F2', '/pmkpi/program/trace/report/edit/indextarget', 'REMARK', '备注', 20, 1, 1, 0, null, 0, 6, null, null, null, null, 150, 0, 's', '{}', null);

--阶段监控填报
delete from p#busfw_t_uitable t where key in('/pmkpi/trace/report/proedit/warn/fund');
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('BA6668DFDF851167E053B11FA8C08965', '/pmkpi/trace/report/proedit/warn/fund', 'V_PERF_T_PROBGTFUND', 0, 0, 0, null, null, 'pmkpi', null);

delete from p#busfw_t_uicolumn t where key in('/pmkpi/trace/report/proedit/warn/fund');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BA6668DFDF861167E053B11FA8C08965', '/pmkpi/trace/report/proedit/warn/fund', 'NAME', '资金来源', 1, 1, 0, 0, null, 0, 6, null, null, null, null, 150, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BA6668DFDF871167E053B11FA8C08965', '/pmkpi/trace/report/proedit/warn/fund', 'AMT1', '年初预算(万元)', 3, 1, 0, 0, null, 0, 6, null, null, null, null, 80, 0, 'amt', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BA6668DFDF881167E053B11FA8C08965', '/pmkpi/trace/report/proedit/warn/fund', 'AMT2', '年度预算调整(万元)', 5, 1, 0, 0, null, 0, 6, null, null, null, null, 80, 0, 'amt', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BA6668DFDF891167E053B11FA8C08965', '/pmkpi/trace/report/proedit/warn/fund', 'AMT3', '调整后的预算(万元)', 6, 1, 0, 0, null, 0, 6, null, null, null, null, 80, 0, 'amt', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BA6668DFDF8A1167E053B11FA8C08965', '/pmkpi/trace/report/proedit/warn/fund', 'AMT4', '累计支出(万元)', 7, 1, 0, 0, null, 0, 6, null, null, null, null, 80, 0, 'amt', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BA6668DFDF8B1167E053B11FA8C08965', '/pmkpi/trace/report/proedit/warn/fund', 'BGTGET', '预算执行率%', 9, 1, 0, 0, null, 0, 6, null, null, null, null, 80, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BA6668DFDF8C1167E053B11FA8C08965', '/pmkpi/trace/report/proedit/warn/fund', 'AMT5', '项目指标结余', 10, 1, 1, 0, null, 0, 6, null, null, null, null, 80, 0, 'amt', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BA6668DFDF8D1167E053B11FA8C08965', '/pmkpi/trace/report/proedit/warn/fund', 'ISEDIT', '是否编辑', 20, 0, 0, 0, null, 0, 6, null, null, null, null, null, 0, 's', null, null);

delete from p#busfw_t_uieditform t where key in('/pmkpi/trace/report/proedit/warn/goal');
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('BA6668DFDFB11167E053B11FA8C08965', '/pmkpi/trace/report/proedit/warn/goal', 'V_PERF_T_PROTRACEANALYSIS', 's', 'guid', 'GUID', 0, null, 0, null, 5, 3, '1', 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('BA6668DFDFB21167E053B11FA8C08965', '/pmkpi/trace/report/proedit/warn/goal', 'V_PERF_T_PROTRACEANALYSIS', 'boolean', '达到预期绩效目标', 'ISGOAL', 1, null, 1, null, 1, 3, '1', 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('BA6668DFDFB31167E053B11FA8C08965', '/pmkpi/trace/report/proedit/warn/goal', 'V_PERF_T_PROTRACEANALYSIS', 'textarea', '年度总体目标', 'NDGOAL', 1, null, 0, null, 2, 3, '2', 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('BA6668DFDFB41167E053B11FA8C08965', '/pmkpi/trace/report/proedit/warn/goal', 'V_PERF_T_PROTRACEANALYSIS', 'textarea', '绩效目标执行情况', 'MEASURES', 1, null, 1, null, 3, 3, '2', 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('BA6668DFDFB51167E053B11FA8C08965', '/pmkpi/trace/report/proedit/warn/goal', 'V_PERF_T_PROTRACEANALYSIS', 'textarea', '未达到支出进度和绩效目标原因分析', 'DEVIATION', 1, null, 0, null, 4, 3, '2', 'pmkpi', 1, null, '{}', null, null, null);

--部门
--编辑
delete from p#busfw_t_uitabpage t where t.key in('/pmkpi/trace/report/deptedit');
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('B96A1051C0B34F49E053B11FA8C07F3C', 'pmkpi', '/pmkpi/trace/report/deptedit', '基本信息', 'depttraceinfo', 1, 1, 'choosed', 'tabfreamedit.clickTabpage', null, '基本信息', null, null, '{url:''/pmkpi/trace/report/deptedit/info.page'',busguid:''B96A1051C0D14F49E053B11FA8C07F3C'',action:''protraceinfo.save''}', null, '0', 'taskinfoiframe', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('B96A1051C0B84F49E053B11FA8C07F3C', 'pmkpi', '/pmkpi/trace/report/deptedit', '年度任务', 'deptyeartrace', 1, 2, 'nomal', 'tabfreamedit.clickTabpage', null, '年度任务', null, null, '{url:''/pmkpi/trace/report/deptedit/perftask.page'',busguid:''B96A1051C0D54F49E053B11FA8C07F3C''}', null, null, 'perftaskiframe', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BA4606149E942C12E053B11FA8C089C0', 'pmkpi', '/pmkpi/trace/report/deptedit', '绩效目标调整', 'deptgoal', 1, 3, 'nomal', 'tabfreamedit.clickTabpage', null, '绩效目标调整', null, null, '{busguid:''B9D8BDAA8B2FDDAEE053B11FA8C04101'',url:''/pmkpi/adjust/report/deptedit/goal.page?istrace=1'',action:''adjustgoal.save''}', null, '0', 'deptgoaliframe', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BA4606149E952C12E053B11FA8C089C0', 'pmkpi', '/pmkpi/trace/report/deptedit', '绩效指标调整', 'deptindex', 1, 4, 'nomal', 'tabfreamedit.clickTabpage', null, '绩效指标调整', null, null, '{busguid:''B9D8BDAA8B30DDAEE053B11FA8C04101'',url:''/pmkpi/adjust/report/deptedit/index.page?istrace=1'',action:''adjustindex.save''}', null, '0', 'deptindexiframe', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('B96A1051C0B44F49E053B11FA8C07F3C', 'pmkpi', '/pmkpi/trace/report/deptedit', '阶段监控填报', 'depttracefund', 1, 5, 'nomal', 'tabfreamedit.clickTabpage', null, '阶段监控填报', null, null, '{url:''/pmkpi/trace/report/deptedit/warn.page'',busguid:''B96A1051C0D24F49E053B11FA8C07F3C'',action:''tracewarn.save''}', null, '0', 'taskfundiframe', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('B96A1051C0B54F49E053B11FA8C07F3C', 'pmkpi', '/pmkpi/trace/report/deptedit', '绩效指标完成情况', 'depttracetarget', 1, 6, 'nomal', 'tabfreamedit.clickTabpage', null, '绩效指标调整及完成情况', null, null, '{url:''/pmkpi/trace/report/deptedit/indextarget.page'',busguid:''B96A1051C0D34F49E053B11FA8C07F3C'',action:''proindextrace.save''}', null, '0', 'targetiframe', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('B96A1051C0B74F49E053B11FA8C07F3C', 'pmkpi', '/pmkpi/trace/report/deptedit', '附件上传', 'depttracefile', 1, 7, 'nomal', 'tabfreamedit.clickTabpage', null, '附件上传', null, '保存', '{url:''/pmkpi/file/index.page''}', null, '0', 'manceiframe', null, null, null, null, null, null);

delete from p#busfw_t_uifunction t where key in('/pmkpi/trace/report/deptedit');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B97BCFBDC80310BCE053B11FA8C099AB', '/pmkpi/trace/report/deptedit', '保存', 1, 1, 'Keepicon', 'tabfreamedit.infosave', null, '保存', 'pmkpi', null, null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B97BCFBDC80410BCE053B11FA8C099AB', '/pmkpi/trace/report/deptedit', '取消', 1, 2, 'Nofinishicon', 'tabfreamedit.close', null, '取消', 'pmkpi', null, null, null);

delete from p#busfw_t_uieditform t where key in('/pmkpi/trace/report/deptedit/analysis');
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B96A1051C0974F49E053B11FA8C07F3C', '/pmkpi/trace/report/deptedit/analysis', 'V_PERF_T_PROTRACEANALYSIS', 's', '创建人', 'CREATER', 0, null, 1, null, 1, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B96A1051C0984F49E053B11FA8C07F3C', '/pmkpi/trace/report/deptedit/analysis', 'V_PERF_T_PROTRACEANALYSIS', 's', '创建时间', 'CREATE_TIME', 0, null, 0, null, 1, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B96A1051C0954F49E053B11FA8C07F3C', '/pmkpi/trace/report/deptedit/analysis', 'V_PERF_T_PROTRACEANALYSIS', 's', '单位', 'AGENCYGUID', 0, null, 0, null, 1, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B96A1051C0994F49E053B11FA8C07F3C', '/pmkpi/trace/report/deptedit/analysis', 'V_PERF_T_PROTRACEANALYSIS', 'textarea', '绩效目标执行出现的偏差', 'DEVIATION', 1, null, 1, null, 2, 3, '2', 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B96A1051C0964F49E053B11FA8C07F3C', '/pmkpi/trace/report/deptedit/analysis', 'V_PERF_T_PROTRACEANALYSIS', 's', '单位', 'AGENCY_CODE', 0, null, 0, null, 2, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B96A1051C09A4F49E053B11FA8C07F3C', '/pmkpi/trace/report/deptedit/analysis', 'V_PERF_T_PROTRACEANALYSIS', 's', '年度', 'FISCAL_YEAR', 0, null, 0, null, 3, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B96A1051C09B4F49E053B11FA8C07F3C', '/pmkpi/trace/report/deptedit/analysis', 'V_PERF_T_PROTRACEANALYSIS', 's', '主建', 'GUID', 0, null, 1, null, 4, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B96A1051C09C4F49E053B11FA8C07F3C', '/pmkpi/trace/report/deptedit/analysis', 'V_PERF_T_PROTRACEANALYSIS', 's', '是否删除', 'IS_DELETED', 0, null, 0, null, 5, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B96A1051C0A04F49E053B11FA8C07F3C', '/pmkpi/trace/report/deptedit/analysis', 'V_PERF_T_PROTRACEANALYSIS', 'textarea', '项目实施存在的问题', 'PROBLEMS', 1, null, 1, null, 6, 3, '2', 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B96A1051C09E4F49E053B11FA8C07F3C', '/pmkpi/trace/report/deptedit/analysis', 'V_PERF_T_PROTRACEANALYSIS', 'textarea', '纠偏整改措施', 'MEASURES', 1, null, 1, null, 7, 3, '2', 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B96A1051C0A34F49E053B11FA8C07F3C', '/pmkpi/trace/report/deptedit/analysis', 'V_PERF_T_PROTRACEANALYSIS', 'textarea', '整改建议', 'SUGGESTIONS', 1, null, 1, null, 8, 3, '2', 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B96A1051C09D4F49E053B11FA8C07F3C', '/pmkpi/trace/report/deptedit/analysis', 'V_PERF_T_PROTRACEANALYSIS', 's', '主单guid', 'MAINGUID', 0, null, 0, null, 9, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B96A1051C09F4F49E053B11FA8C07F3C', '/pmkpi/trace/report/deptedit/analysis', 'V_PERF_T_PROTRACEANALYSIS', 's', '区划', 'MOF_DIV_CODE', 0, null, 0, null, 12, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B96A1051C0A14F49E053B11FA8C07F3C', '/pmkpi/trace/report/deptedit/analysis', 'V_PERF_T_PROTRACEANALYSIS', 's', '区划', 'PROVINCE', 0, null, 0, null, 14, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B96A1051C0A24F49E053B11FA8C07F3C', '/pmkpi/trace/report/deptedit/analysis', 'V_PERF_T_PROTRACEANALYSIS', 'textarea', '备注', 'REMARK', 0, null, 0, null, 15, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B96A1051C0A44F49E053B11FA8C07F3C', '/pmkpi/trace/report/deptedit/analysis', 'V_PERF_T_PROTRACEANALYSIS', 's', '修改时间', 'UPDATE_TIME', 0, null, 0, null, 17, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B96A1051C0A54F49E053B11FA8C07F3C', '/pmkpi/trace/report/deptedit/analysis', 'V_PERF_T_PROTRACEANALYSIS', 's', '年度', 'YEAR', 0, null, 0, null, 18, null, null, 'pmkpi', 0, null, '{}', null, null, null);

--基本信息
delete from p#busfw_t_uieditform t where key in('/pmkpi/trace/report/deptedit/info');
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B973DB00CEB43890E053B11FA8C011C3', '/pmkpi/trace/report/deptedit/info', 'V_PERF_T_PROMONITOR', 's', 'GUID', 'GUID', 0, null, 0, null, 1, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B973DB00CEB53890E053B11FA8C011C3', '/pmkpi/trace/report/deptedit/info', 'V_PERF_T_PROMONITOR', 's', '名称', 'NAME', 1, null, 0, null, 2, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B973DB00CEB63890E053B11FA8C011C3', '/pmkpi/trace/report/deptedit/info', 'V_PERF_T_PROMONITOR', 'textarea', '制度建设', 'CONSTRUCTION', 1, null, 1, null, 11, 3, '2', 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B973DB00CEB73890E053B11FA8C011C3', '/pmkpi/trace/report/deptedit/info', 'V_PERF_T_PROMONITOR', 'textarea', '项目管理', 'PROMANAGEMENT', 1, null, 0, null, 12, 3, '2', 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B973DB00CEB83890E053B11FA8C011C3', '/pmkpi/trace/report/deptedit/info', 'V_PERF_T_PROMONITOR', 'textarea', '财务管理', 'FINMANAGEMENT', 1, null, 0, null, 13, 3, '2', 'pmkpi', 1, null, '{}', null, null, null);

--阶段监控填报
delete from p#busfw_t_uieditform t where key in('/pmkpi/trace/report/deptedit/warn/goal');
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('BA5BCAA67FF50D8BE053B11FA8C07179', '/pmkpi/trace/report/deptedit/warn/goal', 'V_PERF_T_PROTRACEANALYSIS', 's', 'guid', 'GUID', 0, null, 0, null, 5, 3, '1', 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('BA4606149F0E2C12E053B11FA8C089C0', '/pmkpi/trace/report/deptedit/warn/goal', 'V_PERF_T_PROTRACEANALYSIS', 'boolean', '达到预期绩效目标', 'ISGOAL', 1, null, 1, null, 1, 3, '1', 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('BA4606149F0F2C12E053B11FA8C089C0', '/pmkpi/trace/report/deptedit/warn/goal', 'V_PERF_T_PROTRACEANALYSIS', 'textarea', '年度总体目标', 'NDGOAL', 1, null, 0, null, 2, 3, '2', 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('BA4606149F102C12E053B11FA8C089C0', '/pmkpi/trace/report/deptedit/warn/goal', 'V_PERF_T_PROTRACEANALYSIS', 'textarea', '绩效目标执行情况', 'MEASURES', 1, null, 1, null, 3, 3, '2', 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('BA4606149F112C12E053B11FA8C089C0', '/pmkpi/trace/report/deptedit/warn/goal', 'V_PERF_T_PROTRACEANALYSIS', 'textarea', '未达到支出进度和绩效目标原因分析', 'DEVIATION', 1, null, 0, null, 4, 3, '2', 'pmkpi', 1, null, '{}', null, null, null);

delete from p#busfw_t_uitable t where key in('/pmkpi/trace/report/deptedit/warn/fund');
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('B97DC9E424938618E053B11FA8C06469', '/pmkpi/trace/report/deptedit/warn/fund', 'V_PERF_T_PROBGTFUND', 0, 0, 0, null, null, 'pmkpi', null);

delete from p#busfw_t_uicolumn t where key in('/pmkpi/trace/report/deptedit/warn/fund');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B97DC9E424948618E053B11FA8C06469', '/pmkpi/trace/report/deptedit/warn/fund', 'NAME', '资金来源', 1, 1, 0, 0, null, 0, 6, null, null, null, null, 150, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B97DC9E424958618E053B11FA8C06469', '/pmkpi/trace/report/deptedit/warn/fund', 'AMT1', '年初预算(万元)', 3, 1, 0, 0, null, 0, 6, null, null, null, null, 80, 0, 'amt', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B97DC9E424968618E053B11FA8C06469', '/pmkpi/trace/report/deptedit/warn/fund', 'AMT2', '年度预算调整(万元)', 5, 1, 0, 0, null, 0, 6, null, null, null, null, 80, 0, 'amt', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B97DC9E424978618E053B11FA8C06469', '/pmkpi/trace/report/deptedit/warn/fund', 'AMT3', '调整后的预算(万元)', 6, 1, 0, 0, null, 0, 6, null, null, null, null, 80, 0, 'amt', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B97DC9E424988618E053B11FA8C06469', '/pmkpi/trace/report/deptedit/warn/fund', 'AMT4', '累计支出(万元)', 7, 1, 0, 0, null, 0, 6, null, null, null, null, 80, 0, 'amt', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B97DC9E424998618E053B11FA8C06469', '/pmkpi/trace/report/deptedit/warn/fund', 'BGTGET', '预算执行率%', 9, 1, 0, 0, null, 0, 6, null, null, null, null, 80, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B97DC9E4249A8618E053B11FA8C06469', '/pmkpi/trace/report/deptedit/warn/fund', 'AMT5', '项目指标结余', 10, 1, 1, 0, null, 0, 6, null, null, null, null, 80, 0, 'amt', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B97DC9E4249B8618E053B11FA8C06469', '/pmkpi/trace/report/deptedit/warn/fund', 'ISEDIT', '是否编辑', 20, 0, 0, 0, null, 0, 6, null, null, null, null, null, 0, 's', null, null);


--绩效指标调整及完成情况
delete from p#busfw_t_uitable t where key in('/pmkpi/trace/report/deptedit/indextarget');
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('BA4606149EF82C12E053B11FA8C089C0', '/pmkpi/trace/report/deptedit/indextarget', 'V_PERF_T_PROINDEXTRACE', 0, 0, 0, null, null, 'pmkpi', null);

delete from p#busfw_t_uicolumn t where key in('/pmkpi/trace/report/deptedit/indextarget');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BA4606149EF92C12E053B11FA8C089C0', '/pmkpi/trace/report/deptedit/indextarget', 'FINDEX', '一级指标', 1, 0, 0, 0, null, 0, 6, null, '#name', null, null, 110, 1, 'tree', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BA4606149EFA2C12E053B11FA8C089C0', '/pmkpi/trace/report/deptedit/indextarget', 'SINDEX', '二级指标', 2, 0, 0, 0, null, 0, 6, null, '#name', null, null, 110, 1, 'tree', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BA4606149EFB2C12E053B11FA8C089C0', '/pmkpi/trace/report/deptedit/indextarget', 'NAME', '指标名称', 3, 1, 0, 0, null, 0, 6, null, null, null, null, 200, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BA4606149EFC2C12E053B11FA8C089C0', '/pmkpi/trace/report/deptedit/indextarget', 'TARGETVALUE', '年度指标值', 5, 1, 0, 0, null, 0, 6, null, null, null, null, 100, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BA4606149EFD2C12E053B11FA8C089C0', '/pmkpi/trace/report/deptedit/indextarget', 'INDEXVAL', '当前完成值', 6, 1, 1, 0, null, 0, 6, null, null, null, null, 100, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BA4606149EFE2C12E053B11FA8C089C0', '/pmkpi/trace/report/deptedit/indextarget', 'COMPUTESIGN', '计算符号', 7, 0, 0, 0, null, 0, 6, null, null, null, null, 100, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BA4606149EFF2C12E053B11FA8C089C0', '/pmkpi/trace/report/deptedit/indextarget', 'METERUNIT', '计量单位', 9, 0, 0, 0, null, 0, 6, null, null, null, null, 120, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BA4606149F002C12E053B11FA8C089C0', '/pmkpi/trace/report/deptedit/indextarget', 'COMPLETEANALYSIS', '完成可能性分析', 10, 1, 1, 0, null, 0, 6, null, '#name', null, null, 120, 1, 'tree', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BA4606149F012C12E053B11FA8C089C0', '/pmkpi/trace/report/deptedit/indextarget', 'WARN', '序时进度预警', 11, 0, 0, 0, null, 0, 6, null, null, null, null, 100, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BA4606149F022C12E053B11FA8C089C0', '/pmkpi/trace/report/deptedit/indextarget', 'DEVIATIONANALYSIS', '偏差原因分析', 14, 1, 1, 0, null, 0, 6, null, '#name', null, null, 120, 1, 'tree', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BA4606149F032C12E053B11FA8C089C0', '/pmkpi/trace/report/deptedit/indextarget', 'OTHERREASONS', '其他原因', 15, 1, 1, 0, null, 0, 6, null, null, null, null, 150, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BA4606149F042C12E053B11FA8C089C0', '/pmkpi/trace/report/deptedit/indextarget', 'REMARK', '备注', 20, 1, 1, 0, null, 0, 6, null, null, null, null, 150, 0, 's', '{}', null);

--审核
delete from busfw_t_uitabpage t where t.key in('/pmkpi/program/trace/audit');
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('B7A11C351FA349CBE0530100007F4B66', 'pmkpi', '/pmkpi/program/trace/audit', '待审核', 'waitaudit', 1, 1, 'choosed', 'protraceaudit.clickTabpage', null, '待审核', null, '取消审核,审核信息', '{}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('B7A11C351FA449CBE0530100007F4B66', 'pmkpi', '/pmkpi/program/trace/audit', '已审核', 'alreadyaudit', 1, 2, 'nomal', 'protraceaudit.clickTabpage', null, '已审核', null, '审核', '{}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('B7A11C351FA549CBE0530100007F4B66', 'pmkpi', '/pmkpi/program/trace/audit', '曾经办', 'alldeals', 1, 3, 'nomal', 'protraceaudit.clickTabpage', null, '曾经办', null, '审核,取消审核', '{}', null, '0', null, null, null, null, null, null, null);

delete from busfw_t_uifunction t where key in('/pmkpi/program/trace/audit');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B7A11C351F9449CBE0530100007F4B66', '/pmkpi/program/trace/audit', '审核', 1, 4, 'searchicon', 'protraceaudit.audit', null, '审核', 'pmkpi', 'sendaudit', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B7A11C351F9549CBE0530100007F4B66', '/pmkpi/program/trace/audit', '取消审核', 1, 5, 'searchicon', 'protraceaudit.wfAudit', null, '取消审核', 'pmkpi', 'cancelsendaudit', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B7A11C351F9649CBE0530100007F4B66', '/pmkpi/program/trace/audit', '审核情况', 1, 6, 'searchicon', 'protraceaudit.queryaudit', null, '审核情况', 'pmkpi', 'queryaudit', null, '{}');

--查询
delete from busfw_t_uifunction t where key in('/pmkpi/program/trace/query');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BA6668DFDFB71167E053B11FA8C08965', '/pmkpi/program/trace/query', '审核情况', 1, 6, 'searchicon', 'protracequery.queryaudit', null, '审核情况', 'pmkpi', 'queryaudit', null, '{}');
