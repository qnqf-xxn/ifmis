begin
  
update bus_t_diccolumn t set t.csid=null where t.tablecode='BAS_PERF_INDICATOR' and t.columncode='PERF_IND_NAME';

update bus_t_diccolumn t set t.nullable = 0 where t.tablecode = 'BAS_PERF_INDICATOR' and exists (select 1 from user_tab_cols a where a.table_name = 'BAS_PERF_INDICATOR' and a.nullable = 'N' and a.column_name = t.columncode);