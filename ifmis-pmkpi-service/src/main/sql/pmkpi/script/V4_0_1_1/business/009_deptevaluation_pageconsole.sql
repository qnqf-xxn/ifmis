begin
--部门评价项目审核
delete from bus_t_pageconsole where url = '/pmkpi/evaluation/dept/audit';

insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/evaluation/dept/audit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.evaluation.dept.audit.DeptAuditPage', 'list', '{header:[header],left:lefttree,main:[toolbutton,queryform,tabpage,datatable]}', null, null, 0);

--部门评价项目申报
delete from bus_t_pageconsole where url = '/pmkpi/evaluation/dept/report';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/evaluation/dept/report', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.evaluation.dept.report.DeptReportPage', 'list', '{header:[header],left:lefttree,main:[toolbutton,queryform,tabpage,datatable]}', null, null, 1);

--部门评价成果申报
delete from bus_t_pageconsole where url = '/pmkpi/evaluation/dept/result';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/evaluation/dept/result', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.evaluation.dept.result.DeptResultPage', 'list', '{header:[header],left:lefttree,main:[toolbutton,queryform,tabpage,datatable]}', null, null, 1);

--部门评价成果审核
delete from bus_t_pageconsole where url = '/pmkpi/evaluation/dept/resultaudit';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/evaluation/dept/resultaudit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.evaluation.dept.result.DeptResultPage', 'audit', '{header:[header],left:lefttree,main:[toolbutton,queryform,tabpage,datatable]}', null, null, 1);

--部门评价成果查看
delete from bus_t_pageconsole where url = '/pmkpi/evaluation/dept/resultquery';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/evaluation/dept/resultquery', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.evaluation.dept.result.DeptResultPage', 'query', '{header:[header],left:lefttree,main:[toolbutton,queryform,tabpage,datatable]}', null, null, 1);

--选择项目
delete from bus_t_pageconsole where url = '/pmkpi/evaluation/dept/procheck';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/evaluation/dept/procheck', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.evaluation.dept.report.DeptReportPage', 'check', '{main:[queryform,datatable],footer:[toolbutton]}', null, null, 0);

--选择项目（部门）

delete from bus_t_pageconsole where url = '/pmkpi/evaluation/dept/deptcheck';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/evaluation/dept/deptcheck', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.evaluation.dept.report.DeptReportPage', 'check', '{main:[queryform,datatable],footer:[toolbutton]}', null, null, 0);

--审核流程
delete from bus_t_pageconsole where url = '/pmkpi/evaluation/dept/auditedit';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/evaluation/dept/auditedit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.evaluation.dept.audit.DeptAuditPage', 'audit', '{main:[editform],footer:[toolbutton]}', null, null, 0);

--项目明细
delete from bus_t_pageconsole where url = '/pmkpi/evaluation/deptreport/proedit';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/evaluation/deptreport/proedit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.tabfream.TabfreamPage', 'editindex', '{main:[tabpage,infoeditform],footer:[toolbutton]}', null, null, 0);

--项目明细（部门）
delete from bus_t_pageconsole where url = '/pmkpi/evaluation/deptreport/deptedit';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/evaluation/deptreport/deptedit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.tabfream.TabfreamPage', 'editindex', '{main:[tabpage,infoeditform],footer:[toolbutton]}', null, null, 0);

--成果上传（项目）
delete from bus_t_pageconsole where url = '/pmkpi/evaluation/dept/result/edit';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/evaluation/dept/result/edit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.tabfream.TabfreamPage', 'editindex', '{main:[tabpage,infoeditform,editform],footer:[toolbutton]}', null, null, 0);

--成果上传（部门）
delete from bus_t_pageconsole where url = '/pmkpi/evaluation/dept/result/deptedit';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/evaluation/dept/result/deptedit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.tabfream.TabfreamPage', 'editindex', '{main:[tabpage,infoeditform,editform],footer:[toolbutton]}', null, null, 0);

--
delete from bus_t_pageconsole where url = '/pmkpi/evaluation/deptreport/deptedit';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/evaluation/deptreport/deptedit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.tabfream.TabfreamPage', 'editindex', '{main:[tabpage,infoeditform],footer:[toolbutton]}', null, null, 0);




--部门评价项目审核
delete from bus_t_pageconsolecomconfig where url = '/pmkpi/evaluation/dept/audit';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/dept/audit', 'pmkpi_deptaudit', '{}', 'deptaudit', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/dept/audit', 'busdclefttree', '{}', 'lefttree', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/dept/audit', 'busqueryform', '{key:''/pmkpi/evaluation/dept/program'',name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/dept/audit', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/dept/audit', 'header', '{}', 'header', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/dept/audit', 'busuidatatable', '{key:''/pmkpi/evaluation/dept/program/audit'',name:''部门评价对象'',checkbox:true,title:''部门评价对象'',edit:true,addrow:false}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/dept/audit', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

delete from bus_t_pagecomponent where id = 'pmkpi_deptaudit';
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_deptaudit', '部门评价审核', null, '部门评价审核', '/pmkpi/evaluation/dept/audit/deptaudit.js', 'Ext.lt.pmkpi.deptevaluation.audit', 'pmkpi', 'pmkpi.evaluation.dept.audit.DeptAuditService');


--部门评价项目申报
delete from bus_t_pageconsolecomconfig where url = '/pmkpi/evaluation/dept/report';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/dept/report', 'pmkpi_deptproconfirm', '{}', 'deptproconfirm', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/dept/report', 'busdclefttree', '{}', 'lefttree', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/dept/report', 'busqueryform', '{key:''/pmkpi/evaluation/dept/program'',name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/dept/report', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/dept/report', 'header', '{}', 'header', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/dept/report', 'busuidatatable', '{key:''/pmkpi/evaluation/dept/program'',name:''部门项目评价'',checkbox:true,title:''部门项目评价'',edit:true,addrow:false}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/dept/report', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

delete from bus_t_pagecomponent where id = 'pmkpi_deptproconfirm';
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_deptproconfirm', '部门评价项目确认', null, '部门评价项目确认', '/pmkpi/evaluation/dept/report/reportservice.js', 'Ext.lt.pmkpi.deptevaluation.report', 'pmkpi', 'pmkpi.evaluation.dept.report.DeptReportService');

--部门评价成果申报

delete from bus_t_pageconsolecomconfig where url = '/pmkpi/evaluation/dept/result';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/dept/result', 'pmkpi_deptevaluationresult', '{}', 'deptevaluationresult', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/dept/result', 'busdclefttree', '{}', 'lefttree', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/dept/result', 'busqueryform', '{key:''/pmkpi/evaluation/dept/program'',name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/dept/result', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/dept/result', 'header', '{}', 'header', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/dept/result', 'busuidatatable', '{key:''/pmkpi/evaluation/dept/program'',name:''部门评价对象'',checkbox:true,title:''部门评价对象'',edit:true,addrow:false}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/dept/result', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

delete from bus_t_pagecomponent where id = 'pmkpi_deptevaluationresult';
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_deptevaluationresult', '部门评价成果', null, '部门评价成果', '/pmkpi/evaluation/dept/result/resultservice.js', 'Ext.lt.pmkpi.deptevaluation.resultservice', 'pmkpi', 'pmkpi.evaluation.dept.DeptResultService');


--部门评价成果审核
delete from bus_t_pageconsolecomconfig where url = '/pmkpi/evaluation/dept/resultaudit';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/dept/resultaudit', 'pmkpi_deptevaluationresult', '{}', 'deptevaluationresult', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/dept/resultaudit', 'busqueryform', '{key:''/pmkpi/evaluation/dept/program'',name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/dept/resultaudit', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/dept/resultaudit', 'header', '{}', 'header', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/dept/resultaudit', 'busuidatatable', '{key:''/pmkpi/evaluation/dept/program'',name:''部门重点评价对象'',checkbox:true,title:''部门重点评价对象'',edit:true,addrow:false}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/dept/resultaudit', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/dept/resultaudit', 'busdclefttree', '{}', 'lefttree', 'pmkpi', null);

--部门评价成果查看

delete from bus_t_pageconsolecomconfig where url = '/pmkpi/evaluation/dept/resultquery';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/dept/resultquery', 'pmkpi_deptevaluationresult', '{}', 'deptevaluationresult', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/dept/resultquery', 'busqueryform', '{key:''/pmkpi/evaluation/dept/program'',name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/dept/resultquery', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/dept/resultquery', 'header', '{}', 'header', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/dept/resultquery', 'busuidatatable', '{key:''/pmkpi/evaluation/dept/program'',name:''部门重点评价对象'',checkbox:true,title:''部门重点评价对象'',edit:true,addrow:false}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/dept/resultquery', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/dept/resultquery', 'busdclefttree', '{}', 'lefttree', 'pmkpi', null);

--选择项目
delete from bus_t_pageconsolecomconfig where url = '/pmkpi/evaluation/dept/procheck';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/dept/procheck', 'pmkpi_deptprocheck', '{}', 'deptprocheck', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/dept/procheck', 'busuidatatable', '{key:''/pmkpi/program/report/list'',name:''项目'',checkbox:true,title:''项目'',edit:false,addrow:false}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/dept/procheck', 'bustoolbutton', '{key:''/pmkpi/evaluation/dept/check''}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/dept/procheck', 'busqueryform', '{key:''/pmkpi/program/report/list'',name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

delete from bus_t_pagecomponent where id = 'pmkpi_deptprocheck';
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_deptprocheck', '部门评价选择项目', null, '部门评价选择项目', '/pmkpi/evaluation/dept/report/reportchck.js', 'Ext.lt.pmkpi.deptevaluation.checkservice', 'pmkpi', 'pmkpi.evaluation.dept.report.DeptReportCheckService');

--部门整体选择项目
delete from bus_t_pageconsolecomconfig where url = '/pmkpi/evaluation/dept/deptcheck';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/dept/deptcheck', 'pmkpi_deptprocheck', '{}', 'deptprocheck', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/dept/deptcheck', 'busuidatatable', '{name:''部门'',checkbox:true,title:''部门'',edit:false,addrow:false}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/dept/deptcheck', 'bustoolbutton', '{key:''/pmkpi/evaluation/dept/check''}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/dept/deptcheck', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

--审核流程页面
delete from bus_t_pageconsolecomconfig where url = '/pmkpi/evaluation/dept/auditedit';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/dept/auditedit', 'pmkpi_deptauditedit', '{}', 'deptauditedit', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/dept/auditedit', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/dept/auditedit', 'buseditform', '{name:''编辑区'',edit:true,columnsize:2}', 'editform', 'pmkpi', null);

delete from bus_t_pagecomponent where id = 'pmkpi_deptauditedit';
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_deptauditedit', '部门评价审核编辑', null, '部门评价审核编辑', '/pmkpi/evaluation/dept/audit/auditopinion.js', 'Ext.lt.pmkpi.deptevaluation.auditservice', 'pmkpi', 'pmkpi.evaluation.dept.audit.DeptAuditEditService');

--项目明细
delete from bus_t_pageconsolecomconfig where url = '/pmkpi/evaluation/deptreport/proedit';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/deptreport/proedit', 'pmkpi_tabfreamedit', '{}', 'tabfreamedit', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/deptreport/proedit', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/deptreport/proedit', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/deptreport/proedit', 'buseditform', '{key:''/pmkpi/evaluation/deptreport/edit'',columnsize:2,iswf:''true'',tablecode:''v_perf_t_deptevaluation''}', 'infoeditform', 'pmkpi', null);

--项目明细（部门）
delete from bus_t_pageconsolecomconfig where url = '/pmkpi/evaluation/deptreport/deptedit';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/deptreport/deptedit', 'pmkpi_tabfreamedit', '{}', 'tabfreamedit', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/deptreport/deptedit', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/deptreport/deptedit', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/deptreport/deptedit', 'buseditform', '{key:''/pmkpi/evaluation/deptreport/deptedit'',iswf:''true'',tablecode:''v_perf_t_deptevaluation''}', 'infoeditform', 'pmkpi', null);

--成果上传（项目）
delete from bus_t_pageconsolecomconfig where url = '/pmkpi/evaluation/dept/result/edit';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/dept/result/edit', 'pmkpi_tabfreamedit', '{}', 'tabfreamedit', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/dept/result/edit', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/dept/result/edit', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/dept/result/edit', 'buseditform', '{key:''/pmkpi/evaluation/dept/result/edit'',iswf:''true'',tablecode:''v_perf_t_deptevaluation'',title:''评估结果''}', 'editform', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/dept/result/edit', 'buseditform', '{key:''/pmkpi/evaluation/deptreport/edit'',columnsize:2,iswf:''true'',tablecode:''v_perf_t_deptevaluation''}', 'infoeditform', 'pmkpi', null);


--成果上传（部门）
delete from bus_t_pageconsolecomconfig where url = '/pmkpi/evaluation/dept/result/deptedit';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/dept/result/deptedit', 'pmkpi_tabfreamedit', '{}', 'tabfreamedit', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/dept/result/deptedit', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/dept/result/deptedit', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/dept/result/deptedit', 'buseditform', '{key:''/pmkpi/evaluation/dept/result/edit'',iswf:''true'',tablecode:''v_perf_t_deptevaluation'',title:''评估结果''}', 'editform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/dept/result/deptedit', 'buseditform', '{key:''/pmkpi/evaluation/deptreport/deptedit'',columnsize:2,iswf:''true'',tablecode:''v_perf_t_deptevaluation''}', 'infoeditform', 'pmkpi', null);

--
delete from bus_t_pageconsolecomconfig where url = '/pmkpi/evaluation/deptreport/deptedit';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/deptreport/deptedit', 'pmkpi_tabfreamedit', '{}', 'tabfreamedit', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/deptreport/deptedit', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/deptreport/deptedit', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/deptreport/deptedit', 'buseditform', '{key:''/pmkpi/evaluation/deptreport/deptedit'',iswf:''true'',tablecode:''v_perf_t_deptevaluation''}', 'infoeditform', 'pmkpi', null);


