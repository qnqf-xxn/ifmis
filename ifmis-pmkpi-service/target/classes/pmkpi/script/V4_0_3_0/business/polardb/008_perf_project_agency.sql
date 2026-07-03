begin

execute immediate '
create or replace view v_perf_project_agency as
select *
from perf_project_agency where province = global_multyear_cz.v_pmdivid';
