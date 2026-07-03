
begin

--重点监控范围布置（项目）

delete from p#busfw_t_uitable t where t.KEY ='/pmkpi/program/trace/manage/prolistimp';

insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values (sys_guid(), '/pmkpi/program/trace/manage/prolistimp', 'V_PERF_TRACEPROJECT_INFO', 100, 1, 0, 't.pro_code', null, 'pmkpi', null);

delete from p#busfw_t_uicolumn t where t.KEY ='/pmkpi/program/trace/manage/prolistimp';

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/program/trace/manage/prolistimp', 'PRO_LEV', '项目级次', 0, 1, 0, null, null, null, 1, null, null, null, null, 200, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/program/trace/manage/prolistimp', 'AGENCY_CODE', '预算单位', 3, 1, 0, null, null, null, null, null, '#code-#name', null, null, 150, 1, 'tree', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/program/trace/manage/prolistimp', 'DEPT_CODE', '主管部门', 4, 1, 0, null, null, null, null, null, '#code-#name', null, null, 100, 1, 'tree', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/program/trace/manage/prolistimp', 'PRO_CODE', '项目编码', 1, 1, 0, null, null, null, null, null, null, null, null, 200, 0, 's', '{type:''waitaudit''}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/program/trace/manage/prolistimp', 'PROCODE', '项目编码', 1, 1, 0, null, null, null, null, null, null, null, null, 200, 0, 's', '{type:''alreadyaudit''}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/program/trace/manage/prolistimp', 'PRONAME', '项目名称', 2, 1, 0, null, null, null, 1, null, null, null, null, 200, 0, 's', '{type:''alreadyaudit''}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/program/trace/manage/prolistimp', 'PRO_NAME', '项目名称', 2, 1, 0, null, null, null, 1, null, null, null, null, 200, 0, 's', '{type:''waitaudit''}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/program/trace/manage/prolistimp', 'FININTORGGUID', '业务科室', 5, 1, 0, null, null, null, 1, null, '#name', null, null, 100, 1, 'tree', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/program/trace/manage/prolistimp', 'PRO_CAT_CODE', '支出类别', 6, 1, 0, null, null, null, 1, null, '#code-#name', null, null, 100, 1, 'tree', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/program/trace/manage/prolistimp', 'PRO_TOTAL_AMT', '项目总金额', 7, 1, 0, null, null, null, 1, null, null, null, null, 100, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/program/trace/manage/prolistimp', 'YEAR', '预算年份', 9, 0, 0, null, null, null, null, null, null, null, null, 100, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/program/trace/manage/prolistimp', 'CREATE_TIME', '创建时间', 10, 0, 0, null, null, null, null, null, 'yyyy-MM-dd hh:mm:ss', null, null, 100, 0, 'd', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/program/trace/manage/prolistimp', 'BGTAMT', '当年预算金额', 8, 1, 0, null, null, null, 1, null, null, null, null, 100, 0, 's', '{}', null);

delete from p#busfw_t_uiqueryform t where t.KEY ='/pmkpi/program/trace/manage/prolistimp';

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, REQUIREMENT)
values (sys_guid(), '/pmkpi/program/trace/manage/prolistimp', 'BGTAMT', '当年预算金额', 5, 1, 'amt', null, null, null, 'pmkpi', 'V_PERF_TRACEPROJECT_INFO', '{region:1}', null, null);

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, REQUIREMENT)
values (sys_guid(), '/pmkpi/program/trace/manage/prolistimp', 'PRO_TOTAL_AMT', '项目总金额', 4, 1, 'amt', null, null, null, 'pmkpi', 'V_PERF_TRACEPROJECT_INFO', '{region:1}', null, null);

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, REQUIREMENT)
values (sys_guid(), '/pmkpi/program/trace/manage/prolistimp', 'PRO_CAT_CODE', '支出类别', 3, 1, 'tree', null, null, null, 'pmkpi', 'V_PERF_TRACEPROJECT_INFO', '{}', null, null);

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, REQUIREMENT)
values (sys_guid(), '/pmkpi/program/trace/manage/prolistimp', 't.PRO_CODE', '项目编码', 1, 1, 's', null, null, null, 'pmkpi', 'V_PERF_TRACEPROJECT_INFO', '{}', null, null);

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, REQUIREMENT)
values (sys_guid(), '/pmkpi/program/trace/manage/prolistimp', 'PRO_NAME', '项目名称', 2, 1, 's', null, null, null, 'pmkpi', 'V_PERF_TRACEPROJECT_INFO', '{}', null, null);

delete from p#busfw_t_uitabpage t where t.KEY ='/pmkpi/program/trace/manage/prolistimp';

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values (sys_guid(), 'pmkpi', '/pmkpi/program/trace/manage/prolistimp', '已纳入', 'alreadyaudit', 1, 2, 'nomal', 'protaskprolist.clickTabpage', 0, '已纳入', null, '复制任务,纳入任务', '{}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values (sys_guid(), 'pmkpi', '/pmkpi/program/trace/manage/prolistimp', '未纳入', 'waitaudit', 1, 1, 'choosed', 'protaskprolist.clickTabpage', 0, '未纳入', null, '取消任务', '{}', null, '0', null, null, null, null, null, null, null);

delete from p#busfw_t_uifunction t where t.KEY ='/pmkpi/program/trace/manage/prolistimp';

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/program/trace/manage/prolistimp', '复制任务', 1, 1, 'searchicon', 'protaskprolist.copytask', null, '复制任务', 'pmkpi', 'copytask', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/program/trace/manage/prolistimp', '纳入任务', 1, 2, 'searchicon', 'protaskprolist.addtask', null, '纳入任务', 'pmkpi', 'addtask', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/program/trace/manage/prolistimp', '取消任务', 1, 3, 'searchicon', 'protaskprolist.deltask', null, '取消任务', 'pmkpi', 'deltask', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/program/trace/manage/prolistimp', '查询', 0, 4, 'searchicon', 'protaskprolist.query', null, '查询', 'pmkpi', 'query', null, '{}');

--重点监控范围布置（部门整体）

delete from p#busfw_t_uitable t where t.KEY ='/pmkpi/program/trace/manage/deptlistimp';

insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values (sys_guid(), '/pmkpi/program/trace/manage/deptlistimp', 'V_PERF_T_DEPTPERFDECLARE', 100, 1, 0, null, null, 'pmkpi', null);

delete from p#busfw_t_uicolumn t where t.KEY ='/pmkpi/program/trace/manage/deptlistimp';

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/program/trace/manage/deptlistimp', 'CODE', '单位编码', 1, 1, 0, null, null, null, null, null, null, null, null, 150, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/program/trace/manage/deptlistimp', 'NAME', '预算单位', 2, 1, 0, null, null, null, null, null, null, null, null, 200, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/program/trace/manage/deptlistimp', 'FININTORGGUID', '业务科室', 5, 1, 0, null, null, null, null, null, '#name', null, null, 150, 1, 'tree', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/program/trace/manage/deptlistimp', 'YEAR', '预算年份', 7, 0, 0, null, null, null, null, null, null, null, null, 100, 0, 's', '{}', null);

delete from p#busfw_t_uiqueryform t where t.KEY ='/pmkpi/program/trace/manage/deptlistimp';

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, REQUIREMENT)
values (sys_guid(), '/pmkpi/program/trace/manage/deptlistimp', 'CODE', '单位编码', 1, 1, 's', null, null, null, 'pmkpi', 'V_PERF_PROJECT_INFO', '{}', null, null);

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, REQUIREMENT)
values (sys_guid(), '/pmkpi/program/trace/manage/deptlistimp', 'T.NAME', '单位名称', 2, 1, 's', null, null, null, 'pmkpi', 'V_PERF_PROJECT_INFO', '{}', null, null);
