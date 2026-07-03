  i integer;
begin
   select count(1) into i from user_tab_cols t where t.table_name='BAS_PERF_INDICATOR' and t.column_name='PERF_IND_NAME';
   if i=1 then
     execute immediate 'alter table BAS_PERF_INDICATOR modify perf_ind_name VARCHAR2(80)';
   end if;
