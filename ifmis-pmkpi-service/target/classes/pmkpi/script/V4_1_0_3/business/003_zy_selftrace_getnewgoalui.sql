begin

delete from p#busfw_t_uifunction where name = '获取最新目标' and key in ('/pmkpi/perfself/apply/editdept/selfindexhb','/pmkpi/perfself/apply/edit/goalandindex','/pmkpi/program/trace/report/edit/goalandindex');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, ISEDITCTRL, EDITCTRLMSG)
values ('12EFDC9678364EC877710776A2FA3152', '/pmkpi/perfself/apply/edit/goalandindex', '获取最新目标', 0, 2, 'Keepicon', 'selfgoalindex.getindexAndGoal', null, '获取最新目标', 'pmkpi', 'getindexAndGoal', null, null, null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, ISEDITCTRL, EDITCTRLMSG)
values ('0ADABB651A485A8973562958391A6BBE', '/pmkpi/perfself/apply/editdept/selfindexhb', '获取最新目标', 0, 1, 'Keepicon', 'selfindexdept.getindexAndGoal', null, '获取最新目标', 'pmkpi', 'getindexAndGoal', null, null, null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, ISEDITCTRL, EDITCTRLMSG)
values ('11F959B6208E921EFDCC2367D1E21B5D', '/pmkpi/program/trace/report/edit/goalandindex', '获取最新目标', 0, 1, 'Keepicon', 'tracegoalindex.getindexAndGoal', null, '获取最新目标', 'pmkpi', 'getindexAndGoal', null, null, null, null);
