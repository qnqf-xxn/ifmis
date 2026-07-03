begin

--指标页签-引用指标
delete from bus_t_pagecomponent where id = 'pmkpi_refindi';
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_refindi', '引用指标', null, '引用指标', '/pmkpi/perfprogram/prjindex/refindi.js', 'Ext.lt.pmkpi.refindiservice', 'pmkpi', 'pmkpi.prjindex.RefindiIndexService');


delete from bus_t_pageconsolecomconfig where url = '/pmkpi/program/prjindex/refindi';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/prjindex/refindi', 'pmkpi_refindi', '{}', 'pmkpirefindi', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/prjindex/refindi', 'busuidatatable', '{headsort:false,addrow:false,name:''绩效指标'',edit:true,checkbox:false,title:''绩效指标'',nogroupbox:true}', 'recomtable', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/prjindex/refindi', 'buslefttree', '{}', 'lefttree', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/prjindex/refindi', 'bustabpage', '{}', 'tab', 'pmkpi', null);
-- insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
-- values ('/pmkpi/program/prjindex/refindi', 'busqueryform', '{name:''查询区'',fastquery:true,datatable:''recomtable'',drawmode:''table'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

delete from bus_t_pageconsole where url = '/pmkpi/program/prjindex/refindi';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/program/prjindex/refindi', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfprogram.prjindex.PrjIndexPage', 'cmpage', '{header:[tab],main:[recomtable]}', null, null, 0);
