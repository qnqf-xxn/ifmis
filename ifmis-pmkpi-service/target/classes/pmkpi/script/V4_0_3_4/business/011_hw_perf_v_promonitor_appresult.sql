    i number;
begin

--绩效监控结果应用
--视图
execute immediate '
create or replace view perf_v_promonitor_appresult as
select
    t.*,
    case
        when to_number(to_date(b.enddate, ''yyyymmdd'') - to_date(to_char(sysdate, ''yyyymmdd''), ''yyyymmdd'')) > to_number(b.warndays) then ''black''
        when to_number(to_date(b.enddate, ''yyyymmdd'') - to_date(to_char(sysdate, ''yyyymmdd''), ''yyyymmdd'')) <= to_number(b.warndays) then ''red''
        when to_date(to_char(sysdate, ''yyyymmdd''), ''yyyymmdd'') > to_date(b.enddate, ''yyyymmdd'') then ''000''
    end warn,
    case
     when to_date(b.enddate, ''yyyymmdd'') < to_date(to_char(sysdate, ''yyyymmdd''), ''yyyymmdd'') then 0
     else to_date(b.enddate, ''yyyymmdd'') - to_date(to_char(sysdate, ''yyyymmdd''), ''yyyymmdd'')
    end as warndays, --预警截止天数
    t.update_time as updatetime,
    b.taskstage,
    b.startdate,
    b.enddate,
    b.tasktype,
    b.bustype,
    b.name as taskname,
    ps.appresult_details,
    ag.name as agencyname
from
    v_perf_t_promonitor t
    left join v_perf_t_taskset b on b.guid = t.taskguid
    left join v_perf_t_protraceanalysis ps on ps.mainguid = t.guid
    left join pmkpi_fasp_t_pubagency ag on ag.guid = t.agencyguid
where
    to_date(to_char(sysdate, ''yyyymmdd''), ''yyyymmdd'') >= to_date(b.startdate, ''yyyymmdd'') - 1
';
