begin
  
delete from bus_t_pageconsole t where t.url in('/pmkpi/program/beforeview');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/program/beforeview', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfprogram.beforeview.BeforeviewPage', 'edit', '{main:[editform]}', null, null, 0);

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/program/beforeview');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/beforeview', 'pmkpi_beforeview', '{}', 'beforeview', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/beforeview', 'buseditform', '{}', 'editform', 'pmkpi', null);

delete from bus_t_pagecomponent t where t.id in('pmkpi_beforeview');
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_beforeview', '事前绩效评估报告', null, '事前绩效评估报告', '/pmkpi/perfprogram/beforeview/beforeviewservice.js', 'Ext.lt.pmkpi.berforeviewservice', 'pmkpi', 'pmkpi.perfprogram.BeforeviewService');
