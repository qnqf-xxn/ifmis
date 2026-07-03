begin

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/review/report/list') and t.componentid='pmkpiimpexp';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/review/report/list', 'pmkpiimpexp', '{}', 'impexp', 'pmkpi', null);

