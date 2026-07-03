
delete from bus_t_pageconsolecomconfig where  url = '/pmkpi/program/trace/manage/prolist' and componentid = 'busfw.dataexport';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/manage/prolist', 'busfw.dataexport', '{}', 'dataexport', 'pmkpi', null);

delete from bus_t_pageconsolecomconfig where  url = '/pmkpi/program/trace/manage/prolistimp' and componentid = 'busfw.dataexport';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/manage/prolistimp', 'busfw.dataexport', '{}', 'dataexport', 'pmkpi', null);


delete from p#busfw_T_uifunction where key = '/pmkpi/program/trace/manage/prolist' and code = 'export';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG,YEAR, PROVINCE)
values ('B5A085C812F80888E0535164A8C0487A', '/pmkpi/program/trace/manage/prolist', '导出列表', 1, 5, 'searchicon', 'Ext.lt.pmkpi.expdata', null, '导出列表', 'pmkpi', 'export', null, '{}','2016','87');


delete from p#busfw_T_uifunction where key = '/pmkpi/program/trace/manage/prolistimp' and code = 'export';

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG,YEAR, PROVINCE)
values ('B5A085C812F80888E0535164A8C0487Q', '/pmkpi/program/trace/manage/prolistimp', '导出列表', 1, 5, 'searchicon', 'Ext.lt.pmkpi.expdata', null, '导出列表', 'pmkpi', 'export', null, '{}','2016','87');
