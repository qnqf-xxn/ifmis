begin

delete from bus_t_pageconsolecomconfig where url = '/pmkpi/audit/program/showhistrace';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/audit/program/showhistrace', 'pmkpi_showhistrace', '{}', 'showhistrace', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/audit/program/showhistrace', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/audit/program/showhistrace', 'header', '{}', 'header', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/audit/program/showhistrace', 'busuidatatable', '{key:''/pmkpi/program/trace/query'',name:''监控历史记录'',checkbox:true,title:''监控历史记录'',edit:false,addrow:false}', 'datatable', 'pmkpi', null);




delete from bus_t_pageconsole where url = '/pmkpi/audit/program/showhistrace';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION)
values ('/pmkpi/audit/program/showhistrace', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfprotrace.query.ProTraceQueryPage', 'histrace', '{header:[header],main:[toolbutton,datatable]}', null, null);



delete from bus_t_pagecomponent where id = 'pmkpi_showhistrace';
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_showhistrace', '查看监控历史记录', null, '查看监控历史记录', '/pmkpi/perfprotrace/query/showhistrace.js', 'Ext.lt.pmkpi.perfprogram.showhistrace', 'pmkpi', 'pmkpi.perfprotrace.query.ProTraceQueryService');




