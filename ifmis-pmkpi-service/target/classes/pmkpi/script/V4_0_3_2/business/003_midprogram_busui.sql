begin

delete from p#busfw_t_uifunction t where t.key in('/pmkpi/midprogram/report/audit','/pmkpi/midprogram/report/list','/pmkpi/midprogram/query/list') and t.code='expdata';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/midprogram/report/list', '导出列表', 1, 10, 'searchicon', 'Ext.lt.pmkpi.expdata', null, '导出列表', 'pmkpi', 'expdata', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/midprogram/query/list', '导出列表', 1, 10, 'searchicon', 'Ext.lt.pmkpi.expdata', null, '导出列表', 'pmkpi', 'expdata', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/midprogram/report/audit', '导出列表', 1, 10, 'searchicon', 'Ext.lt.pmkpi.expdata', null, '导出列表', 'pmkpi', 'expdata', null, '{}');
