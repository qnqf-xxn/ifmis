begin
  
delete FROM bus_t_pageconsolecomconfig t where t.url = '/pmkpi/program/report/treeindex' and t.id = 'yeareditform';

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/report/treeindex', 'buseditform', '{}', 'yeareditform', 'pmkpi', null);