begin

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/review/report/list');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/review/report/list', 'pmkpi_reviewreport', '{}', 'pmkpireviewreport', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/review/report/list', 'busdclefttree', '{}', 'lefttree', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/review/report/list', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/review/report/list', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/review/report/list', 'header', '{}', 'header', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/review/report/list', 'busuidatatable', '{name:''绩效目标评审表'',checkbox:true,title:''项目绩效申报'',edit:false,addrow:false,pagetype:''report'',uikey:''/pmkpi/assess/goal/edit''}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/review/report/list', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/review/report/list', 'pmkpiimpexp', '{}', 'impexp', 'pmkpi', null);

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/review/report/proindex');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/review/report/proindex', 'pmkpi_reviewproindex', '{}', 'pmkpireviewproindex', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/review/report/proindex', 'busuidatatable', '{headsort:false,addrow:false,nogroupbox:true,edit:true,checkbox:true,groupcols:[''guid'',''superid'',''name'',''levelno''],treedata:true,treemapping:null,initlevel:6,isuphide:false,editgroupdata:true,nextSibling:false,key:''/pmkpi/program/report/treeindex'',rowtolist:false}', 'indexdatatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/review/report/proindex', 'busuidatatable', '{key:''/pmkpi/review/proreview'',edit:true,addrow:false,rowtolist:false}', 'reviewdatatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/review/report/proindex', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/review/report/proindex', 'buseditform', '{key:''/pmkpi/review/report/proindex''}', 'editform', 'pmkpi', null);

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/review/opinion/proindex');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/review/opinion/proindex', 'pmkpi_reopinionindex', '{}', 'prjtreeindex', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/review/opinion/proindex', 'bustabpage', '{key:''/pmkpi/program/report/treeindex''}', 'tabpage', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/review/opinion/proindex', 'buseditform', '{key:''/pmkpi/review/opinion/index''}', 'editform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/review/opinion/proindex', 'busuidatatable', '{key:''/pmkpi/program/report/treeindex'',headsort:false,addrow:false,nogroupbox:true,edit:true,checkbox:false,groupcols:[''guid'',''superid'',''name'',''levelno''],treedata:true,treemapping:null,initlevel:6,isuphide:false,editgroupdata:true,nextSibling:false,rowtolist:false}', 'datatable', 'pmkpi', null);
