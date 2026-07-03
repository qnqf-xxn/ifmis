begin

--/pmkpi/deptTJformance/report/index 
delete FROM Bus_t_Pageconsolecomconfig t where t.url = '/pmkpi/deptTJformance/report/index';
delete FROM Bus_t_Pageconsole t where t.url = '/pmkpi/deptTJformance/report/index';
delete FROM Bus_t_Pagecomponent t where t.id = 'pmkpi_deptTJlist';

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptTJformance/report/index', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptTJformance/report/index', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptTJformance/report/index', 'header', '{}', 'header', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptTJformance/report/index', 'busuidatatable', '{name:''部门绩效申报'',checkbox:true,title:''部门绩效申报'',uikey:''/pmkpi/deptTJformance/report/edit'',edit:false,addrow:false,pagetype:''report'',repeatflag:''false''}', 'datatable', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptTJformance/report/index', 'pmkpi_deptTJlist', '{}', 'deptTJlist', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptTJformance/report/index', 'buslefttree', '{}', 'lefttree', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptTJformance/report/index', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

insert into Bus_t_Pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/deptTJformance/report/index', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.deptTJformance.report.DeptTJPerfPage', 'index', '{header:[header],left:lefttree,main:[toolbutton,queryform,tabpage,datatable]}', null, null, 0);

insert into Bus_t_Pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_deptTJlist', '部门绩效申报列表', null, '部门绩效申报列表', '/pmkpi/deptTJformance/deptTJreport.js', 'Ext.lt.pmkpi.deptTJlist', 'pmkpi', 'pmkpi.deptTJformance.DeptTJPerfService');

--/pmkpi/deptTJformance/audit/index 
delete FROM Bus_t_Pageconsolecomconfig t where t.url = '/pmkpi/deptTJformance/audit/index';
delete FROM Bus_t_Pageconsole t where t.url = '/pmkpi/deptTJformance/audit/index';
delete FROM Bus_t_Pagecomponent t where t.id = 'pmkpi_deptTJauditlist';

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptTJformance/audit/index', 'busqueryform', '{key:''/pmkpi/deptTJformance/report/index'',name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptTJformance/audit/index', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptTJformance/audit/index', 'header', '{}', 'header', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptTJformance/audit/index', 'busuidatatable', '{key:''/pmkpi/deptTJformance/report/index'',name:''部门绩效申报'',checkbox:true,title:''部门绩效申报'',edit:false,addrow:false,pagetype:''report'',uikey:''/pmkpi/deptTJformance/report/edit'',repeatflag:''false''}', 'datatable', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptTJformance/audit/index', 'pmkpi_deptTJauditlist', '{}', 'deptTJauditlist', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptTJformance/audit/index', 'buslefttree', '{}', 'lefttree', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptTJformance/audit/index', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

insert into Bus_t_Pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/deptTJformance/audit/index', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.deptTJformance.report.DeptTJPerfPage', 'auditindex', '{header:[header],left:lefttree,main:[toolbutton,queryform,tabpage,datatable]}', null, null, 0);

insert into Bus_t_Pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_deptTJauditlist', '部门绩效申报列表', null, '部门绩效申报列表', '/pmkpi/deptTJformance/deptTJaudit.js', 'Ext.lt.pmkpi.deptTJauditlist', 'pmkpi', 'pmkpi.deptTJformance.DeptTJPerfAuditService');

--/pmkpi/deptTJformance/audit/tofinintorg'
delete FROM Bus_t_Pageconsolecomconfig t where t.url = '/pmkpi/deptTJformance/audit/tofinintorg';
delete FROM Bus_t_Pageconsole t where t.url = '/pmkpi/deptTJformance/audit/tofinintorg';
delete FROM Bus_t_Pagecomponent t where t.id = 'pmkpi_deptTJtofinintorg';

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptTJformance/audit/tofinintorg', 'pmkpi_deptTJtofinintorg', '{}', 'deptTJtofinintorg', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptTJformance/audit/tofinintorg', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptTJformance/audit/tofinintorg', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptTJformance/audit/tofinintorg', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptTJformance/audit/tofinintorg', 'busuidatatable', '{name:''处室列表'',radio:false,checkbox:true,title:''处室列表'',edit:false,addrow:false}', 'datatable', 'pmkpi', null);

insert into Bus_t_Pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/deptTJformance/audit/tofinintorg', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.deptTJformance.report.DeptTJPerfPage', 'indexfinintorg', '{main:[toolbutton,queryform,tabpage,datatable]}', null, null, 0);

insert into Bus_t_Pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_deptTJtofinintorg', '分发处室列表', null, '分发处室列表', '/pmkpi/deptTJformance/deptTJtofinintorg.js', 'Ext.lt.pmkpi.deptTJtofinintorg', 'pmkpi', 'pmkpi.deptTJformance.DeptTJPerftofinintorgService');


--/pmkpi/deptTJformance/finreview/index
delete FROM Bus_t_Pageconsolecomconfig t where t.url = '/pmkpi/deptTJformance/finreview/index';
delete FROM Bus_t_Pageconsole t where t.url = '/pmkpi/deptTJformance/finreview/index';
delete FROM Bus_t_Pagecomponent t where t.id = 'pmkpi_deptTJfinreview';

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptTJformance/finreview/index', 'pmkpi_deptTJfinreview', '{}', 'deptTJfinreview', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptTJformance/finreview/index', 'header', '{}', 'header', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptTJformance/finreview/index', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptTJformance/finreview/index', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptTJformance/finreview/index', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptTJformance/finreview/index', 'busuidatatable', '{uikey:''/pmkpi/deptTJformance/report/edit'',name:''资金处室审阅列表'',checkbox:true,title:''资金处室审阅列表'',edit:false,addrow:false,pagetype:''audit''}', 'datatable', 'pmkpi', null);

insert into Bus_t_Pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/deptTJformance/finreview/index', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.deptTJformance.report.DeptTJPerfPage', 'indexfinreview', '{header:[header],main:[toolbutton,queryform,tabpage,datatable]}', null, null, 0);

insert into Bus_t_Pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_deptTJfinreview', '资金处室审阅', null, '资金处室审阅', '/pmkpi/deptTJformance/deptTJfinreview.js', 'Ext.lt.pmkpi.deptTJfinreview', 'pmkpi', 'pmkpi.deptTJformance.DeptTJPerffinreviewService');


--/pmkpi/deptTJformance/query/index 
delete FROM Bus_t_Pageconsolecomconfig t where t.url = '/pmkpi/deptTJformance/query/index';
delete FROM Bus_t_Pageconsole t where t.url = '/pmkpi/deptTJformance/query/index';
delete FROM Bus_t_Pagecomponent t where t.id = 'pmkpi_deptTJquerylist';

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptTJformance/query/index', 'pmkpi_deptTJquerylist', '{}', 'deptTJquerylist', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptTJformance/query/index', 'busqueryform', '{key:''/pmkpi/deptTJformance/report/index'',name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptTJformance/query/index', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptTJformance/query/index', 'header', '{}', 'header', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptTJformance/query/index', 'busuidatatable', '{key:''/pmkpi/deptTJformance/report/index'',name:''部门绩效查询'',checkbox:true,title:''部门绩效查询'',edit:false,addrow:false,pagetype:''query'',uikey:''/pmkpi/deptTJformance/report/edit'',repeatflag:''false''}', 'datatable', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptTJformance/query/index', 'buslefttree', '{}', 'lefttree', 'pmkpi', null);

insert into Bus_t_Pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/deptTJformance/query/index', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.deptTJformance.report.DeptTJPerfPage', 'queryindex', '{header:[header],left:lefttree,main:[toolbutton,queryform,datatable]}', null, null, 0);

insert into Bus_t_Pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_deptTJquerylist', '部门绩效查询列表', null, '部门绩效查询列表', '/pmkpi/deptTJformance/deptTJquery.js', 'Ext.lt.pmkpi.deptTJquerylist', 'pmkpi', 'pmkpi.deptTJformance.DeptTJPerfQueryService');
