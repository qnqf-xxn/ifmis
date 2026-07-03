begin
  
--首页
DELETE FROM Bus_t_Pageconsole t where t.url='/pmkpi/program/mod/report';
insert into Bus_t_Pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/program/mod/report', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfpromod.report.ProModRpPage', 'index', '{header:[header],left:lefttree,main:[toolbutton,queryform,tabpage,datatable]}', null, null, 0);


DELETE FROM Bus_t_Pageconsolecomconfig t where t.url='/pmkpi/program/mod/report';
insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/mod/report', 'perf_promodreport', '{}', 'perfpromodreport', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/mod/report', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/mod/report', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/mod/report', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/mod/report', 'header', '{}', 'header', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/mod/report', 'buslefttree', '{}', 'lefttree', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/mod/report', 'busuidatatable', '{name:''绩效目标修订表'',checkbox:true,title:''绩效目标修订表'',edit:false,addrow:false,totalwheresql:'' modtype=\''total\'''',yearwheresql: '' modtype=\''year\''''}', 'datatable', 'pmkpi', null);


DELETE FROM Bus_t_Pagecomponent t where t.id='perf_promodreport';
insert into Bus_t_Pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('perf_promodreport', '绩效目标修改填报', null, '绩效目标修改填报', '/pmkpi/perfpromod/report/promodrp.js', 'Ext.lt.pmkpi.promod.rpservice', 'pmkpi', 'pmkpi.perfpromod.ProModRpService');

--选择项目
DELETE FROM Bus_t_Pageconsole t where t.url='/pmkpi/program/mod/report/procheck';
insert into Bus_t_Pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/program/mod/report/procheck', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfpromod.report.ProModRpPage', 'programcheck', '{main:[queryform,datatable],footer:[toolbutton]}', null, null, 0);

DELETE FROM Bus_t_Pageconsolecomconfig t where t.url='/pmkpi/program/mod/report/procheck';
insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/mod/report/procheck', 'pmkpi_modreportcheck', '{}', 'pmkpimodreportcheck', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/mod/report/procheck', 'busqueryform', '{key:''/pmkpi/program/report/list'',name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/mod/report/procheck', 'busuidatatable', '{key:''/pmkpi/program/report/list'',name:''绩效目标修订表'',checkbox:true,title:''绩效目标修订表'',edit:false,addrow:false,totalwheresql:''  t.wfstatus=\''011\'' and not exists(select 1 from v_PERF_T_PROVISIONDECLARE a where t.guid = a.PROGUID and a.modtype=\''total\'' and a.wfstatus != \''011\'')'',yearwheresql: ''  t.wfstatus=\''011\'' and not exists(select 1 from v_PERF_T_PROVISIONDECLARE a where t.guid = a.PROGUID and a.modtype=\''year\'' and a.wfstatus != \''011\'')''}', 'datatable', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/mod/report/procheck', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

DELETE FROM Bus_t_Pagecomponent t where t.id='pmkpi_modreportcheck';
insert into Bus_t_Pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_modreportcheck', '绩效总体目标修订选择项目', null, '绩效目标修订选择项目', '/pmkpi/perfpromod/report/promodrpcheck.js', 'Ext.lt.pmkpi.promod.promodrpcheck', 'pmkpi', 'pmkpi.perfpromod.ProModRpCheck');

--总体指标
DELETE FROM Bus_t_Pageconsole t where t.url='/pmkpi/program/mod/totaledit';
insert into Bus_t_Pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/program/mod/totaledit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.tabfream.TabfreamPage', 'editindex', '{main:[tabpage],footer:[toolbutton]}', null, null, 0);

DELETE FROM Bus_t_Pageconsolecomconfig t where t.url='/pmkpi/program/mod/totaledit';
insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/mod/totaledit', 'pmkpi_tabfreamedit', '{}', 'tabfreamedit', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/mod/totaledit', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/mod/totaledit', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);


--年度指标
DELETE FROM Bus_t_Pageconsole t where t.url='/pmkpi/program/mod/yearedit';
insert into Bus_t_Pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/program/mod/yearedit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.tabfream.TabfreamPage', 'editindex', '{main:[tabpage],footer:[toolbutton]}', null, null, 0);

DELETE FROM Bus_t_Pageconsolecomconfig t where t.url='/pmkpi/program/mod/yearedit';
insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/mod/yearedit', 'pmkpi_tabfreamedit', '{}', 'tabfreamedit', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/mod/yearedit', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/mod/yearedit', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

--基本信息
DELETE FROM Bus_t_Pageconsole t where t.url='/pmkpi/program/mod/edit/info';
insert into Bus_t_Pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/program/mod/edit/info', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfpromod.info.ProModInfoPage', 'editInfo', '{main:[editform]}', null, null, 0);

DELETE FROM Bus_t_Pageconsolecomconfig t where t.url='/pmkpi/program/mod/edit/info';
insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/mod/edit/info', 'pmkpi_modeditinfo', '{}', 'pmkpimodeditinfo', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/mod/edit/info', 'buseditform', '{key:''/pmkpi/program/report/edit''}', 'editform', 'pmkpi', null);

DELETE FROM Bus_t_Pagecomponent t where t.id='pmkpi_modeditinfo';
insert into Bus_t_Pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_modeditinfo', '绩效目标修订基本信息', null, '绩效目标修订基本信息', '/pmkpi/perfpromod/editinfo/promodinfo.js', 'Ext.lt.pmkpi.promod.modeditinfo', 'pmkpi', 'pmkpi.promod.editinfo.ProModInfoService');

--指标目标合并页面
DELETE FROM Bus_t_Pageconsole t where t.url='/pmkpi/program/mod/mergeindex';
insert into Bus_t_Pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/program/mod/mergeindex', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfpromod.prjindex.ProModIndexPage', 'index', '{main:[editform,toolbutton,datatable]}', null, null, null);

DELETE FROM Bus_t_Pageconsolecomconfig t where t.url='/pmkpi/program/mod/mergeindex';
insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/mod/mergeindex', 'pmkpi_promodmergeindex', '{}', 'promodmergeindex', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/mod/mergeindex', 'buseditform', '{}', 'editform', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/mod/mergeindex', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/mod/mergeindex', 'busuidatatable', '{headsort:false,addrow:false,nogroupbox:true,edit:true,checkbox:true,groupcols:[''guid'',''superid'',''name'',''levelno''],treedata:true,treemapping:null,initlevel:6,isuphide:false,editgroupdata:true,nextSibling:false,key:''/pmkpi/program/report/treeindex'',rowtolist:false}', 'datatable', 'pmkpi', null);

DELETE FROM Bus_t_Pagecomponent t where t.id='pmkpi_promodmergeindex';
insert into Bus_t_Pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_promodmergeindex', '绩效目标指标合并修订', null, '绩效目标指标合并', '/pmkpi/perfpromod/index/promodindex.js', 'Ext.lt.pmkpi.promodmergeindex', 'pmkpi', 'pmkpi.prjindex.ProModIndexService');


--审核页面
DELETE FROM Bus_t_Pageconsole t where t.url='/pmkpi/program/mod/audit';
insert into Bus_t_Pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/program/mod/audit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfpromod.audit.ProModAuditPage', 'index', '{header:[header],left:lefttree,main:[toolbutton,queryform,tabpage,datatable]}', null, null, 0);

DELETE FROM Bus_t_Pageconsolecomconfig t where t.url='/pmkpi/program/mod/audit';
insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/mod/audit', 'pmkpi_promodaudit', '{}', 'pmkpipromodaudit', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/mod/audit', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/mod/audit', 'buslefttree', '{}', 'lefttree', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/mod/audit', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/mod/audit', 'header', '{}', 'header', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/mod/audit', 'busuidatatable', '{name:''绩效目标调整表'',checkbox:true,title:''绩效目标调整表'',edit:false,addrow:false,totalwheresql:''  modtype=\''total\'''',yearwheresql:'' modtype=\''year\''''}', 'datatable', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/mod/audit', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

DELETE FROM Bus_t_Pagecomponent t where t.id='pmkpi_promodaudit';
insert into Bus_t_Pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_promodaudit', '绩效目标修订审核', null, '绩效目标修订审核', '/pmkpi/perfpromod/audit/promodaudit.js', 'Ext.lt.pmkpi.promod.promodaudit', 'pmkpi', 'pmkpi.perfpromod.ProModAuditService');



DELETE FROM Bus_t_Pageconsole t where t.url='/pmkpi/program/apply/mod';
insert into Bus_t_Pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/program/apply/mod', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfpromod.report.ProModRpPage', 'index', '{header:[header],left:lefttree,main:[toolbutton,queryform,tabpage,datatable]}', null, null, 0);


DELETE FROM Bus_t_Pageconsolecomconfig t where t.url='/pmkpi/program/apply/mod';
insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/apply/mod', 'perf_promodreport', '{}', 'perfpromodreport', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/apply/mod', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/apply/mod', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/apply/mod', 'header', '{}', 'header', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/apply/mod', 'busqueryform', '{key:''/pmkpi/program/mod/report'',name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/apply/mod', 'buslefttree', '{}', 'lefttree', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/apply/mod', 'busuidatatable', '{key:''/pmkpi/program/mod/report'',name:''绩效目标修订表'',checkbox:true,title:''绩效目标修订表'',edit:false,addrow:false,totalwheresql:" modtype=''total''",yearwheresql:" modtype=''year''"}', 'datatable', 'pmkpi', null);
