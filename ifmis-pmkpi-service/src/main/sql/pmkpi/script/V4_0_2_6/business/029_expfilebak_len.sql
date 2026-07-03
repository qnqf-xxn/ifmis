 i number;
begin

  select count(1) into i from user_tab_cols t where t.table_name='V_PERF_T_EXPDOCMAIN_SETBAK' and t.column_name='EXPFILENAME';
     if i=1 then
       execute immediate 'alter table V_PERF_T_EXPDOCMAIN_SETBAK modify expfilename VARCHAR2(200)';
     end if;