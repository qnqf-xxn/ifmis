begin

--2-财政评价关联项目-page
delete from bus_t_pagecomponent where id = 'pmkpi_finprorelation';
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_finprorelation', '财政评价关联项目', null, '财政评价关联项目', '/pmkpi/evaluation/financial/relation/prorelation.js', 'Ext.lt.pmkpi.financialevaluation.prorelation', 'pmkpi', 'pmkpi.financial.relation.ProRelationService');
delete from bus_t_pageconsolecomconfig where url = '/pmkpi/evaluation/finconfirm/prorelation';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/finconfirm/prorelation', 'pmkpi_finprorelation', '{}', 'pmkpifinprorelation', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/finconfirm/prorelation', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/finconfirm/prorelation', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/finconfirm/prorelation', 'header', '{}', 'header', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/finconfirm/prorelation', 'busuidatatable', '{name:''项目基本信息'',checkbox:true,title:''项目基本信息'',edit:false,addrow:false,pagetype:''report''}', 'datatable', 'pmkpi', null);
delete from bus_t_pageconsole where url = '/pmkpi/evaluation/finconfirm/prorelation';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/evaluation/finconfirm/prorelation', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.evaluation.financial.relation.ProRelationPage', 'index', '{header:[header],main:[toolbutton,queryform,datatable]}', null, null, 0);

--3-财政评价关联项目-选择关联项目-page
delete from bus_t_pagecomponent where id = 'pmkpi_finprorelationcheck';
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_finprorelationcheck', '财政评价项目关联选择', null, '财政评价项目关联选择', '/pmkpi/evaluation/financial/relation/prorelationcheck.js', 'Ext.lt.pmkpi.financialevaluation.prorelationcheck', 'pmkpi', 'pmkpi.financial.relation.ProRelationCheckService');
delete from bus_t_pageconsolecomconfig where url = '/pmkpi/evaluation/finconfirm/prorelation/procheck';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/finconfirm/prorelation/procheck', 'pmkpi_finprorelationcheck', '{}', 'finprorelationcheck', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/finconfirm/prorelation/procheck', 'buslefttree', '{}', 'lefttree', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/finconfirm/prorelation/procheck', 'busqueryform', '{key:''/pmkpi/evaluation/finconfirm/prorelation'',name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''table'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/finconfirm/prorelation/procheck', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/finconfirm/prorelation/procheck', 'busuidatatable', '{name:''项目'',checkbox:true,title:''项目'',edit:false,addrow:false,pagetype:''report''}', 'datatable', 'pmkpi', null);
delete from bus_t_pageconsole where url = '/pmkpi/evaluation/finconfirm/prorelation/procheck';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/evaluation/finconfirm/prorelation/procheck', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.evaluation.financial.relation.ProRelationPage', 'check', '{left:lefttree,main:[datatable,queryform],footer:[toolbutton]}', null, null, 0);




