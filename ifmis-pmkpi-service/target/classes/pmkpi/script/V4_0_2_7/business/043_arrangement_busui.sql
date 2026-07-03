begin

delete from p#busfw_t_uifunction t where t.key in('/pmkpi/arrangement/index');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/arrangement/index', '保存', 1, 1, 'Keepicon', 'arrangement.save', null, '保存', 'pmkpi', 'save', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/arrangement/index', '初始化', 1, 2, 'Keepicon', 'arrangement.init', null, '初始化', 'pmkpi', 'init', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/arrangement/index', '复制上年指标', 1, 3, 'Keepicon', 'arrangement.copy', null, '复制上年指标', 'pmkpi', 'copy', null, null);
