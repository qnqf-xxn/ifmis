begin

delete from bus_t_pageconsole t where t.url in('/pmkpi/review/report/batchadd');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/review/report/batchadd', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfreview.report.PerfReviewPage', 'batchadd', '{main:[datatable],footer:[toolbutton]}', null, null, 0);

delete from bus_t_pagecomponent t where t.id in('pmkpi_reviewbatchadd');
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_reviewbatchadd', '批量提交评审', null, '批量提交评审', '/pmkpi/perfreview/report/batchadd.js', 'Ext.lt.pmkpi.perfreview.batchadd', 'pmkpi', 'pmkpi.perfreview.BatchAddReviewService');

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/review/report/batchadd');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/review/report/batchadd', 'pmkpi_reviewbatchadd', '{}', 'reviewbatchadd', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/review/report/batchadd', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/review/report/batchadd', 'busuidatatable', '{name:''绩效目标评审表'',checkbox:false,title:''项目绩效申报'',edit:false,addrow:false,pagetype:''report'',uikey:''/pmkpi/assess/goal/edit''}', 'datatable', 'pmkpi', null);
