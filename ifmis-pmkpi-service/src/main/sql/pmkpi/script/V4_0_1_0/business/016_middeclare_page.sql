begin
  --年中绩效目标申报查询
delete from bus_t_pageconsole where url = '/pmkpi/midprogram/query/list';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/midprogram/query/list', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfprogrammiddle.midquery.MidProgramQueryPage', 'index', '{header:[header],left:lefttree,main:[toolbutton,queryform,datatable]}', null, null, 0);
--年中绩效目标申报填报
delete from bus_t_pageconsole where url = '/pmkpi/midprogram/report/list';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/midprogram/report/list', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfprogrammiddle.midreport.MidProgramPage', 'index', '{header:[header],left:lefttree,main:[toolbutton,queryform,tabpage,datatable]}', null, null, 0);
--年中绩效目标申报审核
delete from bus_t_pageconsole where url = '/pmkpi/midprogram/report/audit';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/midprogram/report/audit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfprogrammiddle.midaudit.MidProgramAuditPage', 'index', '{header:[header],left:lefttree,main:[toolbutton,queryform,tabpage,datatable],height:[null,null,null,null]}', null, null, 0);
--选择项目
delete from bus_t_pageconsole where url = '/pmkpi/midprogram/report/procheck';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/midprogram/report/procheck', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfprogrammiddle.midreport.MidProgramPage', 'check', '{main:[queryform,datatable],footer:[toolbutton]}', null, null, 0);
--编辑
delete from bus_t_pageconsole where url = '/pmkpi/midprogram/report/edit';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/midprogram/report/edit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfprogrammiddle.midreport.MidProgramPage', 'editindex', '{main:[tabpage,editform],footer:[toolbutton]}', null, null, 0);


--年中绩效目标申报查询
delete from bus_t_pageconsolecomconfig where url = '/pmkpi/midprogram/query/list';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/midprogram/query/list', 'pmkpi_midprogramquery', '{}', 'midprogramquery', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/midprogram/query/list', 'busuidatatable', '{name:''年中项目绩效'',checkbox:true,title:''年中项目绩效'',edit:false,addrow:false,uikey:''/pmkpi/midprogram/report/edit''}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/midprogram/query/list', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/midprogram/query/list', 'header', '{}', 'header', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/midprogram/query/list', 'buslefttree', '{}', 'lefttree', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/midprogram/query/list', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);
--年中绩效目标申报填报
delete from bus_t_pageconsolecomconfig where url = '/pmkpi/midprogram/report/list';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/midprogram/report/list', 'pmkpi_midreport', '{}', 'pmkpimidreport', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/midprogram/report/list', 'buslefttree', '{}', 'lefttree', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/midprogram/report/list', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/midprogram/report/list', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/midprogram/report/list', 'header', '{}', 'header', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/midprogram/report/list', 'busuidatatable', '{name:''年度绩效目标填报'',checkbox:true,title:''年度绩效目标填报'',edit:false,addrow:false,pagetype:''report'',uikey:''/pmkpi/midprogram/report/edit'',deltables:[v_perf_t_outpayproject,v_pm_perf_indicator]}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/midprogram/report/list', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);
--年中绩效目标申报审核

delete from bus_t_pageconsolecomconfig where url = '/pmkpi/midprogram/report/audit';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/midprogram/report/audit', 'pmkpi_midprogramaudit', '{}', 'midprogramaudit', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/midprogram/report/audit', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/midprogram/report/audit', 'buslefttree', '{}', 'lefttree', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/midprogram/report/audit', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/midprogram/report/audit', 'busuidatatable', '{name:''年中项目绩效审核'',checkbox:true,title:''年中项目绩效审核'',edit:false,addrow:false,pagetype:''audit'',uikey:''/pmkpi/midprogram/report/edit''}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/midprogram/report/audit', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/midprogram/report/audit', 'header', '{}', 'header', 'pmkpi', null);
--选择项目
delete from bus_t_pageconsolecomconfig where url = '/pmkpi/midprogram/report/procheck';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/midprogram/report/procheck', 'pmkpi_midreportcheck', '{}', 'midreportcheck', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/midprogram/report/procheck', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/midprogram/report/procheck', 'busuidatatable', '{key:''/pmkpi/program/report/list'',name:''绩效目标表'',checkbox:true,title:''绩效目标表'',edit:false,addrow:false,wheresql:''wfstatus=011''}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/midprogram/report/procheck', 'busqueryform', '{key:''/pmkpi/program/report/list'',name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

--编辑项目
delete from bus_t_pageconsolecomconfig where url = '/pmkpi/midprogram/report/edit';

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/midprogram/report/edit', 'pmkpi_midprogramedit', '{}', 'pmkpimidprogramedit', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/midprogram/report/edit', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/midprogram/report/edit', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/midprogram/report/edit', 'buseditform', '{key:''/pmkpi/program/report/edit'',title:''基础信息'',tablecode:''v_perf_project_info'',iswf:''true''}', 'editform', 'pmkpi', null);

--年中绩效目标申报查询

delete from bus_t_pagecomponent where id = 'pmkpi_midprogramquery';
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_midprogramquery', '年中项目绩效查询', null, '年中项目绩效查询', '/pmkpi/perfprogrammiddle/midquery/midprogramquery.js', 'Ext.lt.pmkpi.midperfprogram.midpqueryservice', 'pmkpi', 'pmkpi.midperfprogram.MidProgramQueryService');

--年中绩效目标申报填报

delete from bus_t_pagecomponent where id = 'pmkpi_midreport';
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_midreport', '年度绩效目标填报', null, '年度绩效目标填报', '/busfw/ltext/swfupload/jslib/fupload.js,/busfw/ltext/componentview/ltext_fileupload.js,/busfw/common/ui/ui_uploadfiles.js,/busfw/ltext/fuds-download.js,/busfw/ltext/fuds-upload.js,/pmkpi/common/fileupload.js,/pmkpi/perfprogrammiddle/midreport/proreport.js', 'Ext.lt.pmkpi.midperfprogram.midreportservice', 'pmkpi', 'pmkpi.midperfprogram.MidProgramService');

--年中绩效目标申报审核

delete from bus_t_pagecomponent where id = 'pmkpi_midprogramaudit';
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_midprogramaudit', '年中项目绩效审核', null, '年中项目绩效审核', '/pmkpi/perfprogrammiddle/midaudit/midprogramaudit.js', 'Ext.lt.pmkpi.midperfprogram.midpauditservice', 'pmkpi', 'pmkpi.midperfprogram.MidProgramAuditService');

--选择项目

delete from bus_t_pagecomponent where id = 'pmkpi_midreportcheck';
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_midreportcheck', '年中追加项目绩效目标选择项目', null, '年中追加项目绩效目标选择项目', '/pmkpi/perfprogrammiddle/midreport/midreportcheck.js', 'Ext.lt.pmkpi.midprogrm.midcheckservice', 'pmkpi', 'pmkpi.midperfprogram.MidCheckService');

--编辑项目

delete from bus_t_pagecomponent where id = 'pmkpi_midprogramedit';
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_midprogramedit', '年度项目信息编辑', null, '年度项目信息编辑', '/pmkpi/perfprogrammiddle/midreport/proreportedit.js', 'Ext.lt.pmkpi.midperfprogram.mideditservice', 'pmkpi', 'pmkpi.midperfprogram.MidProgramEdit');

