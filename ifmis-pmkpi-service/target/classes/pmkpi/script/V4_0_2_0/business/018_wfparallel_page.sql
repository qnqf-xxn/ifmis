begin

DELETE FROM Bus_t_Pageconsole t WHERE t.url='/pmkpi/workflow/parallel/audit';
insert into Bus_t_Pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/workflow/parallel/audit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.wfparallel.WfParallelAuditPage', 'index', '{header:[header],left:lefttree,main:[toolbutton,queryform,tabpage,datatable]}', null, null, 0);


DELETE FROM Bus_t_Pageconsolecomconfig t WHERE t.url='/pmkpi/workflow/parallel/audit';
insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/workflow/parallel/audit', 'pmkpi_wfparallelaudit', '{}', 'wfparallelaudit', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/workflow/parallel/audit', 'busuidatatable', '{key:''/pmkpi/trace/report/dept'',name:''绩效目标调整表'',checkbox:true,title:''绩效目标调整表'',edit:false,addrow:false}', 'datatable', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/workflow/parallel/audit', 'busqueryform', '{key:''/pmkpi/trace/report/dept'',name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/workflow/parallel/audit', 'busdclefttree', '{}', 'lefttree', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/workflow/parallel/audit', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/workflow/parallel/audit', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/workflow/parallel/audit', 'header', '{}', 'header', 'pmkpi', null);


DELETE FROM Bus_t_Pagecomponent t WHERE t.id='pmkpi_wfparallelaudit';
insert into Bus_t_Pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_wfparallelaudit', '绩效工作流并行', null, '绩效工作流并行', '/pmkpi/wfparallel/wfparallelservice.js', 'Ext.lt.pmkpi.wfparallel.wfparallelservice', 'pmkpi', 'pmkpi.wfparallel.audit.WfParallelAuditService');


