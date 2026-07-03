begin
  
execute immediate '
create or replace view v_perf_t_adjustgoal as
select *
 from PERF_T_ADJUSTGOAL t
where YEAR = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'') 
and PROVINCE = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and t.is_deleted=2 and t.sub_mof_div_code is null';

execute immediate '
create or replace view v_perf_t_adjustindex as
select *
 from PERF_T_ADJUSTINDEX t
where YEAR = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'') 
and PROVINCE = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and t.is_deleted=2 and t.sub_mof_div_code is null';

execute immediate '
create or replace view v_perf_t_adjustallgoal as
select *
 from PERF_T_ADJUSTGOAL t
where YEAR = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'') 
and PROVINCE = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and t.is_deleted=2';

execute immediate '
create or replace view v_perf_t_adjustallindex as
select *
 from PERF_T_ADJUSTINDEX t
where YEAR = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'') 
and PROVINCE = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and t.is_deleted=2';

