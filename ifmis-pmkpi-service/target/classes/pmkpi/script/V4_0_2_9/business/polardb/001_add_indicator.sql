i number;
begin
  --添加字段
  select count(*) into i from user_tab_cols t where t.TABLE_NAME = 'BGT_PERF_INDICATOR'  and t.COLUMN_NAME = 'KPI_VAL2023';
  if i = 0 then
     execute immediate 'alter table BGT_PERF_INDICATOR add KPI_VAL2023 VARCHAR2(1000)';
  end if;
    --添加字段
  select count(*) into i from user_tab_cols t where t.TABLE_NAME = 'PERF_BGT_LINKBGTINFO'  and t.COLUMN_NAME = 'KPI_VAL2023';
  if i = 0 then
     execute immediate 'alter table PERF_BGT_LINKBGTINFO add KPI_VAL2023 VARCHAR2(1000)';
  end if;
  
  --重构视图
  execute immediate'
  create or replace view V_BGT_PERF_INDICATOR as
	select * BGT_PERF_INDICATOR t
  WHERE t.year = global_multyear_cz.v_pmyear
  AND t.province = global_multyear_cz.v_pmdivid 
  AND t.is_deleted = 2';
  
    execute immediate'
  create or replace view V_PERF_BGT_LINKBGTINFO as
	select * from PERF_BGT_LINKBGTINFO t
  WHERE t.year = global_multyear_cz.v_pmyear
  AND t.province = global_multyear_cz.v_pmdivid 
  AND t.is_deleted <> 1';
