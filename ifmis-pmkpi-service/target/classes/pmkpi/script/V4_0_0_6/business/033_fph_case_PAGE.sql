begin
  
--案例库
DELETE FROM Bus_t_Pageconsole t where t.url='/pmkpi/setting/case/list';
insert into Bus_t_Pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/setting/case/list', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.setting.modelcase.ModelCasePage', 'list', '{header:[header],left:lefttree,main:[toolbutton,queryform,datatable]}', null, null, 0);


DELETE FROM Bus_t_Pageconsolecomconfig t where t.url='/pmkpi/setting/case/list';
insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/case/list', 'pmkpi_model', '{}', 'model', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/case/list', 'busuidatatable', '{name:''案例库'',checkbox:true,title:''案例库'',edit:false,addrow:true,uikey:''/pmkpi/setting/caseinfo/edit'',deltables:[v_perf_t_casemodelgoal,v_perf_t_casemodelindex]}', 'datatable', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/case/list', 'header', '{}', 'header', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/case/list', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/case/list', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/case/list', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/case/list', 'buslefttree', '{}', 'lefttree', 'pmkpi', null);


DELETE FROM Bus_t_Pagecomponent t where t.id='pmkpi_model';
insert into Bus_t_Pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_model', '指标模板', null, '指标模板', '/pmkpi/setting/modelcase/modelcaseservice.js', 'Ext.lt.pmkpi.modelcase', 'pmkpi', 'pmkpi.setting.modelcase.ModelCaseService');



--案例库编辑
DELETE FROM Bus_t_Pageconsole t where t.url='/pmkpi/setting/caseinfo/edit';
insert into Bus_t_Pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/setting/caseinfo/edit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfprogram.report.TlpProgramPage', 'editindex', '{main:[tabpage,editform,goaleditform,indexdatatable],footer:[toolbutton]}', null, null, 0);


DELETE FROM Bus_t_Pageconsolecomconfig t where t.url='/pmkpi/setting/caseinfo/edit';
insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/caseinfo/edit', 'pmkpi_modelindex', '{}', 'modelindex', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/caseinfo/edit', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/caseinfo/edit', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/caseinfo/edit', 'buseditform', '{key:''/pmkpi/setting/caseinfo/goal'',tablecode:''V_PERF_T_CASEMODELGOAL'',iswf:''false''}', 'goaleditform', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/caseinfo/edit', 'buseditform', '{title:''基础信息'',tablecode:''V_PERF_T_CASE'',iswf:''true''}', 'editform', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/caseinfo/edit', 'busuidatatable', '{key:''/pmkpi/setting/caseinfo/index'',headsort:false,addrow:true,name:''绩效指标'',edit:true,checkbox:true,title:''绩效指标''}', 'indexdatatable', 'pmkpi', null);


DELETE FROM Bus_t_Pagecomponent t where t.id='pmkpi_modelindex';
insert into Bus_t_Pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_modelindex', '案例/模板指标明细', null, '案例/模板指标明细', '/pmkpi/setting/modelcase/modelcaseindex.js', 'Ext.lt.pmkpi.modelcaseindex', 'pmkpi', 'pmkpi.setting.modelcase.ModelCaseIndexService');



