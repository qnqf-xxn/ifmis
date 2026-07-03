begin

--项目绩效目标查询 导出列表
delete from bus_t_pageconsolecomconfig where url ='/pmkpi/program/query/list' and id ='dataexport';

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/query/list', 'busfw.dataexport', '{}', 'dataexport', 'pmkpi', null);

delete from p#busfw_t_uifunction t where t.key ='/pmkpi/program/query/list' and code ='exportProj';

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/query/list', '导出列表', 1, 9, 'searchicon', 'Ext.lt.pmkpi.expdata', null, '导出列表', 'pmkpi', 'exportProj', null, '{}', null, null);
