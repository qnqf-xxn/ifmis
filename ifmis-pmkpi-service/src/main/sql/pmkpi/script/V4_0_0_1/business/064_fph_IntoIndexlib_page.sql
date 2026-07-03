begin
  
delete from Bus_t_Pageconsole t where t.url='/pmkpi/program/intoindexlib/list';
insert into Bus_t_Pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/program/intoindexlib/list', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfprogram.intoindexlib.IntoIndexlibPage', 'index', '{header:[header],left:lefttree,main:[toolbutton,queryform,datatable]}', null, null, 0);


delete from Bus_t_Pageconsolecomconfig t where t.url='/pmkpi/program/intoindexlib/list';
insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/intoindexlib/list', 'pmkpi_intoindexlib', '{}', 'pmkpiintoindexlib', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/intoindexlib/list', 'buslefttree', '{}', 'lefttree', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/intoindexlib/list', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/intoindexlib/list', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/intoindexlib/list', 'header', '{}', 'header', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/intoindexlib/list', 'busuidatatable', '{name:''项目绩效申报'',checkbox:true,title:''项目指标纳入指标库'',edit:false,addrow:false,tablecode:''V_PERF_PROJECT_INFO''}', 'datatable', 'pmkpi', null);


delete from Bus_t_Pagecomponent t where t.id='pmkpi_intoindexlib';
insert into Bus_t_Pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_intoindexlib', '项目指标纳入指标库', null, '项目指标纳入指标库', '/pmkpi/perfprogram/intoindexlib/intoindexlib.js', 'Ext.lt.pmkpi.intoindexlib.intoindexlibservice', 'pmkpi', 'pmkpi.intoindexlib.IntoIndexlibService');



delete from Bus_t_Pageconsole t where t.url='/pmkpi/deptperformance/intoindexlib/list';
insert into Bus_t_Pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/deptperformance/intoindexlib/list', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfprogram.intoindexlib.IntoIndexlibPage', 'index', '{header:[header],left:lefttree,main:[toolbutton,queryform,datatable]}', null, null, 0);


delete from Bus_t_Pageconsolecomconfig t where t.url='/pmkpi/deptperformance/intoindexlib/list';
insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/intoindexlib/list', 'pmkpi_intoindexlib', '{}', 'pmkpiintoindexlib', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/intoindexlib/list', 'buslefttree', '{}', 'lefttree', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/intoindexlib/list', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/intoindexlib/list', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/intoindexlib/list', 'header', '{}', 'header', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/intoindexlib/list', 'busuidatatable', '{name:''项目绩效申报'',checkbox:true,title:''项目指标纳入指标库'',edit:false,addrow:false,tablecode:''V_PERF_PROJECT_INFO''}', 'datatable', 'pmkpi', null);


delete from Bus_t_Pagecomponent t where t.id='pmkpi_intoindexlib';
insert into Bus_t_Pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_intoindexlib', '部门指标纳入指标库', null, '部门指标纳入指标库', '/pmkpi/perfprogram/intoindexlib/intoindexlib.js', 'Ext.lt.pmkpi.intoindexlib.intoindexlibservice', 'pmkpi', 'pmkpi.intoindexlib.IntoIndexlibService');
