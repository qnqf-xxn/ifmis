begin
delete from bus_t_pageconsole where url = '/pmkpi/program/trace/manage/prolist';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/program/trace/manage/prolist', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfprotrace.manage.ProTraceManagePage', 'prolist', '{main:[queryform,tabpage,datatable],footer:[toolbutton]}', null, null, 0);

delete from bus_t_pageconsole where url = '/pmkpi/program/trace/manage/deptlist';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/program/trace/manage/deptlist', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfprotrace.manage.ProTraceManagePage', 'prolist', '{main:[queryform,tabpage,datatable],footer:[toolbutton]}', null, null, 0);

delete from bus_t_pageconsole where url = '/pmkpi/program/tracemanage/taskcopy';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/program/tracemanage/taskcopy', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfprotrace.manage.ProTraceManagePage', 'taskcopy', '{main:[toolbutton,editform]}', null, null, 0);


delete from bus_t_pageconsolecomconfig where url = '/pmkpi/program/trace/manage/prolist';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/manage/prolist', 'pmkpi_protaskprolist', '{}', 'protaskprolist', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/manage/prolist', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/manage/prolist', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/manage/prolist', 'busuidatatable', '{name:''绩效项目'',checkbox:true,title:''绩效项目'',edit:false,addrow:false}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/manage/prolist', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);


delete from bus_t_pageconsolecomconfig where url = '/pmkpi/program/tracemanage/taskcopy';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/tracemanage/taskcopy', 'pmkpi_promanagetaskcopy', '{}', 'promanagetaskcopy', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/tracemanage/taskcopy', 'buseditform', '{title:''任务信息''}', 'editform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/tracemanage/taskcopy', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);


delete from bus_t_pagecomponent where id = 'pmkpi_protaskprolist';
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_protaskprolist', '项目绩效任务布置', null, '项目绩效任务布置', '/pmkpi/perfprotrace/manage/manageprolist.js', 'Ext.lt.pmkpi.perfprotrace.manageservice', 'pmkpi', 'pmkpi.perfprotrace.manage.ProTraceManageEditService');

delete from bus_t_pagecomponent where id = 'pmkpi_promanagetaskcopy';
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_promanagetaskcopy', '项目任务复制', null, '项目任务复制', '/pmkpi/perfprotrace/manage/managetaskcopy.js', 'Ext.lt.pmkpi.perfprotrace.managetaskcopy', 'pmkpi', 'pmkpi.perfprotrace.manage.ProTraceManageEditService');




delete from bus_t_pageconsolecomconfig where url = '/pmkpi/program/trace/manage/deptlist';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/manage/deptlist', 'pmkpi_protaskprolist', '{}', 'protaskprolist', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/manage/deptlist', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/manage/deptlist', 'bustoolbutton', '{key:''/pmkpi/program/trace/manage/prolist''}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/manage/deptlist', 'busuidatatable', '{name:''绩效项目'',checkbox:true,title:''绩效项目'',edit:false,addrow:false}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/manage/deptlist', 'bustabpage', '{key:''/pmkpi/program/trace/manage/prolist''}', 'tabpage', 'pmkpi', null);
