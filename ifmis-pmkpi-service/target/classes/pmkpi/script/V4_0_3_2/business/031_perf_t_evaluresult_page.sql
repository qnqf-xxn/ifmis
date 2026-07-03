begin
--财政评价成果上传--结果应用情况--页签
--page
delete from bus_t_pagecomponent where id = 'pmkpi_evaluresult';
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_evaluresult', '结果应用情况', null, '结果应用情况', '/pmkpi/evaluation/financial/evaluresult/evaluresult.js', 'Ext.lt.pmkpi.evaluresult', 'pmkpi', 'pmkpi.evaluation.financial.evaluresult.EvaluResultService');

delete from bus_t_pageconsolecomconfig where url = '/pmkpi/evaluation/financial/evaluresult';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/evaluresult', 'pmkpi_evaluresult', '{}', 'evaluresult', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/evaluresult', 'buseditform', '{headsort:false,name:''结果应用情况'',edit:true,title:''结果应用情况'',nextSibling:false,table:"v_perf_t_evaluresult"}', 'editform', 'pmkpi', null);

delete from bus_t_pageconsole where url = '/pmkpi/evaluation/financial/evaluresult';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/evaluation/financial/evaluresult', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.evaluation.financial.evaluresult.EvaluResultPage', 'index', '{main:[editform]}', null, null, 0);






