begin

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/program/trace/report') and id='impexp';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/report', 'pmkpiimpexp', '{}', 'impexp', 'pmkpi', null);
