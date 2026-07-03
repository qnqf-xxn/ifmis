begin

--页面配置
delete from bus_t_pageconsole where url ='/pmkpi/setting/perfcarryover';

insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/setting/perfcarryover', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.setting.perfcarryover.PerfCarryOverPage', 'index', '{header:[header],left:lefttree,main:[toolbutton,queryform,tabpage,datatable]}', null, null, 0);

delete from bus_t_pageconsolecomconfig where url ='/pmkpi/setting/perfcarryover';

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/perfcarryover', 'pmkpi_perfcarryover', '{}', 'perfcarryover', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/perfcarryover', 'header', '{}', 'header', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/perfcarryover', 'busdclefttree', '{}', 'lefttree', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/perfcarryover', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/perfcarryover', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/perfcarryover', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/perfcarryover', 'busuidatatable', '{name:''绩效结转'',checkbox:true,edit:false,addrow:false}', 'datatable', 'pmkpi', null);

delete from bus_t_pagecomponent where id ='pmkpi_perfcarryover';

insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_perfcarryover', '绩效结转', null, '绩效结转', '/pmkpi/setting/perfcarryover/perfcarryover.js', 'Ext.lt.pmkpi.perfcarryover', 'pmkpi', 'pmkpi.perfcarryover.PerfCarryOverService');