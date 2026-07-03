begin

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/index/audit') and t.id='datatable';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/index/audit', 'busuidatatable', '{key:''/pmkpi/indexlib/deptlist'',name:''指标表'',checkbox:true,title:''指标表'',edit:false,addrow:false}', 'datatable', 'pmkpi', null);
