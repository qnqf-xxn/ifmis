begin
  
delete from bus_t_pageconsole t where t.url in('/pmkpi/setting/dataset/reviewtemp');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/setting/dataset/reviewtemp', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.setting.dataset.PerfDataSetPage', 'index', '{header:[header],main:[toolbutton,queryform,datatable]}', null, null, 1);

delete from bus_t_pagecomponent t where t.id in('pmkpi_perfdataset');
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_perfdataset', '绩效评估类别', null, '绩效评估类别', '/pmkpi/setting/dataset/perfdatasetservice.js', 'Ext.lt.pmkpi.perfdataset', 'pmkpi', 'pmkpi.setting.dataset.PerfDataSetService');

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/setting/dataset/reviewtemp');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/dataset/reviewtemp', 'pmkpi_perfdataset', '{}', 'perfdataset', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/dataset/reviewtemp', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/dataset/reviewtemp', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/dataset/reviewtemp', 'header', '{}', 'header', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/dataset/reviewtemp', 'busuidatatable', '{name:''绩效目标评审模板'',checkbox:true,title:''绩效目标评审模板'',edit:true,addrow:true}', 'datatable', 'pmkpi', null);
