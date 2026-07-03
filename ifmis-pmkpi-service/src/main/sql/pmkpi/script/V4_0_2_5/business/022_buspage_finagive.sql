begin
delete FROM Bus_t_Pageconsolecomconfig t where t.url in ('/pmkpi/indexlib/finagive/edit','/pmkpi/indexlib/finagive');
delete FROM Bus_t_Pageconsole t where t.url in ('/pmkpi/indexlib/finagive/edit','/pmkpi/indexlib/finagive');
delete FROM Bus_t_Pagecomponent t where t.id in ('pmkpi_finagiveedit','pmkpi_finagive');

insert into Bus_t_Pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/indexlib/finagive', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.setting.indexlib.finagive.IndFinaGivePage', 'index', '{header:[header],left:lefttree,main:[toolbutton,queryform,datatable],height:[null,null,null,null]}', null, null, 0);

insert into Bus_t_Pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/indexlib/finagive/edit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.setting.indexlib.finagive.IndFinaGivePage', 'giveedit', '{main:[],footer:[toolbutton]}', null, null, 0);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/indexlib/finagive', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/indexlib/finagive', 'buslefttree', '{}', 'lefttree', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/indexlib/finagive/edit', 'pmkpi_finagiveedit', '{}', 'finagiveedit', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/indexlib/finagive/edit', 'busuidatatable', '{headsort:false,edit:false,checkbox:false,radio:true,isuphide:false,nextSibling:false}', 'depttable', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/indexlib/finagive/edit', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/indexlib/finagive', 'header', '{}', 'header', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/indexlib/finagive', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/indexlib/finagive', 'busuidatatable', '{name:''财政个性指标授权'',checkbox:true,title:''财政个性指标授权'',edit:false,addrow:false}', 'datatable', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/indexlib/finagive', 'pmkpi_finagive', '{}', 'indexfinagive', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/indexlib/finagive', 'dataexport', '{}', 'dataexport', 'pmkpi', null);

insert into Bus_t_Pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_finagive', '个性指标授权', null, '个性指标授权', '/pmkpi/setting/indexlib/indFinaGive.js', 'Ext.lt.pmkpi.indFinaGive.finaGiveservice', 'pmkpi', 'pmkpi.finagive.IndFinaGiveService');

insert into Bus_t_Pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_finagiveedit', '授权分类', null, '授权分类', '/pmkpi/setting/indexlib/finagiveedit.js', 'Ext.lt.pmkpi.finagiveedit', 'pmkpi', 'pmkpi.finagive.IndFinaGiveEdit');
