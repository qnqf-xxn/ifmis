begin

delete from bus_t_pageconsole t where t.url in('/pmkpi/auditviewinfo/index');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/auditviewinfo/index', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.setting.auditdefine.auditviewinfo.AuditViewInfoPage', 'index', '{header:[header],main:[toolbutton,busquery,datatable]}', null, null, 0);

delete from bus_t_pagecomponent t where t.id in('pmkpi_auditviewinfo');
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_auditviewinfo', '审核视图信息', null, '审核视图信息', '/pmkpi/setting/auditdefine/auditview/auditviewInfoservice.js', 'Ext.lt.pmkpi.auditviewinfo', 'pmkpi', 'pmkpi.setting.auditviewinfo.AuditViewInfoService');

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/auditviewinfo/index');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/auditviewinfo/index', 'pmkpi_auditviewinfo', '{}', 'auditviewinfo', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/auditviewinfo/index', 'busuidatatable', '{name:''审核视图信息'',checkbox:true,title:''审核视图信息'',edit:true,addrow:false}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/auditviewinfo/index', 'header', '{}', 'header', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/auditviewinfo/index', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/auditviewinfo/index', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'busquery', 'pmkpi', null);

delete from bus_t_pageconsole t where t.url in('/pmkpi/editaudiview/edit');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/editaudiview/edit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.setting.auditdefine.auditviewinfo.AuditViewInfoPage', 'edit', '{main:[toolbutton,editform]}', null, null, 0);

delete from bus_t_pagecomponent t where t.id in('pmkpi_editaudiview');
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_editaudiview', '审核视图信息编辑', null, '审核视图信息编辑', '/pmkpi/setting/auditdefine/auditview/editauditviewservice.js', 'Ext.lt.pmkpi.editaudiview', 'pmkpi', 'pmkpi.setting.auditviewinfo.EditAudiViewService');

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/editaudiview/edit');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/editaudiview/edit', 'pmkpi_editaudiview', '{}', 'editaudiview', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/editaudiview/edit', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/editaudiview/edit', 'buseditform', '{title:''视图登记'',tablecode:''PERF_T_CUSTOMAUDITVIEW''}', 'editform', 'pmkpi', null);


delete from bus_t_pageconsole t where t.url in('/pmkpi/auditdefine/index');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/auditdefine/index', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.setting.auditdefine.define.AuditDefinedPage', 'index', '{header:[header],main:[toolbutton,tabpage,datatable,queryform]}', null, null, 0);


delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/auditdefine/index');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/auditdefine/index', 'pmkpi_auditdefine', '{}', 'auditdefine', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/auditdefine/index', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/auditdefine/index', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/auditdefine/index', 'header', '{}', 'header', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/auditdefine/index', 'busuidatatable', '{name:''审核定义信息'',checkbox:true,title:''审核定义信息'',edit:true,addrow:false}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/auditdefine/index', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);


delete from bus_t_pagecomponent t where t.id in('pmkpi_auditdefine');
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_auditdefine', '审核定义信息', null, '审核定义信息', '/pmkpi/setting/auditdefine/define/auditdefined.js', 'Ext.lt.pmkpi.auditdefine', 'pmkpi', 'pmkpi.setting.define.AuditDefinedService');


delete from bus_t_pageconsole t where t.url in('/pmkpi/auditdefine/edit');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/auditdefine/edit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.setting.auditdefine.define.AuditDefinedPage', 'editindex', '{main:[toolbutton,editform]}', null, null, 0);


delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/auditdefine/edit');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/auditdefine/edit', 'pmkpi_editdefine', '{}', 'editdefine', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/auditdefine/edit', 'buseditform', '{title:''审核属性''}', 'editform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/auditdefine/edit', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);


delete from bus_t_pagecomponent t where t.id in('pmkpi_editdefine');
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_editdefine', '审核属性', null, '审核属性', '/pmkpi/setting/auditdefine/define/editauditdefined.js', 'Ext.lt.pmkpi.editdefine', 'pmkpi', 'pmkpi.setting.define.AuditDefinedAddService');

delete from bus_t_pageconsole t where t.url in('/pmkpi/auditdefine/viewedit');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/auditdefine/viewedit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.setting.auditdefine.define.AuditDefinedPage', 'editindex', '{main:[toolbutton,editform]}', null, null, 0);


delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/auditdefine/viewedit');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/auditdefine/viewedit', 'pmkpi_editdefine', '{}', 'editdefine', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/auditdefine/viewedit', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/auditdefine/viewedit', 'buseditform', '{title:''审核属性''}', 'editform', 'pmkpi', null);


delete from bus_t_pagecomponent t where t.id in('pmkpi_editdefine');
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_editdefine', '审核属性', null, '审核属性', '/pmkpi/setting/auditdefine/define/editauditdefined.js', 'Ext.lt.pmkpi.editdefine', 'pmkpi', 'pmkpi.setting.define.AuditDefinedAddService');

delete from bus_t_pageconsole t where t.url in('/pmkpi/auditdefine/editbeanid');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/auditdefine/editbeanid', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.setting.auditdefine.define.AuditDefinedPage', 'editindex', '{main:[toolbutton,editform]}', null, null, 0);


delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/auditdefine/editbeanid');

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/auditdefine/editbeanid', 'pmkpi_editdefine', '{}', 'editdefine', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/auditdefine/editbeanid', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/auditdefine/editbeanid', 'buseditform', '{title:''审核属性''}', 'editform', 'pmkpi', null);



delete from bus_t_pagecomponent t where t.id in('pmkpi_editdefine');
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_editdefine', '审核属性', null, '审核属性', '/pmkpi/setting/auditdefine/define/editauditdefined.js', 'Ext.lt.pmkpi.editdefine', 'pmkpi', 'pmkpi.setting.define.AuditDefinedAddService');

