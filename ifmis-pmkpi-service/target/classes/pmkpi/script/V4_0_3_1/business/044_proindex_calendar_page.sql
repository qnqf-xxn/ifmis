begin

delete from bus_t_pageconsole t where t.url in('/pmkpi/program/prjindex/calendarindex');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/program/prjindex/calendarindex', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfprogram.prjindex.PrjIndexPage', 'calendarIndex', '{main:[queryform,datatable],footer:[toolbutton]}', null, null, 0);

delete from bus_t_pagecomponent t where t.id in('pmkpi_calendarindex');
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_calendarindex', '参考历年指标', null, '参考历年指标', '/pmkpi/perfprogram/prjindex/calendarindex.js', 'Ext.lt.pmkpi.calendarindex', 'pmkpi', 'pmkpi.prjindex.CalendarIndexService');

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/program/prjindex/calendarindex');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/prjindex/calendarindex', 'pmkpi_calendarindex', '{}', 'calendarindex', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/prjindex/calendarindex', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''table'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/prjindex/calendarindex', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/prjindex/calendarindex', 'busuidatatable', '{name:''历年指标'',checkbox:true,title:''历年指标'',edit:false,addrow:false}', 'datatable', 'pmkpi', null);
