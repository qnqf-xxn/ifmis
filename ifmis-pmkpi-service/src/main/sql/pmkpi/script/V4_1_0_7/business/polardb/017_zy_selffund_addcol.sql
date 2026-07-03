  i number;
  v_sql varchar2(2000);
  ln_i integer;
begin
  --自评预算执行情况添加字段'偏差原因'  DEVIATIONANALYSIS
  select count(*) into i from user_tab_columns t where t.table_name ='PERF_T_SELFPROFUND' and t.column_name='DEVIATIONANALYSIS';
  if i=0 then
     execute immediate 'alter table PERF_T_SELFPROFUND add DEVIATIONANALYSIS VARCHAR2(200)';
  end if;  
  
  
  --重构视图
  v_sql :='
  create or replace view V_PERF_T_SELFPROFUND as
  select t.*
  FROM perf_t_selfprofund T
  where YEAR= global_multyear_cz.v_pmyear and province = global_multyear_cz.v_pmdivid and is_deleted =2';
    select fn_alterview('V_PERF_T_SELFPROFUND',v_sql) into ln_i;
	if ln_i = 0 then
	    return;
	end if;
