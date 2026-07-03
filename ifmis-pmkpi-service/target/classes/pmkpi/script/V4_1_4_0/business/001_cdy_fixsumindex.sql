begin
  
delete from bus_t_pageconsole t where t.url in('/pmkpi/program/query/sumindex');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/program/query/sumindex', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfprogram.prjindex.PrjIndexPage', 'sumIndex', '{main:[datatable],footer:[toolbutton]}', null, null, 0);

delete from bus_t_pagecomponent t where t.id in('pmkpi_prjsumindex');
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_prjsumindex', '一级项目汇总指标', null, '一级项目汇总指标', '/pmkpi/perfprogram/prjindex/prjsumindex.js', 'Ext.lt.pmkpi.sumindex', 'pmkpi', 'pmkpi.prjindex.PrjSumIndexService');

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/program/query/sumindex');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/query/sumindex', 'dataexport', '{}', 'dataexport', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/query/sumindex', 'busuidatatable', '{headsort:false,addrow:false,nogroupbox:true,edit:true,checkbox:true,groupcols:[''guid'',''superid'',''name'',''levelno''],treedata:true,treemapping:null,initlevel:6,isuphide:false,editgroupdata:true,nextSibling:false,key:''/pmkpi/program/report/treeindex'',nextSibling:false,rowtolist:false}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/query/sumindex', 'pmkpi_prjsumindex', '{}', 'prjsumindex', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/query/sumindex', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

delete from p#busfw_t_uifunction t where t.key in('/pmkpi/program/query/list') and t.code='sumindex';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/query/list', '一级项目指标汇总查看', 0, 9, 'searchicon', 'tlprogramquery.sumindex', null, '一级项目指标汇总查看', 'pmkpi', 'sumindex', null, '{}', '87', '2016', null, null);

delete from p#busfw_t_uifunction t where t.key in('/pmkpi/program/query/sumindex');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/query/sumindex', '关闭', 1, 1, 'Nofinishicon', 'Ext.lt.ui.closeModalWindow', null, '关闭', 'pmkpi', null, null, null, '87', '2016', null, null);
