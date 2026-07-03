begin

delete from bus_t_pageconsolecomconfig where url in('/pmkpi/yearprogram/query/list') and id = 'dataexport';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/yearprogram/query/list', 'busfw.dataexport', '{}', 'dataexport', 'pmkpi', null);
