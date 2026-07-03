
i number(9);
begin 
  
  select count(1) into i from user_tab_cols where table_name = upper('PERF_T_PROMONITOR') and column_name = upper('PRO_CODE');
if i = 0 then
     execute immediate 'alter table PERF_T_PROMONITOR add PRO_CODE varchar2(40)';
  end if;


execute immediate '
create or replace view v_perf_t_promonitor as
select *
from perf_t_promonitor t where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
  and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';

execute immediate '
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
    on t.pro_code = a.pro_code
  left join v_perf_t_taskset b
    on b.guid = t.taskguid
 where to_date(to_char(sysdate, ''yyyymmdd''), ''yyyymmdd'') >
       to_date(b.startdate, ''yyyymmdd'') - 1';


execute immediate '
create or replace view perf_v_promonitor_hb as
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
       to_date(b.startdate, ''yyyymmdd'') - 1';

delete from bus_t_diccolumn t where t.tablecode='PERF_T_PROMONITOR' and t.dbcolumncode in('PRO_CODE');
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'PRO_CODE', '1', '2020', '87', 'CA599D63DFDB3146E0533315A8C0BAA2', 'PRO_CODE', 'PERF_T_PROMONITOR', 'ÏîÄ¿±àÂë', 'S', '40', null, null, 1, null, sysdate);
