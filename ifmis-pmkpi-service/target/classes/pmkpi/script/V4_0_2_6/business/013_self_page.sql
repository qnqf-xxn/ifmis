begin

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/perfself/apply') and t.id='impexp';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/apply', 'pmkpiimpexp', '{}', 'impexp', 'pmkpi', null);