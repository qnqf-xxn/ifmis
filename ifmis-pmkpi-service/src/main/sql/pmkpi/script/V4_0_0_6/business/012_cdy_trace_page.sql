begin


--绩效任务布置
delete from bus_t_pageconsole t where t.url in('/pmkpi/setting/taskset/list');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/setting/taskset/list', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.setting.taskset.TaskSetPage', 'list', '{header:[header],left:lefttree,main:[toolbutton,queryform,datatable]}', null, null, 0);

delete from bus_t_pagecomponent t where t.id in('pmkpi_tasksetlist');
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_tasksetlist', '绩效任务', null, '绩效任务', '/pmkpi/setting/taskset/tasksetservice.js', 'Ext.lt.pmkpi.tasksetservice', 'pmkpi', 'pmkpi.setting.taskset.TaskSetService');

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/setting/taskset/list');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/taskset/list', 'pmkpi_tasksetlist', '{}', 'tasksetlist', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/taskset/list', 'buslefttree', '{}', 'lefttree', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/taskset/list', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/taskset/list', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/taskset/list', 'header', '{}', 'header', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/taskset/list', 'busuidatatable', '{name:''绩效任务'',checkbox:true,title:''绩效任务'',edit:false,addrow:false}', 'datatable', 'pmkpi', null);

delete from bus_t_pageconsole t where t.url in('/pmkpi/setting/taskset/edit');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/setting/taskset/edit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.setting.taskset.TaskSetPage', 'edit', '{main:[editform],footer:[toolbutton]}', null, null, null);

delete from bus_t_pagecomponent t where t.id in('pmkpi_tasksetedit');
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_tasksetedit', '绩效任务信息编辑', null, '绩效任务信息编辑', '/pmkpi/setting/taskset/taskseteditservice.js', 'Ext.lt.pmkpi.tasksetservice', 'pmkpi', 'pmkpi.setting.taskset.TaskSetEditService');

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/setting/taskset/edit');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/taskset/edit', 'pmkpi_tasksetedit', '{}', 'tasksetedit', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/taskset/edit', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/taskset/edit', 'buseditform', '{title:''绩效任务信息'',columnsize:2}', 'editform', 'pmkpi', null);

--项目绩效监控下达
delete from bus_t_pageconsole t where t.url in('/pmkpi/program/trace/manage/tasklist','/pmkpi/program/trace/manage/prolist');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/program/trace/manage/prolist', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfprotrace.manage.ProTraceManagePage', 'prolist', '{main:[queryform,tabpage,datatable],footer:[toolbutton]}', null, null, 0);

insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/program/trace/manage/tasklist', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfprotrace.manage.ProTraceManagePage', 'tasklist', '{header:[header],left:lefttree,main:[toolbutton,queryform,datatable]}', null, null, 0);

delete from bus_t_pagecomponent t where t.id in('pmkpi_protasklist','pmkpi_protaskprolist');
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_protasklist', '项目绩效任务', null, '项目绩效任务', '/pmkpi/perfprotrace/manage/manageservice.js', 'Ext.lt.pmkpi.perfprotrace.manageservice', 'pmkpi', 'pmkpi.perfprotrace.manage.ProTraceManageService');

insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_protaskprolist', '项目绩效任务布置', null, '项目绩效任务布置', '/pmkpi/perfprotrace/manage/manageprolist.js', 'Ext.lt.pmkpi.perfprotrace.manageservice', 'pmkpi', 'pmkpi.perfprotrace.manage.ProTraceManageEditService');

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/program/trace/manage/tasklist','/pmkpi/program/trace/manage/prolist');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/manage/tasklist', 'pmkpi_protasklist', '{}', 'protasklist', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/manage/tasklist', 'buslefttree', '{}', 'lefttree', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/manage/tasklist', 'busqueryform', '{key:''/pmkpi/setting/taskset/list'', name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/manage/tasklist', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/manage/tasklist', 'header', '{}', 'header', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/manage/tasklist', 'busuidatatable', '{key:''/pmkpi/setting/taskset/list'',name:''绩效任务'',checkbox:true,title:''绩效任务'',edit:false,addrow:false}', 'datatable', 'pmkpi', null);

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


--任务复制
delete from bus_t_pageconsole t where t.url in('/pmkpi/program/tracemanage/taskcopy');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/program/tracemanage/taskcopy', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfprotrace.manage.ProTraceManagePage', 'taskcopy', '{main:[toolbutton,editform]}', null, null, 0);

delete from bus_t_pagecomponent t where t.id in('pmkpi_promanagetaskcopy');
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_promanagetaskcopy', '项目任务复制', null, '项目任务复制', '/pmkpi/perfprotrace/manage/managetaskcopy.js', 'Ext.lt.pmkpi.perfprotrace.managetaskcopy', 'pmkpi', 'pmkpi.perfprotrace.manage.ProTraceManageEditService');

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/program/tracemanage/taskcopy');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/tracemanage/taskcopy', 'pmkpi_promanagetaskcopy', '{}', 'promanagetaskcopy', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/tracemanage/taskcopy', 'buseditform', '{title:''任务信息''}', 'editform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/tracemanage/taskcopy', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

--部门布置任务
delete from bus_t_pageconsole t where t.url in('/pmkpi/program/trace/manage/deptlist');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/program/trace/manage/deptlist', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfprotrace.manage.ProTraceManagePage', 'prolist', '{main:[queryform,tabpage,datatable],footer:[toolbutton]}', null, null, 0);

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/program/trace/manage/deptlist');
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

--填报列表
delete from bus_t_pageconsole t where t.url in('/pmkpi/program/trace/report');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/program/trace/report', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfprotrace.report.ProTraceTaskPage', 'index', '{header:[header],left:lefttree,main:[toolbutton,queryform,tabpage,datatable]}', null, null, 0);

delete from bus_t_pagecomponent t where t.id in('pmkpi_protaskreport');
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_protaskreport', '项目任务列表', null, '项目任务列表', '/pmkpi/perfprotrace/report/protracetask.js', 'Ext.lt.pmkpi.perfprotrace.protracetask', 'pmkpi', 'pmkpi.perfprotrace.report.ProTraceTaskService');

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/program/trace/report');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/report', 'pmkpi_protaskreport', '{}', 'protaskreport', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/report', 'busuidatatable', '{name:''绩效运行监控'',checkbox:true,title:''绩效运行监控'',edit:false,addrow:false}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/report', 'header', '{}', 'header', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/report', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/report', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/report', 'busdclefttree', '{}', 'lefttree', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/report', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

--编辑
--项目
delete from bus_t_pageconsole t where t.url in('/pmkpi/program/trace/report/edit');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/program/trace/report/edit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.tabfream.TabfreamPage', 'editindex', '{main:[tabpage,analysisformaleditform],footer:[toolbutton]}', null, null, 0);

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/program/trace/report/edit');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/report/edit', 'pmkpi_tabfreamedit', '{}', 'tabfreamedit', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/report/edit', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/report/edit', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/report/edit', 'buseditform', '{key:''/pmkpi/program/trace/report/edit/analysis'',title:''监控分析'',tablecode:''v_perf_t_protraceanalysis''}', 'analysisformaleditform', null, null);

--基本信息
delete from bus_t_pageconsole t where t.url in('/pmkpi/program/trace/report/edit/info');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/program/trace/report/edit/info', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfprotrace.info.ProTraceInfoProPage', 'editInfo', '{main:[infoeditform,traceeditform]}', null, null, 0);

delete from bus_t_pagecomponent t where t.id in('pmkpi_protraceinfo');
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_protraceinfo', '项目绩效监控基本信息', null, '项目绩效监控基本信息', '/pmkpi/perfprotrace/info/infoservice.js', 'Ext.lt.pmkpi.protrace.infoservice', 'pmkpi', 'pmkpi.perfprotrace.info.ProTraceInfoProService');

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/program/trace/report/edit/info');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/report/edit/info', 'pmkpi_protraceinfo', '{}', 'protraceinfo', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/report/edit/info', 'buseditform', '{key:''/pmkpi/program/report/edit'',title:''项目基础信息'',tablecode:''v_perf_project_info''}', 'infoeditform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/report/edit/info', 'buseditform', '{title:''监控信息''}', 'traceeditform', 'pmkpi', null);

--预算执行情况
delete from bus_t_pageconsole t where t.url in('/pmkpi/program/trace/report/edit/fund');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/program/trace/report/edit/fund', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfprotrace.fund.ProFundPage', 'list', '{main:[datatable]}', null, null, 0);

delete from bus_t_pagecomponent t where t.id in('pmkpi_protracefund');
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_protracefund', '项目绩效监控预算执行情况', null, '项目绩效监控预算执行情况', '/pmkpi/perfprotrace/fund/fundservice.js', 'Ext.lt.pmkpi.protrace.fundservice', 'pmkpi', 'pmkpi.perfprotrace.fund.ProFundService');

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/program/trace/report/edit/fund');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/report/edit/fund', 'pmkpi_protracefund', '{}', 'tracefund', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/report/edit/fund', 'busuidatatable', '{addrow:false,name:''预算执行情况'',edit:true,checkbox:false,title:''预算执行情况''}', 'datatable', 'pmkpi', null);

--绩效指标完成情况
delete from bus_t_pageconsole t where t.url in('/pmkpi/program/trace/report/edit/indextarget');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/program/trace/report/edit/indextarget', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfprotrace.indextarget.ProIndexTargetPage', 'list', '{main:[datatable]}', null, null, 0);

delete from bus_t_pagecomponent t where t.id in('pmkpi_proindextrace');
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_proindextrace', '项目绩效监控指标', null, '项目绩效监控指标', '/pmkpi/perfprotrace/indextarget/indextargetservice.js', 'Ext.lt.pmkpi.protrace.indextarget', 'pmkpi', 'pmkpi.perfprotrace.indextarget.ProIndexTargetService');

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/program/trace/report/edit/indextarget');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/report/edit/indextarget', 'pmkpi_proindextrace', '{}', 'proindextrace', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/report/edit/indextarget', 'busuidatatable', '{headsort:false,addrow:false,nogroupbox:false,name:''绩效指标完成情况'',edit:true,checkbox:false,title:''绩效指标完成情况'', groupcols:[''guid'',''superid'',''name'',''levelno''],treedata:true,treemapping:null,initlevel:6,isuphide:false,editgroupdata:true,nextSibling:false,nogroupbox:true}', 'datatable', 'pmkpi', null);

--阶段监控填报
delete from bus_t_pageconsole t where t.url in('/pmkpi/trace/report/proedit/warn');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/trace/report/proedit/warn', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfprotrace.warn.TraceWarnPage', 'index', '{main:[datatable,goaleditform],heights:[200,null]}', null, null, 0);

delete from bus_t_pagecomponent t where t.id in('pmkpi_tracewarn');
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_tracewarn', '部门阶段监控填报', null, '部门阶段监控填报', '/pmkpi/perfprotrace/warn/warnservice.js', 'Ext.lt.pmkpi.protrace.warnservice', 'pmkpi', 'pmkpi.perfprotrace.TraceWarnService');

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/trace/report/proedit/warn');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/trace/report/proedit/warn', 'pmkpi_tracewarn', '{}', 'tracewarn', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/trace/report/proedit/warn', 'buseditform', '{key:''/pmkpi/trace/report/proedit/warn/goal'',title:''绩效目标完成情况''}', 'goaleditform', null, null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/trace/report/proedit/warn', 'busuidatatable', '{key:''/pmkpi/trace/report/proedit/warn/fund'',name:''预算执行情况'',edit:true,checkbox:false,title:''预算执行情况'', addrow:''false''}', 'datatable', null, null);


--部门
--编辑
delete from bus_t_pageconsole t where t.url in('/pmkpi/trace/report/deptedit');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/trace/report/deptedit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.tabfream.TabfreamPage', 'editindex', '{main:[tabpage],footer:[toolbutton]}', null, null, 0);

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/trace/report/deptedit');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/trace/report/deptedit', 'pmkpi_tabfreamedit', '{}', 'tabfreamedit', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/trace/report/deptedit', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/trace/report/deptedit', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/trace/report/deptedit', 'buseditform', '{key:''/pmkpi/trace/report/deptedit/analysis'',title:''监控分析'',tablecode:''v_perf_t_protraceanalysis''}', 'analysisformaleditform', null, null);

--基本信息
delete from bus_t_pageconsole t where t.url in('/pmkpi/trace/report/deptedit/info');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/trace/report/deptedit/info', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfprotrace.info.ProTraceInfoProPage', 'editInfo', '{main:[infoeditform,traceeditform]}', null, null, 0);

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/trace/report/deptedit/info');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/trace/report/deptedit/info', 'pmkpi_protraceinfo', '{}', 'protraceinfo', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/trace/report/deptedit/info', 'buseditform', '{key:''/pmkpi/deptperformance/report/edit'',title:''部门项目信息'',tablecode:''v_perf_t_deptperfdeclare''}', 'infoeditform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/trace/report/deptedit/info', 'buseditform', '{title:''监控信息''}', 'traceeditform', 'pmkpi', null);

--年度任务
delete from bus_t_pageconsole t where t.url in('/pmkpi/trace/report/deptedit/perftask');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/trace/report/deptedit/perftask', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfprotrace.dept.task.DeptTaskPage', 'list', '{main:[datatable]}', null, null, 0);

delete from bus_t_pagecomponent t where t.id in('pmkpi_tracedepttask');
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_tracedepttask', '监控部门任务', null, '监控部门任务', '/pmkpi/perfprotrace/dept/task/depttaskservice.js', 'Ext.lt.pmkpi.protrace.depttaskservice', 'pmkpi', 'pmkpi.perfprotrace.depttask.DeptTaskService');

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/trace/report/deptedit/perftask');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/trace/report/deptedit/perftask', 'pmkpi_tracedepttask', '{}', 'tracedepttask', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/trace/report/deptedit/perftask', 'busuidatatable', '{key:''/pmkpi/deptperformance/report/perftask'',name:''年度任务'',edit:false,checkbox:false,title:''年度任务'', addrow:''false''}', 'datatable', 'bdg', null);

--阶段监控填报
delete from bus_t_pageconsole t where t.url in('/pmkpi/trace/report/deptedit/warn');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/trace/report/deptedit/warn', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfprotrace.warn.TraceWarnPage', 'index', '{main:[datatable,goaleditform],heights:[200,null]}', null, null, 0);

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/trace/report/deptedit/warn');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/trace/report/deptedit/warn', 'pmkpi_tracewarn', '{}', 'tracewarn', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/trace/report/deptedit/warn', 'buseditform', '{key:''/pmkpi/trace/report/deptedit/warn/goal'',title:''绩效目标完成情况''}', 'goaleditform', null, null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/trace/report/deptedit/warn', 'busuidatatable', '{key:''/pmkpi/trace/report/deptedit/warn/fund'',name:''预算执行情况'',edit:true,checkbox:false,title:''预算执行情况'', addrow:''false''}', 'datatable', null, null);


--绩效指标调整及完成情况
delete from bus_t_pageconsole t where t.url in('/pmkpi/trace/report/deptedit/indextarget');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/trace/report/deptedit/indextarget', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfprotrace.indextarget.ProIndexTargetPage', 'list', '{main:[datatable]}', null, null, 0);

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/trace/report/deptedit/indextarget');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/trace/report/deptedit/indextarget', 'pmkpi_proindextrace', '{}', 'proindextrace', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/trace/report/deptedit/indextarget', 'busuidatatable', '{headsort:false,addrow:false,nogroupbox:false,name:''绩效指标完成情况'',edit:true,checkbox:false,title:''绩效指标完成情况'', groupcols:[''guid'',''superid'',''name'',''levelno''],treedata:true,treemapping:null,initlevel:6,isuphide:false,editgroupdata:true,nextSibling:false,nogroupbox:true}', 'datatable', 'pmkpi', null);


--审核
delete from bus_t_pageconsole t where t.url in('/pmkpi/program/trace/audit');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/program/trace/audit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfprotrace.audit.ProTraceAuditPage', 'index', '{header:[header],left:lefttree,main:[toolbutton,queryform,tabpage,datatable]}', null, null, 0);

delete from bus_t_pagecomponent t where t.id in('pmkpi_protraceaudit');
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_protraceaudit', '项目绩效监控审核', null, '项目绩效监控审核', '/pmkpi/perfprotrace/audit/protraceaudit.js', 'Ext.lt.pmkpi.perfprogram.protraceaudit', 'pmkpi', 'pmkpi.perfprotrace.audit.ProTraceAuditService');

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/program/trace/audit');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/audit', 'pmkpi_protraceaudit', '{}', 'protraceaudit', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/audit', 'busuidatatable', '{key:''/pmkpi/program/trace/report'',name:''绩效运行监控'',checkbox:true,title:''绩效运行监控'',edit:false,addrow:false}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/audit', 'header', '{}', 'header', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/audit', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/audit', 'busqueryform', '{key:''/pmkpi/program/trace/report'',name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/audit', 'busdclefttree', '{}', 'lefttree', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/audit', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

--查询
delete from bus_t_pageconsole t where t.url in('/pmkpi/program/trace/query');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/program/trace/query', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfprotrace.query.ProTraceQueryPage', 'index', '{header:[header],left:lefttree,main:[toolbutton,queryform,datatable]}', null, null, 0);

delete from bus_t_pagecomponent t where t.id in('pmkpi_protracequery');
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_protracequery', '项目绩效监控查询', null, '项目绩效监控查询', '/pmkpi/perfprotrace/query/protracequery.js', 'Ext.lt.pmkpi.perfprogram.protracequery', 'pmkpi', 'pmkpi.perfprotrace.query.ProTraceQueryService');

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/program/trace/query');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/query', 'pmkpi_protracequery', '{}', 'protracequery', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/query', 'busuidatatable', '{key:''/pmkpi/program/trace/report'',name:''绩效运行监控'',checkbox:true,title:''绩效运行监控'',edit:false,addrow:false}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/query', 'header', '{}', 'header', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/query', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/query', 'busqueryform', '{key:''/pmkpi/program/trace/report'',name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/query', 'busdclefttree', '{}', 'lefttree', 'pmkpi', null);

