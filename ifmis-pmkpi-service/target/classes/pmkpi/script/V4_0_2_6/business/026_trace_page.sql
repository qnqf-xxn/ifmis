begin
--一般监控项目阶段监控填报
delete from bus_t_pageconsole t where t.url  in('/pmkpi/trace/report/proedit/ordwarn');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/trace/report/proedit/ordwarn', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfprotrace.warn.TraceWarnPage', 'index', '{main:[datatable,goaleditform],heights:[300,null]}', null, null, 0);

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/trace/report/proedit/ordwarn');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/trace/report/proedit/ordwarn', 'pmkpi_tracewarn', '{}', 'tracewarn', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/trace/report/proedit/ordwarn', 'buseditform', '{key:''/pmkpi/trace/report/proedit/ordwarn/goal'',title:''绩效目标完成情况''}', 'goaleditform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/trace/report/proedit/ordwarn', 'busuidatatable', '{key:''/pmkpi/trace/report/proedit/ordwarn/fund'',name:''预算执行情况'',edit:true,checkbox:true,title:''预算执行情况'',addrow:''true''}', 'datatable', 'pmkpi', null);
