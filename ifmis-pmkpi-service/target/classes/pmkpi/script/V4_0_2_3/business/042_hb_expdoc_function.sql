begin

DELETE FROM p#Busfw_t_Uifunction t WHERE t.key='/pmkpi/deptperformance/query/index' and t.code='hbexportpf';
insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('D62776AF940A4D149609410D9EB3036B', '/pmkpi/deptperformance/query/index', '导出部门整体批复表(河北)', 1, 4, 'searchicon', 'deptperformancequery.hbexportpf', null, '导出部门整体批复表', 'pmkpi', 'hbexportpf', null, '{tempatecode:''hbdeptgoalandindexpf''}');


DELETE FROM p#Busfw_t_Uifunction t WHERE t.key='/pmkpi/program/query/list' and t.code='hbexpdocpf';
insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('DD24E1BF09664095A3AA158E41237489', '/pmkpi/program/query/list', '导出目标批复表(河北)', 1, 7, 'searchicon', 'tlprogramquery.hbexpdocpf', null, '导出目标批复表', 'pmkpi', 'hbexpdocpf', null, '{tempatecode:''hbprogoalandindexpf''}');

