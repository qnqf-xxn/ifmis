begin
  
delete from bus_t_pageconsole t where t.url in('/pmkpi/performanceopen/nxreport','/pmkpi/performanceopen/nxquery');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/performanceopen/nxquery', 'template8', '/busfw/common/template/template_defautl.jsp', '/busfw/common/template/template_default.js,/pmkpi/common/perfcommon.js,/pmkpi/common/perfutil.js,/pmkpi/common/ueditor/ueditor.config.js,/pmkpi/common/ueditor/ueditor.all.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.performanceopen.nxreport.NXPerfOpenPage', 'index', '{header:[header],left:lefttree,main:[toolbutton,queryform,datatable]}', null, null, 0);

insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/performanceopen/nxreport', 'template8', '/busfw/common/template/template_defautl.jsp', '/busfw/common/template/template_default.js,/pmkpi/common/perfcommon.js,/pmkpi/common/perfutil.js,/pmkpi/common/ueditor/ueditor.config.js,/pmkpi/common/ueditor/ueditor.all.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.performanceopen.nxreport.NXPerfOpenPage', 'index', '{header:[header],left:lefttree,main:[toolbutton,datatable]}', null, null, 0);

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/performanceopen/nxreport','/pmkpi/performanceopen/nxquery');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/performanceopen/nxquery', 'pmkpi_nxperfopenquery', '{}', 'nxperfopenquery', 'pmkpi', null, null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/performanceopen/nxquery', 'header', '{}', 'header', 'pmkpi', null, null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/performanceopen/nxquery', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null, null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/performanceopen/nxquery', 'busqueryform', '{key:''/pmkpi/performanceopen/nxreport'',name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null, null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/performanceopen/nxquery', 'busfw.dataexport', '{}', 'dataexport', 'pmkpi', null, null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/performanceopen/nxquery', 'busdclefttree', '{}', 'lefttree', 'pmkpi', null, null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/performanceopen/nxquery', 'busuidatatable', '{key:''/pmkpi/performanceopen/nxreport'',name:''绩效公开表'',checkbox:true,title:''绩效公开表'',edit:true,addrow:false}', 'datatable', 'pmkpi', null, null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/performanceopen/nxreport', 'pmkpi_nxperfopenreport', '{}', 'perfopenreport', 'pmkpi', null, null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/performanceopen/nxreport', 'header', '{}', 'header', 'pmkpi', null, null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/performanceopen/nxreport', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null, null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/performanceopen/nxreport', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null, null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/performanceopen/nxreport', 'busfw.dataexport', '{}', 'dataexport', 'pmkpi', null, null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/performanceopen/nxreport', 'busdclefttree', '{}', 'lefttree', 'pmkpi', null, null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/performanceopen/nxreport', 'busuidatatable', '{name:''绩效公开表'',checkbox:true,title:''绩效公开表'',edit:true,addrow:false}', 'datatable', 'pmkpi', null, null);

delete from bus_t_pagecomponent t where t.id in('pmkpi_nxperfopenreport','pmkpi_nxperfopenquery');
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_nxperfopenquery', '宁夏绩效公开查下', null, '宁夏绩效公开查下', '/pmkpi/performanceopen/nxqueryservice.js', 'Ext.lt.pmkpi.performanceopen.queryservice', 'pmkpi', 'pmkpi.performanceopen.NXPerfOpenService');

insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_nxperfopenreport', '宁夏绩效公开列表', null, '宁夏绩效公开列表', '/pmkpi/performanceopen/nxreportservice.js', 'Ext.lt.pmkpi.performanceopen.reportservice', 'pmkpi', 'pmkpi.performanceopen.NXPerfOpenService');
