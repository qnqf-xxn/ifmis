begin
  
update bus_t_diccolumn t set t.issys=1 where t.tablecode in('BAS_PERF_INDICATOR','PM_PERF_INDICATOR','PM_PERF_GOAL_INFO','BGT_PERF_INDICATOR','BGT_PERF_GOAL_INFO') and t.issys=0;

update bus_t_diccolumn t set t.issys=1 where t.tablecode like'PERF_T_%' and t.issys=0;
