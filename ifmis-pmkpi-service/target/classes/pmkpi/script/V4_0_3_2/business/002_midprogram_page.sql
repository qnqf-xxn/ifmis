begin

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/midprogram/report/audit','/pmkpi/midprogram/report/list','/pmkpi/midprogram/query/list') and t.id='dataexport';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/midprogram/report/list', 'busfw.dataexport', '{}', 'dataexport', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/midprogram/report/audit', 'busfw.dataexport', '{}', 'dataexport', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/midprogram/query/list', 'busfw.dataexport', '{}', 'dataexport', 'pmkpi', null);
