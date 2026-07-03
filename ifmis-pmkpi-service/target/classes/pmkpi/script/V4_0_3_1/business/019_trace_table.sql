
  i number;
begin
  select count(1) into i from user_tab_cols where table_name = 'PERF_T_PROINDEXTRACE' and  column_name = 'METERUNIT';
  if i=1 then
     execute immediate 'alter table PERF_T_PROINDEXTRACE modify meterunit VARCHAR2(200)';
  end if;