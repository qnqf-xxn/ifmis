
 i number;
begin

  select count(1) into i from user_tab_cols t where t.table_name='PERF_T_EXPDOCMAIN' and t.column_name='EXPFILENAME';
     if i=1 then
       execute immediate 'alter table PERF_T_EXPDOCMAIN modify expfilename VARCHAR2(200)';
     end if;
