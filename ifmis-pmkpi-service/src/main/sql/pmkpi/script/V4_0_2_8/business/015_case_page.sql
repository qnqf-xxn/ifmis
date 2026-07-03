begin

--案例维护
--列表
delete from bus_t_pageconsole t where t.url  in('/pmkpi/setting/case/list');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/setting/case/list', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.setting.casepage.report.CaseReportPage', 'index', '{header:[header],left:lefttree,main:[toolbutton,tabpage,queryform,datatable]}', null, null, 0);

delete from bus_t_pagecomponent t where t.id in('pmkpi_case');
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_case', '案例库', null, '案例库', '/pmkpi/setting/casepage/casereport.js', 'Ext.lt.pmkpi.caseservice', 'pmkpi', 'pmkpi.casepage.report.CaseReportService');

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/setting/case/list');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/case/list', 'busfw.dataexport', '{}', 'dataexport', null, null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/case/list', 'pmkpi_case', '{}', 'caseservice', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/case/list', 'busuidatatable', '{name:''案例库'',checkbox:true,title:''案例库'',edit:false,addrow:false}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/case/list', 'header', '{}', 'header', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/case/list', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/case/list', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/case/list', 'busdclefttree', '{}', 'lefttree', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/case/list', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

--项目编辑
delete from bus_t_pageconsole t where t.url  in('/pmkpi/setting/caseinfo/edit');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/setting/caseinfo/edit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.tabfream.TabfreamPage', 'editindex', '{main:[tabpage,goaleditform],footer:[toolbutton]}', null, null, 0);

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/setting/caseinfo/edit');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/caseinfo/edit', 'pmkpi_tabfreamedit', '{}', 'tabfreamedit', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/caseinfo/edit', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/caseinfo/edit', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/caseinfo/edit', 'buseditform', '{key:''/pmkpi/setting/caseinfo/goal'',tablecode:''V_PERF_T_CASEMODELGOAL'',iswf:''false''}', 'goaleditform', 'pmkpi', null);

--基本信息
delete from bus_t_pageconsole t where t.url  in('/pmkpi/case/info');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/case/info', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.setting.casepage.info.CaseInfoPage', 'editInfo', '{main:[editform]}', null, null, null);

delete from bus_t_pagecomponent t where t.id in('pmkpi_caseinfo');
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_caseinfo', '案例基本信息', null, '案例基本信息', '/pmkpi/setting/casepage/caseinfo.js', 'Ext.lt.pmkpi.case.infoservice', 'pmkpi', 'pmkpi.casepage.info.CaseInfoService');

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/case/info');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/case/info', 'buseditform', '{title:''基础信息'',tablecode:''V_PERF_T_CASE''}', 'editform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/case/info', 'pmkpi_caseinfo', '{}', 'caseinfo', 'pmkpi', null);

--指标
delete from bus_t_pageconsole t where t.url  in('/pmkpi/case/proindex');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/case/proindex', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.setting.casepage.index.CaseIndexPage', 'index', '{main:[toolbutton,datatable]}', null, null, null);

delete from bus_t_pagecomponent t where t.id in('pmkpi_caseindex');
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_caseindex', '案例指标', null, '案例指标', '/pmkpi/setting/casepage/caseindex.js', 'Ext.lt.pmkpi.case.indexservice', 'pmkpi', 'pmkpi.casepage.index.CaseIndexService');

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/case/proindex');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/case/proindex', 'busuidatatable', '{headsort:false,addrow:false,nogroupbox:false,name:''绩效指标'',edit:true,checkbox:true,title:''绩效指标'', groupcols:[''guid'',''superid'',''name'',''levelno''],treedata:true,treemapping:null,initlevel:6,isuphide:false,editgroupdata:true,nextSibling:false,nogroupbox:true,rowtolist:false}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/case/proindex', 'bustoolbutton', '{key:''/pmkpi/case/index''}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/case/proindex', 'pmkpi_caseindex', '{}', 'caseindex', 'pmkpi', null);

--部门整体编辑
delete from bus_t_pageconsole t where t.url  in('/pmkpi/case/deptedit');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/case/deptedit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.tabfream.TabfreamPage', 'editindex', '{main:[tabpage,goaleditform],footer:[toolbutton]}', null, null, 0);

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/case/deptedit');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/case/deptedit', 'pmkpi_tabfreamedit', '{}', 'tabfreamedit', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/case/deptedit', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/case/deptedit', 'bustoolbutton', '{key:''/pmkpi/setting/caseinfo/edit''}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/case/deptedit', 'buseditform', '{key:''/pmkpi/setting/case/deptgoal'',tablecode:''V_PERF_T_CASEMODELGOAL'',iswf:''false''}', 'goaleditform', 'pmkpi', null);

--指标
delete from bus_t_pageconsole t where t.url  in('/pmkpi/case/deptindex');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/case/deptindex', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.setting.casepage.index.CaseIndexPage', 'index', '{main:[toolbutton,datatable]}', null, null, null);

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/case/deptindex');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/case/deptindex', 'busuidatatable', '{headsort:false,addrow:false,nogroupbox:false,name:''绩效指标'',edit:true,checkbox:true,title:''绩效指标'', groupcols:[''guid'',''superid'',''name'',''levelno''],treedata:true,treemapping:null,initlevel:6,isuphide:false,editgroupdata:true,nextSibling:false,nogroupbox:true,rowtolist:false}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/case/deptindex', 'bustoolbutton', '{key:''/pmkpi/case/index''}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/case/deptindex', 'pmkpi_caseindex', '{}', 'caseindex', 'pmkpi', null);

--审核
delete from bus_t_pageconsole t where t.url  in('/pmkpi/case/audit');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/case/audit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.setting.casepage.audit.CaseAuditPage', 'audit', '{header:[header],left:lefttree,main:[toolbutton,queryform,tabpage,datatable]}', null, null, 1);

delete from bus_t_pagecomponent t where t.id in('pmkpi_caseaudit');
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_caseaudit', '案例审核', null, '案例审核', '/pmkpi/setting/casepage/caseaudit.js', 'Ext.lt.pmkpi.case.auditservice', 'pmkpi', 'pmkpi.casepage.audit.CaseAuditService');

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/case/audit');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/case/audit', 'pmkpi_caseaudit', '{}', 'caseaudit', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/case/audit', 'busqueryform', '{key:''/pmkpi/setting/case/list'',name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/case/audit', 'busdclefttree', '{}', 'lefttree', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/case/audit', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/case/audit', 'header', '{}', 'header', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/case/audit', 'busuidatatable', '{key:''/pmkpi/setting/case/list'',name:''绩效目标调整表'',checkbox:true,title:''绩效目标调整表'',edit:false,addrow:false}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/case/audit', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/case/audit', 'busfw.dataexport', '{}', 'dataexport', 'pmkpi', null);

--查询
delete from bus_t_pageconsole t where t.url  in('/pmkpi/case/query');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/case/query', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.setting.casepage.query.CaseQueryPage', 'list', '{header:[header],left:lefttree,main:[toolbutton,queryform,datatable]}', null, null, 1);

delete from bus_t_pagecomponent t where t.id in('pmkpi_casequery');
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_casequery', '案例查询', null, '案例查询', '/pmkpi/setting/casepage/casequery.js', 'Ext.lt.pmkpi.case.queryservice', 'pmkpi', 'pmkpi.casepage.query.CaseQueryService');

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/case/query');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/case/query', 'busqueryform', '{key:''/pmkpi/setting/case/list'',name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/case/query', 'busdclefttree', '{}', 'lefttree', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/case/query', 'pmkpi_casequery', '{}', 'casequery', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/case/query', 'header', '{}', 'header', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/case/query', 'busuidatatable', '{key:''/pmkpi/setting/case/list'',name:''绩效目标调整表'',checkbox:true,title:''绩效目标调整表'',edit:false,addrow:false}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/case/query', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/case/query', 'busfw.dataexport', '{}', 'dataexport', 'pmkpi', null);

--选择案例
delete from bus_t_pageconsole t where t.url  in('/pmkpi/case/report/check');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/case/report/check', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.setting.casepage.report.CaseReportPage', 'checkcase', '{main:[datatable,queryform],footer:[toolbutton]}', null, null, 0);

delete from bus_t_pagecomponent t where t.id in('pmkpi_checkcase');
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_checkcase', '选择案例', null, '选择案例', '/pmkpi/setting/casepage/casecheck.js', 'Ext.lt.pmkpi.case.checkservice', 'pmkpi', 'pmkpi.casepage.report.CaseCheckService');

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/case/report/check');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/case/report/check', 'busuidatatable', '{name:''选择案例'',checkbox:true,title:''选择案例'',edit:true,addrow:false}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/case/report/check', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/case/report/check', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''table'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/case/report/check', 'pmkpi_checkcase', '{}', 'checkcase', 'pmkpi', null);

