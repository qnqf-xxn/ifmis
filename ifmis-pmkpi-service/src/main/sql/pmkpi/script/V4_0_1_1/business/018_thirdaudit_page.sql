begin
  
--第三方审核推送
delete from bus_t_pageconsole t where t.url in('/pmkpi/audit/index/traceopinion');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/audit/index/traceopinion', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', '', '', 'pmkpi', 'gov.mof.fasp2.pmkpi.perfprotrace.audit.TraceOpinionAuditPage', 'index', '{main:[editform],footer:[toolbutton]}', '', '', 0);

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/audit/index/traceopinion');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/audit/index/traceopinion', 'pmkpi_audittraceopinion', '{}', 'audittraceopinion', 'pmkpi', '');

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/audit/index/traceopinion', 'buseditform', '{title:''审核意见''}', 'editform', 'pmkpi', '');

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/audit/index/traceopinion', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', '');

delete from bus_t_pagecomponent t where t.id in('pmkpi_audittraceopinion');
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_audittraceopinion', '监控绩效审核', '', '监控绩效审核', '/pmkpi/perfprotrace/audit/traceopinion.js', 'Ext.lt.pmkpi.perfprotrace.traceopinion', 'pmkpi', 'pmkpi.perfprotrace.audit.TraceOpinionAuditService');


--第三方审核首页
delete from bus_t_pageconsole t where t.url in('/pmkpi/program/trace/thirdaudit');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/program/trace/thirdaudit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfprotrace.thirdaudit.ProTraceThirdAuditPage', 'index', '{header:[header],left:lefttree,main:[toolbutton,queryform,tabpage,datatable]}', null, null, 0);

delete from bus_t_pagecomponent t where t.id in('pmkpi_protracethirdaudit');
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_protracethirdaudit', '项目绩效监控审核', null, '项目绩效监控审核', '/pmkpi/perfprotrace/thirdaudit/protracethirdaudit.js', 'Ext.lt.pmkpi.perfprogram.protracethirdaudit', 'pmkpi', 'pmkpi.perfprotrace.thirdaudit.ProTraceThirdAuditService');

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/program/trace/thirdaudit');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/thirdaudit', 'pmkpi_protracethirdaudit', '{}', 'protracethirdaudit', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/thirdaudit', 'busuidatatable', '{key:''/pmkpi/program/trace/report'',name:''绩效运行监控'',checkbox:true,title:''绩效运行监控'',edit:false,addrow:false}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/thirdaudit', 'header', '{}', 'header', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/thirdaudit', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/thirdaudit', 'busqueryform', '{key:''/pmkpi/program/trace/report'',name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/thirdaudit', 'busdclefttree', '{}', 'lefttree', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/thirdaudit', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);


--第三方审核填报
delete from Bus_t_Pageconsole t where t.url='/pmkpi/protrace/thirdaudit/opinion';
insert into Bus_t_Pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/protrace/thirdaudit/opinion', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfprotrace.thirdaudit.opinion.ThirdOpinionAuditPage', 'index', '{main:[tabpage,editform],footer:[toolbutton]}', null, null, 0);


delete from Bus_t_Pageconsolecomconfig t where t.url='/pmkpi/protrace/thirdaudit/opinion';
insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/protrace/thirdaudit/opinion', 'pmkpi_thirdauditopinion', '{}', 'thirdauditopinion', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/protrace/thirdaudit/opinion', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/protrace/thirdaudit/opinion', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/protrace/thirdaudit/opinion', 'buseditform', '{title:''审核意见'',tablecode:''V_PERF_T_TRACETHIRDAUDIT'',iswf:''true''}', 'editform', 'pmkpi', null);


delete from bus_t_pagecomponent t where t.id in('pmkpi_thirdauditopinion');
insert into Bus_t_Pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_thirdauditopinion', '项目绩效监控审核', null, '项目绩效监控审核', '/pmkpi/perfprotrace/thirdaudit/thirdauditopinion.js', 'Ext.lt.pmkpi.perfprogram.thirdauditopinion', 'pmkpi', 'pmkpi.perfprotrace.thirdaudit.ThirdOpinionAuditService');



delete from bus_t_pageconsole t where t.url in('/pmkpi/program/trace/auditresults');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/program/trace/auditresults', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfprotrace.thirdaudit.ProTraceThirdAuditPage', 'auditresults', '{header:[header],left:lefttree,main:[toolbutton,queryform,tabpage,datatable]}', null, null, 0);

delete from bus_t_pagecomponent t where t.id in('pmkpi_traceauditresults');
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_traceauditresults', '项目绩效监控审核', null, '项目绩效监控审核', '/pmkpi/perfprotrace/thirdaudit/traceauditresults.js', 'Ext.lt.pmkpi.perfprogram.traceauditresults', 'pmkpi', 'pmkpi.perfprotrace.thirdaudit.ProTraceThirdAuditService');

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/program/trace/auditresults');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/auditresults', 'pmkpi_traceauditresults', '{}', 'traceauditresults', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/auditresults', 'busuidatatable', '{key:''/pmkpi/program/trace/report'',name:''绩效运行监控'',checkbox:true,title:''绩效运行监控'',edit:false,addrow:false}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/auditresults', 'header', '{}', 'header', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/auditresults', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/auditresults', 'busqueryform', '{key:''/pmkpi/program/trace/report'',name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/auditresults', 'busdclefttree', '{}', 'lefttree', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/auditresults', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);
