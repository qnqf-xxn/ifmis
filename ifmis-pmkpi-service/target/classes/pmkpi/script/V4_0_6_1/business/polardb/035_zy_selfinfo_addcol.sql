i number;
begin
  --自评评价基本信息表增加字段
  
  --自评得分
  select count(*) into i from user_tab_columns t where t.table_name ='PERF_T_EVALUATEINFO' and t.column_name='SELFSCORE';
  if i=0 then
     execute immediate 'alter table PERF_T_EVALUATEINFO add SELFSCORE NUMBER(20,2)';
  end if;
  
  
  --重构视图
execute immediate 'create or replace view V_PERF_T_EVALUATEINFO as
select * from PERF_T_EVALUATEINFO t where t.year = global_multyear_cz.v_pmyear and
     T.province = global_multyear_cz.v_pmdivid';
