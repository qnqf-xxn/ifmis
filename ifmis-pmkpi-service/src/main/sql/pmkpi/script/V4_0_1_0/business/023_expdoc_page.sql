begin
delete from bus_t_pageconsole where url = '/pmkpi/setting/expdoctemp';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/setting/expdoctemp', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.setting.expdoc.temp.ExpdocTempPage', 'uitable', '{main:[editform,datatable],footer:[toolbutton]}', null, null, null);

delete from bus_t_pageconsole where url = '/pmkpi/setting/expdoc';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/setting/expdoc', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.setting.expdoc.ExpdocPage', 'list', '{header:[header],main:[toolbutton,queryform,datatable]}', null, null, 1);

delete from bus_t_pageconsole where url = '/pmkpi/setting/expdoc/set';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/setting/expdoc/set', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.setting.expdoc.ExpdocPage', 'edit', '{main:[editform],footer:[toolbutton]}', null, null, 1);

delete from bus_t_pageconsolecomconfig where url = '/pmkpi/setting/expdoctemp';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/expdoctemp', 'pmkpi_expdoctemp', '{}', 'expdoctemp', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/expdoctemp', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/expdoctemp', 'buseditform', '{title:''模板定义信息''}', 'editform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/expdoctemp', 'busuidatatable', '{addrow:true,name:''模板配置区'',edit:true,checkbox:true,title:''模板配置区''}', 'datatable', 'pmkpi', null);


delete from bus_t_pageconsolecomconfig where url = '/pmkpi/setting/expdoc';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/expdoc', 'pmkpi_expdoc', '{}', 'expdoc', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/expdoc', 'busqueryform', '{name:''查询区'',fastquery:true,datatable:''datatable'',drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);


insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/expdoc', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/expdoc', 'header', '{}', 'header', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/expdoc', 'busuidatatable', '{name:''导出配置维护'',checkbox:true,title:''导出配置维护'',edit:false,addrow:false}', 'datatable', 'pmkpi', null);

delete from bus_t_pageconsolecomconfig where url = '/pmkpi/setting/expdoc/set';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/expdoc/set', 'pmkpi_expdocset', '{}', 'expdocset', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/expdoc/set', 'buseditform', '{key:''/pmkpi/setting/expdoctemp'',name:''模板定义'',title:''模板定义''}', 'editform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/expdoc/set', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

delete from bus_t_pagecomponent where id = 'pmkpi_expdocset';
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_expdocset', '导出模板定义', null, '导出模板定义', '/pmkpi/setting/expdoc/expdocedit.js', 'Ext.lt.pmkpi.expdoceditservice', 'pmkpi', 'pmkpi.setting.expdoc.ExpdocEditService');


delete from bus_t_pagecomponent where id = 'pmkpi_expdoc';
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_expdoc', '导出模板维护', null, '导出模板维护', '/pmkpi/setting/expdoc/expdocservice.js', 'Ext.lt.pmkpi.expdocservice', 'pmkpi', 'pmkpi.setting.expdoc.ExpdocService');

delete from bus_t_pagecomponent where id = 'pmkpi_expdoctemp';
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_expdoctemp', '导出模板编辑', null, '导出模板编辑', '/pmkpi/setting/expdoc/temp/expdoctempservice.js', 'Ext.lt.pmkpi.expdoctempservice', 'pmkpi', 'pmkpi.setting.expdoc.temp.ExpdocTempService');

