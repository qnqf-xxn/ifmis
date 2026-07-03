begin
  
update bus_t_diccolumn t set t.nullable=1 where t.tablecode='BAS_PERF_INDICATOR' and t.columncode in('VALUE_CHANGE','PRO_NAME','WFID');
