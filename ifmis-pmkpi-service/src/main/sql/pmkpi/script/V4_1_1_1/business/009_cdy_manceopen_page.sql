begin
  
delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/performanceopen/audit','/pmkpi/performanceopen/report','/pmkpi/performanceopen/query') and t.id='datatable';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/performanceopen/audit', 'busuidatatable', '{key:''/pmkpi/performanceopen/report/listquery'',name:''绩效公开表'',checkbox:true,title:''绩效公开表'',edit:true,addrow:false}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/performanceopen/query', 'busuidatatable', '{key:''/pmkpi/performanceopen/report/listquery'',name:''绩效公开表'',checkbox:true,title:''绩效公开表'',edit:true,addrow:false}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/performanceopen/report', 'busuidatatable', '{key:''/pmkpi/performanceopen/report/listquery'',name:''绩效公开表'',checkbox:true,title:''绩效公开表'',edit:true,addrow:false}', 'datatable', 'pmkpi', null);
