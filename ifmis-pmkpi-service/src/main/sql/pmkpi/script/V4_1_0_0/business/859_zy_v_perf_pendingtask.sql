begin
  
execute immediate '
create or replace view v_perf_pendingtask as
select *
from PERF_PENDINGTASK t where status = 1'
;


update PERF_PENDINGTASK set status = 2 where key like '%/pmkpi/evaluation/dept%' or key like '%/pmkpi/evaluation/financial%' or key like '%/pmkpi/rectification%';