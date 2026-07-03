begin
  -- 重构监控视图
     execute immediate'
  create or replace view perf_v_promonitor as
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
         b.taskstage,
         b.startdate,
         b.enddate,
         b.tasktype,
         b.bustype,
         b.name as taskname
    from v_perf_t_promonitor t
    left join v_perf_t_taskset b
      on b.guid = t.taskguid
   where to_date(to_char(sysdate, ''yyyymmdd''), ''yyyymmdd'') >=
         to_date(b.startdate, ''yyyymmdd'') - 1';
         
   --监控任务视图
execute immediate'create or replace view v_perf_t_taskset as
select t.*
 ,''rectifytrace'' as superguid
 from perf_t_taskset t where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
  and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';