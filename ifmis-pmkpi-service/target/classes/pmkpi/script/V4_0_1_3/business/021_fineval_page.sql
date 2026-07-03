begin

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/evaluation/financial/procheck');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/procheck', 'pmkpi_financialprocheck', '{}', 'financialprocheck', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/procheck', 'busuidatatable', '{key:''/pmkpi/program/report/list'',name:''项目'',checkbox:true,title:''项目'',edit:false,addrow:false,wheresql:"wfstatus=''011''"}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/procheck', 'bustoolbutton', '{key:''/pmkpi/evaluation/financial/check''}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/procheck', 'busqueryform', '{key:''/pmkpi/program/report/list'',name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);
