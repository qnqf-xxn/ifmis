begin

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/index/query','/pmkpi/index/audit') and t.componentid='busqueryform';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/index/audit', 'busqueryform', '{key:''/pmkpi/indexlib/deptlist'',name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/index/query', 'busqueryform', '{key:''/pmkpi/indexlib/deptlist'',name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/index/query') and t.componentid='busqueryform';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/index/query', 'busqueryform', '{key:''/pmkpi/indexlib/list'',name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);
