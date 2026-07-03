begin
-- 一般监控任务布置菜单
update bus_t_pageconsolecomconfig t set 
t.config = '{name:''绩效项目'',checkbox:true,title:''绩效项目'',edit:false,addrow:false,wheresql:''exists (select 1 from v_perf_project_info vppi where exists (select * from (select pro_code from v_bgt_pm_annual an where an.is_deleted = 2 group by an.pro_code) t2 where t2.pro_code = vppi.pro_code and t2.pro_code is not null))''}'
where t.url ='/pmkpi/program/trace/manage/prolist' and t.componentid ='busuidatatable';


