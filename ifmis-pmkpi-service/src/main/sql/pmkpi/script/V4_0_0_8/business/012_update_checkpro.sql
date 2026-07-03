begin

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/adjust/report/procheck','/pmkpi/adjust/report/deptcheck');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/report/deptcheck', 'pmkpi_adjustreportcheck', '{}', 'adjustreportcheck', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/report/deptcheck', 'bustoolbutton', '{key:''/pmkpi/adjust/report/check''}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/report/deptcheck', 'busqueryform', '{key:''/pmkpi/deptperformance/report/index'',name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/report/deptcheck', 'busuidatatable', '{key:''/pmkpi/deptperformance/report/index'',name:''绩效目标调整表'',checkbox:true,title:''绩效目标调整表'',edit:false,addrow:false,wheresql:''wfstatus=011''}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/report/procheck', 'pmkpi_adjustreportcheck', '{}', 'adjustreportcheck', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/report/procheck', 'busuidatatable', '{key:''/pmkpi/program/report/list'',name:''绩效目标调整表'',checkbox:true,title:''绩效目标调整表'',edit:false,addrow:false,wheresql:''wfstatus=011''}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/report/procheck', 'busqueryform', '{key:''/pmkpi/program/report/list'',name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/report/procheck', 'bustoolbutton', '{key:''/pmkpi/adjust/report/check''}', 'toolbutton', 'pmkpi', null);

update p#busfw_t_uitable t set t.defquery='t.wfstatus=011' where key in('/pmkpi/program/trace/manage/deptlist','/pmkpi/program/trace/manage/prolist');
