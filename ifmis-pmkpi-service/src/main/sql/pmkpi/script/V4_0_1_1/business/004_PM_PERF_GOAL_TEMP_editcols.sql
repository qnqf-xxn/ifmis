i integer;
begin  
   select count(1) into i from user_tab_cols t where t.table_name='PM_PERF_GOAL_TEMP' and t.column_name='AGENCYGUID';
     if i=1 then
       execute immediate 'alter table PM_PERF_GOAL_TEMP modify AGENCYGUID varchar2(40)';
   end if;
