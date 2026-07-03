begin
    
--reportedit	
delete FROM Bus_t_Pageconsolecomconfig t where t.url = '/pmkpi/deptTJformance/report/edit';
delete FROM Bus_t_Pageconsole t where t.url = '/pmkpi/deptTJformance/report/edit';
delete FROM Bus_t_Pagecomponent t where t.id = 'pmkpi_deptTJedit';

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptTJformance/report/edit', 'pmkpi_deptTJedit', '{}', 'pmkpideptTJedit', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptTJformance/report/edit', 'buseditform', '{key:''/pmkpi/deptperformance/report/edit'',title:''基本信息'',tablecode:''v_perf_t_deptperfdeclare'',iswf:''true''}', 'infoeditform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptTJformance/report/edit', 'busuidatatable', '{key:''/pmkpi/deptTJformance/report/perftask'',headsort:false,addrow:true,name:''主要工作任务'',edit:true,checkbox:true,tiptiptiptiptiptitle:''主要工作任务'',isuphide:false,nextSibling:false}', 'taskdatatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptTJformance/report/edit', 'busuidatatable', '{key:''/pmkpi/deptTJformance/report/deptperfgoal'',headsort:false,radio:true,addrow:true,name:''绩效目标'',edit:true,checkbox:false,tiptitle:''绩效目标'',isuphide:false,nextSibling:false,rowtolist:false}', 'perfgoaldatatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptTJformance/report/edit', 'busuidatatable', '{key:''/pmkpi/deptTJformance/report/deptperfindex'',headsort:false,addrow:false,edit:true,checkbox:true,groupcols:[''guid'',''superid'',''name'',''levelno''],treedata:true,treemapping:null,initlevel:6,isuphide:false,editgroupdata:true,nextSibling:false,nogroupbox:true,rowtolist:false}', 'perfindexdatatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptTJformance/report/edit', 'bustabpage', '{}', 'edittabpage', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptTJformance/report/edit', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);


insert into Bus_t_Pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/deptTJformance/report/edit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.deptTJformance.report.DeptTJPerfPage', 'editindex', '{main:[edittabpage,infoeditform,taskdatatable,perfgoaldatatable,perfindexdatatable],footer:[toolbutton]}', null, null, 0);

insert into Bus_t_Pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_deptTJedit', '天津部门绩效编辑', null, '天津部门绩效编辑', '/pmkpi/deptTJformance/deptTJperfedit.js', 'Ext.lt.pmkpi.deptTJperfedit', 'pmkpi', 'pmkpi.deptTJformance.DeptTJPerfEditService');


--seltask
delete FROM Bus_t_Pageconsolecomconfig t where t.url = '/pmkpi/deptTJformance/report/seltask';
delete FROM Bus_t_Pageconsole t where t.url = '/pmkpi/deptTJformance/report/seltask';
delete FROM Bus_t_Pagecomponent t where t.id = 'pmkpi_deptTJseltask';

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptTJformance/report/seltask', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptTJformance/report/seltask', 'busuidatatable', '{name:''任务列表'',radio:true,checkbox:false,title:''任务列表'',edit:false,addrow:false}', 'datatable', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptTJformance/report/seltask', 'pmkpi_deptTJseltask', '{}', 'deptTJseltask', 'pmkpi', null);

insert into Bus_t_Pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/deptTJformance/report/seltask', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.deptTJformance.report.DeptTJPerfPage', 'indextask', '{main:[datatable],footer:[toolbutton]}', null, null, 0);

insert into Bus_t_Pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_deptTJseltask', '选择任务列表', null, '选择任务列表', '/pmkpi/deptTJformance/deptTJreportseltask.js', 'Ext.lt.pmkpi.deptTJseltask', 'pmkpi', 'pmkpi.deptTJformance.DeptTJPerfService');

