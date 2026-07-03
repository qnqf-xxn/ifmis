
begin
  
--目标评审
DELETE FROM Bus_t_Pageconsole t where t.url='/pmkpi/review/report/list';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/review/report/list', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfreview.report.PerfReviewPage', 'index', '{header:[header],left:lefttree,main:[toolbutton,queryform,datatable]}', null, null, 0);


DELETE FROM Bus_t_Pageconsolecomconfig t where t.url='/pmkpi/review/report/list';
insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/review/report/list', 'pmkpi_reviewreport', '{}', 'pmkpireviewreport', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/review/report/list', 'busdclefttree', '{}', 'lefttree', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/review/report/list', 'busqueryform', '{key:''/pmkpi/review/report/program'',name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/review/report/list', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/review/report/list', 'header', '{}', 'header', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/review/report/list', 'busuidatatable', '{key:''/pmkpi/review/report/program'',name:''绩效目标评审表'',checkbox:true,title:''项目绩效申报'',edit:false,addrow:false,pagetype:''report'',uikey:''/pmkpi/assess/goal/edit''}', 'datatable', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/review/report/list', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);


DELETE FROM Bus_t_Pagecomponent t where t.id='pmkpi_reviewreport';
insert into Bus_t_Pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_reviewreport', '绩效目标评审', null, '绩效目标评审', '/pmkpi/perfreview/report/perfreview.js', 'Ext.lt.pmkpi.perfreview.reportservice', 'pmkpi', 'pmkpi.perfreview.PerfReviewService');


----项目绩效目标评审编辑
DELETE FROM Bus_t_Pageconsole t where t.url='/pmkpi/review/report/proedit';
insert into Bus_t_Pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/review/report/proedit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.tabfream.TabfreamPage', 'editindex', '{main:[tabpage,editform,mxdatatable,goaleditform]}', null, null, 0);

DELETE FROM Bus_t_Pageconsolecomconfig t where t.url='/pmkpi/review/report/proedit';
insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/review/report/proedit', 'pmkpi_tabfreamedit', '{}', 'tabfreamedit', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/review/report/proedit', 'buseditform', '{key:''/pmkpi/program/report/edit'',title:''基础信息'',tablecode:''v_perf_project_info'',iswf:''true''}', 'editform', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/review/report/proedit', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/review/report/proedit', 'busuidatatable', '{key:''/pmkpi/program/report/mxdatatable'',headsort:false,addrow:false,edit:false,checkbox:false}', 'mxdatatable', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/review/report/proedit', 'buseditform', '{key:''/pmkpi/program/report/proindex'',tablecode:''v_pm_perf_goal_info''}', 'goaleditform', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/review/report/proedit', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);


--部门绩效目标评审编辑
DELETE FROM Bus_t_Pageconsole t where t.url='/pmkpi/review/report/deptedit';
insert into Bus_t_Pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/review/report/deptedit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.tabfream.TabfreamPage', 'editindex', '{main:[tabpage,editform,mxdatatable,goaleditform]}', null, null, 0);


DELETE FROM Bus_t_Pageconsolecomconfig t where t.url='/pmkpi/review/report/deptedit';
insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/review/report/deptedit', 'pmkpi_tabfreamedit', '{}', 'tabfreamedit', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/review/report/deptedit', 'buseditform', '{key:''/pmkpi/deptperformance/report/deptgoal'',tablecode:''v_bgt_perf_goal_info''}', 'goaleditform', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/review/report/deptedit', 'buseditform', '{key:''/pmkpi/deptperformance/report/edit'',title:''基础信息'',tablecode:''v_perf_t_deptperfdeclare'',iswf:''true'',edit:false}', 'editform', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/review/report/deptedit', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/review/report/deptedit', 'busuidatatable', '{key:''/pmkpi/deptperformance/report/perftask'',headsort:false,addrow:false,edit:false,checkbox:false}', 'mxdatatable', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/review/report/deptedit', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

---评审页面
DELETE FROM Bus_t_Pageconsole t where t.url='/pmkpi/review/report/proindex';
insert into Bus_t_Pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/review/report/proindex', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfreview.proindex.ReviewProindexPage', 'index', '{main:[tabpage,indexdatatable,reviewdatatable,editform],heights:[50,500,350,400],footer:[toolbutton]}', null, null, 0);


DELETE FROM Bus_t_Pageconsolecomconfig t where t.url='/pmkpi/review/report/proindex';
insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/review/report/proindex', 'pmkpi_reviewproindex', '{}', 'pmkpireviewproindex', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/review/report/proindex', 'buseditform', '{key:''/pmkpi/review/report/proindex''}', 'editform', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/review/report/proindex', 'busuidatatable', '{headsort:false,addrow:false,nogroupbox:true,edit:true,checkbox:true,groupcols:[''guid'',''superid'',''name'',''levelno''],treedata:true,treemapping:null,initlevel:6,isuphide:false,editgroupdata:true,nextSibling:false,key:''/pmkpi/program/report/treeindex''}', 'indexdatatable', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/review/report/proindex', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/review/report/proindex', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/review/report/proindex', 'busuidatatable', '{key:''/pmkpi/review/proreview'',edit:true}', 'reviewdatatable', 'pmkpi', null);


DELETE FROM Bus_t_Pagecomponent t where t.id='pmkpi_reviewproindex';
insert into Bus_t_Pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_reviewproindex', '评审页面', null, '评审页面', '/pmkpi/perfreview/index/proindex.js', 'Ext.lt.pmkpi.perfreview.proindexservice', 'pmkpi', 'pmkpi.perfreview.ReviewProindexService');

--委托专家
DELETE FROM Bus_t_Pageconsole t where t.url='/pmkpi/review/entrust/expert';
insert into Bus_t_Pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/review/entrust/expert', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfreview.report.PerfReviewPage', 'entrust', '{main:[toolbutton,queryform,datatable,seldatatable]}', null, null, null);

DELETE FROM Bus_t_Pageconsolecomconfig t where t.url='/pmkpi/review/entrust/expert';
insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/review/entrust/expert', 'pmkpi_entrustexpert', '{}', 'pmkpientrustexpert', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/review/entrust/expert', 'busuidatatable', '{key:''/pmkpi/review/entrust/expert'',name:''专家库'',checkbox:true,title:''专家库'',edit:false,addrow:false}', 'datatable', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/review/entrust/expert', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/review/entrust/expert', 'header', '{}', 'header', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/review/entrust/expert', 'busuidatatable', '{key:''/pmkpi/review/entrust/selexpert'',name:''已选专家'',checkbox:true,title:''已选专家'',edit:false,addrow:false}', 'seldatatable', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/review/entrust/expert', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

DELETE FROM Bus_t_Pagecomponent t where t.id='pmkpi_entrustexpert';
insert into Bus_t_Pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_entrustexpert', '委托专家', null, '委托专家', '/pmkpi/perfreview/report/entrustexpert.js', 'Ext.lt.pmkpi.perfreview.entrustexpert', 'pmkpi', 'pmkpi.perfreview.EntrustExpertService');


--专家评审页面
DELETE FROM Bus_t_Pageconsole t where t.url='/pmkpi/review/expert/list';
insert into Bus_t_Pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/review/expert/list', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfreview.report.PerfReviewPage', 'entrustindex', '{left:lefttree,main:[toolbutton,queryform,datatable]}', null, null, 0);


DELETE FROM Bus_t_Pageconsolecomconfig t where t.url='/pmkpi/review/expert/list';
insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/review/expert/list', 'pmkpi_reviewreport', '{}', 'pmkpireviewreport', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/review/expert/list', 'busdclefttree', '{}', 'lefttree', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/review/expert/list', 'busqueryform', '{key:''/pmkpi/review/report/program'',name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/review/expert/list', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/review/expert/list', 'header', '{}', 'header', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/review/expert/list', 'busuidatatable', '{key:''/pmkpi/review/report/program'',name:''绩效目标评审表'',checkbox:true,title:''项目绩效申报'',edit:false,addrow:false,pagetype:''report'',uikey:''/pmkpi/assess/goal/edit''}', 'datatable', 'pmkpi', null);

DELETE FROM Bus_t_Pagecomponent t where t.id='pmkpi_reviewreport';
insert into Bus_t_Pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_reviewreport', '绩效目标评审', null, '绩效目标评审', '/pmkpi/perfreview/report/perfreview.js', 'Ext.lt.pmkpi.perfreview.reportservice', 'pmkpi', 'pmkpi.perfreview.PerfReviewService');


--评审查询
DELETE FROM Bus_t_Pageconsole t where t.url='/pmkpi/review/query/list';
insert into Bus_t_Pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/review/query/list', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfreview.query.ReviewQueryPage', 'index', '{left:lefttree,main:[toolbutton,queryform,datatable]}', null, null, null);

DELETE FROM Bus_t_Pageconsolecomconfig t where t.url='/pmkpi/review/query/list';
insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/review/query/list', 'pmkpi_reviewquery', '{}', 'pmkpireviewquery', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/review/query/list', 'busdclefttree', '{}', 'lefttree', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/review/query/list', 'busqueryform', '{key:''/pmkpi/review/query/program'',name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/review/query/list', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/review/query/list', 'header', '{}', 'header', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/review/query/list', 'busuidatatable', '{key:''/pmkpi/review/query/program'',name:''绩效目标评审表'',checkbox:true,title:''项目绩效申报'',edit:false,addrow:false,pagetype:''report'',uikey:''/pmkpi/assess/goal/edit''}', 'datatable', 'pmkpi', null);

DELETE FROM Bus_t_Pagecomponent t where t.id='pmkpi_reviewquery';
insert into Bus_t_Pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_reviewquery', '绩效目标评审查询', null, '绩效目标评审查询', '/pmkpi/perfreview/query/reviewquery.js', 'Ext.lt.pmkpi.perfreview.queryservice', 'pmkpi', 'pmkpi.perfreview.ReviewQueryService');
