begin
  
delete from bus_t_pageconsole t where t.url in('/pmkpi/audit/aisendaudit');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/audit/aisendaudit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfcommon.aisendaudit.AISendAuditPage', 'sendaudit', '{main:[editform],footer:[toolbutton]}', null, null, 0);

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/audit/aisendaudit');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/audit/aisendaudit', 'pmkpi_aisendaudit', '{}', 'aisendaudit', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/audit/aisendaudit', 'buseditform', '{columnsize:1}', 'editform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/audit/aisendaudit', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

delete from bus_t_pagecomponent t where t.id in('pmkpi_aisendaudit');
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_aisendaudit', 'AI∏®÷˙…Û∫À', null, 'AI∏®÷˙…Û∫À', '/pmkpi/perfcommon/aisendaudit/aisendaudit.js', 'Ext.lt.pmkpi.aisendaudit', 'pmkpi', 'pmkpi.aisendaudit.AISendAuditService');
