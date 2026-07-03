begin
delete FROM Bus_t_Pageconsole t where t.url in ('/pmkpi/program/reportdp/list'，'/pmkpi/program/reportdp/audit','/pmkpi/program/report/dpedit');
delete FROM Bus_t_Pageconsolecomconfig t where t.url in ('/pmkpi/program/reportdp/list'，'/pmkpi/program/reportdp/audit','/pmkpi/program/report/dpedit');
delete FROM Bus_t_Pagecomponent t where t.id in ('pmkpi_tlpdpedit','pmkpi_tlproreportdp','pmkpi_tlprogramauditdp');

insert into Bus_t_Pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/program/report/dpedit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.doubleprocess.report.TlpProgramPage', 'editindex', '{main:[tabpage,editform],footer:[toolbutton]}', null, null, 0);

insert into Bus_t_Pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/program/reportdp/audit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.doubleprocess.audit.TlpProgramAuditPage', 'index', '{header:[header],left:lefttree,main:[toolbutton,queryform,tabpage,datatable],height:[null,null,null,null]}', null, null, 0);

insert into Bus_t_Pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/program/reportdp/list', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.doubleprocess.report.TlpProgramPage', 'index', '{header:[header],left:lefttree,main:[toolbutton,queryform,tabpage,datatable]}', null, null, 0);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/report/dpedit', 'pmkpi_tlpdpedit', '{}', 'pmkpitlpdpedit', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/report/dpedit', 'buseditform', '{title:''基础信息'',tablecode:''V_PERF_PROJECT_INFO''}', 'editform', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/report/dpedit', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/report/dpedit', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/reportdp/list', 'pmkpi_tlproreportdp', '{}', 'pmkpitlproreportdp', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/reportdp/list', 'buslefttree', '{}', 'lefttree', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/reportdp/list', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/reportdp/list', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/reportdp/list', 'header', '{}', 'header', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/reportdp/list', 'busuidatatable', '{name:''项目绩效申报'',checkbox:true,title:''项目绩效申报'',edit:false,addrow:false,pagetype:''report'',uikey:''/pmkpi/program/report/edit'',deltables:[v_perf_t_outpayproject,v_pm_perf_indicator],tablecode1:''PERF_PROJECT_INFODP''}', 'datatable', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/reportdp/list', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/reportdp/audit', 'pmkpi_tlprogramauditdp', '{}', 'tlprogramauditdp', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/reportdp/audit', 'busuidatatable', '{name:''项目绩效审核'',checkbox:true,title:''项目绩效审核'',edit:false,addrow:false,pagetype:''audit'',uikey:''/pmkpi/program/report/edit'',tablecode1:''PERF_PROJECT_INFODP''}', 'datatable', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/reportdp/audit', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/reportdp/audit', 'header', '{}', 'header', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/reportdp/audit', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/reportdp/audit', 'buslefttree', '{}', 'lefttree', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/reportdp/audit', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);


insert into Bus_t_Pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_tlpdpedit', '项目信息编辑', null, '项目信息编辑', '/pmkpi/doubleprocess/report/prodpedit.js', 'Ext.lt.pmkpi.perfdp.editservice', 'pmkpi', 'pmkpi.doubleprocess.TlpProgramEdit');

insert into Bus_t_Pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_tlprogramauditdp', '项目绩效审核', null, '项目绩效审核', '/pmkpi/doubleprocess/audit/tlprogramaudit.js', 'Ext.lt.pmkpi.doubleprocess.tlpauditservice', 'pmkpi', 'pmkpi.doubleprocess.TlpProgramAuditService');

insert into Bus_t_Pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_tlproreportdp', '项目绩效申报', null, '项目绩效申报', '/busfw/ltext/swfupload/jslib/fupload.js,/busfw/ltext/componentview/ltext_fileupload.js,/busfw/common/ui/ui_uploadfiles.js,/busfw/ltext/fuds-download.js,/busfw/ltext/fuds-upload.js,/pmkpi/common/fileupload.js,/pmkpi/doubleprocess/report/proreport.js', 'Ext.lt.pmkpi.doubleprocess.reportservice', 'pmkpi', 'pmkpi.doubleprocess.TlpProgramService');
