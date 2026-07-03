begin
  
delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/program/trace/report/edit/indextarget') and t.componentid in('pmkpiimpexp');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/program/trace/report/edit/indextarget', 'pmkpiimpexp', '{}', 'impexp', 'pmkpi', null, null);

delete from p#busfw_t_uifunction t where t.key in('/pmkpi/program/trace/report/edit/indextarget') and code in('impdata') and province='87' and year='2016';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/trace/report/edit/indextarget', '导入', 0, 9, 'searchicon', 'proindextrace.impdata', null, '导入', 'pmkpi', 'impdata', null, '{protrace:''traceprogram'',depttrace:''tracedept'',protraceexpname:''项目支出绩效监控指标完成情况导入模板@sysdate@.xls'',depttraceexpname:''部门整体绩效监控指标完成情况导入模板@sysdate@.xls''}', '87', '2016', null, null);
