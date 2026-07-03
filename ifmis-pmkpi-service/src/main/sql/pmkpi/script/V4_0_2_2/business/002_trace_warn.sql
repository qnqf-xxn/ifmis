begin
  --绩效监控填报  阶段监控页签 预算执行情况列表展示区高度调整
delete from bus_t_pageconsole where url ='/pmkpi/trace/report/proedit/warn';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/trace/report/proedit/warn', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfprotrace.warn.TraceWarnPage', 'index', '{main:[datatable,goaleditform],heights:[300,null]}', null, null, 0);


delete from bus_t_pageconsole where url ='/pmkpi/trace/report/deptedit/warn';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/trace/report/deptedit/warn', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfprotrace.warn.TraceWarnPage', 'index', '{main:[datatable,goaleditform],heights:[300,null]}', null, null, 0);

