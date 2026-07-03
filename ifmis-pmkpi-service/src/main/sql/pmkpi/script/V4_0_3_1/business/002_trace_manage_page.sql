begin

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/program/trace/manage/tasklist') and t.id='datatable';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/manage/tasklist', 'busuidatatable', '{key:''/pmkpi/setting/taskset/list'',name:''绩效任务'',radio:true,title:''绩效任务'',edit:false,addrow:false}', 'datatable', 'pmkpi', null);
