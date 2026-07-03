i integer;
  leng integer;
begin
  execute immediate ' SELECT count(*),max(data_length) FROM user_tab_columns t where t.table_name  = ''PM_PERF_INDICATOR'' and t.column_name = ''EXPLAIN'''
   into i, leng;
  if i > 0 and leng < 500 then
     --execute immediate 'alter table PM_PERF_INDICATOR modify explain VARCHAR2(500)';
	 execute immediate 'select fn_altertablecol(''PM_PERF_INDICATOR'', ''explain'', ''VARCHAR2'', 500)';

  end if;
  execute immediate ' SELECT count(*),max(data_length) FROM user_tab_columns t where t.table_name  = ''PM_PERF_INDICATOR_TEMP'' and t.column_name = ''EXPLAIN'''
   into i, leng;
  if i > 0 and leng < 500 then
     --execute immediate 'alter table PM_PERF_INDICATOR_TEMP modify explain VARCHAR2(500)';
	 execute immediate 'select fn_altertablecol(''PM_PERF_INDICATOR_TEMP'', ''explain'', ''VARCHAR2'', 500)';

  end if;
  
  update Bus_t_Diccolumn t set t.datalength = 500 where t.tablecode = 'PM_PERF_INDICATOR' and t.columncode = 'EXPLAIN';
  update Bus_t_Diccolumn t set t.datalength = 500 where t.tablecode = 'PM_PERF_INDICATOR_TEMP' and t.columncode = 'EXPLAIN';