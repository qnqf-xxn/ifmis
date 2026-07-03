begin

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/midprogram/report/procheck');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/midprogram/report/procheck', 'pmkpi_midreportcheck', '{}', 'midreportcheck', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/midprogram/report/procheck', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/midprogram/report/procheck', 'busuidatatable', '{key:''/pmkpi/program/report/list'',name:''绩效目标表'',checkbox:true,title:''绩效目标表'',edit:false,addrow:false}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/midprogram/report/procheck', 'busqueryform', '{key:''/pmkpi/program/report/list'',name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''table'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);
