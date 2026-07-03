begin
   execute immediate '
create or replace view v_perf_t_auditmain as
select *
from PERF_T_AUDITMAIN where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
  and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';

execute immediate '
create or replace view v_perf_t_deptperfdeclare as
select *
from perf_t_deptperfdeclare where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
  and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';

execute immediate '
create or replace view v_perf_t_deptfunction as
select *
from PERF_T_DEPTFUNCTION where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
  and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';

execute immediate '
create or replace view v_perf_t_auditmain as
select *
from PERF_T_AUDITMAIN where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
  and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';

execute immediate '
create or replace view v_perf_t_natrueaudittemp as
select *
from perf_t_natrueaudittemp where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
  and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';

execute immediate '
create or replace view v_perf_t_deptauditindex as
select *
from PERF_T_DEPTAUDITINDEX where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
  and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';