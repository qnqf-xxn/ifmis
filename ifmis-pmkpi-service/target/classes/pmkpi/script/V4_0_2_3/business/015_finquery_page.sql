begin

--财政评价项目查询-page
delete from bus_t_pagecomponent where id = 'pmkpi_finevalquery';
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_finevalquery', '财政评价查询', null, '财政评价查询', '/pmkpi/evaluation/financial/query/finquery.js', 'Ext.lt.pmkpi.financialevaluation.query', 'pmkpi', 'pmkpi.evaluation.financial.query.FinancialQueryService');

delete from bus_t_pageconsolecomconfig where url = '/pmkpi/evaluation/financial/query';  
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/query', 'pmkpi_finevalquery', '{}', 'finevalquery', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/query', 'busdclefttree', '{}', 'lefttree', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/query', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/query', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/query', 'header', '{}', 'header', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/query', 'busuidatatable', '{name:''财政重点评价对象'',checkbox:true,title:''财政重点评价对象'',edit:true,addrow:false}', 'datatable', 'pmkpi', null);

delete from bus_t_pageconsole where url = '/pmkpi/evaluation/financial/query';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/evaluation/financial/query', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.evaluation.financial.query.FinancialQueryPage', 'list', '{header:[header],left:lefttree,main:[toolbutton,queryform,datatable]}', null, null, 0);


