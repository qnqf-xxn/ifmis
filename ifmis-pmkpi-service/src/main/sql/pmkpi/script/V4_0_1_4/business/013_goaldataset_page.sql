begin
--绩效目标默认数据配置3.配置
--3-1.bus_t_pageconsolecomconfig
delete from bus_t_pageconsolecomconfig t where url ='/pmkpi/setting/goaldataset';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/goaldataset', 'pmkpi_perfdataset', '{}', 'perfdataset', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/goaldataset', 'busuidatatable', '{name:''绩效目标默认数据配置'',checkbox:true,title:''绩效目标默认数据配置'',viewtabcode:''V_PERF_GOAL_DATA'',edit:true,addrow:true,delcols:[''guid'',''province'',''year''],updatecols:[''guid'',''province'',''year'']}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/goaldataset', 'header', '{}', 'header', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/goaldataset', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/goaldataset', 'busqueryform', '{name:''查询区'',fastquery:true,datatable:''PERF_GOAL_DATA'',drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

--3-2.bus_t_pageconsole
delete from bus_t_pageconsole t where url = '/pmkpi/setting/goaldataset';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/setting/goaldataset', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.setting.dataset.PerfDataSetPage', 'index', '{header:[header],main:[toolbutton,datatable]}', null, null, 0);
