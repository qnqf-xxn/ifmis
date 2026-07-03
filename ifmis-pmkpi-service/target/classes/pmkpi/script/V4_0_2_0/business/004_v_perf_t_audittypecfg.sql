begin

execute immediate '
create or replace view v_perf_t_audittypecfg as
select t.*
from perf_t_audittypecfg t where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
  and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';
