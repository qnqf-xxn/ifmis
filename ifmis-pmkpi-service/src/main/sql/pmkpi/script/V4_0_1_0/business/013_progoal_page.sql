begin

delete from bus_t_pageconsole t where t.url in('/pmkpi/program/report/protabgoal');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/program/report/protabgoal', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfprogram.goal.PrjIndexPage', 'listpage', '{main:[tabpage,editform]}', null, null, 0);

delete from bus_t_pagecomponent t where t.id in('pmkpi_tlprotabgoal');
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_tlprotabgoal', '项目年度目标(分页签)', null, '项目年度目标(分页签)', '/pmkpi/perfprogram/goal/progoaltab.js', 'Ext.lt.pmkpi.prjgoalservice', 'pmkpi', 'pmkpi.goal.PrjGoalTabService');

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/program/report/protabgoal');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/report/protabgoal', 'pmkpi_tlprotabgoal', '{}', 'tlprotabgoal', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/report/protabgoal', 'buseditform', '{}', 'editform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/report/protabgoal', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

