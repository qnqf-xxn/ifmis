begin
  
delete from bus_t_pageconsolecomconfig where url = '/pmkpi/program/reportdp/jxaudit';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/reportdp/jxaudit', 'pmkpi_jxauditdp', '{}', 'jxauditdp', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/reportdp/jxaudit', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/reportdp/jxaudit', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/reportdp/jxaudit', 'buslefttree', '{}', 'lefttree', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/reportdp/jxaudit', 'header', '{}', 'header', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/reportdp/jxaudit', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/reportdp/jxaudit', 'busuidatatable', '{name:''项目绩效审核'',checkbox:true,title:''项目绩效审核'',edit:false,addrow:false,pagetype:''audit'',uikey:''/pmkpi/program/report/edit''}', 'datatable', 'pmkpi', null);


delete from bus_t_pageconsole where url = '/pmkpi/program/reportdp/jxaudit';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/program/reportdp/jxaudit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.doubleprocess.jxaudit.TlpJxAuditPage', 'index', '{header:[header],left:lefttree,main:[toolbutton,queryform,tabpage,datatable],height:[null,null,null,null]}', null, null, 0);


delete from bus_t_pagecomponent where id = 'pmkpi_jxauditdp';
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_jxauditdp', '项目绩效处审核', null, '项目绩效处审核', '/pmkpi/doubleprocess/audit/tlpjxaudit.js', 'Ext.lt.pmkpi.doubleprocess.tlpjxaudit', 'pmkpi', 'pmkpi.doubleprocess.TlpJxAuditService');




