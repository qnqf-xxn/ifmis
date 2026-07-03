begin

--结转自评任务布置
delete from bus_t_pageconsole t where t.url in('/pmkpi/perfself/transfer/taskmanage');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/perfself/transfer/taskmanage', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfself.page.PerfSelfTaskManagePage', 'index', '{header:[header],left:lefttree,main:[toolbutton,queryform,tabpage,datatable]}', null, null, 0);

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/perfself/transfer/taskmanage');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/transfer/taskmanage', 'pmkpi_perfselftaskmanage', '{}', 'perfselfmanage', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/transfer/taskmanage', 'bustabpage', '{key:''/pmkpi/perfself/taskmanage''}', 'tabpage', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/transfer/taskmanage', 'busuidatatable', '{key:''/pmkpi/perfself/taskmanage'',name:''绩效自评下达'',checkbox:true,title:''绩效自评下达'',edit:false,addrow:false,uikey:''/pmkpi/perfselftaskmanage/edit'',deltables:[''v_perf_t_selfperfindex'',''v_perf_t_selfperfdesc'',''v_perf_t_selfprofund''],delcols:[''mainguid'',''mainguid'',''mainguid'']}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/transfer/taskmanage', 'buseditform', '{key:''/pmkpi/perfselftaskmanage/index''}', 'editform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/transfer/taskmanage', 'header', '{}', 'header', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/transfer/taskmanage', 'bustoolbutton', '{key:''/pmkpi/perfselftaskmanage/index''}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/transfer/taskmanage', 'busqueryform', '{key:''/pmkpi/perfselftaskmanage/index'',name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/transfer/taskmanage', 'busdclefttree', '{}', 'lefttree', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/transfer/taskmanage', 'busfw.dataexport', '{}', 'dataexport', null, null);

delete from perf_t_treetab t where t.key in('/pmkpi/perfself/transfer/taskmanage');
insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID, CONFIG)
values ('F4A40680B98E7C1BE0533315A8C03265', '/pmkpi/perfself/transfer/taskmanage', 'transprogram', '项目支出', 1, null, 1, '2016', '87', '97453626C11A83A453494FB4E08F3C16', 'F4A40680B92D7C1BE0533315A8C03265', null);

--结转自评填报
delete from bus_t_pageconsole t where t.url in('/pmkpi/perfself/transfer/apply');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/perfself/transfer/apply', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfself.page.PerfSelfApplyPage', 'index', '{header:[header],left:lefttree,main:[toolbutton,queryform,tabpage,datatable]}', null, null, 0);

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/perfself/transfer/apply');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/transfer/apply', 'busuidatatable', '{name:''绩效自评填报'',key:''/pmkpi/perfself/query'',checkbox:true,tiptiptitle:''绩效自评填报'',edit:false,addrow:false,pagetype:''report'',deltables:[''v_perf_t_selfevaltask''],delcols:[''guid''],viewtabcode:''v_perf_v_selfevaltask'',infotablecode:''v_perf_project_info'',infosavetablecode:''v_perf_project_info'',busguid:''31A575D94D5C0FD937BEBD2D18C144A1_000''}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/transfer/apply', 'header', '{}', 'header', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/transfer/apply', 'bustoolbutton', '{key:''/pmkpi/perfself/apply/index''}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/transfer/apply', 'busdclefttree', '{}', 'lefttree', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/transfer/apply', 'busqueryform', '{key:''/pmkpi/perfself/apply/index'',name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/transfer/apply', 'busfw.dataexport', '{}', 'dataexport', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/transfer/apply', 'pmkpiimpexp', '{}', 'impexp', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/transfer/apply', 'pmkpi_perfselfapply', '{}', 'perfselfapply', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/transfer/apply', 'bustabpage', '{key:''/pmkpi/perfself/apply''}', 'tabpage', 'pmkpi', null);

delete from perf_t_treetab t where t.key in('/pmkpi/perfself/transfer/apply');
insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID, CONFIG)
values ('F4A40680B9F17C1BE0533315A8C03265', '/pmkpi/perfself/transfer/apply', 'transprogram', '项目支出', 1, '导出部门整体支出绩效自评表(山西)', 1, '2016', '87', '97453626C11A83A453494FB4E08F3C16', 'F4A40680B92B7C1BE0533315A8C03265', null);


--结转自评审核
delete from bus_t_pageconsole t where t.url in('/pmkpi/perfself/transfer/audit');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/perfself/transfer/audit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfself.page.PerfSelfAuditPage', 'index', '{header:[header],left:lefttree,main:[toolbutton,queryform,tabpage,datatable]}', null, null, 0);

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/perfself/transfer/audit');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/transfer/audit', 'pmkpi_perfselfaudit', '{}', 'perfselfaudit', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/transfer/audit', 'header', '{}', 'header', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/transfer/audit', 'bustoolbutton', '{key:''/pmkpi/perfself/audit/index''}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/transfer/audit', 'busqueryform', '{key:''/pmkpi/perfself/apply/index'',name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/transfer/audit', 'busdclefttree', '{}', 'lefttree', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/transfer/audit', 'bustabpage', '{key:''/pmkpi/perfself/audit''}', 'tabpage', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/transfer/audit', 'busuidatatable', '{name:''绩效自评审核'',key:''/pmkpi/perfself/query'',checkbox:true,title:''绩效自评审核'',edit:false,addrow:false}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/transfer/audit', 'busfw.dataexport', '{}', 'dataexport', 'pmkpi', null);

delete from perf_t_treetab t where t.key in('/pmkpi/perfself/transfer/audit');
insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID, CONFIG)
values ('F4C91E55ADE13772E0533315A8C083EF', '/pmkpi/perfself/transfer/audit', 'transprogram', '项目支出', 1, '导出部门整体支出绩效自评表(山西)', 1, '2016', '87', '97453626C11A83A453494FB4E08F3C16', 'F4A40680B92F7C1BE0533315A8C03265', null);

--结转自评查询
delete from bus_t_pageconsole t where t.url in('/pmkpi/perfself/transfer/query');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/perfself/transfer/query', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfself.page.PerfSelfQueryPage', 'index', '{header:[header],left:lefttree,main:[toolbutton,queryform,datatable]}', null, null, 0);

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/perfself/transfer/query');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/transfer/query', 'pmkpi_perfselfquery', '{}', 'perfselfquery', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/transfer/query', 'busuidatatable', '{name:''绩效自评查询'',key:''/pmkpi/perfself/query'',checkbox:true,title:''绩效自评查询'',edit:false,addrow:false,pagetype:''report''}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/transfer/query', 'busfw.dataexport', '{}', 'dataexport', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/transfer/query', 'header', '{}', 'header', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/transfer/query', 'bustoolbutton', '{key:''/pmkpi/perfself/query/index''}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/transfer/query', 'busqueryform', '{key:''/pmkpi/perfself/apply/index'',name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/transfer/query', 'busdclefttree', '{}', 'lefttree', 'pmkpi', null);

delete from perf_t_treetab t where t.key in('/pmkpi/perfself/transfer/query');
insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID, CONFIG)
values ('F4C91E55ADE33772E0533315A8C083EF', '/pmkpi/perfself/transfer/query', 'transprogram', '项目支出', 1, '导出部门整体自评表,导出部门整体支出绩效自评表（河北）,导出部门整体自评表（湖北）,导出部门整体支出绩效自评表(山西)', 1, '2016', '87', '97453626C11A83A453494FB4E08F3C16', 'F4A40680B92C7C1BE0533315A8C03265', null);
