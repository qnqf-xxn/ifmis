begin

execute immediate '
create or replace view v_perf_t_warnset as
select t.*
from perf_t_warnset t where year = global_multyear_cz.v_pmyear
  and province = global_multyear_cz.v_pmdivid and t.status=''1''';
