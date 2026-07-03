i number(5);
begin
  SELECT count(*) into i FROM  Perf_t_Treetab t  where t.key = '/pmkpi/adjust/report' and t.code = 'dept' and t.hidebtns like '%查看可执行指标%';
  if i = 0 then
     update Perf_t_Treetab t set t.hidebtns = t.hidebtns||decode(t.hidebtns,null,'查看可执行指标',',查看可执行指标') where t.key = '/pmkpi/adjust/report' and t.code = 'dept';
  end if;
  SELECT count(*) into i FROM  Perf_t_Treetab t where t.key = '/pmkpi/adjust/audit' and t.code = 'dept' and t.hidebtns like '%查看可执行指标%';
  if i = 0 then
  update Perf_t_Treetab t set t.hidebtns = t.hidebtns||decode(t.hidebtns,null,'查看可执行指标',',查看可执行指标') where t.key = '/pmkpi/adjust/audit' and t.code = 'dept';
  end if;
  SELECT count(*) into i FROM  Perf_t_Treetab t where t.key = '/pmkpi/adjust/query' and t.code = 'dept' and t.hidebtns like '%查看可执行指标%';
  if i = 0 then
  update Perf_t_Treetab t set t.hidebtns = t.hidebtns||decode(t.hidebtns,null,'查看可执行指标',',查看可执行指标') where t.key = '/pmkpi/adjust/query' and t.code = 'dept';
  end if;

  --- add key btn for hqreport
  delete from p#Busfw_t_Uifunction t where t.KEY = '/pmkpi/yearprogram/query/list' and t.CODE = 'querybdg';
  insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
  values (sys_guid(), '/pmkpi/yearprogram/query/list', '查看可执行指标', 0, 24, 'searchicon', 'Ext.lt.pmkpi.configUrlBut', null, '查看可执行指标', 'pmkpi', 'querybdg', null, '{url:''/hqreport/show.htm?reportId=584950472'||chr(38)||'sysId=PAY'',tittle:''可执行指标'',params:''pro_code=#pro_code,year=#year,province=#province''}', '87', '2016');
 
  delete from p#Busfw_t_Uifunction t where t.KEY = '/pmkpi/adjust/report' and t.CODE = 'querybdg';
  insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
  values (sys_guid(), '/pmkpi/adjust/report', '查看可执行指标', 0, 24, 'searchicon', 'Ext.lt.pmkpi.configUrlBut', null, '查看可执行指标', 'pmkpi', 'querybdg', null, '{url:''/hqreport/show.htm?reportId=584950472'||chr(38)||'sysId=PAY'',tittle:''可执行指标'',params:''pro_code=#pro_code,year=#year,province=#province''}', '87', '2016');
  
  delete from p#Busfw_t_Uifunction t where t.KEY = '/pmkpi/adjust/audit' and t.CODE = 'querybdg';
  insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
  values (sys_guid(), '/pmkpi/adjust/audit', '查看可执行指标', 0, 24, 'searchicon', 'Ext.lt.pmkpi.configUrlBut', null, '查看可执行指标', 'pmkpi', 'querybdg', null, '{url:''/hqreport/show.htm?reportId=584950472'||chr(38)||'sysId=PAY'',tittle:''可执行指标'',params:''pro_code=#pro_code,year=#year,province=#province''}', '87', '2016');
  
  delete from p#Busfw_t_Uifunction t where t.KEY = '/pmkpi/adjust/query' and t.CODE = 'querybdg';
  insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
  values (sys_guid(), '/pmkpi/adjust/query', '查看可执行指标', 0, 24, 'searchicon', 'Ext.lt.pmkpi.configUrlBut', null, '查看可执行指标', 'pmkpi', 'querybdg', null, '{url:''/hqreport/show.htm?reportId=584950472'||chr(38)||'sysId=PAY'',tittle:''可执行指标'',params:''pro_code=#pro_code,year=#year,province=#province''}', '87', '2016');
  
  ---- 年中追加
  delete from p#Busfw_t_Uifunction t where t.KEY = '/pmkpi/midprogram/report/list' and t.CODE = 'querybdg';
  insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
  values (sys_guid(), '/pmkpi/midprogram/report/list', '查看可执行指标', 0, 24, 'searchicon', 'Ext.lt.pmkpi.configUrlBut', null, '查看可执行指标', 'pmkpi', 'querybdg', null, '{url:''/hqreport/show.htm?reportId=584950472'||chr(38)||'sysId=PAY'',tittle:''可执行指标'',params:''pro_code=#pro_code,year=#year,province=#province''}', '87', '2016');
  
  delete from p#Busfw_t_Uifunction t where t.KEY = '/pmkpi/midprogram/report/audit' and t.CODE = 'querybdg';
  insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
  values (sys_guid(), '/pmkpi/midprogram/report/audit', '查看可执行指标', 0, 24, 'searchicon', 'Ext.lt.pmkpi.configUrlBut', null, '查看可执行指标', 'pmkpi', 'querybdg', null, '{url:''/hqreport/show.htm?reportId=584950472'||chr(38)||'sysId=PAY'',tittle:''可执行指标'',params:''pro_code=#pro_code,year=#year,province=#province''}', '87', '2016');
  
  delete from p#Busfw_t_Uifunction t where t.KEY = '/pmkpi/midprogram/query/list' and t.CODE = 'querybdg';
  insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
  values (sys_guid(), '/pmkpi/midprogram/query/list', '查看可执行指标', 0, 24, 'searchicon', 'Ext.lt.pmkpi.configUrlBut', null, '查看可执行指标', 'pmkpi', 'querybdg', null, '{url:''/hqreport/show.htm?reportId=584950472'||chr(38)||'sysId=PAY'',tittle:''可执行指标'',params:''pro_code=#pro_code,year=#year,province=#province''}', '87', '2016');