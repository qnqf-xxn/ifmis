begin

execute immediate '
create or replace view v_perf_reviewintermediary as
select * from PERF_REVIEWINTERMEDIARY
where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';

execute immediate '
create or replace view v_perf_selintermediary as
select
    m.code,m.name,m.institutional,m.creditno,m.evaluatenum, t.review,t.intermediary,t.guid
from v_perf_reviewintermediary t
left join v_perf_intermediaryinfo m on m.guid = t.intermediary';