begin

execute immediate '
create or replace view v_perf_t_assessmenttemp as
select t.*
  from perf_t_assessmenttemp t
 where province = global_multyear_cz.v_pmdivid';

execute immediate '
create or replace view v_perf_t_assessment as
select t.*
  from perf_t_assessment t
 where t.is_deleted = 2
   and province = global_multyear_cz.v_pmdivid';

execute immediate '
create or replace view v_perf_t_assessmentopinion as
select t.*
  from perf_t_assessmentopinion t
 where t.is_deleted = 2
   and province = global_multyear_cz.v_pmdivid';
