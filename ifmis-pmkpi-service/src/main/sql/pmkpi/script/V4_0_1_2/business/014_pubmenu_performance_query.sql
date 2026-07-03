begin

delete FROM Fasp_t_Pubmenu where guid =  'performance_target_query';
insert into Fasp_t_Pubmenu (GUID, LEVELNO, ISLEAF, STATUS, CODE, NAME, PARENTID, URL, MENUORDER, REMARK, DBVERSION, APPSYSID, PROVINCE, YEAR, APPID, PARAM1, PARAM2, PARAM3, PARAM4, PARAM5, SSOFLAG, ADMINTYPE, ALIAS, ISPTADMIN, ADMDIV)
values ('performance_target_query', 2, 1, '1', '010004', '绩效目标查询', 'SOtGK8iC', '/pmkpi/performance/query.page?prolev=3', 66, null, sysdate, 1, null, null, 'pmkpi', null, null, null, null, null, null, 1, null, null, null);

delete FROM Fasp_t_Pubmenu where  guid = 'deptperformance_target'; 
insert into Fasp_t_Pubmenu (GUID, LEVELNO, ISLEAF, STATUS, CODE, NAME, PARENTID, URL, MENUORDER, REMARK, DBVERSION, APPSYSID, PROVINCE, YEAR, APPID, PARAM1, PARAM2, PARAM3, PARAM4, PARAM5, SSOFLAG, ADMINTYPE, ALIAS, ISPTADMIN, ADMDIV)
values ('deptperformance_target', 3, null, '1', '001002003', '部门绩效目标查询（隐藏）', 'QxtowzFd', '/pmkpi/deptperformance/query/index.page', 8, null, sysdate, 1, null, null, 'pmkpi', null, null, null, null, null, null, 1, null, null, null);

delete FROM Fasp_t_Pubmenu where  guid = 'projectperformance_target'; 
insert into Fasp_t_Pubmenu (GUID, LEVELNO, ISLEAF, STATUS, CODE, NAME, PARENTID, URL, MENUORDER, REMARK, DBVERSION, APPSYSID, PROVINCE, YEAR, APPID, PARAM1, PARAM2, PARAM3, PARAM4, PARAM5, SSOFLAG, ADMINTYPE, ALIAS, ISPTADMIN, ADMDIV)
values ('projectperformance_target', 3, null, '1', '001001005', '项目绩效目标查询（隐藏）', 'SOtGK8iC', '/pmkpi/program/query/list.page?prolev=3'||CHR(38)||'type=2', 5, null, sysdate, 1, null, null, 'pmkpi', null, null, null, null, null, null, 1, null, null, null);
