
i number;
begin
  select count(1) into i from user_tab_columns t where t.table_name='PERF_TMP_GUIDS' and t.column_name='PROVINCE';
  if i > 0 then
	 execute immediate 'select fn_altertablecol(''PERF_TMP_GUIDS'', ''PROVINCE'', ''VARCHAR2'', 500)';
  end if;
