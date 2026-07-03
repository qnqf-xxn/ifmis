begin
  
execute immediate '
create or replace view v_perf_pendingtask as
select *
from PERF_PENDINGTASK t where status = 1'
;
