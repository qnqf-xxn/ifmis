begin
  
--中介库
DELETE FROM bus_t_pageconsole t where t.url='/pmkpi/setting/baseinfo/intermediaryinfo';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/setting/baseinfo/intermediaryinfo', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.setting.baseinfo.BaseinfoPage', 'zjindex', '{header:[header],main:[toolbutton,queryform,datatable]}', null, null, null);

DELETE FROM bus_t_pageconsolecomconfig t where t.url='/pmkpi/setting/baseinfo/intermediaryinfo';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/baseinfo/intermediaryinfo', 'pmkpi_baseinfo', '{}', 'baseinfo', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/baseinfo/intermediaryinfo', 'busqueryform', '{}', 'queryform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/baseinfo/intermediaryinfo', 'header', '{}', 'header', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/baseinfo/intermediaryinfo', 'busuidatatable', '{headsort:false,addrow:true,nogroupbox:false,edit:true,checkbox:true,title:''基础资料'',uikey:''/pmkpi/setting/baseinfo/intermediaryinfo/edit''}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/baseinfo/intermediaryinfo', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/baseinfo/intermediaryinfo', 'buslefttree', '{}', 'lefttree', 'pmkpi', null);

DELETE FROM bus_t_pagecomponent t where t.id='pmkpi_baseinfo';
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_baseinfo', '基础资料', null, '基础资料', '/pmkpi/setting/baseinfo/baseinfo.js', 'Ext.lt.pmkpi.baseinfo', 'pmkpi', 'pmkpi.baseinfo.BaseinfoService');

--中介库编辑
DELETE FROM bus_t_pageconsole t where t.url='/pmkpi/setting/baseinfo/intermediaryinfo/edit';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/setting/baseinfo/intermediaryinfo/edit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.setting.baseinfo.BaseinfoPage', 'editindex', '{main:[editform],footer:[toolbutton]}', null, null, null);

DELETE FROM bus_t_pageconsolecomconfig t where t.url='/pmkpi/setting/baseinfo/intermediaryinfo/edit';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/baseinfo/intermediaryinfo/edit', 'pmkpi_baseinfoedit', '{}', 'baseinfoedit', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/baseinfo/intermediaryinfo/edit', 'buseditform', '{title:''中介编辑'',tablecode:''V_PERF_INTERMEDIARYINFO'',iswf:''true''}', 'editform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/baseinfo/intermediaryinfo/edit', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

DELETE FROM bus_t_pagecomponent t where t.id='pmkpi_baseinfoedit';
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_baseinfoedit', '基础资料编辑', null, '基础资料编辑', '/pmkpi/setting/baseinfo/baseinfoedit.js', 'Ext.lt.pmkpi.baseinfoedit', 'pmkpi', 'pmkpi.baseinfo.BaseinfoEditService');
