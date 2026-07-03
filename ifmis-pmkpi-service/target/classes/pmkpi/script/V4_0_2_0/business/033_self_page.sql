begin

--任务布置
delete from bus_t_pageconsole t where t.url in('/pmkpi/perfself/taskmanage');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/perfself/taskmanage', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfSelf.page.PerfSelfTaskManagePage', 'index', '{header:[header],left:lefttree,main:[toolbutton,queryform,tabpage,datatable]}', null, null, 0);

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/perfself/taskmanage');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/taskmanage', 'pmkpi_perfselftaskmanage', '{}', 'perfselfmanage', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/taskmanage', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/taskmanage', 'busuidatatable', '{name:''绩效自评下达'',checkbox:true,title:''绩效自评下达'',edit:false,addrow:false,pagetype:''report'',uikey:''/pmkpi/perfselftaskmanage/edit'',modelguid:''7453C8E782048BF5F0D9354A088C39F1'',fromtables:[''v_perf_t_projperfindex'',''v_perf_t_projperfdesc''],deltables:[''v_perf_t_selfperfindex'',''v_perf_t_selfperfdesc''],delcols:[''mainguid''],viewtabcode:''v_perf_v_selfevaltask''}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/taskmanage', 'buseditform', '{key:''/pmkpi/perfselftaskmanage/index''}', 'editform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/taskmanage', 'header', '{}', 'header', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/taskmanage', 'bustoolbutton', '{key:''/pmkpi/perfselftaskmanage/index''}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/taskmanage', 'busqueryform', '{key:''/pmkpi/perfselftaskmanage/index'',name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/taskmanage', 'busdclefttree', '{}', 'lefttree', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/taskmanage', 'busfw.dataexport', '{}', 'dataexport', null, null);

