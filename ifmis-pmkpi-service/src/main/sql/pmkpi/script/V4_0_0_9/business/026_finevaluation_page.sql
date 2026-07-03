begin
--财政评价项目确定
delete from bus_t_pageconsole t where t.url in('/pmkpi/evaluation/financial/proconfirm');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/evaluation/financial/proconfirm', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.evaluation.financial.proconfirm.ProConfirmPage', 'list', '{header:[header],left:lefttree,main:[toolbutton,queryform,tabpage,datatable]}', null, null, 1);

delete from bus_t_pagecomponent t where t.id in('pmkpi_finproconfirm');
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_finproconfirm', '财政评价项目确认', null, '财政评价项目确认', '/pmkpi/evaluation/financial/proconfirm/proconfirm.js', 'Ext.lt.pmkpi.financialevaluation.proconfire', 'pmkpi', 'pmkpi.financial.proconfirm.ProConfirmService');

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/evaluation/financial/proconfirm');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/proconfirm', 'pmkpi_finproconfirm', '{}', 'finproconfirm', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/proconfirm', 'busdclefttree', '{}', 'lefttree', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/proconfirm', 'busqueryform', '{key:''/pmkpi/evaluation/financial/program'',name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/proconfirm', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/proconfirm', 'header', '{}', 'header', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/proconfirm', 'busuidatatable', '{key:''/pmkpi/evaluation/financial/program'',name:''财政重点评价对象'',checkbox:true,title:''财政重点评价对象'',edit:true,addrow:false}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/proconfirm', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

--选择项目
--项目
delete from bus_t_pageconsole t where t.url in('/pmkpi/evaluation/financial/procheck');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/evaluation/financial/procheck', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.evaluation.financial.proconfirm.ProConfirmPage', 'check', '{main:[queryform,datatable],footer:[toolbutton]}', null, null, 0);

delete from bus_t_pagecomponent t where t.id in('pmkpi_financialprocheck');
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_financialprocheck', '财政评价选择项目', null, '财政评价选择项目', '/pmkpi/evaluation/financial/proconfirm/proconfirmchck.js', 'Ext.lt.pmkpi.financialevaluation.checkservice', 'pmkpi', 'pmkpi.financial.proconfirm.ProConfirmCheckService');

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/evaluation/financial/procheck');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/procheck', 'pmkpi_financialprocheck', '{}', 'financialprocheck', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/procheck', 'busuidatatable', '{key:''/pmkpi/program/report/list'',name:''项目'',checkbox:true,title:''项目'',edit:false,addrow:false}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/procheck', 'bustoolbutton', '{key:''/pmkpi/evaluation/financial/check''}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/procheck', 'busqueryform', '{key:''/pmkpi/program/report/list'',name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

--部门
delete from bus_t_pageconsole t where t.url in('/pmkpi/evaluation/financial/deptcheck');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/evaluation/financial/deptcheck', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.evaluation.financial.proconfirm.ProConfirmPage', 'check', '{main:[queryform,datatable],footer:[toolbutton]}', null, null, 0);

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/evaluation/financial/deptcheck');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/deptcheck', 'pmkpi_financialprocheck', '{}', 'financialprocheck', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/deptcheck', 'busuidatatable', '{name:''部门'',checkbox:true,title:''部门'',edit:false,addrow:false}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/deptcheck', 'bustoolbutton', '{key:''/pmkpi/evaluation/financial/check''}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/deptcheck', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

--项目编辑
delete from bus_t_pageconsole t where t.url in('/pmkpi/evaluation/finconfirm/proedit');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/evaluation/finconfirm/proedit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.tabfream.TabfreamPage', 'editindex', '{main:[tabpage,infoeditform],footer:[toolbutton]}', null, null, 0);

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/evaluation/finconfirm/proedit');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/finconfirm/proedit', 'pmkpi_tabfreamedit', '{}', 'tabfreamedit', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/finconfirm/proedit', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/finconfirm/proedit', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/finconfirm/proedit', 'buseditform', '{key:''/pmkpi/evaluation/finconfirm/edit'',columnsize:2,iswf:''true'',tablecode:''v_perf_t_finevaluation''}', 'infoeditform', 'pmkpi', null);

--部门编辑
delete from bus_t_pageconsole t where t.url in('/pmkpi/evaluation/finconfirm/deptedit');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/evaluation/finconfirm/deptedit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.tabfream.TabfreamPage', 'editindex', '{main:[tabpage,infoeditform],footer:[toolbutton]}', null, null, 0);

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/evaluation/finconfirm/deptedit');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/finconfirm/deptedit', 'pmkpi_tabfreamedit', '{}', 'tabfreamedit', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/finconfirm/deptedit', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/finconfirm/deptedit', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/finconfirm/deptedit', 'buseditform', '{key:''/pmkpi/evaluation/finconfirm/deptedit'',iswf:''true'',tablecode:''v_perf_t_finevaluation''}', 'infoeditform', 'pmkpi', null);


--财政评价项目审核
delete from bus_t_pageconsole t where t.url in('/pmkpi/evaluation/financial/audit');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/evaluation/financial/audit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.evaluation.financial.audit.FinancialAuditPage', 'list', '{header:[header],left:lefttree,main:[toolbutton,queryform,tabpage,datatable]}', null, null, 0);

delete from bus_t_pagecomponent t where t.id in('pmkpi_finevalaudit');
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_finevalaudit', '财政评价审核', null, '财政评价审核', '/pmkpi/evaluation/financial/audit/finaudit.js', 'Ext.lt.pmkpi.financialevaluation.audit', 'pmkpi', 'pmkpi.evaluation.financial.audit.FinancialAuditService');

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/evaluation/financial/audit');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/audit', 'pmkpi_finevalaudit', '{}', 'finevalaudit', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/audit', 'busdclefttree', '{}', 'lefttree', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/audit', 'busqueryform', '{key:''/pmkpi/evaluation/financial/program'',name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/audit', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/audit', 'header', '{}', 'header', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/audit', 'busuidatatable', '{key:''/pmkpi/evaluation/financial/program/audit'',name:''财政重点评价对象'',checkbox:true,title:''财政重点评价对象'',edit:true,addrow:false}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/audit', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

--审核意见
delete from bus_t_pageconsole t where t.url in('/pmkpi/evaluation/financial/auditedit');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/evaluation/financial/auditedit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.evaluation.financial.audit.FinancialAuditPage', 'audit', '{main:[editform],footer:[toolbutton]}', null, null, 0);

delete from bus_t_pagecomponent t where t.id in('pmkpi_finauditedit');
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_finauditedit', '财政评价审核编辑', null, '财政评价审核编辑', '/pmkpi/evaluation/financial/audit/auditopinion.js', 'Ext.lt.pmkpi.financialevaluation.auditservice', 'pmkpi', 'pmkpi.evaluation.financial.audit.FinancialAuditEditService');

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/evaluation/financial/auditedit');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/auditedit', 'pmkpi_finauditedit', '{}', 'finauditedit', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/auditedit', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/auditedit', 'buseditform', '{name:''编辑区'',edit:true,columnsize:2}', 'editform', 'pmkpi', null);


--财政评价成果上传
delete from bus_t_pageconsole t where t.url in('/pmkpi/evaluation/financial/resultupload');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/evaluation/financial/resultupload', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.evaluation.financial.result.ResultPage', 'list', '{header:[header],left:lefttree,main:[toolbutton,queryform,tabpage,datatable]}', null, null, 1);

delete from bus_t_pagecomponent t where t.id in('pmkpi_finevaluationresult');
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_finevaluationresult', '财政评价成果', null, '财政评价成果', '/pmkpi/evaluation/financial/result/resultservice.js', 'Ext.lt.pmkpi.financialevaluation.resultservice', 'pmkpi', 'pmkpi.evaluation.financial.ResultService');

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/evaluation/financial/resultupload');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/resultupload', 'pmkpi_finevaluationresult', '{}', 'finevaluationresult', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/resultupload', 'busdclefttree', '{}', 'lefttree', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/resultupload', 'busqueryform', '{key:''/pmkpi/evaluation/financial/program'',name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/resultupload', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/resultupload', 'header', '{}', 'header', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/resultupload', 'busuidatatable', '{key:''/pmkpi/evaluation/financial/program'',name:''财政重点评价对象'',checkbox:true,title:''财政重点评价对象'',edit:true,addrow:false}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/resultupload', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

--项目上传
delete from bus_t_pageconsole t where t.url in('/pmkpi/evaluation/financial/result/edit');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/evaluation/financial/result/edit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.tabfream.TabfreamPage', 'editindex', '{main:[tabpage,infoeditform,editform],footer:[toolbutton]}', null, null, 0);

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/evaluation/financial/result/edit');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/result/edit', 'pmkpi_tabfreamedit', '{}', 'tabfreamedit', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/result/edit', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/result/edit', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/result/edit', 'buseditform', '{key:''/pmkpi/evaluation/financial/result/edit'',iswf:''true'',tablecode:''v_perf_t_finevaluation'',title:''评估结果''}', 'editform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/result/edit', 'buseditform', '{key:''/pmkpi/evaluation/finconfirm/edit'',columnsize:2,iswf:''true'',tablecode:''v_perf_t_finevaluation''}', 'infoeditform', 'pmkpi', null);

--部门上传
delete from bus_t_pageconsole t where t.url in('/pmkpi/evaluation/financial/result/deptedit');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/evaluation/financial/result/deptedit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.tabfream.TabfreamPage', 'editindex', '{main:[tabpage,infoeditform,editform],footer:[toolbutton]}', null, null, 0);

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/evaluation/financial/result/deptedit');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/result/deptedit', 'pmkpi_tabfreamedit', '{}', 'tabfreamedit', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/result/deptedit', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/result/deptedit', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/result/deptedit', 'buseditform', '{key:''/pmkpi/evaluation/financial/result/edit'',iswf:''true'',tablecode:''v_perf_t_finevaluation'',title:''评估结果''}', 'editform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/result/deptedit', 'buseditform', '{key:''/pmkpi/evaluation/finconfirm/deptedit'',columnsize:2,iswf:''true'',tablecode:''v_perf_t_finevaluation''}', 'infoeditform', 'pmkpi', null);

--财政评价成果审核
delete from bus_t_pageconsole t where t.url in('/pmkpi/evaluation/financial/resultaudit');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/evaluation/financial/resultaudit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.evaluation.financial.result.ResultPage', 'audit', '{header:[header],left:lefttree,main:[toolbutton,queryform,tabpage,datatable]}', null, null, 1);

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/evaluation/financial/resultaudit');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/resultaudit', 'pmkpi_finevaluationresult', '{}', 'finevaluationresult', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/resultaudit', 'busdclefttree', '{}', 'lefttree', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/resultaudit', 'busqueryform', '{key:''/pmkpi/evaluation/financial/program'',name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/resultaudit', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/resultaudit', 'header', '{}', 'header', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/resultaudit', 'busuidatatable', '{key:''/pmkpi/evaluation/financial/program'',name:''财政重点评价对象'',checkbox:true,title:''财政重点评价对象'',edit:true,addrow:false}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/resultaudit', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

--财政评价反馈意见
delete from bus_t_pageconsole t where t.url in('/pmkpi/evaluation/financial/feedback');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/evaluation/financial/feedback', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.evaluation.financial.result.ResultPage', 'feedback', '{header:[header],left:lefttree,main:[toolbutton,queryform,tabpage,datatable]}', null, null, 1);

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/evaluation/financial/feedback');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/feedback', 'pmkpi_finevaluationresult', '{}', 'finevaluationresult', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/feedback', 'busdclefttree', '{}', 'lefttree', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/feedback', 'busqueryform', '{key:''/pmkpi/evaluation/financial/program'',name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/feedback', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/feedback', 'header', '{}', 'header', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/feedback', 'busuidatatable', '{key:''/pmkpi/evaluation/financial/program'',name:''财政重点评价对象'',checkbox:true,title:''财政重点评价对象'',edit:true,addrow:false}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/feedback', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

--财政评价接收通知
delete from bus_t_pageconsole t where t.url in('/pmkpi/evaluation/financial/acceptnotice');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/evaluation/financial/acceptnotice', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.evaluation.financial.result.ResultPage', 'acceptnotice', '{header:[header],left:lefttree,main:[toolbutton,queryform,datatable]}', null, null, 1);

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/evaluation/financial/acceptnotice');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/acceptnotice', 'pmkpi_finevaluationresult', '{}', 'finevaluationresult', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/acceptnotice', 'busdclefttree', '{}', 'lefttree', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/acceptnotice', 'busqueryform', '{key:''/pmkpi/evaluation/financial/program'',name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/acceptnotice', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/acceptnotice', 'header', '{}', 'header', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/acceptnotice', 'busuidatatable', '{key:''/pmkpi/evaluation/financial/acceptnotice'',name:''财政重点评价对象'',checkbox:true,title:''财政重点评价对象'',edit:true,addrow:false}', 'datatable', 'pmkpi', null);

--绩效评价类别维护
delete from bus_t_pageconsole t where t.url in('/pmkpi/setting/dataset/fineval');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/setting/dataset/fineval', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.setting.dataset.PerfDataSetPage', 'index', '{header:[header],main:[toolbutton,queryform,datatable]}', null, null, 1);

delete from bus_t_pagecomponent t where t.id in('pmkpi_perfdataset');
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_perfdataset', '绩效评估类别', null, '绩效评估类别', '/pmkpi/setting/dataset/perfdatasetservice.js', 'Ext.lt.pmkpi.perfdataset', 'pmkpi', 'pmkpi.setting.dataset.PerfDataSetService');

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/setting/dataset/fineval');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/dataset/fineval', 'pmkpi_perfdataset', '{}', 'perfdataset', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/dataset/fineval', 'busqueryform', '{key:''/pmkpi/setting/dataset'',name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/dataset/fineval', 'bustoolbutton', '{key:''/pmkpi/setting/dataset''}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/dataset/fineval', 'header', '{}', 'header', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/dataset/fineval', 'busuidatatable', '{key:''/pmkpi/setting/dataset'',name:''绩效评价类别'',checkbox:true,title:''绩效评价类别'',edit:true,addrow:true}', 'datatable', 'pmkpi', null);
