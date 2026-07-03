begin

--绩效目标评审填报
--项目支出
delete from bus_t_pageconsole t where t.url in('/pmkpi/review/report/proedit');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/review/report/proedit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.tabfream.TabfreamPage', 'editindex', '{main:[tabpage,editform,mxdatatable],footer:[toolbutton]}', null, null, 0);

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/review/report/proedit');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/review/report/proedit', 'pmkpi_tabfreamedit', '{}', 'tabfreamedit', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/review/report/proedit', 'buseditform', '{key:''/pmkpi/program/report/proindex'',tablecode:''v_pm_perf_goal_info''}', 'goaleditform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/review/report/proedit', 'buseditform', '{key:''/pmkpi/program/report/edit'',title:''基础信息'',tablecode:''v_perf_project_info'',iswf:''true''}', 'editform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/review/report/proedit', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/review/report/proedit', 'busuidatatable', '{key:''/pmkpi/program/report/mxdatatable'',headsort:false,addrow:false,edit:false,checkbox:false''}', 'mxdatatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/review/report/proedit', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

--部门整体
delete from bus_t_pageconsole t where t.url in('/pmkpi/review/report/deptedit');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/review/report/deptedit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.tabfream.TabfreamPage', 'editindex', '{main:[tabpage,editform,mxdatatable,goaleditform],footer:[toolbutton]}', null, null, 0);

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/review/report/deptedit');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/review/report/deptedit', 'pmkpi_tabfreamedit', '{}', 'tabfreamedit', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/review/report/deptedit', 'buseditform', '{key:''/pmkpi/deptperformance/report/edit'',title:''基础信息'',tablecode:''v_perf_t_deptperfdeclare'',iswf:''true'',edit:false}', 'editform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/review/report/deptedit', 'buseditform', '{key:''/pmkpi/deptperformance/report/deptgoal'',tablecode:''v_bgt_perf_goal_info''}', 'goaleditform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/review/report/deptedit', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/review/report/deptedit', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/review/report/deptedit', 'busuidatatable', '{key:''/pmkpi/deptperformance/report/perftask'',headsort:false,addrow:false,edit:false,checkbox:false}', 'mxdatatable', 'pmkpi', null);

--指标意见审核填报
--项目支出
delete from bus_t_pageconsole t where t.url in('/pmkpi/review/report/proindex');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/review/report/proindex', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfreview.proindex.ReviewProindexPage', 'index', '{main:[tabpage,indexdatatable,reviewdatatable,editform],heights:[50,500,350,400]}', null, null, 0);

delete from bus_t_pageconsole t where t.url in('/pmkpi/review/opinion/proindex');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/review/opinion/proindex', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfreview.opinion.PerfReviewOpinionPage', 'index', '{main:[tabpage,datatable,editform]}', null, null, 0);

delete from bus_t_pagecomponent t where t.id in('pmkpi_reopinionindex');
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_reopinionindex', '项目绩效目标评审意见填报', null, '项目绩效目标评审意见填报', '/pmkpi/perfreview/opinion/opinionindex.js', 'Ext.lt.pmkpi.review.opinionservice', 'pmkpi', 'pmkpi.perfreview.opinion.PerfReviewOpinionService');

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/review/opinion/proindex');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/review/opinion/proindex', 'pmkpi_reopinionindex', '{}', 'prjtreeindex', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/review/opinion/proindex', 'bustabpage', '{key:''/pmkpi/program/report/treeindex''}', 'tabpage', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/review/opinion/proindex', 'buseditform', '{key:''/pmkpi/review/opinion/index''}', 'editform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/review/opinion/proindex', 'busuidatatable', '{key:''/pmkpi/program/report/treeindex'',headsort:false,addrow:false,nogroupbox:true,edit:true,checkbox:false,groupcols:[''guid'',''superid'',''name'',''levelno''],treedata:true,treemapping:null,initlevel:6,isuphide:false,editgroupdata:true,nextSibling:false}', 'datatable', 'pmkpi', null);

--部门整体
delete from bus_t_pageconsole t where t.url in('/pmkpi/review/opinion/deptindex');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/review/opinion/deptindex', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfreview.opinion.PerfReviewOpinionPage', 'index', '{main:[datatable,editform]}', null, null, 0);

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/review/opinion/deptindex');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/review/opinion/deptindex', 'pmkpi_reopinionindex', '{}', 'prjtreeindex', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/review/opinion/deptindex', 'buseditform', '{key:''/pmkpi/review/opinion/index''}', 'editform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/review/opinion/deptindex', 'busuidatatable', '{key:''/pmkpi/deptperformance/report/perfindex'',headsort:false,addrow:false,nogroupbox:true,edit:true,checkbox:false,groupcols:[''guid'',''superid'',''name'',''levelno''],treedata:true,treemapping:null,initlevel:6,isuphide:false,editgroupdata:true,nextSibling:false}', 'datatable', 'pmkpi', null);
