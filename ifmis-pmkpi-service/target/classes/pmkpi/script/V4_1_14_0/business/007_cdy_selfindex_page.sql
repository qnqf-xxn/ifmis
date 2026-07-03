begin
  
delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/perfself/apply/edit/selfindex') and t.componentid in('pmkpiimpexp','busuidatatable');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/perfself/apply/edit/selfindex', 'pmkpiimpexp', '{}', 'impexp', 'pmkpi', null, null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/perfself/apply/edit/selfindex', 'busuidatatable', '{headsort:false,addrow:false,nogroupbox:true,name:''指标完成情况'',edit:true,checkbox:false,tiptitle:''指标完成情况'', groupcols:[''guid'',''superid'',''name'',''levelno''],treedata:true,treemapping:null,initlevel:6,isuphide:false,editgroupdata:true,nextSibling:false,isnegative:1,rowtolist:false}', 'datatable', 'pmkpi', null, null);