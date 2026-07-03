begin
  
delete from bus_t_pageconsolecomconfig where url = '/pmkpi/adjust/report/deptedit/goallist';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/report/deptedit/goallist', 'pmkpi_adjustgoallist', '{}', 'adjustgoallist', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/report/deptedit/goallist', 'busuidatatable', '{name:''绩效目标调整'',checkbox:true,title:''绩效目标调整'',edit:true,addrow:true}', 'datatable', 'pmkpi', null);


delete from bus_t_pageconsole where url = '/pmkpi/adjust/report/deptedit/goallist';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/adjust/report/deptedit/goallist', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.adjust.goal.AdjustGoalPage', 'goalindex', '{main:[datatable]}', null, null, 0);


delete from bus_t_pagecomponent where id = 'pmkpi_adjustgoallist';
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_adjustgoallist', '绩效目标调整', null, '绩效目标调整', '/pmkpi/adjust/goal/adjustgoallist.js', 'Ext.lt.pmkpi.adjust.goallistservice', 'pmkpi', 'pmkpi.adjust.goal.AdjustGoalListService');
