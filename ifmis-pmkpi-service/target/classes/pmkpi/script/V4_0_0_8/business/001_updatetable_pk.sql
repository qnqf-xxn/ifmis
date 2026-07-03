
i integer;
begin
  select count(*) into i from user_constraints t where t.table_name = upper('BAS_PERF_INDICATOR') and t.constraint_type = 'P';
  if i > 0 then
    execute immediate 'alter table BAS_PERF_INDICATOR
            drop constraint PK_BAS_PERF_INDICATOR cascade';
    execute immediate 'alter table BAS_PERF_INDICATOR
            add constraint PK_BAS_PERF_INDICATOR primary key (IND_ID)
            using index';
  elsif i=0 then
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
  elsif i=0 then
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
  elsif i=0 then
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
  elsif i=0 then
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
  elsif i=0 then
    execute immediate 'alter table BGT_PERF_GOAL_INFO
            add constraint PK_BGT_PERF_GOAL_INFO primary key (KPI_DEP_ID)
            using index';
  end if;
  select count(*) into i from user_indexes where table_name = 'BGT_PERF_GOAL_INFO' and index_name = 'KPIID_BGT_GOALINFO';
  if i=0 then
     execute immediate'create index KPIID_BGT_GOALINFO on BGT_PERF_GOAL_INFO(GUID, YEAR, PROVINCE)';
  end if;
  
  select count(1) into i from user_tab_cols t where t.table_name='PM_PERF_INDICATOR' and t.column_name='VALUE_DESC';
  if i=0 then
    execute immediate 'alter table PM_PERF_INDICATOR add VALUE_DESC VARCHAR2(4000)';
  end if;
  
  select count(1) into i from user_tab_cols t where t.table_name='PM_PERF_INDICATOR' and t.column_name='FROMGUID';
  if i=0 then
    execute immediate 'alter table PM_PERF_INDICATOR add FROMGUID VARCHAR2(40)';
  end if;
  
  execute immediate 'create or replace view v_perf_enum as select * FROM PERF_ENUM T
      WHERE T.PROVINCE = global_multyear_cz.Secu_f_Global_Parm(''DIVID'')';
	
  	
  DELETE FROM bus_t_Diccolumn t where t.tablecode='PM_PERF_INDICATOR' and t.columncode in ('VALUE_DESC','FROMGUID');
  insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
  values (null, null, null, '1', 'VALUE_DESC', '1', '2021', '87', 'BA70BB8D6936B4CCE053480A050AA63A', 'VALUE_DESC', 'PM_PERF_INDICATOR', '指标值说明', 'S', '2000', null, 1, 0, null, sysdate);

  insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
  values (null, null, null, '1', 'FROMGUID', '1', '2021', '87', 'BF8B3F6D9976B4E6E053470A050AA2F9', 'FROMGUID', 'PM_PERF_INDICATOR', 'FROMGUID', 'S', '40', null, 1, 0, null, sysdate);

  execute immediate 'create or replace view v_pm_perf_indicator as 
	select * FROM PM_PERF_INDICATOR T WHERE year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
    and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and is_deleted =2';
