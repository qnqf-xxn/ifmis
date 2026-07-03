begin

delete from bus_t_pagecomponent where id  = 'performance_query';
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('performance_query', '绩效目标查询', null, '绩效目标查询', '/pmkpi/perfQuery/query.js', 'Ext.lt.pmkpi.perfQuery.index', 'pmkpi', 'pmkpi.perfQuery.PerfQueryService');

delete from bus_t_pageconsolecomconfig where  url = '/pmkpi/performance/query';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/performance/query', 'busfw.dataexport', '{}', 'dataexport', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/performance/query', 'performance_query', '{}', 'performance', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/performance/query', 'busuidatatable', '{name:''绩效目标查询'',checkbox:true,title:''绩效目标查询'',edit:false,addrow:false}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/performance/query', 'header', '{}', 'header', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/performance/query', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/performance/query', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/performance/query', 'busdclefttree', '{}', 'lefttree', 'pmkpi', null);

delete from bus_t_pageconsole where url = '/pmkpi/performance/query';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/performance/query', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfQuery.PerfQueryPage', 'index', '{header:[header],left:lefttree,main:[toolbutton,queryform,datatable]}', null, null, 0);

delete from p#busfw_t_uitable where key = '/pmkpi/performance/query';
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('44D9B3DADDF14C10A2DB4D2D9B547812', '/pmkpi/performance/query', 'PERF_T_SUPERVISION', 100, 1, 0, null, null, 'pmkpi', '{}');

delete from p#Busfw_t_Uicolumn where key = '/pmkpi/performance/query';
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('7BB54BE4DB6647289D5BFE57E2EC3D08', '/pmkpi/performance/query', 'GUID', 'GUID', 1, 0, 0, null, null, null, null, null, null, null, null, null, 0, 's', '{}', null);

delete from p#busfw_t_uifunction where key = '/pmkpi/performance/query';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('AFEAA51A31E14CC2ADA69A025258116E', '/pmkpi/performance/query', '查询', 0, 1, 'searchicon', 'performance.query', null, '查询', 'pmkpi', 'query', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('07469D5C18904327A68729CB6371627E', '/pmkpi/performance/query', '审核情况', 1, 2, 'searchicon', 'performance.queryaudit', null, '审核情况', 'pmkpi', 'queryaudit', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('5890170D54444B0C8C7D58D7BCEDD11A', '/pmkpi/performance/query', '导出', 1, 3, 'searchicon', 'performance.export', null, '导出', 'pmkpi', 'export', null, '{}');