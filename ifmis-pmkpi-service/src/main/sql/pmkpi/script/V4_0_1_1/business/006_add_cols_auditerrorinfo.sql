i integer;
begin
  -- Test statements here
  select count(1) into i from user_tab_cols t where t.table_name='PERF_TMP_AUDITERRORINFO' and t.column_name='AGENCYNAME';
     if i=0 then
       execute immediate 'alter table PERF_TMP_AUDITERRORINFO add AGENCYNAME VARCHAR2(400)';
     end if;
select count(1) into i from user_tab_cols t where t.table_name='PERF_TMP_AUDITERRORINFO' and t.column_name='TABLENAME';
     if i=0 then
       execute immediate 'alter table PERF_TMP_AUDITERRORINFO add TABLENAME VARCHAR2(400)';
     end if;
select count(1) into i from user_tab_cols t where t.table_name='PERF_TMP_AUDITERRORINFO' and t.column_name='TABLECODE';
     if i=0 then
       execute immediate 'alter table PERF_TMP_AUDITERRORINFO add TABLECODE VARCHAR2(400)';
     end if;
