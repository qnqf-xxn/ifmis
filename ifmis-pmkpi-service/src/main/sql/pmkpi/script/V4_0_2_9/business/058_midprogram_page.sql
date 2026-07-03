begin

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/evaluate/preevaluate/edit','/pmkpi/midprogram/report/edit') and t.componentid in('pmkpi_midprogramedit','preevaluateeditservice','pmkpi_tabfreamedit');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/midprogram/report/edit', 'pmkpi_tabfreamedit', '{}', 'tabfreamedit', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluate/preevaluate/edit', 'pmkpi_tabfreamedit', '{}', 'tabfreamedit', 'pmkpi', null);

update p#busfw_t_uitabpage t set t.click='tabfreamedit.clickTabpage' where t.key in('/pmkpi/evaluate/preevaluate/edit','/pmkpi/midprogram/report/edit');
