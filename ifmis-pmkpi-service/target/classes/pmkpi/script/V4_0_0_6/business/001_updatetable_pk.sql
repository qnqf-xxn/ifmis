i integer;
begin
  select count(*) into i from user_constraints t where t.table_name = upper('BAS_PERF_INDICATOR') and t.constraint_type = 'P';
  if i > 0 then
    execute immediate 'alter table BAS_PERF_INDICATOR
            drop constraint PK_BAS_PERF_INDICATOR cascade';
    execute immediate 'alter table BAS_PERF_INDICATOR
            add constraint PK_BAS_PERF_INDICATOR primary key (IND_ID)
            using index';
  end if;
  select count(*) into i from user_indexes where table_name = 'BAS_PERF_INDICATOR' and index_name = 'IND_PERF_INDICATOR';
  if i=0 then
     execute immediate'create index IND_PERF_INDICATOR on BAS_PERF_INDICATOR(GUID, YEAR, PROVINCE)';
  end if;
  
  select count(*) into i from user_constraints t where t.table_name = upper('PM_PERF_INDICATOR') and t.constraint_type = 'P';
  if i > 0 then
    execute immediate 'alter table PM_PERF_INDICATOR
            drop constraint PK_PM_PERF_INDICATOR cascade';
    execute immediate 'alter table PM_PERF_INDICATOR
            add constraint PK_PM_PERF_INDICATOR primary key (KPI_ID)
            using index';
  end if;
  select count(*) into i from user_indexes where table_name = 'PM_PERF_INDICATOR' and index_name = 'KPIID_PM_INDICATOR';
  if i=0 then
     execute immediate'create index KPIID_PM_INDICATOR on PM_PERF_INDICATOR(GUID, YEAR, PROVINCE)';
  end if;
  
  select count(*) into i from user_constraints t where t.table_name = upper('PM_PERF_GOAL_INFO') and t.constraint_type = 'P';
  if i > 0 then
    execute immediate 'alter table PM_PERF_GOAL_INFO
            drop constraint PK_PM_PERF_GOAL_INFO cascade';
    execute immediate 'alter table PM_PERF_GOAL_INFO
            add constraint PK_PM_PERF_GOAL_INFO primary key (KPI_PER_ID)
            using index';
  end if;
  select count(*) into i from user_indexes where table_name = 'PM_PERF_GOAL_INFO' and index_name = 'KPIID_PM_GOALINFO';
  if i=0 then
     execute immediate'create index KPIID_PM_GOALINFO on PM_PERF_GOAL_INFO(GUID, YEAR, PROVINCE)';
  end if;
  
  select count(*) into i from user_constraints t where t.table_name = upper('BGT_PERF_INDICATOR') and t.constraint_type = 'P';
  if i > 0 then
    execute immediate 'alter table BGT_PERF_INDICATOR
            drop constraint PK_BGT_PERF_INDICATOR cascade';
    execute immediate 'alter table BGT_PERF_INDICATOR
            add constraint PK_BGT_PERF_INDICATOR primary key (KPI_ID)
            using index';
  end if;
  select count(*) into i from user_indexes where table_name = 'BGT_PERF_INDICATOR' and index_name = 'KPIID_BGT_INDICATOR';
  if i=0 then
     execute immediate'create index KPIID_BGT_INDICATOR on BGT_PERF_INDICATOR(GUID, YEAR, PROVINCE)';
  end if;
  
  select count(*) into i from user_constraints t where t.table_name = upper('BGT_PERF_GOAL_INFO') and t.constraint_type = 'P';
  if i > 0 then
    execute immediate 'alter table BGT_PERF_GOAL_INFO
            drop constraint PK_BGT_PERF_GOAL_INFO cascade';
    execute immediate 'alter table BGT_PERF_GOAL_INFO
            add constraint PK_BGT_PERF_GOAL_INFO primary key (KPI_DEP_ID)
            using index';
  end if;
  select count(*) into i from user_indexes where table_name = 'BGT_PERF_GOAL_INFO' and index_name = 'KPIID_BGT_GOALINFO';
  if i=0 then
     execute immediate'create index KPIID_BGT_GOALINFO on BGT_PERF_GOAL_INFO(GUID, YEAR, PROVINCE)';
  end if;