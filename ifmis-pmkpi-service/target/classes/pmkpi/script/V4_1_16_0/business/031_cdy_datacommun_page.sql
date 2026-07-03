begin
  
delete from bus_t_pageconsole t where t.url in('/pmkpi/perfself/pushdatacommunication');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/perfself/pushdatacommunication', 'template8', '/busfw/common/template/template_defautl.jsp', '/busfw/common/template/template_default.js,/pmkpi/common/perfcommon.js,/pmkpi/common/perfutil.js,/pmkpi/common/ueditor/ueditor.config.js,/pmkpi/common/ueditor/ueditor.all.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfself.pushdatacommun.PushDataCommunPage', 'index', '{header:[header],left:lefttree,main:[toolbutton,queryform,tabpage,datatable]}', null, null, 0);


delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/perfself/pushdatacommunication');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/perfself/pushdatacommunication', 'pmkpi_perfselfdatacommun', '{}', 'perfselfdatacommun', 'pmkpi', null, null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/perfself/pushdatacommunication', 'busuidatatable', '{name:''绩效自评推送'',checkbox:true,title:''绩效自评推送'',edit:false,addrow:false}', 'datatable', 'pmkpi', null, null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/perfself/pushdatacommunication', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null, null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/perfself/pushdatacommunication', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null, null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/perfself/pushdatacommunication', 'buslefttree', '{}', 'lefttree', 'pmkpi', null, null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/perfself/pushdatacommunication', 'bustabpage', '{}', 'tabpage', 'pmkpi', null, null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/perfself/pushdatacommunication', 'header', '{}', 'header', 'pmkpi', null, null);

delete from bus_t_pagecomponent t where t.id in('pmkpi_perfselfdatacommun');
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_perfselfdatacommun', '山西绩效自评推送数据中心', null, '山西绩效自评推送数据中心', '/pmkpi/perfself/pushdatacommun.js', 'Ext.lt.pmkpi.perfselfqueryservice', 'pmkpi', 'pmkpi.perfself.PushDataCommunService');
