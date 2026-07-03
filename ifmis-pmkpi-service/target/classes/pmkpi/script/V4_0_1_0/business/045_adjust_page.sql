begin

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/adjust/report/procheck');

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/report/procheck', 'pmkpi_adjustreportcheck', '{}', 'adjustreportcheck', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/report/procheck', 'busuidatatable', '{key:''/pmkpi/program/report/list'',name:''绩效目标调整表'',checkbox:true,title:''绩效目标调整表'',edit:false,addrow:false,wheresql:''wfstatus=011 and nvl(t.is_end,2)=2 and exists (select * from (select pro_code from v_bgt_pm_annual an where an.is_deleted = 2 group by an.pro_code)t2 where t2.pro_code=t.pro_code and t2.pro_code is not null)''}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/report/procheck', 'bustoolbutton', '{key:''/pmkpi/adjust/report/check''}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/report/procheck', 'busqueryform', '{key:''/pmkpi/program/report/list'',name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

