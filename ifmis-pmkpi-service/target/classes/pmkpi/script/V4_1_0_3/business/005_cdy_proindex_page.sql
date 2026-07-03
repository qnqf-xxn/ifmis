begin

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/program/prjindex/lastyear') and t.id='lasttable';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/prjindex/lastyear', 'busuidatatable', '{headsort:false,addrow:false,nogroupbox:true,edit:true,checkbox:true,rowtolist:false}', 'lasttable', 'pmkpi', null);

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/program/prjindex/pickindex') and t.id in('queryform','picktable');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/prjindex/pickindex', 'busqueryform', '{name:''查询区'',fastquery:true,drawmode:''table'',label:''快速查询'',labelwidth:''120'',datatable:''picktable''}', 'queryform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/prjindex/pickindex', 'busuidatatable', '{title:''挑选指标'',addrow:false,nogroupbox:false,edit:false,checkbox:true,nextSibling:false}', 'picktable', 'pmkpi', null);

update bus_t_pageconsole t set t.config='{main:[queryform,picktable],footer:[toolbutton]}' where url='/pmkpi/program/prjindex/pickindex';