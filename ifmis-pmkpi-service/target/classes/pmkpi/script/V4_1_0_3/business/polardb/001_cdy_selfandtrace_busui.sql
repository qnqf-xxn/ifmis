begin

delete from p#busfw_t_uifunction t where t.key in('/pmkpi/perfself/apply/edit/selfindex','/pmkpi/perfself/apply/editdept/selfindex','/pmkpi/program/trace/report/edit/indextarget','/pmkpi/trace/report/deptedit/indextarget') and t.code='getindexAndGoal';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/perfself/apply/edit/selfindex', '获取最新目标', 0, 2, 'Keepicon', 'selfindex.getindexAndGoal', null, '获取最新目标', 'pmkpi', 'getindexAndGoal', null, null, '2016', '87');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/perfself/apply/editdept/selfindex', '获取最新目标', 0, 2, 'Keepicon', 'selfindex.getindexAndGoal', null, '获取最新目标', 'pmkpi', 'getindexAndGoal', null, null, '2016', '87');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/program/trace/report/edit/indextarget', '获取最新目标', 0, 1, 'Keepicon', 'proindextrace.getindexAndGoal', null, '获取最新目标', 'pmkpi', 'getindexAndGoal', null, null, '2016', '87');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/trace/report/deptedit/indextarget', '获取最新目标', 0, 1, 'Keepicon', 'proindextrace.getindexAndGoal', null, '获取最新目标', 'pmkpi', 'getindexAndGoal', null, null, '2016', '87');
