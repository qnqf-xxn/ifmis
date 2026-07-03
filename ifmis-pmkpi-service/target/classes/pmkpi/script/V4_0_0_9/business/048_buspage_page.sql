begin

--页面配置
delete from bus_t_pageconsole t where t.url in('/pmkpi/setting/buspage');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/setting/buspage', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.setting.buspage.BusAppendPage', 'list', '{header:[header],left:lefttree,main:[toolbutton,datatable]}', null, null, 1);

delete from bus_t_pagecomponent t where t.id in('pmkpi_buspage');
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_buspage', '页面配置维护', null, '页面配置维护', '/pmkpi/setting/buspage/buspageservice.js', 'Ext.lt.pmkpi.buspageservice', 'pmkpi', 'pmkpi.setting.buspage.BusAppendService');

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/setting/buspage');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/buspage', 'pmkpi_buspage', '{}', 'buspage', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/buspage', 'busdclefttree', '{}', 'lefttree', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/buspage', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/buspage', 'header', '{}', 'header', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/buspage', 'busuidatatable', '{name:''页面组件列表'',checkbox:true,title:''页面组件列表'',edit:true,addrow:false}', 'datatable', 'pmkpi', null);

--菜单编辑
delete from bus_t_pageconsole t where t.url in('/pmkpi/setting/buspage/setmenu');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/setting/buspage/setmenu', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.setting.buspage.BusAppendPage', 'edit', '{main:[editform],footer:[toolbutton]}', null, null, 1);

delete from bus_t_pagecomponent t where t.id in('pmkpi_buseditmenu');
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_buseditmenu', '页面配置菜单维护', null, '页面配置菜单维护', '/pmkpi/setting/buspage/buseditmenu.js', 'Ext.lt.pmkpi.buseditmenuservice', 'pmkpi', 'pmkpi.setting.buspage.BusEditMenuService');

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/setting/buspage/setmenu');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/buspage/setmenu', 'pmkpi_buseditmenu', '{}', 'buseditmenu', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/buspage/setmenu', 'buseditform', '{name:''菜单信息'',title:''菜单信息''}', 'editform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/buspage/setmenu', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);
