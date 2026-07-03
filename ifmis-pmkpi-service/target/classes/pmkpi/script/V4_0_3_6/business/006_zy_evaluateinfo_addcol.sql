i number;
begin
  select count(1) into i from user_tab_columns t where t.table_name='PERF_T_EVALUATEINFO' and t.column_name='EVALUATEAREA';
  if i<1 then
  execute immediate 'alter table PERF_T_EVALUATEINFO add EVALUATEAREA VARCHAR2(40)';
  end if;
  select count(1) into i from user_tab_columns t where t.table_name='PERF_T_EVALUATEINFO' and t.column_name='PERCENTILE';
  if i<1 then
  execute immediate 'alter table PERF_T_EVALUATEINFO add PERCENTILE VARCHAR2(40)';
  end if;
  
execute immediate 'create or replace view V_PERF_T_EVALUATEINFO as
select * from PERF_T_EVALUATEINFO t where t.year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
  and t.province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';
