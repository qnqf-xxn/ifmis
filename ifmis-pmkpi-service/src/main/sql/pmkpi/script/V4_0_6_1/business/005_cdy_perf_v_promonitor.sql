begin
  
execute immediate'
create or replace view perf_v_promonitor as
select
    t.*
    ,case
        when to_date(to_char(sysdate, ''yyyymmdd''), ''yyyymmdd'') > to_date(b.enddate, ''yyyymmdd'') then ''000''
        when to_number(to_date(b.enddate, ''yyyymmdd'') - to_date(to_char(sysdate, ''yyyymmdd''), ''yyyymmdd'')) > to_number(b.warndays) then ''black''
        when to_number(to_date(b.enddate, ''yyyymmdd'') - to_date(to_char(sysdate, ''yyyymmdd''), ''yyyymmdd'')) <= to_number(b.warndays) then ''red''
    end warn,
    case
     when to_date(b.enddate, ''yyyymmdd'') < to_date(to_char(sysdate, ''yyyymmdd''), ''yyyymmdd'') then 0
     else to_date(b.enddate, ''yyyymmdd'') - to_date(to_char(sysdate, ''yyyymmdd''), ''yyyymmdd'')
    end as warndays,
    t.update_time as updatetime,
    b.taskstage,
    b.startdate,
    b.enddate,
    b.tasktype,
    b.bustype,
    b.name as taskname
from v_perf_t_promonitor t
left join v_perf_t_taskset b on b.guid = t.taskguid
where to_date(to_char(sysdate, ''yyyymmdd''), ''yyyymmdd'') >= to_date(b.startdate, ''yyyymmdd'') - 1';
