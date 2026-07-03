begin

delete from bus_t_pageconsole t where t.url in('/pmkpi/program/report/protabgoal');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/program/report/protabgoal', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfprogram.goal.PrjIndexPage', 'listpage', '{main:[toolbutton,tabpage,editform]}', null, null, 0);

delete from bus_T_pageconsolecomconfig where url = '/pmkpi/program/report/protabgoal' and id = 'toolbutton';
insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/report/protabgoal', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

delete from p#busfw_t_uifunction t where t.key in('/pmkpi/program/report/protabgoal') and t.code='copyyeargoal';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('CAC0FDA41F3A359BE0533315A8C0AWER', '/pmkpi/program/report/protabgoal', '复制上年绩效目标', 1, 9, 'keepicon', 'Ext.lt.pmkpi.copyyeargoal', null, '复制上年绩效目标', 'pmkpi', 'copyyeargoal', null,null);

--总体绩效目标code修改
update p#busfw_t_uitabpage t set code = 'total' where key in('/pmkpi/program/report/protabgoal') and t.code='tabgoal';
