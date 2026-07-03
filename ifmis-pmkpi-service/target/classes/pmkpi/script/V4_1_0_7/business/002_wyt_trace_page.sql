begin
  --监控任务布置页面添加快速查询
update bus_t_pageconsole t set t.config ='{main:[tabpage,queryform,datatable],footer:[toolbutton]}' where t.url='/pmkpi/program/trace/manage/deptlist';
update bus_t_pageconsole t set t.config ='{main:[tabpage,queryform,datatable],footer:[toolbutton]}' where t.url='/pmkpi/program/trace/manage/deptlistimp';
