begin
delete FROM Bus_t_Pageconsolecomconfig t where t.url in ('/pmkpi/program/prjindex/lastyear','/pmkpi/program/prjindex/budget');
delete FROM Bus_t_Pageconsole t where t.url in ('/pmkpi/program/prjindex/lastyear','/pmkpi/program/prjindex/budget');
delete FROM Bus_t_Pagecomponent t where t.id in ('pmkpi_lastyear','pmkpi_prjbudget');

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/prjindex/lastyear', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/prjindex/lastyear', 'busuidatatable', '{addrow:false,nogroupbox:false,edit:false,checkbox:true}', 'lasttable', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/prjindex/lastyear', 'pmkpi_lastyear', '{}', 'pmkpilastyear', 'pmkpi', null);

insert into Bus_t_Pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/program/prjindex/lastyear', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfprogram.prjindex.PrjIndexPage', 'lastpage', '{main:[lasttable],footer:[toolbutton]}', null, null, 0);

insert into Bus_t_Pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_lastyear', '复制上年指标', null, '复制上年指标', '/pmkpi/perfprogram/prjindex/lastindex.js', 'Ext.lt.pmkpi.lastindexservice', 'pmkpi', 'pmkpi.prjindex.IndexLastService');

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/prjindex/budget', 'pmkpi_prjbudget', '{}', 'pmkpiprjbudget', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/prjindex/budget', 'busuidatatable', '{addrow:false,nogroupbox:false,edit:false,checkbox:true}', 'budgettable', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/prjindex/budget', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into Bus_t_Pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/program/prjindex/budget', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfprogram.prjindex.PrjIndexPage', 'bdugetpage', '{main:[budgettable],footer:[toolbutton]}', null, null, 0);

insert into Bus_t_Pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_prjbudget', '预算执行情况', null, '预算执行情况', '/pmkpi/perfprogram/prjindex/prjbudget.js', 'Ext.lt.pmkpi.prjbudget', 'pmkpi', 'pmkpi.prjindex.PrjBudgetService');