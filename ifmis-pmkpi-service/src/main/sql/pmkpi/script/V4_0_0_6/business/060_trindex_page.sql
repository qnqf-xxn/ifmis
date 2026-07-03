begin
delete FROM Bus_t_Pagecomponent t where t.id = 'pmkpi_prjtreeindex';
delete FROM Bus_t_Pageconsole t where t.url = '/pmkpi/program/report/treeindex';
delete FROM Bus_t_Pageconsolecomconfig t where t.url = '/pmkpi/program/report/treeindex';

insert into Bus_t_Pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_prjtreeindex', '绩效指标树级', null, '绩效指标树级', '/pmkpi/perfprogram/prjindex/prjtreeindex.js', 'Ext.lt.pmkpi.treeindex', 'pmkpi', 'pmkpi.prjindex.PrjTreeInxService');

insert into Bus_t_Pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/program/report/treeindex', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfprogram.prjindex.PrjIndexPage', 'index', '{main:[toolbutton,tabpage,datatable]}', null, null, null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/report/treeindex', 'pmkpi_prjtreeindex', '{}', 'prjtreeindex', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/report/treeindex', 'busuidatatable', '{headsort:false,addrow:false,nogroupbox:true,edit:true,checkbox:true,groupcols:[''guid'',''superid'',''name'',''levelno''],treedata:true,treemapping:null,initlevel:6,isuphide:false,editgroupdata:true,nextSibling:false,key:''/pmkpi/program/report/treeindex''}', 'datatable', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/report/treeindex', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/report/treeindex', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);