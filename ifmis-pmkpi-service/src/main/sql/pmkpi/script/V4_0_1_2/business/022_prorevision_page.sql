begin
delete from bus_t_pageconsole where url in('/pmkpi/prorevision/power','/pmkpi/prorevision/report','/pmkpi/prorevision/report/proedit','/pmkpi/prorevision/report/deptedit','/pmkpi/prorevision/report/deptcheck','/pmkpi/prorevision/report/procheck','/pmkpi/prorevision/report/dept','/pmkpi/prorevision/report/program','/pmkpi/prorevision/report/proedit/info','/pmkpi/prorevision/report/proedit/goal','/pmkpi/prorevision/report/proedit/index','/pmkpi/prorevision/report/proedit/editindex','/pmkpi/prorevision/report/edit/editindex');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/prorevision/power', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.prorevision.empower.ProrevisionPowerPage', 'index', '{header:[header],main:[toolbutton,queryform,tabpage,datatable]}', null, null, 0);

insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/prorevision/report', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.prorevision.report.ProrevisionReportPage', 'index', '{header:[header],left:lefttree,main:[toolbutton,queryform,tabpage,datatable]}', null, null, 0);

insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/prorevision/report/deptcheck', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.prorevision.report.ProrevisionReportPage', 'check', '{main:[queryform,datatable],footer:[toolbutton]}', null, null, 0);

insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/prorevision/report/procheck', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.prorevision.report.ProrevisionReportPage', 'check', '{main:[queryform,datatable],footer:[toolbutton]}', null, null, 0);

insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/prorevision/report/proedit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.tabfream.TabfreamPage', 'editindex', '{main:[tabpage],footer:[toolbutton]}', null, null, 0);

insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/prorevision/report/proedit/goal', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.prorevision.goal.ProrevisionGoalPage', 'index', '{main:[tabpage,editform]}', null, null, 0);

insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/prorevision/report/proedit/index', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.prorevision.index.ProrevisionIndexPage', 'index', '{main:[toolbutton,tabpage,datatable]}', null, null, null);

insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/prorevision/report/proedit/info', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.prorevision.editinfo.EditInfoProPage', 'editInfo', '{main:[infoeditform,editform]}', null, null, 0);


delete from bus_t_pageconsole where url = '/pmkpi/prorevision/audit';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/prorevision/audit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.prorevision.audit.ProrevisionAuditPage', 'index', '{header:[header],left:lefttree,main:[toolbutton,queryform,tabpage,datatable]}', null, null, 0);



delete from bus_t_pageconsolecomconfig where url = '/pmkpi/prorevision/power';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/prorevision/power', 'pmkpi_revisionpower', '{}', 'revisionpower', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/prorevision/power', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/prorevision/power', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/prorevision/power', 'header', '{}', 'header', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/prorevision/power', 'busuidatatable', '{tablecode:''pmkpi_fasp_t_pubagency'',title:''绩效目标修订授权'', groupcols:[''guid'',''superid'',''name'',''levelno''],edit:false,checkbox:true,treedata:true,treemapping:null,initlevel:6,isuphide:false,editgroupdata:true,nextSibling:false,nogroupbox:false}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/prorevision/power', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);



delete from bus_t_pageconsolecomconfig where url = '/pmkpi/prorevision/report';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/prorevision/report', 'pmkpi_revisionreport', '{}', 'revisionreport', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/prorevision/report', 'header', '{}', 'header', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/prorevision/report', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/prorevision/report', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/prorevision/report', 'busqueryform', '{key:''/pmkpi/prorevision/report/dept'',name:''部门整体查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'deptqueryform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/prorevision/report', 'busdclefttree', '{}', 'lefttree', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/prorevision/report', 'busuidatatable', '{key:''/pmkpi/prorevision/report/program'',name:''绩效目标修订表'',checkbox:true,title:''绩效目标修订表'',edit:false,addrow:false}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/prorevision/report', 'busuidatatable', '{key:''/pmkpi/prorevision/report/dept'',name:''部门整体绩效目标修订表'',checkbox:true,title:''绩效目标修订表'',edit:false,addrow:false}', 'deptdatatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/prorevision/report', 'busqueryform', '{key:''/pmkpi/prorevision/report/program'',name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);


delete from bus_t_pageconsolecomconfig where url = '/pmkpi/prorevision/report/procheck';

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/prorevision/report/procheck', 'pmkpi_revisionreportcheck', '{}', 'revisionreportcheck', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/prorevision/report/procheck', 'busqueryform', '{key:''/pmkpi/program/report/list'',name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/prorevision/report/procheck', 'busuidatatable', '{key:''/pmkpi/program/report/list'',name:''绩效目标修订表'',checkbox:true,title:''绩效目标修订表'',edit:false,addrow:false,wheresql:'' wfstatus=011 and exists (select 1 from v_pm_perf_goal_info gf where gf.mainguid = t.guid and gf.YEARFLAG = 1)''}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/prorevision/report/procheck', 'bustoolbutton', '{key:''/pmkpi/prorevision/report/check''}', 'toolbutton', 'pmkpi', null);



delete from bus_t_pageconsolecomconfig where url = '/pmkpi/prorevision/report/proedit';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/prorevision/report/proedit', 'pmkpi_tabfreamedit', '{}', 'tabfreamedit', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/prorevision/report/proedit', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/prorevision/report/proedit', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);


delete from bus_t_pageconsolecomconfig where url = '/pmkpi/prorevision/report/proedit/editindex';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/prorevision/report/proedit/editindex', 'pmkpi_prorevisioneditindex', '{}', 'prorevisioneditindex', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/prorevision/report/proedit/editindex', 'bustoolbutton', '{key:''/pmkpi/prorevision/report/edit/editindex''}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/prorevision/report/proedit/editindex', 'buseditform', '{key:''/pmkpi/program/prjindex/editindex'',name:''编辑区'',columnsize:2,amtflag:2}', 'indexform', 'pmkpi', null);


delete from bus_t_pageconsolecomconfig where url = '/pmkpi/prorevision/report/proedit/goal';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/prorevision/report/proedit/goal', 'pmkpi_revisiongoal', '{}', 'revisiongoal', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/prorevision/report/proedit/goal', 'buseditform', '{}', 'editform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/prorevision/report/proedit/goal', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

delete from bus_t_pageconsolecomconfig where url = '/pmkpi/prorevision/report/proedit/index';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/prorevision/report/proedit/index', 'pmkpi_revisionindex', '{}', 'revisionindex', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/prorevision/report/proedit/index', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/prorevision/report/proedit/index', 'busuidatatable', '{headsort:false,addrow:false,nogroupbox:false,name:''年度绩效指标'',edit:true,checkbox:true,title:''年度绩效指标'', groupcols:[''guid'',''superid'',''name'',''levelno''],treedata:true,treemapping:null,initlevel:6,isuphide:false,editgroupdata:true,nextSibling:false,nogroupbox:true}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/prorevision/report/proedit/index', 'bustoolbutton', '{key:''/pmkpi/prorevision/report/edit/index''}', 'toolbutton', 'pmkpi', null);


delete from bus_t_pageconsolecomconfig where url = '/pmkpi/prorevision/report/proedit/info';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/prorevision/report/proedit/info', 'buseditform', '{}', 'editform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/prorevision/report/proedit/info', 'pmkpi_revisioninfo', '{}', 'revisioninfo', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/prorevision/report/proedit/info', 'buseditform', '{key:''/pmkpi/program/report/edit'',title:''项目基础信息'',tablecode:''v_perf_project_info''}', 'infoeditform', 'pmkpi', null);


delete from bus_t_pageconsolecomconfig where url = '/pmkpi/prorevision/audit';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/prorevision/audit', 'pmkpi_prorevisionaudit', '{}', 'prorevisionaudit', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/prorevision/audit', 'busqueryform', '{key:''/pmkpi/prorevision/report/program'',name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/prorevision/audit', 'busdclefttree', '{}', 'lefttree', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/prorevision/audit', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/prorevision/audit', 'header', '{}', 'header', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/prorevision/audit', 'busuidatatable', '{key:''/pmkpi/prorevision/report/program'',name:''绩效目标调整表'',checkbox:true,title:''绩效目标调整表'',edit:false,addrow:false}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/prorevision/audit', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);



delete from bus_t_pagecomponent where id in ('pmkpi_revisionpower','pmkpi_revisionreport','pmkpi_revisionreportcheck','pmkpi_prorevisioneditindex','pmkpi_revisiongoal','pmkpi_revisionindex','pmkpi_revisioninfo','pmkpi_prorevisionaudit');
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_revisionreportcheck', '绩效目标修订选择项目', null, '绩效目标修订选择项目', '/pmkpi/prorevision/report/proreportcheck.js', 'Ext.lt.pmkpi.prorevision.revisioncheckservice', 'pmkpi', 'pmkpi.prorevision.ProrevisionCheckService');

insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_revisionpower', '绩效目标修订授权', null, '绩效目标修订授权', '/pmkpi/prorevision/power/revisionpower.js', 'Ext.lt.pmkpi.prorevision.revisionpower', 'pmkpi', 'pmkpi.prorevision.ProrevisionPowerService');

insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_revisionreport', '绩效目标修订填报', null, '绩效目标修订填报', '/pmkpi/prorevision/report/proreport.js', 'Ext.lt.pmkpi.prorevision.revisionreportservice', 'pmkpi', 'pmkpi.prorevision.ProrevisionReportService');

insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_revisioninfo', '绩效目标修订基本信息', null, '绩效目标修订基本信息', '/pmkpi/prorevision/editinfo/editinfoservice.js', 'Ext.lt.pmkpi.prorevision.editinfoservice', 'pmkpi', 'pmkpi.prorevision.editinfo.EditInfoProService');

insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_revisiongoal', '绩效目标修订绩效目标', null, '绩效目标修订绩效目标', '/pmkpi/prorevision/goal/prorevisiongoal.js', 'Ext.lt.pmkpi.prorevision.goalservice', 'pmkpi', 'pmkpi.prorevision.goal.ProrevisionGoalService');

insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_revisionindex', '绩效目标修订绩效指标', null, '绩效目标修订绩效指标', '/pmkpi/prorevision/index/prorevisionindex.js', 'Ext.lt.pmkpi.prorevision.indexservice', 'pmkpi', 'pmkpi.prorevision.index.ProrevisionIndexService');

insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_prorevisionaudit', '绩效目标修订审核', null, '绩效目标修订审核', '/pmkpi/prorevision/audit/prorevisionaudit.js', 'Ext.lt.pmkpi.prorevision.auditservice', 'pmkpi', 'pmkpi.prorevision.ProrevisionAuditService');

insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_prorevisioneditindex', '绩效目标修订指标编辑', null, '绩效目标修订指标编辑', '/pmkpi/prorevision/index/prorevisionindexedit.js', 'Ext.lt.pmkpi.indexedit', 'pmkpi', 'pmkpi.prorevision.index.ProrevisionIndexEditService');

