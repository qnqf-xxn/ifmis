
i number;
begin
  select count(1) into i from user_tab_cols t where t.table_name = 'BGT_PERF_INDICATOR' and t.column_name='NAME';
  if i=1 then
     execute immediate'alter table BGT_PERF_INDICATOR modify name VARCHAR2(1000)';
  end if;
  update bus_t_diccolumn t set t.datalength=1000 where t.tablecode in('BGT_PERF_INDICATOR') and t.columncode='NAME';
  
  update bus_t_diccolumn t set t.datalength=20 where t.tablecode in('PM_PERF_INDICATOR') and t.columncode='CODE';
