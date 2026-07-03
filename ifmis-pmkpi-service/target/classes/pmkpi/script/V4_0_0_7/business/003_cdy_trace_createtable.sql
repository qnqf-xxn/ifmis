 
  i integer;
begin
  --任务表
  select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_T_TASKSET';
  if i=0 then
     execute immediate '
create table PERF_T_TASKSET
(
  guid         VARCHAR2(40) not null,
  name         VARCHAR2(200),
  bustype      VARCHAR2(40),
  tasktype     VARCHAR2(40),
  taskstage    VARCHAR2(40),
  startdate    VARCHAR2(17),
  enddate      VARCHAR2(17),
  warndays     NUMBER(3),
  status       NUMBER(1),
  agencyguid   VARCHAR2(40),
  agency_code  VARCHAR2(40),
  creater      VARCHAR2(40),
  create_time  VARCHAR2(17),
  update_time  VARCHAR2(17),
  is_deleted   NUMBER(1),
  fiscal_year  VARCHAR2(4) not null,
  mof_div_code VARCHAR2(9) not null,
  year  VARCHAR2(4) not null,
  province VARCHAR2(9) not null
)
partition by list (PROVINCE)
subpartition by list (YEAR)
(
  partition P87 values (''87'')
    pctfree 10
    initrans 1
    maxtrans 255
  (
    subpartition P87_Y2016 values (''2016'')
  )
)';
-- Create/Recreate primary, unique and foreign key constraints 
execute immediate 'alter table PERF_T_TASKSET
  add constraint PK_PERF_TASKSET primary key (GUID, PROVINCE, YEAR)
  using index ';
   end if;
   
   --项目监控主表
   select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_T_PROMONITOR';
  if i=0 then
     execute immediate '
create table PERF_T_PROMONITOR
(
  guid           VARCHAR2(40) not null,
  name           VARCHAR2(200),
  taskguid       VARCHAR2(40),
  proguid        VARCHAR2(40),
  depttask       VARCHAR2(40),
  provincetask   VARCHAR2(40),
  bgtwarn        VARCHAR2(40),
  goalwarn       VARCHAR2(40),
  islast         NUMBER(1),
  tracenum       NUMBER(1),
  tracestatus    NUMBER(1),
  status         NUMBER(1),
  agencyguid     VARCHAR2(40),
  agency_code    VARCHAR2(40),
  creater        VARCHAR2(40),
  create_time    VARCHAR2(17),
  update_time    VARCHAR2(17),
  is_deleted     NUMBER(1),
  fiscal_year    VARCHAR2(4) not null,
  mof_div_code   VARCHAR2(9) not null,
  year           VARCHAR2(4) not null,
  province       VARCHAR2(9) not null,
  wfstatus       VARCHAR2(40),
  auditor        VARCHAR2(32),
  lastupdatetime VARCHAR2(17) default to_char(sysdate,''yyyyMMddHH24miss''),
  finintorgguid  VARCHAR2(40),
  wfid           VARCHAR2(40),
  construction   VARCHAR2(4000),
  promanagement  VARCHAR2(4000),
  finmanagement  VARCHAR2(4000)
)
partition by list (PROVINCE)
subpartition by list (YEAR)
(
  partition P87 values (''87'')
    pctfree 10
    initrans 1
    maxtrans 255
  (
    subpartition P87_Y2016 values (''2016'')
  )
)';
execute immediate 'alter table PERF_T_PROMONITOR
  add constraint PK_PERF_PROMONITOR primary key (GUID, PROVINCE, YEAR)
  using index ';
   end if;

--编辑公示配置表
select count(1) into i from user_tab_cols t where t.table_name='PERF_T_FUNDTEMP' and t.column_name='ISEDIT';
    if i=0 then
    execute immediate 'alter table PERF_T_FUNDTEMP add isedit VARCHAR2(40)';
end if;

--预算执行情况
select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_T_PROBGTFUND';
  if i=0 then
     execute immediate '
create table PERF_T_PROBGTFUND
(
  guid         VARCHAR2(40) not null,
  name         VARCHAR2(200),
  totalamt     VARCHAR2(200),
  amt1         VARCHAR2(200),
  amt2         VARCHAR2(200),
  amt3         VARCHAR2(200),
  amt4         VARCHAR2(200),
  amt5         VARCHAR2(200),
  amt6         VARCHAR2(200),
  amt7         VARCHAR2(200),
  amt8         VARCHAR2(200),
  amt9         VARCHAR2(200),
  bgtget       VARCHAR2(30),
  ordernum     NUMBER(9),
  mainguid     VARCHAR2(40),
  isedit       VARCHAR2(40),
  agencyguid   VARCHAR2(40),
  agency_code  VARCHAR2(40),
  creater      VARCHAR2(40),
  create_time  VARCHAR2(17),
  update_time  VARCHAR2(17),
  is_deleted   NUMBER(1),
  fiscal_year  VARCHAR2(4) not null,
  mof_div_code VARCHAR2(9) not null,
  year         VARCHAR2(4) not null,
  province     VARCHAR2(9) not null
)
partition by list (PROVINCE)
subpartition by list (YEAR)
(
  partition P87 values (''87'')
    pctfree 10
    initrans 1
    maxtrans 255
  (
    subpartition P87_Y2016 values (''2016'')
  )
)';
execute immediate 'alter table PERF_T_PROBGTFUND
  add constraint PK_PERF_PROBGTFUND primary key (GUID, PROVINCE, YEAR)
  using index ';
   end if;

--监控指标
select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_T_PROINDEXTRACE';
  if i=0 then
     execute immediate '
create table PERF_T_PROINDEXTRACE
(
  guid              VARCHAR2(40) not null,
  name              VARCHAR2(80),
  findex            VARCHAR2(40),
  sindex            VARCHAR2(40),
  tindex            VARCHAR2(40),
  targetvalue       VARCHAR2(60),
  indexval          VARCHAR2(60),
  computesign       VARCHAR2(40),
  meterunit         VARCHAR2(40),
  completeanalysis  VARCHAR2(2000),
  deviationanalysis VARCHAR2(40),
  otherreasons      VARCHAR2(2000),
  remark            VARCHAR2(4000),
  ordernum          NUMBER(9),
  mainguid          VARCHAR2(40),
  proguid           VARCHAR2(40),
  warn              VARCHAR2(40),
  agencyguid        VARCHAR2(40),
  agency_code       VARCHAR2(40),
  creater           VARCHAR2(40),
  create_time       VARCHAR2(17),
  update_time       VARCHAR2(17),
  is_deleted        NUMBER(1),
  fiscal_year       VARCHAR2(4) not null,
  mof_div_code      VARCHAR2(9) not null,
  year              VARCHAR2(4) not null,
  province          VARCHAR2(9) not null
)
partition by list (PROVINCE)
subpartition by list (YEAR)
(
  partition P87 values (''87'')
    pctfree 10
    initrans 1
    maxtrans 255
  (
    subpartition P87_Y2016 values (''2016'')
  )
)';
-- Create/Recreate primary, unique and foreign key constraints 
execute immediate 'alter table PERF_T_PROINDEXTRACE
  add constraint PK_PERF_PROINDEXTRACE primary key (GUID, PROVINCE, YEAR)
  using index ';
end if;
  
--监控分析
select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_T_PROTRACEANALYSIS';
  if i=0 then
     execute immediate '
create table PERF_T_PROTRACEANALYSIS
(
  guid         VARCHAR2(40) not null,
  deviation    VARCHAR2(4000),
  problems     VARCHAR2(4000),
  measures     VARCHAR2(4000),
  suggestions  VARCHAR2(4000),
  remark       VARCHAR2(200),
  isgoal       VARCHAR2(40),
  mainguid     VARCHAR2(40),
  agencyguid   VARCHAR2(40),
  agency_code  VARCHAR2(40),
  creater      VARCHAR2(40),
  create_time  VARCHAR2(17),
  update_time  VARCHAR2(17),
  is_deleted   NUMBER(1),
  fiscal_year  VARCHAR2(4) not null,
  mof_div_code VARCHAR2(9) not null,
  year         VARCHAR2(4) not null,
  province     VARCHAR2(9) not null
)
partition by list (PROVINCE)
subpartition by list (YEAR)
(
  partition P87 values (''87'')
    pctfree 10
    initrans 1
    maxtrans 255
  (
    subpartition P87_Y2016 values (''2016'')
  )
)';
-- Create/Recreate primary, unique and foreign key constraints 
execute immediate 'alter table PERF_T_PROTRACEANALYSIS
  add constraint PK_PERF_PROTRACEANALYSIS primary key (GUID, PROVINCE, YEAR)
  using index ';
end if;

--预警规则表
  select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_T_WARNSET';
  if i=0 then
     execute immediate '
create table PERF_T_WARNSET
(
  guid       VARCHAR2(40) not null,
  code       VARCHAR2(40),
  name       VARCHAR2(100),
  type       VARCHAR2(40),
  warnsql    VARCHAR2(2000),
  updatetime VARCHAR2(17),
  createtime VARCHAR2(17),
  year       VARCHAR2(4),
  province   VARCHAR2(9)
)
partition by list (PROVINCE)
subpartition by list (YEAR)
(
  partition P87 values (''87'')
    pctfree 10
    initrans 1
    maxtrans 255
  (
    subpartition P87_Y2016 values (''2016'')
  )
)';
-- Create/Recreate primary, unique and foreign key constraints 
execute immediate 'alter table PERF_T_WARNSET
  add constraint PK_PERF_WARNSET primary key (GUID,YEAR,PROVINCE)';
end if;

execute immediate '
create or replace view v_perf_t_taskset as
select *
 from perf_t_taskset t where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
  and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';

execute immediate '
create or replace view v_perf_t_promonitor as
select *
 from perf_t_promonitor t where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
  and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';

--列表查询视图
execute immediate '
create or replace view perf_v_promonitor as
select t.*
,case when to_number(to_date(b.enddate,''yyyymmdd'')-to_date(to_char(sysdate,''yyyymmdd''),''yyyymmdd'')) > to_number(b.warndays) then ''black''
when to_date(to_char(sysdate,''yyyymmdd''),''yyyymmdd'') > to_date(b.enddate,''yyyymmdd'') then ''000''
when to_number(to_date(b.enddate,''yyyymmdd'')-to_date(to_char(sysdate,''yyyymmdd''),''yyyymmdd'')) <= to_number(b.warndays) then ''red''
end warn,
to_date(b.enddate,''yyyymmdd'') - to_date(to_char(sysdate,''yyyymmdd''),''yyyymmdd'') warndays,
t.update_time updatetime,a.pro_code,a.pro_name,b.taskstage,b.startdate,b.enddate,b.tasktype,b.bustype
from v_perf_t_promonitor t
left join v_perf_project_info a on t.proguid=a.guid
left join v_perf_t_taskset b on b.guid=t.taskguid
where to_date(to_char(sysdate,''yyyymmdd''),''yyyymmdd'') > to_date(b.startdate,''yyyymmdd'')';

execute immediate '  
create or replace view v_perf_t_proindextrace as
select *
from perf_t_proindextrace t where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
  and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';

execute immediate '
create or replace view v_perf_t_protraceanalysis as
select *
from perf_t_protraceanalysis t where YEAR= global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'') and PROVINCE = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';

execute immediate '
create or replace view v_perf_t_probgtfund as
select t.*
 from perf_t_probgtfund t  where YEAR= global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'') and PROVINCE = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';

execute immediate '
create or replace view v_perf_t_fundtemp as
select t.*
from perf_t_fundtemp t where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
  and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';

execute immediate '
create or replace view v_perf_t_warnset as
select *
from perf_t_warnset t where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
  and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';
