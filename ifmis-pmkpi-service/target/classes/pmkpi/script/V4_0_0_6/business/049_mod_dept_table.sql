

  i integer;
begin
execute immediate '
create or replace view v_bgt_perf_indicator as
select *
	from bgt_perf_indicator t where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
	  and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and t.is_deleted=2';

execute immediate '
create or replace view v_bgt_perf_goal_info as
select *
from bgt_perf_goal_info t where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
  and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and t.is_deleted=2';
