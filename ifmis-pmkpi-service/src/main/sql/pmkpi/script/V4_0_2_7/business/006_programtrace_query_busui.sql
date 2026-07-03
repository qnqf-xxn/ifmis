begin

--绩效监控查询增加按钮
delete from p#busfw_t_uifunction where key = '/pmkpi/program/trace/query' and code = 'resultsquery';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/program/trace/query', '成果查看', 0, 6, 'searchicon', 'protracequery.uploadresults', null, '成果查看', 'pmkpi', 'resultsquery', null, '{}');

--广西-部门整体目标增加排序
delete from p#busfw_t_uitable where key = '/pmkpi/deptperformance/report/target';
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values (sys_guid(), '/pmkpi/deptperformance/report/target', 'V_BGT_PERF_GOAL_INFO', 0, 1, 0, ' order by ordernum', null, 'pmkpi', null);

--广西-部门职能活动增加排序
delete from p#busfw_t_uitable where key = '/pmkpi/deptperformance/report/funcd';
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values (sys_guid(), '/pmkpi/deptperformance/report/funcd', 'V_PERF_T_DEPTFUNCTION', 0, 0, 0, ' order by ordernum', null, 'pmkpi', null);

