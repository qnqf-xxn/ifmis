begin

execute immediate '
create or replace view v_pm_perf_goal_info as
select t.*
from pm_perf_goal_info t where year = global_multyear_cz.v_pmyear
  and province = global_multyear_cz.v_pmdivid and t.is_deleted=2';