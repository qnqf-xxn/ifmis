i number;
begin
  --财政评价表增加字段
  
  --评价类型
  select count(*) into i from user_tab_columns t where t.table_name ='PERF_T_FINEVALUATION' and t.column_name='EVALUATE_TYPE';
  if i=0 then
     execute immediate 'alter table PERF_T_FINEVALUATION add EVALUATE_TYPE VARCHAR2(40)';
  end if;
  --项目资金性质
  select count(*) into i from user_tab_columns t where t.table_name ='PERF_T_FINEVALUATION' and t.column_name='FUND_TYPE_CODE';
  if i=0 then
     execute immediate 'alter table PERF_T_FINEVALUATION add FUND_TYPE_CODE VARCHAR2(40)';
  end if;
  --评价组织实施方式
  select count(*) into i from user_tab_columns t where t.table_name ='PERF_T_FINEVALUATION' and t.column_name='EVALUATE_MODE';
  if i=0 then
     execute immediate 'alter table PERF_T_FINEVALUATION add EVALUATE_MODE VARCHAR2(40)';
  end if;
  --第三方机构名称
    select count(*) into i from user_tab_columns t where t.table_name ='PERF_T_FINEVALUATION' and t.column_name='INSTITUTION_NAME';
  if i=0 then
     execute immediate 'alter table PERF_T_FINEVALUATION add INSTITUTION_NAME VARCHAR2(180)';
  end if;
  --线上线下
    select count(*) into i from user_tab_columns t where t.table_name ='PERF_T_FINEVALUATION' and t.column_name='LINES';
  if i=0 then
     execute immediate 'alter table PERF_T_FINEVALUATION add LINES VARCHAR2(40)';
  end if;
  
  
  --重构视图
  execute immediate'
  create or replace view v_perf_t_finevaluation as
select *
    from PERF_T_FINEVALUATION t where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
        and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';
