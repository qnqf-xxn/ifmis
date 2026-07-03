begin

execute immediate '
create or replace view V_PERF_T_PROMONITOR as
select *
from PERF_T_PROMONITOR t where YEAR= global_multyear_cz.v_pmyear 
and PROVINCE = global_multyear_cz.v_pmdivid';
