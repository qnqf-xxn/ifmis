begin
  
execute immediate '
create or replace view v_perf_t_datasource as
select * 
from perf_t_datasource t where t.status=1 order by ordernum';

update perf_t_datasource t set t.status=1 where t.status is null;

update fasp_t_dicdssource t set t.datasource = replace(t.datasource,'perf_t_datasource','v_perf_t_datasource') where t.datasource like'%perf_t_datasource%' and t.datasource not like'%v_perf_t_datasource%';