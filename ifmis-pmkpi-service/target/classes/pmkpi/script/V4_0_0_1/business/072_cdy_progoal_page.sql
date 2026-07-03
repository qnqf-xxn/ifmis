begin

delete from bus_t_pageconsole t where t.url in('/pmkpi/program/report/progoal');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/program/report/progoal', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfprogram.goal.PrjIndexPage', 'listpage', '{main:[editform,toolbutton,indexdatatable]}', null, null, 0);


delete from bus_t_pagecomponent t where t.id in('pmkpi_tlprogoal');
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_tlprogoal', '项目年度目标', null, '项目年度目标', '/pmkpi/perfprogram/goal/prjindex.js', 'Ext.lt.pmkpi.prjindexservice', 'pmkpi', 'pmkpi.goal.PrjIndexService');


delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/program/report/progoal');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/report/progoal', 'pmkpi_tlprogoal', '{}', 'pmkpitlproindex', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/report/progoal', 'busuidatatable', '{key:''/pmkpi/program/report/proindex'',headsort:false,addrow:false,nogroupbox:false,name:''年度绩效指标'',edit:true,checkbox:false,radio:true,title:''年度绩效指标'',indextable:''v_pm_perf_indicator'',nextSibling:false,nogroupbox:true}', 'indexdatatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/report/progoal', 'bustoolbutton', '{key:''/pmkpi/program/report/proindex''}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/report/progoal', 'buseditform', '{key:''/pmkpi/program/report/proindex''}', 'editform', 'pmkpi', null);
