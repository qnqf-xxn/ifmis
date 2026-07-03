i integer;
begin
  -- Test statements here
  select count(1) into i from user_tab_cols t where t.table_name='PERF_TMP_AUDITERRORINFO' and t.column_name='AUDITNAME';
     if i=0 then
       execute immediate 'alter table PERF_TMP_AUDITERRORINFO add AUDITNAME VARCHAR2(400)';
     end if;
select count(1) into i from user_tab_cols t where t.table_name='PERF_TMP_AUDITERRORINFO' and t.column_name='ALARMLEVELS';
     if i=0 then
       execute immediate 'alter table PERF_TMP_AUDITERRORINFO add ALARMLEVELS VARCHAR2(400)';
     end if;
