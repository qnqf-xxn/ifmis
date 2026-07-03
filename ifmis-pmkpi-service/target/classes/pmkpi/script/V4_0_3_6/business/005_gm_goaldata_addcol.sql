i number;
begin
  select count(1) into i from user_tab_columns t where t.table_name='PERF_GOAL_DATA' and t.column_name='PROJECTKIND';
  if i<1 then
  execute immediate 'alter table PERF_GOAL_DATA add PROJECTKIND VARCHAR2(40)';
  end if;
  
  execute immediate '
  create or replace view v_perf_goal_data as select * from perf_goal_data where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
    and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')
  ';