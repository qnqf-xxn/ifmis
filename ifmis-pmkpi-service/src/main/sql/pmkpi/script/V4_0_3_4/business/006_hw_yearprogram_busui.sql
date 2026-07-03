begin

delete from p#busfw_t_uifunction where key in('/pmkpi/yearprogram/query/list') and code = 'expdata';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/yearprogram/query/list', '导出列表', 1, 10, 'searchicon', 'Ext.lt.pmkpi.expdata', null, '导出列表', 'pmkpi', 'expdata', null, '{}');

