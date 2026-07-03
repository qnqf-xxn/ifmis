begin

--项目
--财政部门自评列表
delete from bus_t_pageconsole t where t.url in('/pmkpi/evaluation/financial/deptassessment/list');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/evaluation/financial/deptassessment/list', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.evaluation.financial.deptfill.DeptfillPage', 'list', '{header:[header],left:lefttree,main:[toolbutton,queryform,tabpage,datatable]}', null, null, 1);

delete from bus_t_pagecomponent t where t.id in('pmkpi_findeptassessment');
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_findeptassessment', '财政评价部门自评', null, '财政评价部门自评', '/pmkpi/evaluation/financial/deptfill/deptfill.js', 'Ext.lt.pmkpi.financialevaluation.deptfill', 'pmkpi', 'pmkpi.evaluation.financial.deptfill.DeptfillService');

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/evaluation/financial/deptassessment/list');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/deptassessment/list', 'pmkpi_findeptassessment', '{}', 'findeptassessment', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/deptassessment/list', 'busdclefttree', '{}', 'lefttree', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/deptassessment/list', 'busqueryform', '{key:''/pmkpi/evaluation/financial/program'',name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/deptassessment/list', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/deptassessment/list', 'header', '{}', 'header', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/deptassessment/list', 'busuidatatable', '{key:''/pmkpi/evaluation/financial/deptassessment'',name:''财政重点评价对象'',checkbox:true,title:''财政重点评价对象'',edit:true,addrow:false}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/deptassessment/list', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

--财政部门自评编辑
delete from bus_t_pageconsole t where t.url in('/pmkpi/evaluation/financial/deptfill/proedit');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/evaluation/financial/deptfill/proedit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.tabfream.TabfreamPage', 'editindex', '{main:[tabpage,infoeditform],footer:[toolbutton]}', null, null, 0);

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/evaluation/financial/deptfill/proedit');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/deptfill/proedit', 'pmkpi_tabfreamedit', '{}', 'tabfreamedit', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/deptfill/proedit', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/deptfill/proedit', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/deptfill/proedit', 'buseditform', '{key:''/pmkpi/evaluation/finconfirm/edit'',columnsize:2,iswf:''true'',tablecode:''v_perf_t_finevaluation''}', 'infoeditform', 'pmkpi', null);

--财政部门自评评分表
delete from bus_t_pageconsole t where t.url in('/pmkpi/evaluation/financial/deptfill/score');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/evaluation/financial/deptfill/score', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.evaluation.financial.deptfill.DeptfillPage', 'score', '{main:[datatable]}', null, null, 0);

delete from bus_t_pagecomponent t where t.id in('pmkpi_deptfillscore');
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_deptfillscore', '财政评价部门自评', null, '财政评价部门自评', '/pmkpi/evaluation/financial/deptfill/deptfillscore.js', 'Ext.lt.pmkpi.financialevaluation.deptfillscore', 'pmkpi', 'pmkpi.evaluation.financial.deptfill.DeptScoreService');

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/evaluation/financial/deptfill/score');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/deptfill/score', 'pmkpi_deptfillscore', '{}', 'deptfillscore', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/deptfill/score', 'busuidatatable', '{headsort:false,addrow:false,nogroupbox:true,edit:true,checkbox:true,groupcols:[''guid'',''superid'',''name'',''levelno''],treedata:true,treemapping:null,initlevel:6,isuphide:false,editgroupdata:true,nextSibling:false}', 'datatable', 'pmkpi', null);


--部门
--财政部门自评编辑
delete from bus_t_pageconsole t where t.url in('/pmkpi/evaluation/financial/deptfill/deptedit');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/evaluation/financial/deptfill/deptedit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.tabfream.TabfreamPage', 'editindex', '{main:[tabpage,infoeditform],footer:[toolbutton]}', null, null, 0);

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/evaluation/financial/deptfill/deptedit');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/deptfill/deptedit', 'pmkpi_tabfreamedit', '{}', 'tabfreamedit', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/deptfill/deptedit', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/deptfill/deptedit', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/deptfill/deptedit', 'buseditform', '{key:''/pmkpi/evaluation/finconfirm/deptedit'',columnsize:2,iswf:''true'',tablecode:''v_perf_t_finevaluation''}', 'infoeditform', 'pmkpi', null);
