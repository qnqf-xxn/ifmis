begin
  
DELETE FROM bus_t_pageconsole t WHERE t.url='/pmkpi/hbtracereport/upload/index';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/hbtracereport/upload/index', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.hbtracereport.upload.HbtracereportPage', 'index', '{header:[header],left:lefttree,main:[toolbutton,queryform,datatable]}', null, null, 0);


DELETE FROM bus_t_pageconsolecomconfig t WHERE t.url='/pmkpi/hbtracereport/upload/index';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/hbtracereport/upload/index', 'pmkpi_hbtracereportupload', '{}', 'hbtracereportupload', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/hbtracereport/upload/index', 'busuidatatable', '{name:''部门绩效申报'',checkbox:true,title:''部门监控报告'',edit:false,addrow:false,pagetype:''report''}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/hbtracereport/upload/index', 'header', '{}', 'header', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/hbtracereport/upload/index', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/hbtracereport/upload/index', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/hbtracereport/upload/index', 'buslefttree', '{}', 'lefttree', 'pmkpi', null);


DELETE FROM Bus_t_Pagecomponent t WHERE t.id='pmkpi_hbtracereportupload';
insert into Bus_t_Pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_hbtracereportupload', '部门监控报告上报', null, '部门监控报告上报', '/pmkpi/hbtracereport/index/hbtracereportupload.js', 'Ext.lt.pmkpi.hbtracereportupload', 'pmkpi', 'pmkpi.hbtracereport.hbtracereportService');


DELETE FROM bus_t_pageconsole t where t.url='/pmkpi/hbtracereport/upload/edit';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/hbtracereport/upload/edit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.hbtracereport.upload.HbtracereportPage', 'editindex', '{main:[tabpage,formaleditform],footer:[toolbutton]}', null, null, 0);


DELETE FROM bus_t_pageconsolecomconfig t where t.url='/pmkpi/hbtracereport/upload/edit';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/hbtracereport/upload/edit', 'pmkpi_hbtracereportedit', '{}', 'hbtracereportedit', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/hbtracereport/upload/edit', 'buseditform', '{title:''基本信息'',tablecode:''PERF_T_HBTRACEREPORTUPLOAD'',pagetype:''manceinfo'',iswf:''true''}', 'formaleditform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/hbtracereport/upload/edit', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/hbtracereport/upload/edit', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);


DELETE FROM Bus_t_Pagecomponent t WHERE t.id='pmkpi_hbtracereportedit';
insert into Bus_t_Pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_hbtracereportedit', '部门监控报告上报', null, '部门监控报告上报', '/pmkpi/hbtracereport/index/hbtracereportedit.js', 'Ext.lt.pmkpi.hbtracereportedit', 'pmkpi', 'pmkpi.hbtracereport.hbtracereportService');


DELETE FROM bus_t_pageconsole t WHERE t.url='/pmkpi/hbtracereport/upload/query';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/hbtracereport/upload/query', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.hbtracereport.query.HbtracereportQueryPage', 'index', '{header:[header],left:lefttree,main:[toolbutton,queryform,datatable]}', null, null, 0);


DELETE FROM bus_t_pageconsolecomconfig t WHERE t.url='/pmkpi/hbtracereport/upload/query';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/hbtracereport/upload/query', 'pmkpi_hbtracereportquery', '{}', 'hbtracereportquery', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/hbtracereport/upload/query', 'busuidatatable', '{name:''部门绩效申报'',checkbox:true,title:''部门监控报告'',edit:false,addrow:false,pagetype:''report''}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/hbtracereport/upload/query', 'header', '{}', 'header', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/hbtracereport/upload/query', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/hbtracereport/upload/query', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/hbtracereport/upload/query', 'buslefttree', '{}', 'lefttree', 'pmkpi', null);


DELETE FROM Bus_t_Pagecomponent t WHERE t.id='pmkpi_hbtracereportquery';
insert into Bus_t_Pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_hbtracereportquery', '部门监控报告上报查询', null, '部门监控报告上报查询', '/pmkpi/hbtracereport/query/hbtracereportquery.js', 'Ext.lt.pmkpi.hbtracereportquery', 'pmkpi', 'pmkpi.hbtracereport.hbtracereportqueryService');
