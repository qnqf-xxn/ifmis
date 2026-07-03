begin

delete from busfw_t_uifunction where key = '/pmkpi/midprogram/report/list' and guid in ('midprogram/report/listfunction12','midprogram/report/listfunction11');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('midprogram/report/listfunction11', '/pmkpi/midprogram/report/list', '修改一级项目', 0, 3, 'searchicon', 'pmkpimidreport.promainedit', null, '修改一级项目', 'pmkpi', 'promainedit', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('midprogram/report/listfunction12', '/pmkpi/midprogram/report/list', '查看一级项目明细', 0, 3, 'searchicon', 'pmkpimidreport.queryPromain', null, '查看一级项目明细', 'pmkpi', 'queryPromain', null, null);



delete from busfw_t_uifunction where key = '/pmkpi/midprogram/report/audit' and guid in ('B5671A60D7DO47FFAA4A176A7B52FE2B','B5671A60D7DO47JJAA4A176A7B52FE2B');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B5671A60D7DO47FFAA4A176A7B52FE2B', '/pmkpi/midprogram/report/audit', '修改一级项目', 0, 3, 'searchicon', 'midprogramaudit.promainedit', null, '修改一级项目', 'pmkpi', 'promainedit', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B5671A60D7DO47JJAA4A176A7B52FE2B', '/pmkpi/midprogram/report/audit', '查看一级项目明细', 0, 3, 'searchicon', 'midprogramaudit.queryPromain', null, '查看一级项目明细', 'pmkpi', 'queryPromain', null, null);


delete from busfw_t_uifunction where key = '/pmkpi/midprogram/query/list' and guid in ('B5671A60D7DO47JJGG4A176A7B52FE2B');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B5671A60D7DO47JJGG4A176A7B52FE2B', '/pmkpi/midprogram/query/list', '查看一级项目明细', 0, 3, 'searchicon', 'midprogramquery.queryPromain', null, '查看一级项目明细', 'pmkpi', 'queryPromain', null, null);



delete from busfw_t_uifunction t where key = '/pmkpi/program/trace/query' and guid = 'D3BC967AA5894D6B0B0F8F548FCD9540';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('D3BC967AA5894D6B0B0F8F548FCD9540', '/pmkpi/program/trace/query', '查看项目明细', 1, 10, 'searchicon', 'protracequery.prodetailed', null, '查看项目明细', 'pmkpi', 'prodetailed', null, '{}');


delete from busfw_t_uifunction t where key = '/pmkpi/program/trace/report' and guid = '8BF6FE9C5DAA5E651FFFE941A5DF56D8';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('8BF6FE9C5DAA5E651FFFE941A5DF56D8', '/pmkpi/program/trace/report', '查看项目明细', 1, 9, 'searchicon', 'protaskreport.prodetailed', null, '查看项目明细', 'pmkpi', 'prodetailed', null, '{}');



delete from busfw_t_uifunction t where key = '/pmkpi/program/trace/audit' and guid = 'EA858D2AFDAC0C5E8D9140D10628FFC7';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('EA858D2AFDAC0C5E8D9140D10628FFC7', '/pmkpi/program/trace/audit', '查看项目明细', 1, 12, 'searchicon', 'protraceaudit.prodetailed', null, '查看项目明细', 'pmkpi', 'prodetailed', null, '{}');



delete from busfw_t_uifunction where key = '/pmkpi/adjust/report' and guid = 'BF4D5ADDB15E3275E053C664280A66FC';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BF4D5ADDB15E3275E053C664280A66FC', '/pmkpi/adjust/report', '查看项目明细', 1, 8, 'searchicon', 'adjustreport.prodetailed', null, '查看项目明细', 'pmkpi', 'prodetailed', null, null);


delete from busfw_t_uifunction where key = '/pmkpi/adjust/audit' and guid = 'BF4D5ADDB15E3335E053C664280A66FC';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BF4D5ADDB15E3335E053C664280A66FC', '/pmkpi/adjust/audit', '查看项目明细', 1, 8, 'searchicon', 'adjustaudit.prodetailed', null, '查看项目明细', 'pmkpi', 'prodetailed', null, null);


delete from busfw_t_uifunction where key = '/pmkpi/adjust/query' and guid = 'BF4D5ADDB45E3875E053C664280A66FC';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BF4D5ADDB45E3875E053C664280A66FC', '/pmkpi/adjust/query', '查看项目明细', 1, 8, 'searchicon', 'adjustquery.prodetailed', null, '查看项目明细', 'pmkpi', 'prodetailed', null, null);


delete from busfw_t_uifunction where key = '/pmkpi/index/query' and guid = '03372A8CA084BE9E730AF45F1CA25BFB';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('03372A8CA084BE9E730AF45F1CA25BFB', '/pmkpi/index/query', '导出', 1, 4, 'searchicon', 'Ext.lt.pmkpi.expdata', null, '导出', 'pmkpi', 'export', null, '{}');


delete from busfw_t_uifunction t where key = '/pmkpi/indexlib/list' and guid = '66672A8CA084BE9E730AF45F1CA25BFB';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('66672A8CA084BE9E730AF45F1CA25BFB', '/pmkpi/indexlib/list', '导出', 1, 4, 'searchicon', 'Ext.lt.pmkpi.expdata', null, '导出', 'pmkpi', 'export', null, '{}');


delete from busfw_t_uifunction t where key = '/pmkpi/indexlib/deptlist' and guid = '03372A8CA084BE9E756AF45F1CA25BFB';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('03372A8CA084BE9E756AF45F1CA25BFB', '/pmkpi/indexlib/deptlist', '导出', 1, 4, 'searchicon', 'Ext.lt.pmkpi.expdata', null, '导出', 'pmkpi', 'export', null, '{}');


delete from bus_t_pageconsolecomconfig where url = '/pmkpi/index/query' and id = 'dataexport';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/index/query', 'busfw.dataexport', '{}', 'dataexport', 'pmkpi', null);


delete from bus_t_pageconsolecomconfig t where url = '/pmkpi/indexlib/list' and id = 'dataexport';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/indexlib/list', 'busfw.dataexport', '{}', 'dataexport', 'pmkpi', null);


delete from bus_t_pageconsolecomconfig t where url = '/pmkpi/indexlib/deptlist' and id = 'dataexport';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/indexlib/deptlist', 'busfw.dataexport', '{}', 'dataexport', 'pmkpi', null);