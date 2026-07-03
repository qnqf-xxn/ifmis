begin

delete from bus_t_pageconsole t where t.url in('/pmkpi/deptperformance/report/index');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/deptperformance/report/index', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', '', '', 'pmkpi', 'gov.mof.fasp2.pmkpi.tabfream.TabfreamPage', 'index', '{header:[header],left:lefttree,main:[toolbutton,queryform,tabpage,datatable]}', '', '', 0);

delete from bus_t_pagecomponent t where t.id in('pmkpi_tabfreamlist');
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_tabfreamlist', '绩效申报列表', '', '绩效申报列表', '/pmkpi/tabfream/tabfreamlist.js', 'Ext.lt.pmkpi.tabfreamlist', 'pmkpi', 'pmkpi.tabfream.TabfreamService');

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/deptperformance/report/index');

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/report/index', 'pmkpi_tabfreamlist', '{}', 'tabfreamlist', 'pmkpi', '');

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/report/index', 'busuidatatable', '{name:''部门绩效申报'',checkbox:true,title:''部门绩效申报'',edit:false,addrow:false,pagetype:''report'',uikey:''/pmkpi/deptperformance/report/edit'',deltables:[v_perf_t_deptfunction,v_bgt_perf_indicator]}', 'datatable', 'pmkpi', '');

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/report/index', 'header', '{}', 'header', 'pmkpi', '');

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/report/index', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', '');

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/report/index', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', '');

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/report/index', 'buslefttree', '{}', 'lefttree', 'pmkpi', '');

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/report/index', 'bustabpage', '{}', 'tabpage', 'pmkpi', '');

delete from bus_t_pageconsole t where t.url in('/pmkpi/deptperformance/report/edit');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/deptperformance/report/edit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', '', '', 'pmkpi', 'gov.mof.fasp2.pmkpi.tabfream.TabfreamPage', 'editindex', '{main:[tabpage,formaleditform,auditindexdatatable,toolbutton]}', '', '', 0);

delete from bus_t_pagecomponent t where t.id in('pmkpi_tabfreamedit');
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_tabfreamedit', '绩效申报填报', '', '绩效申报填报', '/pmkpi/tabfream/tabfreamedit.js', 'Ext.lt.pmkpi.tabfreamedit', 'pmkpi', 'pmkpi.tabfream.TabfreamEditService');

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/deptperformance/report/edit');

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/report/edit', 'pmkpi_tabfreamedit', '{}', 'tabfreamedit', 'pmkpi', '');

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/report/edit', 'buseditform', '{title:''基础信息'',tablecode:''perf_t_deptperfdeclare'',pagetype:''manceinfo''}', 'editform', 'pmkpi', '');



insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/report/edit', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', '');

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/report/edit', 'bustabpage', '{}', 'tabpage', 'pmkpi', '');

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/report/edit', 'busuidatatable', '{key:''/pmkpi/deptperformance/report/auditindex'',headsort:false,addrow:true,name:''考评一类指标'',edit:true,checkbox:true,title:''考评一类指标'',initlevel:6,isuphide:false,nextSibling:false}', 'auditindexdatatable', 'pmkpi', '');

delete from bus_t_pageconsole t where t.url in('/pmkpi/deptperformance/report/funcd');

insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/deptperformance/report/funcd', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', '', '', 'pmkpi', 'gov.mof.fasp2.pmkpi.deptperformance.func.DeptFuncPage', 'index', '{main:[datatable]}', '', '', 0);

delete from bus_t_pagecomponent t where t.id in('pmkpi_deptfunc');

insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_deptfunc', '部门职能活动', '', '部门职能活动', '/pmkpi/deptperformance/deptfunc.js', 'Ext.lt.pmkpi.deptfunc', 'pmkpi', 'pmkpi.deptperformance.func.DeptFuncService');

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/deptperformance/report/funcd');

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/report/funcd', 'pmkpi_deptfunc', '{}', 'deptfunc', 'pmkpi', '');

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/report/funcd', 'busuidatatable', '{headsort:false,addrow:true,nogroupbox:false,name:''部门职能活动'',edit:true,checkbox:true,title:''部门职能活动'',initlevel:6,isuphide:false,nextSibling:false,findex:''EA1B684EACB848D8BE35C84E3B551E81''}', 'datatable', 'pmkpi', '');



delete from bus_t_pageconsole t where t.url in('/pmkpi/deptperformance/report/perfindex');

insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/deptperformance/report/perfindex', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', '', '', 'pmkpi', 'gov.mof.fasp2.pmkpi.deptperformance.index.DeptIndexPage', 'index', '{main:[datatable]}', '', '', null);

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/deptperformance/report/perfindex');

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/report/perfindex', 'pmkpi_deptindex', '{}', 'deptindex', 'pmkpi', '');

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/report/perfindex', 'busuidatatable', '{headsort:false,addrow:false,nogroupbox:false,name:''年度绩效指标'',edit:true,checkbox:true,title:''年度绩效指标'', groupcols:[''guid'',''superid'',''name'',''levelno''],treedata:true,treemapping:null,initlevel:6,isuphide:false,editgroupdata:true,nextSibling:false,nogroupbox:true,modelguid:''7453C8E782048BF5F0D9354A088C39F1''}', 'datatable', 'pmkpi', '');



delete from bus_t_pagecomponent t where t.id in('pmkpi_deptindex');

insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_deptindex', '部门年度指标', '', '部门年度指标', '/pmkpi/deptperformance/deptindex.js', 'Ext.lt.pmkpi.deptindex', 'pmkpi', 'pmkpi.deptperformance.index.DeptIndexService');

delete from bus_t_pageconsole t where t.url in('/pmkpi/deptperformance/report/indexcheck');

insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/deptperformance/report/indexcheck', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', '', '', 'pmkpi', 'gov.mof.fasp2.pmkpi.deptperformance.index.DeptIndexPage', 'indexcheck', '{main:[toolbutton,queryform,datatable]}', '', '', 0);

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/deptperformance/report/indexcheck');

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/report/indexcheck', 'pmkpi_deptcheckindex', '{}', 'deptcheckindex', 'pmkpi', '');

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/report/indexcheck', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', '');

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/report/indexcheck', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', '');

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/report/indexcheck', 'busuidatatable', '{name:''选择指标'',checkbox:true,title:''选择指标'',edit:false,addrow:false}', 'datatable', 'pmkpi', '');



delete from bus_t_pagecomponent t where t.id in('pmkpi_deptcheckindex');

insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_deptcheckindex', '部门绩效申报选择指标', '', '部门绩效申报选择指标', '/pmkpi/deptperformance/checkindex.js', 'Ext.lt.pmkpi.deptperformance.deptcheckindex', 'pmkpi', 'pmkpi.deptperformance.index.DeptIndexService');


delete from bus_t_pageconsole t where t.url in('/pmkpi/deptperformance/audit/index');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/deptperformance/audit/index', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.deptperformance.page.DeptPerformanceAuditPage', 'index', '{header:[header],left:lefttree,main:[toolbutton,queryform,tabpage,datatable],height:[null,null,null,null]}', null, null, 0);

delete from bus_t_pagecomponent t where t.id in('pmkpi_deptperformanceaudit');
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_deptperformanceaudit', '绩效部门审核', null, '绩效部门审核', '/pmkpi/deptperformance/deptaudit.js', 'Ext.lt.pmkpi.deptperformance.depteauditservice', 'pmkpi', 'pmkpi.deptperformance.DeptPerformanceAuditService');

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/deptperformance/audit/index');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/audit/index', 'pmkpi_deptperformanceaudit', '{}', 'deptperformanceaudit', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/audit/index', 'busuidatatable', '{name:''部门绩效审核'',checkbox:true,title:''部门绩效审核'',edit:false,addrow:false,pagetype:''audit'',uikey:''/pmkpi/deptperformance/report/edit''}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/audit/index', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/audit/index', 'header', '{}', 'header', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/audit/index', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/audit/index', 'buslefttree', '{}', 'lefttree', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/audit/index', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

delete from bus_t_pageconsole t where t.url in('/pmkpi/audit/view');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/audit/view', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.deptperformance.audit.PmkpiPerfAuditPage', 'index', '{main:[]}', null, null, 0);

delete from bus_t_pagecomponent t where t.id in('pmkpi_audit');
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_audit', '部门绩效审核', null, '部门绩效审核', '/pmkpi/deptperformance/audit/auditservice.js', 'Ext.lt.pmkpi.auditservice', 'pmkpi', 'pmkpi.audit.PmkpiPerfAuditService');

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/audit/view');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/audit/view', 'pmkpi_audit', '{}', 'audit', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/audit/view', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

delete from bus_t_pageconsole t where t.url in('/pmkpi/audit/index/normal');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/audit/index/normal', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.deptperformance.audit.PmkpiPerfAuditPage', 'index', '{main:[editform]}', null, null, 0);

delete from bus_t_pagecomponent t where t.id in('pmkpi_auditinfo');
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_auditinfo', '部门绩效审核明细', null, '部门绩效审核明细', '/pmkpi/deptperformance/audit/audititem.js', 'Ext.lt.pmkpi.auditservice', 'pmkpi', 'pmkpi.audit.PmkpiPerfAuditService');

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/audit/index/normal');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/audit/index/normal', 'pmkpi_auditinfo', '{}', 'auditinfo', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/audit/index/normal', 'buseditform', '{title:''审核意见''}', 'editform', 'pmkpi', null);

delete from bus_t_pageconsole t where t.url in('/pmkpi/deptperformance/query/index');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/deptperformance/query/index', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.deptperformance.page.DeptPerformanceQueryPage', 'index', '{header:[header],left:lefttree,main:[toolbutton,queryform,datatable],height:[null,null,null,null]}', null, null, 0);

delete from bus_t_pagecomponent t where t.id in('pmkpi_deptperformancequery');
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_deptperformancequery', '绩效部门查询列表', null, '绩效部门查询列表', '/pmkpi/deptperformance/deptquery.js', 'Ext.lt.pmkpi.deptperformance.deptequeryservice', 'pmkpi', 'pmkpi.deptperformance.DeptPerformanceQueryService');

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/deptperformance/query/index');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/query/index', 'pmkpi_deptperformancequery', '{}', 'deptperformancequery', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/query/index', 'busuidatatable', '{name:''部门绩效'',checkbox:true,title:''部门绩效'',edit:false,addrow:false,uikey:''/pmkpi/deptperformance/report/edit''}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/query/index', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/query/index', 'header', '{}', 'header', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/query/index', 'buslefttree', '{}', 'lefttree', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/query/index', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

delete from bus_t_pageconsole t where t.url in('/pmkpi/deptperformance/report/addperfindex');

insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/deptperformance/report/addperfindex', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', '', '', 'pmkpi', 'gov.mof.fasp2.pmkpi.deptperformance.page.DeptPerformancePage', 'addindex', '{main:[toolbutton,editform]}', '', '', 0);

delete from bus_t_pagecomponent t where t.id in('pmkpi_deptaddindex');

insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_deptaddindex', '部门绩效申报新增指标', '', '部门绩效申报新增指标', '/pmkpi/deptperformance/adddeptindex.js', 'Ext.lt.pmkpi.deptperformance.deptaddindex', 'pmkpi', 'pmkpi.deptperformance.DeptPerformanceService');

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/deptperformance/report/addperfindex');

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/report/addperfindex', 'pmkpi_deptaddindex', '{}', 'deptaddindex', 'pmkpi', '');

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/report/addperfindex', 'buseditform', '{title:''指标信息''}', 'editform', 'pmkpi', '');

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/report/addperfindex', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', '');




delete from bus_t_pageconsole t where t.url in('/pmkpi/auditnode/index');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/auditnode/index', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', '', '', 'pmkpi', 'gov.mof.fasp2.pmkpi.setting.auditprocess.auditnode.AuditNodePage', 'index', '{header:[header],left:lefttree,main:[toolbutton,datatable]}', '', '', 0);


delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/auditnode/index');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/auditnode/index', 'pmkpi_auditnode', '{}', 'auditnode', 'pmkpi', '');

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/auditnode/index', 'busuidatatable', '{name:''流程节点审核配置'',checkbox:true,title:''流程节点审核配置'',edit:true,addrow:false}', 'datatable', 'pmkpi', '');

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/auditnode/index', 'header', '{}', 'header', 'pmkpi', '');

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/auditnode/index', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', '');

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/auditnode/index', 'buslefttree', '{}', 'lefttree', 'pmkpi', '');


delete from bus_t_pagecomponent t where t.id in('pmkpi_auditnode');
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_auditnode', '审核流程节点配置表', '', '审核流程节点配置表', '/pmkpi/setting/auditprocess/audltnodeservice.js', 'Ext.lt.pmkpi.auditnode', 'pmkpi', 'pmkpi.setting.auditnode.AuditNodeService');


delete from bus_t_pageconsole t where t.url in('/pmkpi/naturesaudit/index');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/naturesaudit/index', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', '', '', 'pmkpi', 'gov.mof.fasp2.pmkpi.setting.auditprocess.naturesaudit.NaturesAuditPage', 'index', '{header:[header],main:[toolbutton,datatable]}', '', '', 0);


delete from bus_t_pagecomponent t where t.id in('pmkpi_naturesaudit');
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_naturesaudit', '四性审核配置', '', '四性审核配置', '/pmkpi/setting/auditprocess/naturesauditservice.js', 'Ext.lt.pmkpi.naturesaudit', 'pmkpi', 'pmkpi.naturesaudit.NaturesAuditService');


delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/naturesaudit/index');

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/naturesaudit/index', 'pmkpi_naturesaudit', '{}', 'naturesaudit', 'pmkpi', '');

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/naturesaudit/index', 'busuidatatable', '{name:''四性审核配置'',checkbox:true,title:''四性审核配置'',edit:true,addrow:true}', 'datatable', 'pmkpi', '');

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/naturesaudit/index', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', '');

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/naturesaudit/index', 'header', '{}', 'header', 'pmkpi', '');

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/naturesaudit/index', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', '');


delete from bus_t_pageconsole t where t.url in('/pmkpi/audit/index/nature');

insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/audit/index/nature', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', '', '', 'pmkpi', 'gov.mof.fasp2.pmkpi.deptperformance.audit.PmkpiPerfAuditPage', 'index', '{main:[datatable]}', '', '', 0);

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/audit/index/nature');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/audit/index/nature', 'pmkpi_auditinfo', '{}', 'auditinfo', 'pmkpi', '');

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/audit/index/nature', 'busuidatatable', '{name:''四性审核'',checkbox:false,title:''四性审核'',edit:true,addrow:false}', 'datatable', 'pmkpi', '');

delete from bus_t_pagecomponent t where t.id in('pmkpi_auditinfo');
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_auditinfo', '部门绩效审核明细', '', '部门绩效审核明细', '/pmkpi/deptperformance/audit/audititem.js', 'Ext.lt.pmkpi.auditservice', 'pmkpi', 'pmkpi.audit.PmkpiPerfAuditService');

delete from bus_t_pageconsole t where t.url in('/pmkpi/audit/index/opinion');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/audit/index/opinion', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', '', '', 'pmkpi', 'gov.mof.fasp2.pmkpi.deptperformance.audit.PmkpiPerfAuditPage', 'index', '{main:[editform]}', '', '', 0);

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/audit/index/opinion');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/audit/index/opinion', 'pmkpi_auditinfo', '{}', 'auditinfo', 'pmkpi', '');

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/audit/index/opinion', 'buseditform', '{title:''审核意见''}', 'editform', 'pmkpi', '');

delete from bus_t_pagecomponent t where t.id in('pmkpi_auditinfo');
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_auditinfo', '部门绩效审核明细', '', '部门绩效审核明细', '/pmkpi/deptperformance/audit/audititem.js', 'Ext.lt.pmkpi.auditservice', 'pmkpi', 'pmkpi.audit.PmkpiPerfAuditService');
