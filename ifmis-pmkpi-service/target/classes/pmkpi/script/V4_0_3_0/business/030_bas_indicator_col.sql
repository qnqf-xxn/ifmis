i number;
begin
  --部门整体添加字段调整状态，调整前guid   ADJUSTSTATUS  ADJUSTGUID
  select count(*) into i from user_tab_columns t where t.table_name ='BAS_PERF_INDICATOR' and t.column_name='ADJUSTSTATUS';
  if i=0 then
     execute immediate 'alter table BAS_PERF_INDICATOR add ADJUSTSTATUS VARCHAR2(1)';
  end if;  
  
  select count(*) into i from user_tab_columns t where t.table_name ='BAS_PERF_INDICATOR' and t.column_name='ADJUSTGUID';
  if i=0 then
     execute immediate 'alter table BAS_PERF_INDICATOR add ADJUSTGUID VARCHAR2(40)';
  end if;  
  
  --重构视图
  execute immediate '
  create or replace view v_bas_perf_indicator as
  select t.*
  FROM BAS_PERF_INDICATOR T
  WHERE province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and is_deleted =2
  ';
