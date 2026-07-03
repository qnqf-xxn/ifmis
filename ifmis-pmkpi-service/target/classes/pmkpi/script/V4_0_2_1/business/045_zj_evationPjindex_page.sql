begin
delete bus_t_pageconsole where url = '/pmkpi/evation/result/edit/randomIndexEdit';

insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/evation/result/edit/randomIndexEdit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.evaluation.financial.prjindex.EvaPrjIndexPage', 'toIndex', '{header:[header],main:[datatable]}', null, null, 0);
delete bus_t_pageconsolecomconfig where url = '/pmkpi/evation/result/edit/randomIndexEdit';

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evation/result/edit/randomIndexEdit', 'pmkpi_evaprjindex', '{}', 'evaprjindex', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evation/result/edit/randomIndexEdit', 'header', '{}', 'header', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evation/result/edit/randomIndexEdit', 'busuidatatable', '{headsort:false,addrow:true,nogroupbox:false,edit:true,checkbox:true,title:''重点评价指标'', groupcols:[''guid'',''superid'',''name'',''levelno''],treedata:true,treemapping:null,initlevel:6,isuphide:false,editgroupdata:true,nextSibling:false}', 'datatable', 'pmkpi', null);

delete from bus_t_pagecomponent where id = 'pmkpi_evaprjindex';
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_evaprjindex', '财政评价指标', null, '财政评价指标', '/pmkpi/evaluation/financial/prjindex/evaPrjindex.js', 'Ext.lt.pmkpi.evaPrjindex', 'pmkpi', 'pmkpi.evaluation.EvaPrjIndexService');
