begin
 
DELETE FROM  bus_t_pageconsole t where t.url='/pmkpi/workevaluate/task/list';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/workevaluate/task/list', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.workevaluate.task.WorkEvaluateTaskPage', 'index', '{header:[header],main:[toolbutton,queryform,datatable]}', null, null, 0);

DELETE FROM  Bus_t_Pageconsolecomconfig t where t.url='/pmkpi/workevaluate/task/list';
insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/workevaluate/task/list', 'pmkpi_workevaluatetask', '{}', 'workevaluatetask', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/workevaluate/task/list', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/workevaluate/task/list', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/workevaluate/task/list', 'header', '{}', 'header', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/workevaluate/task/list', 'busuidatatable', '{name:''绩效任务'',checkbox:true,title:''绩效管理工作考核任务'',edit:false,addrow:false}', 'datatable', 'pmkpi', null);

DELETE FROM Bus_t_Pagecomponent t where t.id='pmkpi_workevaluatetask';
insert into Bus_t_Pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_workevaluatetask', '绩效工作管理任务', null, '项目绩效任务', '/pmkpi/workevaluate/task/workevaluatetask.js', 'Ext.lt.pmkpi.workevaluate.taskservice', 'pmkpi', 'pmkpi.workevaluate.task.WorkEvaluateTaskService');



DELETE FROM bus_t_pageconsole t where t.url='/pmkpi/workevaluate/task/edit';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/workevaluate/task/edit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.workevaluate.task.WorkEvaluateTaskPage', 'editindex', '{main:[tabpage,editform],footer:[toolbutton]}', null, null, 0);

DELETE FROM Bus_t_Pageconsolecomconfig t where t.url='/pmkpi/workevaluate/task/edit';
insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/workevaluate/task/edit', 'pmkpi_workevaluatetaskedit', '{}', 'workevaluatetaskedit', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/workevaluate/task/edit', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/workevaluate/task/edit', 'buseditform', '{title:''绩效管理工作考核任务'',tablecode:''V_PERF_T_WORKEVALUATETASK''}', 'editform', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/workevaluate/task/edit', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

DELETE FROM Bus_t_Pagecomponent t where t.id='pmkpi_workevaluatetaskedit';
insert into Bus_t_Pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_workevaluatetaskedit', '绩效工作管理任务编辑', null, '绩效工作管理任务编辑', '/pmkpi/workevaluate/task/workevaluatetaskedit.js', 'Ext.lt.pmkpi.workevaluate.taskeditservice', 'pmkpi', 'pmkpi.workevaluate.task.WorkEvaluateTaskService');



DELETE FROM bus_t_pageconsole t where t.url='/pmkpi/workevaluate/assign/agencylist';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/workevaluate/assign/agencylist', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.workevaluate.assign.TaskAssignPage', 'index', '{main:[tabpage,datatable],footer:[toolbutton]}', null, null, 0);

DELETE FROM Bus_t_Pageconsolecomconfig t where t.url='/pmkpi/workevaluate/assign/agencylist';
insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/workevaluate/assign/agencylist', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/workevaluate/assign/agencylist', 'pmkpi_taskassign', '{}', 'pmkpitaskassign', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/workevaluate/assign/agencylist', 'busuidatatable', '{checkbox:true,edit:false,addrow:false}', 'datatable', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/workevaluate/assign/agencylist', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);


DELETE FROM Bus_t_Pagecomponent t where t.id='pmkpi_taskassign';
insert into Bus_t_Pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_taskassign', '绩效工作管理任务下达', null, '绩效工作管理任务下达', '/pmkpi/workevaluate/task/taskassignservice.js', 'Ext.lt.pmkpi.workevaluate.taskassignservice', 'pmkpi', 'pmkpi.workevaluate.assign.TaskAssignService');


DELETE FROM bus_t_pageconsole t where t.url='/pmkpi/workevaluate/assign/provincelist';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/workevaluate/assign/provincelist', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.workevaluate.assign.TaskAssignPage', 'index', '{main:[tabpage,datatable],footer:[toolbutton]}', null, null, 0);

DELETE FROM Bus_t_Pageconsolecomconfig t where t.url='/pmkpi/workevaluate/assign/provincelist';
insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/workevaluate/assign/provincelist', 'pmkpi_taskassign', '{}', 'pmkpitaskassign', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/workevaluate/assign/provincelist', 'busuidatatable', '{checkbox:true,edit:false,addrow:false}', 'datatable', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/workevaluate/assign/provincelist', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/workevaluate/assign/provincelist', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);
