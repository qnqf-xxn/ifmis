i  number(6);
begin
  
  --- add hiden lefttabe btn
  SELECT count(*) into i FROM Perf_t_Treetab t where t.key = '/pmkpi/program/trace/report' and t.code = 'depttrace' and t.hidebtns like '%查看可执行指标%';
if i=0 then
  update Perf_t_Treetab t set t.hidebtns = t.hidebtns||decode(t.hidebtns,null,'查看可执行指标',',查看可执行指标') where t.key = '/pmkpi/program/trace/report' and t.code = 'depttrace';
end if;
SELECT count(*) into i FROM Perf_t_Treetab t where t.key = '/pmkpi/program/trace/audit' and t.code = 'depttrace' and t.hidebtns like '%查看可执行指标%';
if i=0 then
  update Perf_t_Treetab t set t.hidebtns = t.hidebtns||decode(t.hidebtns,null,'查看可执行指标',',查看可执行指标') where t.key = '/pmkpi/program/trace/audit' and t.code = 'depttrace';
end if;
SELECT count(*) into i FROM Perf_t_Treetab t where t.key = '/pmkpi/program/trace/query' and t.code = 'depttrace' and t.hidebtns like '%查看可执行指标%';
if i=0 then
  update Perf_t_Treetab t set t.hidebtns = t.hidebtns||decode(t.hidebtns,null,'查看可执行指标',',查看可执行指标') where t.key = '/pmkpi/program/trace/query' and t.code = 'depttrace';
end if;
SELECT count(*) into i FROM Perf_t_Treetab t where t.key = '/pmkpi/perfself/apply' and t.code = 'depttrace' and t.hidebtns like '%查看可执行指标%';
if i=0 then
  update Perf_t_Treetab t set t.hidebtns = t.hidebtns||decode(t.hidebtns,null,'查看可执行指标',',查看可执行指标') where t.key = '/pmkpi/perfself/apply' and t.code = 'dept';
end if;
SELECT count(*) into i FROM Perf_t_Treetab t where t.key = '/pmkpi/perfself/audit' and t.code = 'depttrace' and t.hidebtns like '%查看可执行指标%';
if i=0 then
  update Perf_t_Treetab t set t.hidebtns = t.hidebtns||decode(t.hidebtns,null,'查看可执行指标',',查看可执行指标') where t.key = '/pmkpi/perfself/audit' and t.code = 'dept';
end if;
SELECT count(*) into i FROM Perf_t_Treetab t where t.key = '/pmkpi/perfself/query' and t.code = 'depttrace' and t.hidebtns like '%查看可执行指标%';
if i=0 then
  update Perf_t_Treetab t set t.hidebtns = t.hidebtns||decode(t.hidebtns,null,'查看可执行指标',',查看可执行指标') where t.key = '/pmkpi/perfself/query' and t.code = 'dept';
end if;
  --- add key btn for hqreport
  delete from p#Busfw_t_Uifunction t where t.KEY = '/pmkpi/perfself/apply/index' and t.CODE = 'querybdg';
  insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
  values (sys_guid(), '/pmkpi/perfself/apply/index', '查看可执行指标', 0, 24, 'searchicon', 'Ext.lt.pmkpi.configUrlBut', null, '查看可执行指标', 'pmkpi', 'querybdg', null, '{url:''/hqreport/show.htm?reportId=584950472'||chr(38)||'sysId=PAY'',tittle:''可执行指标'',params:''pro_code=#pro_code,year=#year,province=#province''}', '87', '2016');

  delete from p#Busfw_t_Uifunction t where t.KEY = '/pmkpi/perfself/audit/index' and t.CODE = 'querybdg';
  insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
  values (sys_guid(), '/pmkpi/perfself/audit/index', '查看可执行指标', 0, 12, 'searchicon', 'Ext.lt.pmkpi.configUrlBut', null, '查看可执行指标', 'pmkpi', 'querybdg', null, '{url:''/hqreport/show.htm?reportId=584950472'||chr(38)||'sysId=PAY'',tittle:''可执行指标'',params:''pro_code=#pro_code,year=#year,province=#province''}', '87', '2016');

  delete from p#Busfw_t_Uifunction t where t.KEY = '/pmkpi/perfself/query/index' and t.CODE = 'querybdg';
  insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
  values (sys_guid(), '/pmkpi/perfself/query/index', '查看可执行指标', 0, 26, 'searchicon', 'Ext.lt.pmkpi.configUrlBut', null, '查看可执行指标', 'pmkpi', 'querybdg', null, '{url:''/hqreport/show.htm?reportId=584950472'||chr(38)||'sysId=PAY'',tittle:''可执行指标'',params:''pro_code=#pro_code,year=#year,province=#province''}', '87', '2016');

  delete from p#Busfw_t_Uifunction t where t.KEY = '/pmkpi/program/trace/audit' and t.CODE = 'querybdg';
  insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
  values (sys_guid(), '/pmkpi/program/trace/audit', '查看可执行指标', 0, 26, 'searchicon', 'Ext.lt.pmkpi.configUrlBut', null, '查看可执行指标', 'pmkpi', 'querybdg', null, '{url:''/hqreport/show.htm?reportId=584950472'||chr(38)||'sysId=PAY'',tittle:''可执行指标'',params:''pro_code=#pro_code,year=#year,province=#province''}', '87', '2016');

  delete from p#Busfw_t_Uifunction t where t.KEY = '/pmkpi/program/trace/query' and t.CODE = 'querybdg';
  insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
  values (sys_guid(), '/pmkpi/program/trace/query', '查看可执行指标', 0, 26, 'searchicon', 'Ext.lt.pmkpi.configUrlBut', null, '查看可执行指标', 'pmkpi', 'querybdg', null, '{url:''/hqreport/show.htm?reportId=584950472'||chr(38)||'sysId=PAY'',tittle:''可执行指标'',params:''pro_code=#pro_code,year=#year,province=#province''}', '87', '2016');

  delete from p#Busfw_t_Uifunction t where t.KEY = '/pmkpi/program/trace/report' and t.CODE = 'querybdg';
  insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
  values (sys_guid(), '/pmkpi/program/trace/report', '查看可执行指标', 0, 30, 'searchicon', 'Ext.lt.pmkpi.configUrlBut', null, '查看可执行指标', 'pmkpi', 'querybdg', null, '{url:''/hqreport/show.htm?reportId=584950472'||chr(38)||'sysId=PAY'',tittle:''可执行指标'',params:''pro_code=#pro_code,year=#year,province=#province''}', '87', '2016');