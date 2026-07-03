
i integer;
begin


   select count(1) into i from user_tab_cols t where t.table_name='PERF_TMP_EDITFORMAL' and t.column_name='VALUE';
     if i=1 then
       execute immediate 'alter table PERF_TMP_EDITFORMAL modify VALUE VARCHAR2(4000)';
     end if;
