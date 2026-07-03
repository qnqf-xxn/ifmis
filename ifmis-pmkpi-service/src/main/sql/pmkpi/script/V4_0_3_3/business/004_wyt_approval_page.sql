begin
  --绩效批复查询页面
delete from bus_t_pageconsole where url ='/pmkpi/approval/program/query';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/approval/program/query', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfprogram.approvalquery.ApprovalQueryPage', 'index', '{header:[header],left:lefttree,main:[toolbutton,queryform,datatable]}', null, null, 0);


delete from bus_t_pageconsolecomconfig where url ='/pmkpi/approval/program/query';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/approval/program/query', 'busuidatatable', '{name:''预算批复项目'',checkbox:true,title:''预算批复项目'',edit:false,addrow:false}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/approval/program/query', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/approval/program/query', 'header', '{}', 'header', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/approval/program/query', 'buslefttree', '{}', 'lefttree', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/approval/program/query', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/approval/program/query', 'pmkpi_approvalquery', '{}', 'approvalquery', 'pmkpi', null);


delete from bus_t_pagecomponent where id ='pmkpi_approvalquery';
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_approvalquery', '绩效批复查询', null, '绩效批复查询', '/pmkpi/perfprogram/approvalquery/approvalquery.js', 'Ext.lt.pmkpi.perfprogram.approvalqueryservice', 'pmkpi', 'pmkpi.perfprogram.ApprovalQueryService');



--查看详情页面
delete from bus_t_pageconsole where url ='/pmkpi/approval/query';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/approval/query', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.tabfream.TabfreamPage', 'editindex', '{main:[tabpage],footer:[toolbutton]}', null, null, 0);

delete from bus_t_pageconsolecomconfig where url ='/pmkpi/approval/query';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/approval/query', 'pmkpi_tabfreamedit', '{}', 'tabfreamedit', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/approval/query', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/approval/query', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);


--年度绩效目标页面
delete from  bus_t_pageconsole where url ='/pmkpi/approval/query/protabgoal';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/approval/query/protabgoal', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfprogram.approvalquery.goal.ApprovalGoalPage', 'listpage', '{main:[tabpage,editform]}', null, null, 0);

delete from bus_t_pageconsolecomconfig where url ='/pmkpi/approval/query/protabgoal';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/approval/query/protabgoal', 'pmkpi_approvalgoal', '{}', 'approvalgoal', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/approval/query/protabgoal', 'buseditform', '{key:''/pmkpi/program/report/protabgoal'',tablecode:''v_pm_perf_goal_info'',title:''编辑区'',iswf:''true''}', 'editform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/approval/query/protabgoal', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);


delete from bus_t_pagecomponent where id ='pmkpi_approvalgoal';
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_approvalgoal', '批复项目绩效目标(分页签)', null, '批复项目绩效目标(分页签)', '/pmkpi/perfprogram/approvalquery/approvalgoal.js', 'Ext.lt.pmkpi.approvalgoalservice', 'pmkpi', 'pmkpi.perfprogram.approvalquery.ApprovalGoalService');


--年度绩效指标页面
delete from bus_t_pageconsole where url ='/pmkpi/approval/query/treeindex';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/approval/query/treeindex', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfprogram.approvalquery.prjindex.ApprovalPrjIndexPage', 'index', '{main:[toolbutton,tabpage,datatable]}', null, null, null);


delete from bus_t_pageconsolecomconfig where url ='/pmkpi/approval/query/treeindex';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/approval/query/treeindex', 'pmkpi_approvalindex', '{}', 'approvalindex', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/approval/query/treeindex', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/approval/query/treeindex', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/approval/query/treeindex', 'busuidatatable', '{headsort:false,addrow:false,nogroupbox:true,edit:true,checkbox:true,groupcols:[''guid'',''superid'',''name'',''levelno''],treedata:true,treemapping:null,initlevel:6,isuphide:false,editgroupdata:true,nextSibling:false,key:''/pmkpi/program/report/treeindex'',nextSibling:false,rowtolist:false}', 'datatable', 'pmkpi', null);

delete from bus_t_pagecomponent where id ='pmkpi_approvalindex';
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_approvalindex', '批复项目绩效指标', null, '批复项目绩效指标', '/buscommon/fileimport/js/import.js,/pmkpi/perfprogram/approvalquery/approvalprjindex.js', 'Ext.lt.pmkpi.approvalprjindex', 'pmkpi', 'pmkpi.perfprogram.approvalquery.ApprovalPrjIndexService');

