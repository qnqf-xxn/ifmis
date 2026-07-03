begin

--绩效目标调整填报
delete from bus_t_pageconsole t where t.url in('/pmkpi/adjust/report');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/adjust/report', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.adjust.report.AdjustReportPage', 'index', '{header:[header],left:lefttree,main:[toolbutton,queryform,tabpage,datatable]}', null, null, 0);

delete from bus_t_pagecomponent t where t.id in('pmkpi_adjustreport');
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_adjustreport', '绩效目标调整列表', null, '绩效目标调整列表', '/pmkpi/adjust/report/reportservice.js', 'Ext.lt.pmkpi.adjust.reportservice', 'pmkpi', 'pmkpi.adjust.report.AdjustReportService');

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/adjust/report');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/report', 'pmkpi_adjustreport', '{}', 'adjustreport', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/report', 'busuidatatable', '{key:''/pmkpi/adjust/report/program'',name:''绩效目标调整表'',checkbox:true,title:''绩效目标调整表'',edit:false,addrow:false}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/report', 'busqueryform', '{key:''/pmkpi/adjust/report/program'',name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/report', 'busdclefttree', '{}', 'lefttree', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/report', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/report', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/report', 'header', '{}', 'header', 'pmkpi', null);


--选择项目
--项目
delete from bus_t_pageconsole t where t.url in('/pmkpi/adjust/report/procheck');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/adjust/report/procheck', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.adjust.report.AdjustReportPage', 'check', '{main:[queryform,datatable],footer:[toolbutton]}', null, null, 0);

delete from bus_t_pagecomponent t where t.id in('pmkpi_adjustreportcheck');
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_adjustreportcheck', '绩效目标调整选择项目', null, '绩效目标调整选择项目', '/pmkpi/adjust/report/adjustreportcheck.js', 'Ext.lt.pmkpi.adjust.checkservice', 'pmkpi', 'pmkpi.adjust.report.AdjustCheckService');

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/adjust/report/procheck');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/report/procheck', 'pmkpi_adjustreportcheck', '{}', 'adjustreportcheck', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/report/procheck', 'busuidatatable', '{key:''/pmkpi/program/report/list'',name:''绩效目标调整表'',checkbox:true,title:''绩效目标调整表'',edit:false,addrow:false}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/report/procheck', 'bustoolbutton', '{key:''/pmkpi/adjust/report/check''}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/report/procheck', 'busqueryform', '{key:''/pmkpi/program/report/list'',name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

--部门
delete from bus_t_pageconsole t where t.url in('/pmkpi/adjust/report/deptcheck');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/adjust/report/deptcheck', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.adjust.report.AdjustReportPage', 'check', '{main:[queryform,datatable],footer:[toolbutton]}', null, null, 0);

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/adjust/report/deptcheck');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/report/deptcheck', 'pmkpi_adjustreportcheck', '{}', 'adjustreportcheck', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/report/deptcheck', 'busuidatatable', '{key:''/pmkpi/deptperformance/report/index'',name:''绩效目标调整表'',checkbox:true,title:''绩效目标调整表'',edit:false,addrow:false}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/report/deptcheck', 'bustoolbutton', '{key:''/pmkpi/adjust/report/check''}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/report/deptcheck', 'busqueryform', '{key:''/pmkpi/deptperformance/report/index'',name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);


--编辑区
--项目
delete from bus_t_pageconsole t where t.url in('/pmkpi/adjust/report/proedit');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/adjust/report/proedit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.tabfream.TabfreamPage', 'editindex', '{main:[tabpage],footer:[toolbutton]}', null, null, 0);

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/adjust/report/proedit');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/report/proedit', 'pmkpi_tabfreamedit', '{}', 'tabfreamedit', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/report/proedit', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/report/proedit', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

--基本信息
delete from bus_t_pageconsole t where t.url in('/pmkpi/adjust/report/proedit/info');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/adjust/report/proedit/info', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.adjust.editinfo.EditInfoProPage', 'editInfo', '{main:[infoeditform,editform]}', null, null, 0);

delete from bus_t_pagecomponent t where t.id in('pmkpi_adjustinfo');
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_adjustinfo', '绩效目标调整基本信息', null, '绩效目标调整基本信息', '/pmkpi/adjust/editinfo/editinfoservice.js', 'Ext.lt.pmkpi.adjust.editinfoservice', 'pmkpi', 'pmkpi.adjust.editinfo.EditInfoProService');

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/adjust/report/proedit/info');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/report/proedit/info', 'pmkpi_adjustinfo', '{}', 'adjustinfo', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/report/proedit/info', 'buseditform', '{key:''/pmkpi/program/report/edit'',title:''项目基础信息'',tablecode:''v_perf_project_info''}', 'infoeditform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/report/proedit/info', 'buseditform', '{}', 'editform', 'pmkpi', null);

--资金明细
delete from bus_t_pageconsole t where t.url in('/pmkpi/adjust/report/proedit/bgtamt');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/adjust/report/proedit/bgtamt', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.adjust.editquery.EditQueryPage', 'index', '{main:[datatable]}', null, null, 0);

delete from bus_t_pagecomponent t where t.id in('pmkpi_adjusteditquery');
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_adjusteditquery', '绩效目标调整查询', null, '绩效目标调整查询', '/pmkpi/adjust/editquery/editqueryservice.js', 'Ext.lt.pmkpi.adjust.editqueryservice', 'pmkpi', 'pmkpi.adjust.editinfo.EditInfoProService');

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/adjust/report/proedit/bgtamt');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/report/proedit/bgtamt', 'pmkpi_adjusteditquery', '{}', 'adjustquery', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/report/proedit/bgtamt', 'busuidatatable', '{key:''/pmkpi/program/report/mxdatatable'',name:''资金明细'',checkbox:true,title:''资金明细'',edit:true,addrow:false}', 'datatable', 'pmkpi', null);

--调整目标
delete from bus_t_pageconsole t where t.url in('/pmkpi/adjust/report/proedit/goal');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/adjust/report/proedit/goal', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.adjust.goal.AdjustGoalPage', 'index', '{main:[editform]}', null, null, 0);

delete from bus_t_pagecomponent t where t.id in('pmkpi_adjustgoal');
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_adjustgoal', '绩效目标调整绩效目标', null, '绩效目标调整绩效目标', '/pmkpi/adjust/goal/adjustgoal.js', 'Ext.lt.pmkpi.adjust.goalservice', 'pmkpi', 'pmkpi.adjust.goal.AdjustGoalService');

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/adjust/report/proedit/goal');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/report/proedit/goal', 'pmkpi_adjustgoal', '{}', 'adjustgoal', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/report/proedit/goal', 'buseditform', '{tablecode:''v_pm_perf_goal_info''}', 'editform', 'pmkpi', null);

--调整指标
delete from bus_t_pageconsole t where t.url in('/pmkpi/adjust/report/proedit/index');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/adjust/report/proedit/index', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.adjust.index.AdjustIndexPage', 'index', '{main:[editform,toolbutton,datatable]}', null, null, null);

delete from bus_t_pagecomponent t where t.id in('pmkpi_adjustindex');
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_adjustindex', '绩效目标调整绩效指标', null, '绩效目标调整绩效指标', '/pmkpi/adjust/index/adjustindex.js', 'Ext.lt.pmkpi.adjust.indexservice', 'pmkpi', 'pmkpi.adjust.index.AdjustIndexService');

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/adjust/report/proedit/index');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/report/proedit/index', 'pmkpi_adjustindex', '{}', 'adjustindex', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/report/proedit/index', 'busuidatatable', '{headsort:false,addrow:false,nogroupbox:false,name:''年度绩效指标'',edit:true,checkbox:true,title:''年度绩效指标'', groupcols:[''guid'',''superid'',''name'',''levelno''],treedata:true,treemapping:null,initlevel:6,isuphide:false,editgroupdata:true,nextSibling:false,nogroupbox:true}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/report/proedit/index', 'buseditform', '{}', 'editform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/report/proedit/index', 'bustoolbutton', '{key:''/pmkpi/adjust/report/edit/index''}', 'toolbutton', 'pmkpi', null);

--指标编辑
delete from bus_t_pageconsole t where t.url in('/pmkpi/adjust/report/proedit/editindex');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/adjust/report/proedit/editindex', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.deptperformance.index.DeptIndexPage', 'editpage', '{main:[indexform],footer:[toolbutton]}', null, null, 0);

delete from bus_t_pagecomponent t where t.id in('pmkpi_adjusteditindex');
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_adjusteditindex', '绩效目标调整指标编辑', null, '绩效目标调整指标编辑', '/pmkpi/adjust/index/adjustindexedit.js', 'Ext.lt.pmkpi.indexedit', 'pmkpi', 'pmkpi.adjust.index.AdjustIndexEditService');

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/adjust/report/proedit/editindex');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/report/proedit/editindex', 'pmkpi_adjusteditindex', '{}', 'adjusteditindex', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/report/proedit/editindex', 'bustoolbutton', '{key:''/pmkpi/adjust/report/edit/editindex''}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/report/proedit/editindex', 'buseditform', '{key:''/pmkpi/program/prjindex/editindex'',name:''编辑区'',columnsize:2,amtflag:2}', 'indexform', 'pmkpi', null);

--部门
delete from bus_t_pageconsole t where t.url in('/pmkpi/adjust/report/deptedit');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/adjust/report/deptedit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.tabfream.TabfreamPage', 'editindex', '{main:[tabpage],footer:[toolbutton]}', null, null, 0);

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/adjust/report/deptedit');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/report/deptedit', 'pmkpi_tabfreamedit', '{}', 'tabfreamedit', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/report/deptedit', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/report/deptedit', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

--基础信息
delete from bus_t_pageconsole t where t.url in('/pmkpi/adjust/report/deptedit/info');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/adjust/report/deptedit/info', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.adjust.editinfo.EditInfoProPage', 'editInfo', '{main:[infoeditform,editform]}', null, null, 0);

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/adjust/report/deptedit/info');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/report/deptedit/info', 'pmkpi_adjustinfo', '{}', 'adjustinfo', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/report/deptedit/info', 'buseditform', '{key:''/pmkpi/deptperformance/report/edit'',title:''部门基础信息'',tablecode:''v_perf_t_deptperfdeclare''}', 'infoeditform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/report/deptedit/info', 'buseditform', '{}', 'editform', 'pmkpi', null);

--年度任务
delete from bus_t_pageconsole t where t.url in('/pmkpi/adjust/report/deptedit/task');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/adjust/report/deptedit/task', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.adjust.editquery.EditQueryPage', 'index', '{main:[datatable]}', null, null, 0);

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/adjust/report/deptedit/task');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/report/deptedit/task', 'pmkpi_adjusteditquery', '{}', 'adjustquery', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/report/deptedit/task', 'busuidatatable', '{key:''/pmkpi/deptperformance/report/perftask'',name:''年度任务'',checkbox:true,title:''年度任务'',edit:true,addrow:false}', 'datatable', 'pmkpi', null);

--调整目标
delete from bus_t_pageconsole t where t.url in('/pmkpi/adjust/report/deptedit/goal');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/adjust/report/deptedit/goal', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.adjust.goal.AdjustGoalPage', 'index', '{main:[editform]}', null, null, 0);

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/adjust/report/deptedit/goal');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/report/deptedit/goal', 'pmkpi_adjustgoal', '{}', 'adjustgoal', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/report/deptedit/goal', 'buseditform', '{tablecode:''v_bgt_perf_goal_info''}', 'editform', 'pmkpi', null);

--调整指标
delete from bus_t_pageconsole t where t.url in('/pmkpi/adjust/report/deptedit/index');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/adjust/report/deptedit/index', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.adjust.index.AdjustIndexPage', 'index', '{main:[editform,toolbutton,datatable]}', null, null, null);

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/adjust/report/deptedit/index');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/report/deptedit/index', 'pmkpi_adjustindex', '{}', 'adjustindex', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/report/deptedit/index', 'busuidatatable', '{headsort:false,addrow:false,nogroupbox:false,name:''年度绩效指标'',edit:true,checkbox:true,title:''年度绩效指标'', groupcols:[''guid'',''superid'',''name'',''levelno''],treedata:true,treemapping:null,initlevel:6,isuphide:false,editgroupdata:true,nextSibling:false,nogroupbox:true}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/report/deptedit/index', 'buseditform', '{}', 'editform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/report/deptedit/index', 'bustoolbutton', '{key:''/pmkpi/adjust/report/edit/index''}', 'toolbutton', 'pmkpi', null);

--指标编辑
delete from bus_t_pageconsole t where t.url in('/pmkpi/adjust/report/deptedit/editindex');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/adjust/report/deptedit/editindex', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.deptperformance.index.DeptIndexPage', 'editpage', '{main:[indexform],footer:[toolbutton]}', null, null, 0);

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/adjust/report/deptedit/editindex');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/report/deptedit/editindex', 'pmkpi_adjusteditindex', '{}', 'adjusteditindex', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/report/deptedit/editindex', 'bustoolbutton', '{key:''/pmkpi/adjust/report/edit/editindex''}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/report/deptedit/editindex', 'buseditform', '{key:''/pmkpi/deptperformance/report/editindex'',name:''编辑区'',columnsize:2,amtflag:2}', 'indexform', 'pmkpi', null);

--审核
delete from bus_t_pageconsole t where t.url in('/pmkpi/adjust/audit');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/adjust/audit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.adjust.audit.AdjustAuditPage', 'index', '{header:[header],left:lefttree,main:[toolbutton,queryform,tabpage,datatable]}', null, null, 0);

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/adjust/audit');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/audit', 'pmkpi_adjustaudit', '{}', 'adjustaudit', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/audit', 'busqueryform', '{key:''/pmkpi/adjust/report/program'',name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/audit', 'busdclefttree', '{}', 'lefttree', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/audit', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/audit', 'header', '{}', 'header', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/audit', 'busuidatatable', '{key:''/pmkpi/adjust/report/program'',name:''绩效目标调整表'',checkbox:true,title:''绩效目标调整表'',edit:false,addrow:false}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/audit', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

delete from bus_t_pagecomponent t where t.id in('pmkpi_adjustaudit');
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_adjustaudit', '绩效目标调整审核', null, '绩效目标调整审核', '/pmkpi/adjust/audit/adjustaudit.js', 'Ext.lt.pmkpi.adjust.auditservice', 'pmkpi', 'pmkpi.adjust.audit.AdjustAuditService');


--查询
delete from bus_t_pageconsole t where t.url in('/pmkpi/adjust/query');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/adjust/query', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.adjust.query.AdjustQueryPage', 'index', '{header:[header],left:lefttree,main:[toolbutton,queryform,datatable]}', null, null, 0);

delete from bus_t_pagecomponent t where t.id in('pmkpi_adjustquery');
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_adjustquery', '绩效目标调整查询', null, '绩效目标调整查询', '/pmkpi/adjust/query/adjustquery.js', 'Ext.lt.pmkpi.adjust.queryservice', 'pmkpi', 'pmkpi.adjust.query.AdjustQueryService');

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/adjust/query');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/query', 'pmkpi_adjustquery', '{}', 'adjustquery', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/query', 'busqueryform', '{key:''/pmkpi/adjust/report/program'',name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/query', 'busdclefttree', '{}', 'lefttree', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/query', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/query', 'header', '{}', 'header', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/query', 'busuidatatable', '{key:''/pmkpi/adjust/report/program'',name:''绩效目标调整表'',checkbox:true,title:''绩效目标调整表'',edit:false,addrow:false}', 'datatable', 'pmkpi', null);
