begin
  update bus_t_diccolumn t set t.issys = 0 where t.TABLECODE = 'PM_PERF_GOAL_INFO' and t.columncode = 'KPI_TARGET';
  update bus_t_diccolumn t set t.issys = 0 where t.TABLECODE = 'PM_PERF_INDICATOR' and t.columncode in ('NAME','COMPUTESIGN','INDEXVAL','METERUNIT');
