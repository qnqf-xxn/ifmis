i number;
begin
  --监控主表添加字段  填报人
  select count(*) into i from user_tab_columns t where t.table_name ='PERF_T_PROMONITOR' and t.column_name='FILLMAN';
  if i=0 then
     execute immediate 'alter table PERF_T_PROMONITOR add(FILLMAN varchar2(200))';
  end if;
  -- 填报人联系方式
  select count(*) into i from user_tab_columns t where t.table_name ='PERF_T_PROMONITOR' and t.column_name='FILLCONTACTTYPE';
  if i=0 then
     execute immediate 'alter table PERF_T_PROMONITOR add(FILLCONTACTTYPE varchar2(200))';
  end if;
  
  --重构视图
  execute immediate'
  create or replace view v_perf_t_promonitor as
    select *
    from perf_t_promonitor t  where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
      and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';
  
    --重构视图
  execute immediate'
   create or replace view perf_v_promonitor as
    select t.*,
           case 
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
             to_date(to_char(sysdate, ''yyyymmdd''), ''yyyymmdd'') as warndays,
             t.update_time as updatetime,
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
