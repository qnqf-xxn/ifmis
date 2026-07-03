begin
--绩效自评整合-page       
--1.绩效自评查询
delete from bus_t_pageconsolecomconfig where url = '/pmkpi/perfself/query';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/query', 'pmkpi_perfselfquery', '{}', 'perfselfquery', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/query', 'busuidatatable', '{name:''绩效自评查询'',key:''/pmkpi/perfself/query'',checkbox:true,title:''绩效自评查询'',edit:false,addrow:false,pagetype:''report'',deltables:[''v_perf_t_selfevaltask''],delcols:[''guid''],viewtabcode:''v_perf_v_selfevaltask'',infotablecode:''v_perf_project_info'',infosavetablecode:''v_perf_project_info''}', 'datatable', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/query', 'dataexport', '{}', 'dataexport', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/query', 'header', '{}', 'header', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/query', 'bustoolbutton', '{key:''/pmkpi/perfself/query/index''}', 'toolbutton', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/query', 'busqueryform', '{key:''/pmkpi/perfself/apply/index'',name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/query', 'busdclefttree', '{}', 'lefttree', 'pmkpi', null);

delete from bus_t_pageconsole where url = '/pmkpi/perfself/query';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/perfself/query', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfSelf.page.PerfSelfQueryPage', 'index', '{header:[header],left:lefttree,main:[toolbutton,queryform,datatable,dataexport]}', null, null, 0);

--2.绩效自评审核
delete from bus_t_pageconsolecomconfig where url = '/pmkpi/perfself/audit';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/audit', 'pmkpi_perfselfaudit', '{}', 'perfselfaudit', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/audit', 'header', '{}', 'header', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/audit', 'bustoolbutton', '{key:''/pmkpi/perfself/audit/index''}', 'toolbutton', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/audit', 'busqueryform', '{key:''/pmkpi/perfself/apply/index'',name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/audit', 'busdclefttree', '{}', 'lefttree', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/audit', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/audit', 'busuidatatable', '{name:''绩效自评审核'',key:''/pmkpi/perfself/query'',checkbox:true,title:''绩效自评审核'',edit:false,addrow:false,pagetype:''report'',savetablecode:''V_PERF_T_SELFEVALTASK''}', 'datatable', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/audit', 'dataexport', '{}', 'dataexport', 'pmkpi', null);

delete from bus_t_pageconsole where url = '/pmkpi/perfself/audit';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/perfself/audit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfSelf.page.PerfSelfAuditPage', 'index', '{header:[header],left:lefttree,main:[toolbutton,queryform,tabpage,datatable,dataexport]}', null, null, 0);


--3.自评工作布置
delete from bus_t_pageconsolecomconfig where url = '/pmkpi/perfself/taskmanage';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/taskmanage', 'pmkpi_perfselftaskmanage', '{}', 'perfselfmanage', 'pmkpi', null);
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
values ('/pmkpi/perfself/taskmanage', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/taskmanage', 'dataexport', '{}', 'dataexport', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/taskmanage', 'busuidatatable', '{name:''绩效自评下达'',checkbox:true,title:''绩效自评下达'',edit:false,addrow:false,wheresql:wfstatus=''011'',pagetype:''report'',uikey:''/pmkpi/perfselftaskmanage/edit'',modelguid:''7453C8E782048BF5F0D9354A088C39F1'',fromtables:[''v_perf_t_projperfindex'',''v_perf_t_projperfdesc''],deltables:[''v_perf_t_selfperfindex'',''v_perf_t_selfperfdesc''],delcols:[''mainguid''],viewtabcode:''v_perf_v_selfevaltask''}', 'datatable', 'pmkpi', null);

delete from bus_t_pageconsole where url = '/pmkpi/perfself/taskmanage';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/perfself/taskmanage', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfSelf.page.PerfSelfTaskManagePage', 'index', '{header:[header],left:lefttree,main:[toolbutton,queryform,tabpage,datatable,dataexport]}', null, null, 0);

--4.绩效自评填报            
delete from bus_t_pageconsolecomconfig where url = '/pmkpi/perfself/apply';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/apply', 'pmkpi_perfselfapply', '{}', 'perfselfapply', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/apply', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/apply', 'busuidatatable', '{name:''绩效自评填报'',key:''/pmkpi/perfself/query'',checkbox:true,title:''绩效自评填报'',edit:false,addrow:false,pagetype:''report'',deltables:[''v_perf_t_selfevaltask''],delcols:[''guid''],viewtabcode:''v_perf_v_selfevaltask'',infotablecode:''v_perf_project_info'',infosavetablecode:''v_perf_project_info'',busguid:''31A575D94D5C0FD937BEBD2D18C144A1_000''}', 'datatable', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/apply', 'header', '{}', 'header', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/apply', 'bustoolbutton', '{key:''/pmkpi/perfself/apply/index''}', 'toolbutton', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/apply', 'busdclefttree', '{}', 'lefttree', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/apply', 'busqueryform', '{key:''/pmkpi/perfself/apply/index'',name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/apply', 'dataexport', '{}', 'dataexport', 'pmkpi', null);

delete from bus_t_pageconsole where url = '/pmkpi/perfself/apply';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/perfself/apply', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfSelf.page.PerfSelfApplyPage', 'index', '{header:[header],left:lefttree,main:[toolbutton,queryform,tabpage,datatable,dataexport]}', null, null, 0);



