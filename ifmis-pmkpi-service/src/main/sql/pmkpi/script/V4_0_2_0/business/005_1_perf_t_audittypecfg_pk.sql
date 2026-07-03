
i number;
begin
  select count(*) into i from user_constraints t where t.table_name = 'PERF_T_AUDITTYPECFG' and t.constraint_type = 'P';
  if i > 0 then
    execute immediate 'alter table PERF_T_AUDITTYPECFG
    drop constraint P_PERF_T_AUDITTYPECFG cascade';
  end if;
  select count(*) into i from user_indexes t where table_name=upper('PERF_T_AUDITTYPECFG') and t.index_name='P_PERF_T_AUDITTYPECFG'; 
  if i > 0 then
      execute immediate 'drop index P_PERF_T_AUDITTYPECFG';
  end if;
  
  select count(*) into i from user_constraints t where t.table_name = 'PERF_T_AUDITTYPECFG' and t.constraint_type = 'P';
  if i = 0 then
    execute immediate 'alter table PERF_T_AUDITTYPECFG
    add constraint P_PERF_T_AUDITTYPECFG primary key (GUID, YEAR, PROVINCE)';
  end if;