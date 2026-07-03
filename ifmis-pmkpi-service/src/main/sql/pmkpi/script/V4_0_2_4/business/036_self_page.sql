begin
--自评指标完成情况（定性指标下拉框定位不准确问题-多嵌套了一层页面 去掉  ,rowtolist:false）
--项目支出
delete from bus_t_pageconsolecomconfig where url = '/pmkpi/perfself/apply/edit/selfindex';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/apply/edit/selfindex', 'pmkpi_selfindex', '{}', 'selfindex', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/apply/edit/selfindex', 'busuidatatable', '{headsort:false,addrow:false,nogroupbox:true,name:''指标完成情况'',edit:true,checkbox:false,title:''指标完成情况'', groupcols:[''guid'',''superid'',''name'',''levelno''],treedata:true,treemapping:null,initlevel:6,isuphide:false,editgroupdata:true,nextSibling:false}', 'datatable', 'pmkpi', null);

--部门整体
delete from bus_t_pageconsolecomconfig where url = '/pmkpi/perfself/apply/editdept/selfindex';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/apply/editdept/selfindex', 'pmkpi_selfindex', '{}', 'selfindex', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/apply/editdept/selfindex', 'busuidatatable', '{headsort:false,addrow:false,nogroupbox:true,name:''指标完成情况'',edit:true,checkbox:false,title:''指标完成情况'', groupcols:[''guid'',''superid'',''name'',''levelno''],treedata:true,treemapping:null,initlevel:6,isuphide:false,editgroupdata:true,nextSibling:false}', 'datatable', 'pmkpi', null);

