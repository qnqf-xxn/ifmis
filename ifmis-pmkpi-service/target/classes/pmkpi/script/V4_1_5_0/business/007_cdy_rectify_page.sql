begin
  
delete from bus_t_pageconsole t where t.url in('/pmkpi/rectification/programquery');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/rectification/programquery', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.rectification.page.RectificationPage', 'feedbackEdit', '{main:[tabpage]}', null, null, 0);

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/rectification/programquery');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/programquery', 'pmkpi_addprogram', '{}', 'addprogram', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/programquery', 'buseditform', '{key:''/pmkpi/program/report/edit'',title:''»ù´¡ÐÅÏ¢'',tablecode:''v_perf_project_info'',iswf:''true''}', 'editform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/programquery', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/programquery', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);
