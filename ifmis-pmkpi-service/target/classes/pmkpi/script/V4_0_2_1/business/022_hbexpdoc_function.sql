begin
  
DELETE FROM p#Busfw_t_Uifunction t WHERE t.key='/pmkpi/program/query/list' and t.code='hbexpdoc';
insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('DD24E1BF09664095A3AA158E41237489', '/pmkpi/program/query/list', '导出项目支出表(河北)', 0, 7, 'searchicon', 'tlprogramquery.hbexpdoc', null, '导出项目支出表(河北)', 'pmkpi', 'hbexpdoc', null, '{tempatecode:''hbprogoalandindex''}');


DELETE FROM p#Busfw_t_Uifunction t WHERE t.key='/pmkpi/deptperformance/query/index' and t.code='hbexport';
insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('D62776AF940A4D149609410D9EB3036B', '/pmkpi/deptperformance/query/index', '导出部门整体申报表(河北)', 0, 4, 'searchicon', 'deptperformancequery.hbexport', null, '导出部门整体申报表(河北)', 'pmkpi', 'hbexport', null, '{tempatecode:''hbdeptgoalandindex''}');


