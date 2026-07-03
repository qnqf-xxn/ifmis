begin
delete FROM Bus_t_Pageconsolecomconfig t where t.url in 
('/pmkpi/perfselftaskmanage/dept/index','/pmkpi/perfself/apply/dept/index','/pmkpi/perfself/apply/dept/edit',
'/pmkpi/perfself/apply/dept/edit/projinfo','/pmkpi/perfself/apply/editdept/selfindex',
'/pmkpi/perfself/apply/editdept/selfdesc','/pmkpi/perfself/audit/dept/index','/pmkpi/perfself/query/dept/index');

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/apply/dept/edit', 'pmkpi_tabfreamedit', '{}', 'tabfreamedit', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/apply/dept/edit', 'bustoolbutton', '{key:''/pmkpi/perfself/apply/edit''}', 'toolbutton', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/apply/dept/edit', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/apply/dept/edit/projinfo', 'pmkpi_selfprojinfo', '{}', 'projinfo', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/apply/dept/edit/projinfo', 'buseditform', '{key:''/pmkpi/deptperformance/report/edit'',headsort:false,name:''部门基本信息'',edit:true,title:''部门基本信息'',nextSibling:false,table:''V_PERF_T_DEPTPERFDECLARE''}', 'editform', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/apply/dept/edit/projinfo', 'buseditform', '{key:''/pmkpi/perfself/apply/projsfelvtask'',headsort:false,name:''自评信息'',edit:true,title:''自评信息'',nextSibling:false,table:''V_PERF_T_SELFEVALTASK''}', 'selfeditform', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/apply/dept/index', 'pmkpi_perfselfapply', '{}', 'perfselfapply', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/apply/dept/index', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/apply/dept/index', 'bustoolbutton', '{key:''/pmkpi/perfself/apply/index''}', 'toolbutton', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/apply/dept/index', 'header', '{}', 'header', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/apply/dept/index', 'busuidatatable', '{name:''绩效自评填报'',checkbox:true,title:''绩效自评填报'',edit:false,addrow:false,pagetype:''report'',uikey:''/pmkpi/perfself/apply/dept/edit''}', 'datatable', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/apply/dept/index', 'busqueryform', '{key:''/pmkpi/perfself/apply/index'',name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/apply/dept/index', 'buslefttree', '{}', 'lefttree', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/apply/editdept/selfdesc', 'pmkpi_selfdesc', '{}', 'selfdesc', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/apply/editdept/selfdesc', 'buseditform', '{headsort:false,name:''自评分析信息'',edit:true,title:''自评分析信息'',nextSibling:false,table:"V_PERF_T_SELFPERFDESC"}', 'editform', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/apply/editdept/selfindex', 'pmkpi_selfindex', '{}', 'selfindex', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/apply/editdept/selfindex', 'busuidatatable', '{headsort:false,addrow:false,nogroupbox:true,name:''指标完成情况'',edit:true,checkbox:false,title:''指标完成情况'', groupcols:[''guid'',''superid'',''name'',''levelno''],treedata:true,treemapping:null,initlevel:6,isuphide:false,editgroupdata:true,nextSibling:false,pagetype:''selfindex''}', 'datatable', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/audit/dept/index', 'pmkpi_perfselfaudit', '{}', 'perfselfaudit', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/audit/dept/index', 'busuidatatable', '{name:''绩效自评审核'',key:''/pmkpi/perfself/apply/dept/index'',checkbox:true,title:''绩效自评审核'',edit:false,addrow:false,pagetype:''report'',uikey:''/pmkpi/perfself/apply/dept/edit'',savetablecode:''V_PERF_T_SELFEVALTASK''}', 'datatable', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/audit/dept/index', 'buslefttree', '{}', 'lefttree', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/audit/dept/index', 'busqueryform', '{key:''/pmkpi/perfself/apply/index'',name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/audit/dept/index', 'bustoolbutton', '{key:''/pmkpi/perfself/audit/index''}', 'toolbutton', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/audit/dept/index', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/audit/dept/index', 'header', '{}', 'header', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/query/dept/index', 'pmkpi_perfselfquery', '{}', 'perfselfquery', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/query/dept/index', 'header', '{}', 'header', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/query/dept/index', 'buslefttree', '{}', 'lefttree', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/query/dept/index', 'busuidatatable', '{name:''绩效自评查询'',key:''/pmkpi/perfself/apply/dept/index'',checkbox:true,title:''绩效自评查询'',edit:false,addrow:false,pagetype:''report'',uikey:''/pmkpi/perfself/apply/dept/edit''}', 'datatable', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/query/dept/index', 'busqueryform', '{key:''/pmkpi/perfself/apply/index'',name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/query/dept/index', 'bustoolbutton', '{key:''/pmkpi/perfself/query/index''}', 'toolbutton', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfselftaskmanage/dept/index', 'pmkpi_perfselftaskmanage', '{}', 'perfselfmanage', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfselftaskmanage/dept/index', 'buseditform', '{key:''/pmkpi/perfselftaskmanage/index''}', 'editform', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfselftaskmanage/dept/index', 'busuidatatable', '{name:''绩效自评下达'',checkbox:true,title:''绩效自评下达'',edit:false,addrow:false,pagetype:''report'',uikey:''/pmkpi/perfselftaskmanage/edit'',modelguid:''7453C8E782048BF5F0D9354A088C39F1''}', 'datatable', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfselftaskmanage/dept/index', 'header', '{}', 'header', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfselftaskmanage/dept/index', 'bustoolbutton', '{key:''/pmkpi/perfselftaskmanage/index''}', 'toolbutton', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfselftaskmanage/dept/index', 'busqueryform', '{key:''/pmkpi/perfselftaskmanage/index'',name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfselftaskmanage/dept/index', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfselftaskmanage/dept/index', 'buslefttree', '{}', 'lefttree', 'pmkpi', null);

