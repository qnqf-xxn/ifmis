begin

delete from bus_t_pageconsole t where t.url in('/pmkpi/busauditdefine/index');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/busauditdefine/index', 'template8', '/pmkpi/setting/auditdefine/busauditdefine/busauditdefine.jsp', '/pmkpi/setting/auditdefine/busauditdefine/busauditdefine.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.setting.auditdefine.busauditdefine.BusAuditDefinePage', 'index', '{header:[header],left:lefttree,main:[statustree,toolbutton,datatable]}', null, null, 0);

delete from bus_t_pagecomponent t where t.id in('pmkpi_busauditdefine');
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_busauditdefine', '审核定义业务配置', null, '审核定义业务配置', '/pmkpi/setting/auditdefine/busauditdefine/busauditdefineservice.js', 'Ext.lt.pmkpi.busauditdefineservice', 'pmkpi', 'pmkpi.setting.busauditdefine.BusAuditDefineService');

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/busauditdefine/index');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/busauditdefine/index', 'pmkpi_busauditdefine', '{}', 'busauditdefine', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/busauditdefine/index', 'busuidatatable', '{name:''审核定义'',checkbox:true,title:''审核定义'',edit:true,addrow:true}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/busauditdefine/index', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/busauditdefine/index', 'header', '{}', 'header', 'pmkpi', null);

delete from bus_t_pageconsole t where t.url in('/pmkpi/busauditdefine/editmenu');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/busauditdefine/editmenu', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.setting.auditdefine.busauditdefine.BusAuditDefinePage', 'editMenu', '{main:[toolbutton,editform]}', null, null, 0);

delete from bus_t_pagecomponent t where t.id in('pmkpi_busauditeditmenu');
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_busauditeditmenu', '审核定义菜单扩展', null, '审核定义菜单扩展', '/pmkpi/setting/auditdefine/busauditdefine/busmenuedit.js', 'Ext.lt.pmkpi.busmenueditservice', 'pmkpi', 'pmkpi.setting.busauditdefine.BusAuditMenuEditService');

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/busauditdefine/editmenu');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/busauditdefine/editmenu', 'pmkpi_busauditeditmenu', '{}', 'busauditeditmenu', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/busauditdefine/editmenu', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/busauditdefine/editmenu', 'buseditform', '{}', 'editform', 'pmkpi', null);
