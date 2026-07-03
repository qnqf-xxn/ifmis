begin
  --自评指标完成情况 组件注册 添加参数 isnegative:1，支持录入负数
--通版项目支出
delete from bus_t_pageconsolecomconfig where url ='/pmkpi/perfself/apply/edit/selfindex' and id='datatable';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/apply/edit/selfindex', 'busuidatatable', '{headsort:false,addrow:false,nogroupbox:true,name:''指标完成情况'',edit:true,checkbox:false,tiptitle:''指标完成情况'', groupcols:[''guid'',''superid'',''name'',''levelno''],treedata:true,treemapping:null,initlevel:6,isuphide:false,editgroupdata:true,nextSibling:false,isnegative:1}', 'datatable', 'pmkpi', null);

--部门整体
delete from bus_t_pageconsolecomconfig where url ='/pmkpi/perfself/apply/editdept/selfindex' and id='datatable';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/apply/editdept/selfindex', 'busuidatatable', '{headsort:false,addrow:false,nogroupbox:true,name:''指标完成情况'',edit:true,checkbox:false,title:''指标完成情况'', groupcols:[''guid'',''superid'',''name'',''levelno''],treedata:true,treemapping:null,initlevel:6,isuphide:false,editgroupdata:true,nextSibling:false,rowtolist:false,isnegative:1}', 'datatable', 'pmkpi', null);



--湖北项目支出
delete from bus_t_pageconsolecomconfig where url ='/pmkpi/perfself/apply/edit/goalandindex' and id='datatable';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/apply/edit/goalandindex', 'busuidatatable', '{headsort:false,addrow:false,nogroupbox:true,edit:true,checkbox:true,groupcols:[''guid'',''superid'',''name'',''levelno''],treedata:true,treemapping:null,initlevel:6,isuphide:false,editgroupdata:true,nextSibling:false,key:''/pmkpi/perfself/apply/edit/hbtreeindex'',nextSibling:false,rowtolist:false,isnegative:1}', 'datatable', 'pmkpi', null);

--部门整体
delete from bus_t_pageconsolecomconfig where url ='/pmkpi/perfself/apply/editdept/selfindexhb' and id='datatable';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/apply/editdept/selfindexhb', 'busuidatatable', '{key:''/pmkpi/perfself/apply/editdept/hbindex'',headsort:false,addrow:false,nogroupbox:true,edit:true,checkbox:false,groupcols:[''guid'',''superid'',''name'',''levelno''],treedata:true,treemapping:null,initlevel:6,isuphide:false,editgroupdata:true,nextSibling:false,nextSibling:false,rowtolist:false,isnegative:1}', 'datatable', 'pmkpi', null);

