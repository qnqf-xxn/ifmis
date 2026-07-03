begin
--¥¥Ω® ”Õº
execute immediate '
create or replace view v_bgt_perf_goal_info as
select * 
  from bgt_perf_goal_info t where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
    and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and t.is_deleted=2';
   
execute immediate '
create or replace view v_pm_perf_goal_info as
select *
 from pm_perf_goal_info WHERE year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
    and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and is_deleted =2';
   
execute immediate '
create or replace view v_pm_perf_indicator as
select *
  FROM PM_PERF_INDICATOR T
      WHERE year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
    and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and is_deleted =2';
    
    execute immediate '
create or replace view V_BGT_PERF_INDICATOR as
select *
  FROM BGT_PERF_INDICATOR T
      WHERE year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
    and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and is_deleted =2';
          
    execute immediate '
create or replace view V_PERF_T_ADJUSTGOAL as
select *
  FROM PERF_T_ADJUSTGOAL T
     where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
  and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';
  
      execute immediate '
create or replace view V_PERF_T_ADJUSTINDEX as
select *
  FROM PERF_T_ADJUSTINDEX T
    where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
  and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';
  
      execute immediate '
create or replace view V_BAS_PERF_INDICATOR as
select *
  FROM BAS_PERF_INDICATOR T
      WHERE  province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and is_deleted =2';
