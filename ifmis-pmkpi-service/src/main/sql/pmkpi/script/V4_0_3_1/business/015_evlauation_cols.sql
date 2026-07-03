i number;
begin
  --财政评价表增加字段
  
  --分数
  select count(*) into i from user_tab_columns t where t.table_name ='PERF_T_FINEVALUATION' and t.column_name='SCORE';
  if i=0 then
     execute immediate 'alter table PERF_T_FINEVALUATION add SCORE NUMBER(20,2)';
  end if;
  --等级
  select count(*) into i from user_tab_columns t where t.table_name ='PERF_T_FINEVALUATION' and t.column_name='GRADE';
  if i=0 then
     execute immediate 'alter table PERF_T_FINEVALUATION add GRADE VARCHAR2(200)';
  end if;
  --绩效评价指标情况
  select count(*) into i from user_tab_columns t where t.table_name ='PERF_T_FINEVALUATION' and t.column_name='INDEXEVALUATION';
  if i=0 then
     execute immediate 'alter table PERF_T_FINEVALUATION add INDEXEVALUATION VARCHAR2(2000)';
  end if;
  
  
  --重构视图
  execute immediate'
  create or replace view v_perf_t_finevaluation as
select *
    from PERF_T_FINEVALUATION t where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
        and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';
