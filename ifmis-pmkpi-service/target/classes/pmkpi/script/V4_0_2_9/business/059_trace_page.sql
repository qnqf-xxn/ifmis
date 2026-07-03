begin

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/protrace/thirdaudit/opinion');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/protrace/thirdaudit/opinion', 'pmkpi_tabfreamedit', '{}', 'tabfreamedit', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/protrace/thirdaudit/opinion', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/protrace/thirdaudit/opinion', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/protrace/thirdaudit/opinion', 'buseditform', '{title:''…Û∫À“‚º˚'',tablecode:''V_PERF_T_TRACETHIRDAUDIT''}', 'editform', 'pmkpi', null);
