i number;
begin
  --自评预算执行情况添加字段'偏差原因'  DEVIATIONANALYSIS
  select count(*) into i from user_tab_columns t where t.table_name ='PERF_T_SELFPROFUND' and t.column_name='DEVIATIONANALYSIS';
  if i=0 then
     execute immediate 'alter table PERF_T_SELFPROFUND add DEVIATIONANALYSIS VARCHAR2(200)';
  end if;  
  
  
  --重构视图
  execute immediate '
  create or replace view v_perf_t_selfprofund as
  select t.*
  FROM perf_t_selfprofund T
  where YEAR= global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'') and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and is_deleted =2
  ';
