begin

execute immediate '
create or replace view perf_v_promonitor_hb as
select t.*
       ,case
         when to_number(to_date(b.enddate, ''yyyymmdd'') -
                        to_date(to_char(sysdate, ''yyyymmdd''), ''yyyymmdd'')) >
              to_number(b.warndays) then
          ''black''
         when to_number(to_date(b.enddate, ''yyyymmdd'') -
                        to_date(to_char(sysdate, ''yyyymmdd''), ''yyyymmdd'')) <=
              to_number(b.warndays) then
          ''red''
         when to_date(to_char(sysdate, ''yyyymmdd''), ''yyyymmdd'') >
              to_date(b.enddate, ''yyyymmdd'') then
          ''000''
       end warn,
       to_date(b.enddate, ''yyyymmdd'') -
       to_date(to_char(sysdate, ''yyyymmdd''), ''yyyymmdd'') warndays,
       t.update_time updatetime,
       a.pro_name,
       b.taskstage,
       b.startdate,
       b.enddate,
       b.tasktype,
       b.bustype
  from v_perf_t_promonitor t
  left join v_perf_project_info a
    on t.proguid = a.guid
  left join v_perf_t_taskset b
    on b.guid = t.taskguid
 where to_date(to_char(sysdate, ''yyyymmdd''), ''yyyymmdd'') >
       to_date(b.startdate, ''yyyymmdd'') - 1'
;
