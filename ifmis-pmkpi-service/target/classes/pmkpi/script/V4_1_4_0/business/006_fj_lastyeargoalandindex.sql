begin

delete from bus_t_pageconsole t where t.url in('/pmkpi/adjust/report/proedit/goal');

insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/adjust/report/proedit/goal', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.adjust.goal.AdjustGoalPage', 'index', '{main:[toolbutton,editform]}', null, null, 0);

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/adjust/report/proedit/goal') and id ='toolbutton';

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/report/proedit/goal', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

delete from p#busfw_t_uifunction where key = '/pmkpi/adjust/report/proedit/goal' and code ='lastyeargoal';

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/adjust/report/proedit/goal', '复制上年目标', 0, 9, 'keepicon', 'adjustgoal.lastyeargoal', null, '复制上年目标', 'pmkpi', 'lastyeargoal', null,null, '87', '2016');

delete from p#busfw_t_uifunction where key = '/pmkpi/adjust/report/proedit/index' and code ='lastyear';

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/adjust/report/proedit/index', '上年指标', 0, 6, 'keepicon', 'adjustindex.lastyear', null, '上年指标', 'pmkpi', 'lastyear', null, null, '87', '2016');
