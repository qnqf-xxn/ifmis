begin
  
delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/midprogram/report/audit','/pmkpi/midprogram/report/list') and t.id = 'datatable';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/midprogram/report/list', 'busuidatatable', '{key:''/pmkpi/midprogram/query/list'',name:''年度绩效目标填报'',checkbox:true,title:''年度绩效目标填报'',edit:false,addrow:false,pagetype:''report'',uikey:''/pmkpi/midprogram/report/edit'',deltables:[v_perf_t_outpayproject,v_pm_perf_indicator]}', 'datatable', 'pmkpi', null, null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/midprogram/report/audit', 'busuidatatable', '{key:''/pmkpi/midprogram/query/list'',name:''年中项目绩效审核'',checkbox:true,title:''年中项目绩效审核'',edit:false,addrow:false,pagetype:''audit'',uikey:''/pmkpi/midprogram/report/edit''}', 'datatable', 'pmkpi', null, null);

update bus_t_pageconsole t set t.consoleservice='gov.mof.fasp2.pmkpi.tabfream.TabfreamPage' where t.url in('/pmkpi/midprogram/report/edit');