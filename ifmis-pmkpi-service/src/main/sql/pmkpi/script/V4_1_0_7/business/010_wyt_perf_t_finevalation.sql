i number;
begin
  --类别
  select count(*) into i from user_tab_columns t where t.table_name ='PERF_T_FINEVALUATION' and t.column_name='FUND_TYPE';
  if i=0 then
     execute immediate 'alter table PERF_T_FINEVALUATION add(FUND_TYPE varchar2(4000))';
  end if;
  
  --项目概况
   select count(*) into i from user_tab_columns t where t.table_name ='PERF_T_FINEVALUATION' and t.column_name='PRO_DESC';
  if i=0 then
     execute immediate 'alter table PERF_T_FINEVALUATION add(PRO_DESC varchar2(40))';
  end if;
  
  
  --重构视图
  execute immediate '
    create or replace view v_perf_t_finevaluation as
    select *
        from PERF_T_FINEVALUATION t where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
            and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';
