begin

delete from bus_t_pageconsole t where t.url in('/pmkpi/adjust/report/proedit/index');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/adjust/report/proedit/index', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.adjust.index.AdjustIndexPage', 'index', '{main:[toolbutton,datatable]}', null, null, null);

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/adjust/report/proedit/index') and t.id='editform';

delete from p#busfw_t_uieditform t where key in('/pmkpi/adjust/report/proedit/index');
