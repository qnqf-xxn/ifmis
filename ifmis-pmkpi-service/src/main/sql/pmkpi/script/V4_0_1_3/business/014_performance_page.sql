begin

--1-4.一级项目-配置
delete from bus_t_pagecomponent where id  = 'pmkpi_firstprogram';
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_firstprogram', '项目绩效查询', null, '项目绩效查询', '/pmkpi/perfQuery/firstPro/firstproquery.js', 'Ext.lt.pmkpi.perfquery.firstqueryservice', 'pmkpi', 'pmkpi.perfQuery.FirstProgramQueryService');

delete from bus_t_pageconsolecomconfig where url ='/pmkpi/firstprogram/query/list';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/firstprogram/query/list', 'pmkpi_firstprogram', '{}', 'firstprogram', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/firstprogram/query/list', 'busuidatatable', '{name:''项目绩效'',checkbox:true,title:''项目绩效'',edit:false,addrow:false,uikey:''/pmkpi/program/report/edit''}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/firstprogram/query/list', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/firstprogram/query/list', 'header', '{}', 'header', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/firstprogram/query/list', 'buslefttree', '{}', 'lefttree', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/firstprogram/query/list', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/firstprogram/query/list', 'busfw.dataexport', '{}', 'dataexport', 'pmkpi', null);


delete from bus_t_pageconsole where url ='/pmkpi/firstprogram/query/list';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/firstprogram/query/list', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfQuery.firstPro.FirstProgramQueryPage', 'index', '{header:[header],left:lefttree,main:[toolbutton,queryform,datatable]}', null, null, 0);


--2-4.转移支付-配置
delete from bus_t_pagecomponent  where id  = 'pmkpi_transpay';
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_transpay', '项目绩效查询', null, '项目绩效查询', '/pmkpi/perfQuery/transPay/transpayquery.js', 'Ext.lt.pmkpi.perfquery.transpayservice', 'pmkpi', 'pmkpi.perfQuery.TransPayQueryService');

delete from bus_t_pageconsolecomconfig  where url ='/pmkpi/transpay/query/list';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/transpay/query/list', 'pmkpi_transpay', '{}', 'transpay', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/transpay/query/list', 'busuidatatable', '{name:''项目绩效'',checkbox:true,title:''项目绩效'',edit:false,addrow:false,uikey:''/pmkpi/program/report/edit''}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/transpay/query/list', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/transpay/query/list', 'header', '{}', 'header', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/transpay/query/list', 'buslefttree', '{}', 'lefttree', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/transpay/query/list', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/transpay/query/list', 'busfw.dataexport', '{}', 'dataexport', 'pmkpi', null);

delete from bus_t_pageconsole  where url ='/pmkpi/transpay/query/list';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/transpay/query/list', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfQuery.transPay.TransPayQueryPage', 'index', '{header:[header],left:lefttree,main:[toolbutton,queryform,datatable]}', null, null, 0);

--3-4.绩效目标查询-整合-配置
delete from bus_t_pagecomponent  where id  = 'performance_query' ;
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('performance_query', '绩效目标查询', null, '绩效目标查询', '/pmkpi/perfQuery/query.js', 'Ext.lt.pmkpi.perfQuery.index', 'pmkpi', 'pmkpi.perfQuery.PerfQueryService');

delete from bus_t_pageconsolecomconfig  where  url = '/pmkpi/performance/query';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/performance/query', 'performance_query', '{}', 'performance', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/performance/query', 'busfw.dataexport', '{}', 'dataexport', 'pmkpi', null);

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

delete from bus_t_pageconsole  where url = '/pmkpi/performance/query';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/performance/query', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfQuery.PerfQueryPage', 'index', '{header:[header],left:lefttree,main:[toolbutton,queryform,datatable]}', null, null, 0);


