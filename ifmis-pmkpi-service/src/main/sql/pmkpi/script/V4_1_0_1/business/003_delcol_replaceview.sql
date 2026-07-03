  i number;
begin
  -- Test statements here
 
execute immediate '
create or replace view v_bgt_perf_goal_info as
select *
    from BGT_PERF_GOAL_INFO t where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
      and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and t.is_deleted=2 and t.is_backup =2';

    
    
execute immediate '
create or replace view v_bgt_perf_indicator as
select *
from BGT_PERF_INDICATOR t where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
      and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and is_deleted = 2 and t.is_backup =2';      
  

  
execute immediate '
create or replace view v_pm_perf_indicator as
select t.*
from pm_perf_indicator t where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
      and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and is_deleted = 2
    and t.is_backup = 2 and nvl(t.is_adj, 2) = 2';


    
execute immediate '
create or replace view v_pm_perf_goal_info as
select *
from pm_perf_goal_info t where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
  and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and t.is_deleted=2
  and t.is_backup = 2 and nvl(t.is_adj, 2) = 2';
  

  
execute immediate '
create or replace view v_perf_t_adjustgoal as
select *
 from perf_t_adjustgoal t
where YEAR = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'') 
and PROVINCE = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and t.is_deleted=2';



execute immediate '
create or replace view v_perf_t_adjustindex as
select *
 from PERF_T_ADJUSTINDEX t
where YEAR = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'') and PROVINCE = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and t.is_deleted=2';    



execute immediate '
create or replace view v_pm_perf_indicator_temp as
select *
FROM pm_perf_indicator_temp 
WHERE province = global_multyear_cz.secu_f_global_parm(''DIVID'') and is_deleted = 2';



execute immediate '
create or replace view v_pm_perf_goal_temp as
select *
FROM pm_perf_goal_temp  
WHERE province = global_multyear_cz.secu_f_global_parm(''DIVID'') and is_deleted =2';




execute immediate '
create or replace view v_perf_provision_indicator as
select *
from PERF_PROVISION_INDICATOR where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
      and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and is_deleted = 2';
    

    
    
execute immediate '
create or replace view v_perf_provision_goal_info as
select *
from PERF_PROVISION_GOAL_INFO t where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
  and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and t.is_deleted=2';
  

  
  
execute immediate '
create or replace view v_perf_transfer_indicator as
select *
from perf_transfer_indicator where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
      and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and is_deleted = 2';
    
    
execute immediate '
create or replace view v_perf_transfer_goal as
select *
from perf_transfer_goal t where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
  and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and t.is_deleted=2';
  
  

