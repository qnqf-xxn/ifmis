begin

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/program/prjindex/lastyear') and t.id='lasttable';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/prjindex/lastyear', 'busuidatatable', '{key:''/pmkpi/program/report/treeindex'',headsort:false,addrow:false,nogroupbox:true,edit:true,checkbox:true,rowtolist:false}', 'lasttable', 'pmkpi', null);
