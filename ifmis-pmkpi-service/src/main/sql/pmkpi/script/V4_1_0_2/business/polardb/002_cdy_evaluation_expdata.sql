begin

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/seeting/evaluation/query') and t.componentid='busfw.dataexport';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/seeting/evaluation/query', 'busfw.dataexport', '{}', 'dataexport', 'pmkpi', null);

delete from p#busfw_t_uifunction t where t.key in('/pmkpi/seeting/evaluation/query') and t.code='expdata';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/seeting/evaluation/query', '导出列表', 1, 4, 'searchicon', 'Ext.lt.pmkpi.expdata', null, '导出列表', 'pmkpi', 'expdata', null, '{}', '2016','87');