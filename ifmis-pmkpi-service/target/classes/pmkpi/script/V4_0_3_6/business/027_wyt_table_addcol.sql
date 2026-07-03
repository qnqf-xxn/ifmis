i number;
begin

--自评主表添加 支出项目类别、以及项目编码字段
select count(*) into i from user_tab_columns t where t.table_name ='PERF_T_SELFEVALTASK' and t.column_name='PROJECTKIND';
if i=0 then
    execute immediate 'alter table PERF_T_SELFEVALTASK add(PROJECTKIND VARCHAR2(32))';
end if;
select count(*) into i from user_tab_columns t where t.table_name ='PERF_T_SELFEVALTASK' and t.column_name='PRO_LEVONE_CODE';
if i=0 then
    execute immediate 'alter table PERF_T_SELFEVALTASK add(PRO_LEVONE_CODE VARCHAR2(21))';
end if;


--调整主表添加 支出项目类别、以及项目编码字段
select count(*) into i from user_tab_columns t where t.table_name ='PERF_T_ADJUST' and t.column_name='PROJECTKIND';
if i=0 then
    execute immediate 'alter table PERF_T_ADJUST add(PROJECTKIND VARCHAR2(32))';
end if;
select count(*) into i from user_tab_columns t where t.table_name ='PERF_T_ADJUST' and t.column_name='PRO_LEVONE_CODE';
if i=0 then
    execute immediate 'alter table PERF_T_ADJUST add(PRO_LEVONE_CODE VARCHAR2(21))';
end if;

--年中追加主表添加 支出项目类别、以及项目编码字段
select count(*) into i from user_tab_columns t where t.table_name ='PERF_T_DEPTPERFMIDDECLARE' and t.column_name='PROJECTKIND';
if i=0 then
    execute immediate 'alter table PERF_T_DEPTPERFMIDDECLARE add(PROJECTKIND VARCHAR2(32))';
end if;
select count(*) into i from user_tab_columns t where t.table_name ='PERF_T_DEPTPERFMIDDECLARE' and t.column_name='PRO_LEVONE_CODE';
if i=0 then
    execute immediate 'alter table PERF_T_DEPTPERFMIDDECLARE add(PRO_LEVONE_CODE VARCHAR2(21))';
end if;

--重构自评视图
execute immediate '
create or replace view v_perf_t_selfevaltask as
select t.*
  from PERF_T_SELFEVALTASK t
 where t.year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
  and t.province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and t.is_deleted = 2 ';
  
execute immediate '
create or replace view perf_v_selfevaltask as
select
    t.*,
    ''2'' as rectifytype,
    case
     when to_date(t.evalend, ''yyyymmdd'') < to_date(to_char(sysdate, ''yyyymmdd''), ''yyyymmdd'') then 0
     else to_date(t.evalend, ''yyyymmdd'') - to_date(to_char(sysdate, ''yyyymmdd''), ''yyyymmdd'')
    end warndays, --截止天数
    nvl(s.score,0) score,
    s.selfresult,
    s.warn
from
    v_perf_t_selfevaltask t
    left join v_perf_t_selfperfdesc s on s.mainguid = t.guid'
;


--重构调整视图
execute immediate'
create or replace view v_perf_t_adjust as
select t.*
 from perf_t_adjust t
where YEAR = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
and PROVINCE = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';


--年中追加视图
execute immediate'
create or replace view v_perf_t_deptperfmiddeclare as
select *
 from perf_t_deptperfmiddeclare
    where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'') 
    and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';

--重构监控视图
execute immediate'
create or replace view perf_v_promonitor as
select
    t.*
    ,case
        when to_number(to_date(b.enddate, ''yyyymmdd'') - to_date(to_char(sysdate, ''yyyymmdd''), ''yyyymmdd'')) > to_number(b.warndays) then ''black''
        when to_number(to_date(b.enddate, ''yyyymmdd'') - to_date(to_char(sysdate, ''yyyymmdd''), ''yyyymmdd'')) <= to_number(b.warndays) then ''red''
        when to_date(to_char(sysdate, ''yyyymmdd''), ''yyyymmdd'') > to_date(b.enddate, ''yyyymmdd'') then ''000''
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
from
    v_perf_t_promonitor t
    left join v_perf_t_taskset b on b.guid = t.taskguid
where
    to_date(to_char(sysdate, ''yyyymmdd''), ''yyyymmdd'') >= to_date(b.startdate, ''yyyymmdd'') - 1';
