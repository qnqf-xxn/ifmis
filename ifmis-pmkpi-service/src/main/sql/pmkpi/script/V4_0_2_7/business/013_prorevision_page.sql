begin

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/prorevision/report/proedit/index');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/prorevision/report/proedit/index', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/prorevision/report/proedit/index', 'pmkpi_revisionindex', '{}', 'revisionindex', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/prorevision/report/proedit/index', 'busuidatatable', '{headsort:false,addrow:false,nogroupbox:false,name:''绩效指标'',edit:true,checkbox:true,title:''绩效指标'', groupcols:[''guid'',''superid'',''name'',''levelno''],treedata:true,treemapping:null,initlevel:6,isuphide:false,editgroupdata:true,nextSibling:false,nogroupbox:true,rowtolist:false}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/prorevision/report/proedit/index', 'bustoolbutton', '{key:''/pmkpi/prorevision/report/edit/index''}', 'toolbutton', 'pmkpi', null);
