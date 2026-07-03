begin

delete from p#busfw_t_uifunction t where t.key in('/pmkpi/perfselftaskmanage/index') and code = 'exportProj';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/perfselftaskmanage/index', '导出列表', 1, 9, 'searchicon', 'Ext.lt.pmkpi.expdata', null, '导出列表', 'pmkpi', 'exportProj', null, '{}', null, null);
