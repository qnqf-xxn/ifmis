i number;
begin
  select count(*) into i from user_tab_columns t where t.table_name ='PERF_T_EVALUATION' and t.column_name='PINGGUTYPE';
  if i=0 then
     execute immediate 'alter table PERF_T_EVALUATION add(PINGGUTYPE VARCHAR2(40))';
  end if;
  
  --÷ÿππ ”Õº
  execute immediate'
  create or replace view v_perf_t_evaluation as
  select *
       from PERF_T_EVALUATION
          where YEAR= global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'') and
          PROVINCE = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';
