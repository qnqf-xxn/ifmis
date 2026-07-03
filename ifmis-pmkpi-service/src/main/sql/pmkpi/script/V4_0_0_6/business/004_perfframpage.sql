begin
delete FROM Bus_t_Pagecomponent t where t.id = 'pmkpi_arrangement';
delete FROM Bus_t_Pageconsole t where t.url = '/pmkpi/arrangement/index';
delete FROM Bus_t_Pageconsolecomconfig t where t.url = '/pmkpi/arrangement/index';

insert into Bus_t_Pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_arrangement', '绩效指标层级', null, '绩效指标层级', '/pmkpi/setting/arrangement/arrangement.js', 'Ext.lt.pmkpi.arrangement', 'pmkpi', 'pmkpi.arrangement.ArrangementService');

insert into Bus_t_Pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/arrangement/index', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.setting.arrangement.ArrangementPage', 'toIndex', '{header:[header],main:[toolbutton,datatable]}', null, null, 0);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/arrangement/index', 'pmkpi_arrangement', '{}', 'arrangement', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/arrangement/index', 'header', '{}', 'header', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/arrangement/index', 'busuidatatable', '{headsort:false,addrow:true,nogroupbox:false,edit:true,checkbox:true,title:''绩效指标层级'', groupcols:[''guid'',''superid'',''name'',''levelno''],treedata:true,treemapping:null,initlevel:6,isuphide:false,editgroupdata:true,nextSibling:false}', 'datatable', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/arrangement/index', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/arrangement/index', 'buslefttree', '{}', 'lefttree', 'pmkpi', null);