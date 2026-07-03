begin

--下达
delete from bus_t_pageconsole t where t.url in('/pmkpi/workevaluate/assign/provincelist');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/workevaluate/assign/provincelist', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.workevaluate.assign.TaskAssignPage', 'index', '{main:[tabpage,datatable],footer:[toolbutton]}', null, null, 0);

--绩效工作管理考核填报（区县）
delete from bus_t_pageconsole t where t.url in('/pmkpi/workevaluate/report/subprovinceedit');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/workevaluate/report/subprovinceedit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.tabfream.TabfreamPage', 'editindex', '{main:[tabpage,infoeditformformal],footer:[toolbutton]}', null, null, 0);

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/workevaluate/report/subprovinceedit');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/workevaluate/report/subprovinceedit', 'pmkpi_tabfreamedit', '{}', 'tabfreamedit', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/workevaluate/report/subprovinceedit', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/workevaluate/report/subprovinceedit', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/workevaluate/report/subprovinceedit', 'buseditform', '{key:''/pmkpi/workevaluate/report/subpedit/info'',title:''基本信息'',tablecode:''perf_t_worktaskassign'',iswf:''true'',columnsize:2}', 'infoeditformformal', 'pmkpi', null);

--绩效工作管理考核审核
delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/workevaluate/audit/list');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/workevaluate/audit/list', 'pmkpi_workevalaudit', '{}', 'workevalaudit', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/workevaluate/audit/list', 'busqueryform', '{key:''/pmkpi/workevaluate/report/list'',name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/workevaluate/audit/list', 'busdclefttree', '{}', 'lefttree', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/workevaluate/audit/list', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/workevaluate/audit/list', 'header', '{}', 'header', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/workevaluate/audit/list', 'busuidatatable', '{key:''/pmkpi/workevaluate/report/list'',name:''绩效目标调整表'',checkbox:true,title:''绩效目标调整表'',edit:false,addrow:false}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/workevaluate/audit/list', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);
--审核填报
delete from bus_t_pageconsole t where t.url in('/pmkpi/workevaluate/audit/subprovinceedit');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/workevaluate/audit/subprovinceedit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.tabfream.TabfreamPage', 'editindex', '{main:[tabpage,infoeditformformal],footer:[toolbutton]}', null, null, 0);

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/workevaluate/audit/subprovinceedit');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/workevaluate/audit/subprovinceedit', 'pmkpi_tabfreamedit', '{}', 'tabfreamedit', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/workevaluate/audit/subprovinceedit', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/workevaluate/audit/subprovinceedit', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/workevaluate/audit/subprovinceedit', 'buseditform', '{key:''/pmkpi/workevaluate/report/subpedit/info'',title:''基本信息'',tablecode:''v_perf_t_worktaskassign'',iswf:''true'',columnsize:2}', 'infoeditformformal', 'pmkpi', null);

--查询
delete from bus_t_pageconsole t where t.url in('/pmkpi/workevaluate/query/list');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/workevaluate/query/list', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.workevaluate.query.WorkEvaluateQueryPage', 'list', '{header:[header],left:lefttree,main:[toolbutton,queryform,datatable]}', null, null, null);

delete from bus_t_pagecomponent t where t.id in('pmkpi_workevalquery');
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_workevalquery', '绩效工作管理考核结果查询', null, '绩效工作管理考核结果查询', '/pmkpi/workevaluate/query/workevaluatequery.js', 'Ext.lt.pmkpi.workevaluate.query', 'pmkpi', 'pmkpi.workevaluate.query.WorkEvaluateQueryService');

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/workevaluate/query/list');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/workevaluate/query/list', 'pmkpi_workevalquery', '{}', 'workevalquery', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/workevaluate/query/list', 'busuidatatable', '{name:''绩效管理工作考核'',checkbox:true,title:''绩效管理工作考核'',edit:false,addrow:false}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/workevaluate/query/list', 'header', '{}', 'header', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/workevaluate/query/list', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/workevaluate/query/list', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/workevaluate/query/list', 'busdclefttree', '{}', 'lefttree', 'pmkpi', null);
