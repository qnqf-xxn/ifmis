begin

--自评评审意见
delete from bus_t_pageconsole t where t.url in('/pmkpi/self/opinion/edit');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/self/opinion/edit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfself.opinion.SelfOpinionPage', 'edit', '{main:[toolbutton,editform,datatable],heights:[null,500,200]}', null, null, 0);

delete from bus_t_pagecomponent t where t.id in('pmkpi_selfopinion');
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_selfopinion', '自评评审意见', null, '自评评审意见', '/pmkpi/perfself/selfopinion.js', 'Ext.lt.pmkpi.selfopinion', 'pmkpi', 'pmkpi.perfself.opinion.SelfOpinionService');

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/self/opinion/edit');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/self/opinion/edit', 'pmkpi_selfopinion', '{}', 'selfopinion', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/self/opinion/edit', 'buseditform', '{headsort:false,name:''评审意见'',edit:true,title:''评审意见'',nextSibling:false}', 'editform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/self/opinion/edit', 'busuidatatable', '{key:''/pmkpi/upload/file/index'',addrow:false,name:''附件管理'',edit:true,nogroupbox:true,checkbox:true,title:''附件管理'',groupcols:[''guid'',''superid'',''supername'',''levelno''],treedata:true,treemapping:null,initlevel:6,isuphide:false,editgroupdata:true,nextSibling:false,rowtolist:false}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/self/opinion/edit', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);
