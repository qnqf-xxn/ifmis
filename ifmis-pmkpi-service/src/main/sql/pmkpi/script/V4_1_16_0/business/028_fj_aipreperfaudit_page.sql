begin

--“≥√Ê≈‰÷√
delete from bus_t_pageconsole where url ='/pmkpi/common/aipreperfaudit';

insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/common/aipreperfaudit', 'template8', '/busfw/common/template/template_defautl.jsp', '/busfw/common/template/template_default.js,/pmkpi/common/perfcommon.js,/pmkpi/common/perfutil.js,/pmkpi/common/ueditor/ueditor.config.js,/pmkpi/common/ueditor/ueditor.all.js', '/pmkpi/common/css/ai_common.css', null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfcommon.aisupportaudit.AISupportAuditPage', 'preperf', '{main:[editform],footer:[toolbutton]}', null, null, 0);


delete from bus_t_pageconsolecomconfig where url ='/pmkpi/common/aipreperfaudit';

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/common/aipreperfaudit', 'pmkpi_aipreperfaudit', '{}', 'aipreperfaudit', 'pmkpi', null, null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/common/aipreperfaudit', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null, null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/common/aipreperfaudit', 'buseditform', '{}', 'editform', 'pmkpi', null);

delete from bus_t_pagecomponent where id ='pmkpi_aipreperfaudit';

insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_aipreperfaudit', ' ¬«∞∆¿π¿÷«ƒ‹…Û∫À', null, ' ¬«∞∆¿π¿÷«ƒ‹…Û∫À', '/pmkpi/perfcommon/aipreperfaudit.js', 'Ext.lt.pmkpi.aipreperfaudit', 'pmkpi', 'pmkpi.aisupportaudit.AIPrePerfAuditService');
