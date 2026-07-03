begin

execute immediate'
create or replace view perf_v_promonitor_appresult as
select
    t.*
    ,t.update_time as updatetime,
    b.taskstage,
    b.tasktype,
    b.bustype,
    ps.appresult_details
from
    v_perf_t_promonitor t
    left join v_perf_t_taskset b on b.guid = t.taskguid
    left join v_perf_t_protraceanalysis ps on ps.mainguid = t.guid';
