begin
  -- 绩效监控 阶段监控填报
delete from bus_t_pageconsolecomconfig where url ='/pmkpi/trace/report/proedit/warn';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/trace/report/proedit/warn', 'pmkpi_tracewarn', '{}', 'tracewarn', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/trace/report/proedit/warn', 'buseditform', '{key:''/pmkpi/trace/report/proedit/warn/goal'',title:''绩效目标完成情况''}', 'goaleditform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/trace/report/proedit/warn', 'busuidatatable', '{key:''/pmkpi/trace/report/proedit/warn/fund'',name:''预算执行情况'',edit:true,checkbox:true,title:''预算执行情况'',addrow:''false''}', 'datatable', 'pmkpi', null);


delete from bus_t_pageconsolecomconfig where url ='/pmkpi/trace/report/deptedit/warn';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/trace/report/deptedit/warn', 'pmkpi_tracewarn', '{}', 'tracewarn', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/trace/report/deptedit/warn', 'buseditform', '{key:''/pmkpi/trace/report/deptedit/warn/goal'',title:''绩效目标完成情况''}', 'goaleditform', null, null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/trace/report/deptedit/warn', 'busuidatatable', '{key:''/pmkpi/trace/report/deptedit/warn/fund'',name:''预算执行情况'',edit:true,checkbox:true,title:''预算执行情况'', addrow:''false''}', 'datatable', null, null);

