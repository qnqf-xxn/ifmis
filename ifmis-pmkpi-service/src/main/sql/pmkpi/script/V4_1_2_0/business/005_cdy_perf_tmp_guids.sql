
i number(1);
begin
  select count(1) into i from user_tab_cols t where t.table_name='PERF_TMP_GUIDS' and t.column_name='PROVINCE';
  if i > 0 then
     execute immediate 'alter table PERF_TMP_GUIDS modify province VARCHAR2(500)';
  end if;
