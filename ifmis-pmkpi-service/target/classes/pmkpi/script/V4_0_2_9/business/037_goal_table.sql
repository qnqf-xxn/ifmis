
i number(1);
begin
  
  select count(1) into i from user_tab_cols t where t.table_name='PM_PERF_GOAL_INFO' and t.column_name='STATUS';
  if i=0 then
     execute immediate 'alter table PM_PERF_GOAL_INFO add STATUS NUMBER(1)';
  end if;

execute immediate '
create or replace view v_pm_perf_goal_info as
select t.*
from pm_perf_goal_info t where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
  and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and t.is_deleted=2';