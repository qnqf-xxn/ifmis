
begin
  
DELETE FROM p#Busfw_t_Uifunction t WHERE t.key='/pmkpi/program/trace/query' and t.code='hbexpdoc';
insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('DB00747F4159437694453B91AA39D805', '/pmkpi/program/trace/query', '导出监控表(河北)', 0, 15, 'searchicon', 'protracequery.hbexpdoc', null, '导出监控表(河北)', 'pmkpi', 'hbexpdoc', null, '{tempatecode:''hbpmkpigoaltrace''}');

