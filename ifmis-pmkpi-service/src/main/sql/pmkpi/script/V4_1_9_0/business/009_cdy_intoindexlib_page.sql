begin

delete from bus_t_pageconsole t where t.url in('/pmkpi/intoindexlib/index');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/intoindexlib/index', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', '', '', 'pmkpi', 'gov.mof.fasp2.pmkpi.perfcommon.intoindexlib.IntoIndexLibPage', 'list', '{main:[datatable],footer:[toolbutton]}', '', '', 0);

delete from bus_t_pagecomponent t where t.id in('pmkpi_intoindexlibcommon');
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_intoindexlibcommon', '纳入指标', '', '纳入指标', '/pmkpi/perfcommon/intolindexlib/intoindexlib.js', 'Ext.lt.pmkpi.intoindexlib', 'pmkpi', 'pmkpi.intoindexlib.IntoIndexLibService');

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/intoindexlib/index');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/intoindexlib/index', 'pmkpi_intoindexlibcommon', '{}', 'intoindexlibcommon', 'pmkpi', '');

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/intoindexlib/index', 'busuidatatable', '{name:''纳入指标”'',title:''纳入指标'',edit:true,addrow:false}', 'datatable', 'pmkpi', '');

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/intoindexlib/index', 'bustoolbutton', '{}', 'toolbutton', 'inspect', '');
