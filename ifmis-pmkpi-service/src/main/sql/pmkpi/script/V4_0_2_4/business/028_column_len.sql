 i number;
begin
  --À©Õ¹×Ö¶Î³¤¶È
  select count(1) into i from user_tab_cols t where t.table_name='PERF_T_TREETAB' and t.column_name='LEFTWFID';
    if i=1 then
       execute immediate 'alter table PERF_T_TREETAB modify LEFTWFID VARCHAR2(1000)';
    end if;
   
  --V_PERF_T_TREETAB_SETBAK 
  select count(1) into i from user_tab_cols t where t.table_name='V_PERF_T_TREETAB_SETBAK' and t.column_name='LEFTWFID';
   if i=1 then
      execute immediate 'alter table V_PERF_T_TREETAB_SETBAK modify LEFTWFID VARCHAR2(1000)';
   end if;