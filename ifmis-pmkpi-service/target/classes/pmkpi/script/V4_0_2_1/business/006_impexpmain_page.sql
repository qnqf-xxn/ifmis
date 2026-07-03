begin
--修改  V_PERF_T_IMPEXPMAIN 被换行问题
delete from bus_t_pageconsolecomconfig where URL='/pmkpi/setting/impexp/impexpmianedit';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/impexp/impexpmianedit', 'pmkpi_impexpmianedit', '{}', 'impexpmianedit', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/impexp/impexpmianedit', 'buseditform', '{title:''模板类型操作'',tablecode:''V_PERF_T_IMPEXPMAIN'',iswf:''true''}', 'editform', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/impexp/impexpmianedit', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

