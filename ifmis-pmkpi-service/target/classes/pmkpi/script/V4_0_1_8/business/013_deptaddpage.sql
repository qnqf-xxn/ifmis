begin
-- 部门填报 年度任务页签
delete from bus_t_pageconsole where url ='/pmkpi/deptperformance/report/perftask';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/deptperformance/report/perftask', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.deptperformance.task.DeptTaskPage', 'index', '{main:[datatable]}', null, null, 1);

delete from bus_t_pageconsolecomconfig where url ='/pmkpi/deptperformance/report/perftask';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/report/perftask', 'pmkpi_depttask', '{}', 'depttask', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/report/perftask', 'busuidatatable', '{addrow:true,headsort:false,name:''主要任务'',edit:true,checkbox:true,title:''主要任务'',initlevel:6,isuphide:false,nextSibling:false}', 'datatable', 'pmkpi', null);

delete from bus_t_pagecomponent where id ='pmkpi_depttask';
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_depttask', '年度任务', null, '年度任务', '/pmkpi/deptperformance/depttask.js', 'Ext.lt.pmkpi.depttask', 'pmkpi', 'pmkpi.deptperformance.DeptTaskService');


-- 部门填报页面
delete from bus_t_pageconsole where url ='/pmkpi/deptperformance/report/edit';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/deptperformance/report/edit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.tabfream.TabfreamPage', 'editindex', '{main:[tabpage,formaleditform,perftaskdatatable,deptgoaleditform],footer:[toolbutton]}', null, null, 0);

delete from bus_t_pageconsolecomconfig where url ='/pmkpi/deptperformance/report/edit';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/report/edit', 'busuidatatable', '{key:''/pmkpi/deptperformance/report/perftask'',addrow:true,headsort:false,name:''主要任务'',edit:true,checkbox:true,title:''主要任务'',initlevel:6,isuphide:false,nextSibling:false}  ', 'perftaskdatatable', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/report/edit', 'pmkpi_tabfreamedit', '{}', 'tabfreamedit', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/report/edit', 'busuidatatable', '{key:''/pmkpi/deptperformance/report/perftarget'',headsort:false,addrow:true,name:''年度绩效目标'',edit:true,checkbox:true,title:''年度绩效目标'',initlevel:6,isuphide:false,nextSibling:false}', 'perftargetdatatable', 'pmkpi', null);
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
values ('/pmkpi/deptperformance/report/edit', 'buseditform', '{key:''/pmkpi/deptperformance/report/deptgoal'',title:''绩效目标'',tablecode:''v_bgt_perf_goal_info''}', 'deptgoaleditform', 'pmkpi', null);



-- 页签 （新增一个页签，默认隐藏）
delete from p#busfw_t_uitabpage where key ='/pmkpi/deptperformance/report/edit' and code ='yeartask';
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('00A652FB74804776B8045BBE186B74D5', 'pmkpi', '/pmkpi/deptperformance/report/edit', '年度主要任务', 'yeartask', 0, 14, 'nomal', 'tabfreamedit.clickTabpage', null, '年度主要任务', null, null, '{url:''/pmkpi/deptperformance/report/perftask.page'',action:''depttask.save''}', null, '0', 'depttaskiframe', null, null, null, null, null, null);
