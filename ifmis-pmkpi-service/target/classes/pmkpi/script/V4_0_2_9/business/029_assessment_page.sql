begin

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/program/assessment/list');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/assessment/list', 'pmkpi_perfassessment', '{}', 'perfassessment', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/assessment/list', 'busuidatatable', '{headsort:false,addrow:false,nogroupbox:false,name:''绩效事前评估'',edit:true,checkbox:false,title:''绩效事前评估'', groupcols:[''guid'',''superid'',''name'',''levelno''],treedata:true,treemapping:null,initlevel:6,isuphide:false,editgroupdata:true,nextSibling:false,rowtolist:false}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/assessment/list', 'buseditform', '{title:''评估意见''}', 'editform', 'pmkpi', null);
