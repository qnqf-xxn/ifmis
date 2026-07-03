begin

--随机抽取管理-按钮注册
delete from bus_t_pageconsolecomconfig where url = '/pmkpi/randomcomment/randoms' and componentid = 'dataexport';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/randomcomment/randoms', 'busfw.dataexport', '{}', 'dataexport', null, null);

delete from P#busfw_t_uifunction t where t.key = '/pmkpi/randomcomment/random/index' and code = 'export';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/randomcomment/random/index', '导出列表', 1, 10, 'searchicon', 'Ext.lt.pmkpi.expdata', null, '导出列表', 'pmkpi', 'export', null, '{}','2016','87');

--范围标识-按钮注册
delete from bus_t_pageconsolecomconfig where url = '/pmkpi/randomcomment/scope' and componentid = 'dataexport';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/randomcomment/scope', 'busfw.dataexport', '{}', 'dataexport', null, null);

delete from P#busfw_t_uifunction t where t.key = '/pmkpi/randomcomment/scope/index' and code = 'export';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/randomcomment/scope/index', '导出列表', 1, 10, 'searchicon', 'Ext.lt.pmkpi.expdata', null, '导出列表', 'pmkpi', 'export', null, '{}','2016','87');

--抽评对象确定-按钮注册
delete from bus_t_pageconsolecomconfig where url = '/pmkpi/randomcomment/object' and componentid = 'dataexport';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/randomcomment/object', 'busfw.dataexport', '{}', 'dataexport', null, null);

delete from P#busfw_t_uifunction t where t.key = '/pmkpi/randomcomment/object/index' and code = 'export';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/randomcomment/object/index', '导出列表', 1, 10, 'searchicon', 'Ext.lt.pmkpi.expdata', null, '导出列表', 'pmkpi', 'export', null, '{}','2016','87');

--绩效抽评委托-按钮注册
delete from bus_t_pageconsolecomconfig where url = '/pmkpi/randomcomment/entrust' and componentid = 'dataexport';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/randomcomment/entrust', 'busfw.dataexport', '{}', 'dataexport', null, null);

delete from P#busfw_t_uifunction t where t.key = '/pmkpi/randomcomment/entrust/index' and code = 'export';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/randomcomment/entrust/index', '导出列表', 1, 10, 'searchicon', 'Ext.lt.pmkpi.expdata', null, '导出列表', 'pmkpi', 'export', null, '{}','2016','87');

--抽评结果上传-按钮注册
delete from P#bus_t_pageconsolecomconfig where url = '/pmkpi/randomcomment/result' and componentid = 'dataexport';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/randomcomment/result', 'busfw.dataexport', '{}', 'dataexport', null, null);

delete from P#busfw_t_uifunction t where t.key = '/pmkpi/randomcomment/result/index' and code = 'export';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/randomcomment/result/index', '导出列表', 1, 10, 'searchicon', 'Ext.lt.pmkpi.expdata', null, '导出列表', 'pmkpi', 'export', null, '{}','2016','87');

--绩效抽评查询-按钮注册
delete from P#bus_t_pageconsolecomconfig where url = '/pmkpi/randomcomment/query' and componentid = 'dataexport';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/randomcomment/query', 'busfw.dataexport', '{}', 'dataexport', null, null);

delete from busfw_t_uifunction t where t.key = '/pmkpi/randomcomment/query/index' and code = 'export';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/randomcomment/query/index', '导出列表', 1, 10, 'searchicon', 'Ext.lt.pmkpi.expdata', null, '导出列表', 'pmkpi', 'export', null, '{}','2016','87');
