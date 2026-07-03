begin

delete from bus_t_pageconsolecomconfig t where t.url in ('/pmkpi/deptperformance/report/edit');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/report/edit', 'pmkpi_tabfreamedit', '{}', 'tabfreamedit', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/report/edit', 'buseditform', '{title:''基础信息'',tablecode:''perf_t_deptperfdeclare'',pagetype:''manceinfo'',iswf:''true''}', 'formaleditform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/report/edit', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/report/edit', 'busuidatatable', '{key:''/pmkpi/deptperformance/report/auditindex'',headsort:false,addrow:true,name:''考评一类指标'',edit:true,checkbox:true,title:''考评一类指标'',initlevel:6,isuphide:false,nextSibling:false}', 'auditindexdatatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/report/edit', 'busuidatatable', '{key:''/pmkpi/deptperformance/report/target'',headsort:false,addrow:true,name:''部门整体目标'',edit:true,checkbox:true,title:''部门整体目标'',initlevel:6,isuphide:false,nextSibling:false}', 'targetdatatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/report/edit', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/report/edit', 'busuidatatable', '{key:''/pmkpi/deptperformance/report/perftask'',headsort:false,addrow:true,name:''主要任务'',edit:true,checkbox:true,title:''主要任务'',initlevel:6,isuphide:false,nextSibling:false}', 'perftaskdatatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/report/edit', 'buseditform', '{key:''/pmkpi/deptperformance/report/deptgoal'',title:''绩效目标'',tablecode:''v_bgt_perf_goal_info''}', 'deptgoaleditform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/report/edit', 'busuidatatable', '{key:''/pmkpi/deptperformance/report/perftarget'',headsort:false,addrow:true,name:''年度绩效目标'',edit:true,checkbox:true,title:''年度绩效目标'',initlevel:6,isuphide:false,nextSibling:false}', 'perftargetdatatable', 'pmkpi', null);

delete from bus_t_pageconsolecomconfig t where t.url in ('/pmkpi/deptperformance/report/perfindex');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/report/perfindex', 'pmkpi_deptindex', '{}', 'deptindex', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/report/perfindex', 'busuidatatable', '{headsort:false,addrow:false,nogroupbox:false,name:''绩效指标'',edit:true,checkbox:true,title:''绩效指标'', groupcols:[''guid'',''superid'',''name'',''levelno''],treedata:true,treemapping:null,initlevel:6,isuphide:false,editgroupdata:true,nextSibling:false,nogroupbox:true,modelguid:''7453C8E782048BF5F0D9354A088C39F1''}', 'datatable', 'pmkpi', null);


delete from bus_t_pageconsolecomconfig t where t.url in ('/pmkpi/deptperformance/report/index');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/report/index', 'pmkpi_tabfreamlist', '{}', 'tabfreamlist', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/report/index', 'busuidatatable', '{name:''部门绩效申报'',checkbox:true,title:''部门绩效申报'',edit:false,addrow:false,pagetype:''report'',uikey:''/pmkpi/deptperformance/report/edit'',deltables:[perf_t_deptfunction,v_bgt_perf_goal_info,v_bgt_perf_indicator],repeatflag:''false''}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/report/index', 'header', '{}', 'header', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/report/index', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/report/index', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/report/index', 'buslefttree', '{}', 'lefttree', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/report/index', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);
