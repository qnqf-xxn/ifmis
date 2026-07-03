begin

--填报
delete from bus_t_pageconsole t where t.url in('/pmkpi/workevaluate/report/list');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/workevaluate/report/list', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.workevaluate.report.WorkEvaluateReportPage', 'list', '{header:[header],left:lefttree,main:[toolbutton,queryform,tabpage,datatable]}', null, null, null);

delete from bus_t_pagecomponent t where t.id in('pmkpi_workevalreport');
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_workevalreport', '预算部门绩效管理工作考核', null, '预算部门绩效管理工作考核', '/pmkpi/workevaluate/report/workevaluatereport.js', 'Ext.lt.pmkpi.workevaluate.report', 'pmkpi', 'pmkpi.workevaluate.report.WorkEvaluateReportService');

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/workevaluate/report/list');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/workevaluate/report/list', 'pmkpi_workevalreport', '{}', 'workevalreport', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/workevaluate/report/list', 'busuidatatable', '{name:''绩效管理工作考核'',checkbox:true,title:''绩效管理工作考核'',edit:false,addrow:false}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/workevaluate/report/list', 'header', '{}', 'header', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/workevaluate/report/list', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/workevaluate/report/list', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/workevaluate/report/list', 'busdclefttree', '{}', 'lefttree', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/workevaluate/report/list', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

--编辑
delete from bus_t_pageconsole t where t.url in('/pmkpi/workevaluate/report/deptedit');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/workevaluate/report/deptedit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.tabfream.TabfreamPage', 'editindex', '{main:[tabpage,infoeditformformal],footer:[toolbutton]}', null, null, 0);

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/workevaluate/report/deptedit');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/workevaluate/report/deptedit', 'pmkpi_tabfreamedit', '{}', 'tabfreamedit', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/workevaluate/report/deptedit', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/workevaluate/report/deptedit', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/workevaluate/report/deptedit', 'buseditform', '{key:''/pmkpi/workevaluate/report/deptedit/info'',title:''基本信息'',tablecode:''v_perf_t_worktaskassign'',iswf:''true'',columnsize:2}', 'infoeditformformal', 'pmkpi', null);


--评分标
delete from bus_t_pageconsole t where t.url in('/pmkpi/workevaluate/report/deptedit/score');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/workevaluate/report/deptedit/score', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.workevaluate.score.WorkEvaluateScorePage', 'score', '{main:[datatable]}', null, null, 0);

delete from bus_t_pagecomponent t where t.id in('pmkpi_workevalscore');
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_workevalscore', '绩效工作管理考核评分表', null, '绩效工作管理考核评分表', '/pmkpi/workevaluate/score/workevaluatescore.js', 'Ext.lt.pmkpi.workevaluate.score', 'pmkpi', 'pmkpi.workevaluate.score.WorkEvaluateScoreService');

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/workevaluate/report/deptedit/score');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/workevaluate/report/deptedit/score', 'pmkpi_workevalscore', '{}', 'workevalscore', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/workevaluate/report/deptedit/score', 'busuidatatable', '{headsort:false,addrow:false,nogroupbox:true,edit:true,checkbox:true,groupcols:[''guid'',''superid'',''name'',''levelno''],treedata:true,treemapping:null,initlevel:6,isuphide:false,editgroupdata:true,nextSibling:false}', 'datatable', 'pmkpi', null);


--审核
delete from bus_t_pageconsole t where t.url in('/pmkpi/workevaluate/audit/list');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/workevaluate/audit/list', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.workevaluate.audit.WorkEvaluateAuditPage', 'list', '{header:[header],left:lefttree,main:[toolbutton,queryform,tabpage,datatable]}', null, null, null);

delete from bus_t_pagecomponent t where t.id in('pmkpi_workevalaudit');
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_workevalaudit', '绩效工作管理考核审核', null, '绩效工作管理考核审核', '/pmkpi/workevaluate/audit/workevaluateaudit.js', 'Ext.lt.pmkpi.workevaluate.audit', 'pmkpi', 'pmkpi.workevaluate.audit.WorkEvaluateAuditService');

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

--审核编辑
delete from bus_t_pageconsole t where t.url in('/pmkpi/workevaluate/audit/deptedit');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/workevaluate/audit/deptedit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.tabfream.TabfreamPage', 'editindex', '{main:[tabpage,infoeditformformal],footer:[toolbutton]}', null, null, 0);

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/workevaluate/audit/deptedit');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/workevaluate/audit/deptedit', 'pmkpi_tabfreamedit', '{}', 'tabfreamedit', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/workevaluate/audit/deptedit', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/workevaluate/audit/deptedit', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/workevaluate/audit/deptedit', 'buseditform', '{key:''/pmkpi/workevaluate/report/deptedit/info'',title:''基本信息'',tablecode:''v_perf_t_worktaskassign'',iswf:''true'',columnsize:2}', 'infoeditformformal', 'pmkpi', null);
