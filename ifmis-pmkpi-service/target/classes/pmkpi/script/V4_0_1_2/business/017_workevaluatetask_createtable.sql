i integer;
begin
  --绩效管理工作考核任务表
  select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_T_WORKEVALUATETASK';
  if i=0 then
     execute immediate '
create table PERF_T_WORKEVALUATETASK
(
  guid         VARCHAR2(40) not null,
  name         VARCHAR2(500),
  bustype      VARCHAR2(40),
  tasktype     VARCHAR2(40),
  startdate    VARCHAR2(17),
  enddate      VARCHAR2(17),
  taskyear     VARCHAR2(4),
  linkman      VARCHAR2(200),
  tel          VARCHAR2(100),
  remark       VARCHAR2(4000),
  status       NUMBER(1),
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
  (
    subpartition P87_Y2016 values (''2016'') tablespace EFMIS
  )
)';
-- Create/Recreate primary, unique and foreign key constraints 
execute immediate 'alter table PERF_T_WORKEVALUATETASK
  add constraint PK_PERF_WORKEVALUATETASK primary key (GUID, PROVINCE, YEAR)
  using index ';
   end if;
execute immediate '
create or replace view V_PERF_T_WORKEVALUATETASK as
select * from PERF_T_WORKEVALUATETASK t where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
  and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';

--绩效管理工作考核任务下达表
select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_T_WORKTASKASSIGN';
  if i=0 then
     execute immediate '
create table PERF_T_WORKTASKASSIGN
(
  guid           VARCHAR2(40) not null,
  taskguid       VARCHAR2(40),
  agencyguid     VARCHAR2(40),
  bustype        VARCHAR2(40),
  tasktype       VARCHAR2(40),
  status         NUMBER(1),
  code           VARCHAR2(40),
  name           VARCHAR2(500),
  creater        VARCHAR2(40),
  create_time    VARCHAR2(17),
  update_time    VARCHAR2(17),
  is_deleted     NUMBER(1),
  year           VARCHAR2(4) not null,
  province       VARCHAR2(9) not null,
  subprovince    VARCHAR2(40),
  auditor        VARCHAR2(40),
  lastupdatetime VARCHAR2(20),
  wfstatus       VARCHAR2(50),
  wfid           VARCHAR2(100),
  linkman        VARCHAR2(200),
  tel            VARCHAR2(200),
  assessmentrate VARCHAR2(40),
  goalrate       VARCHAR2(40),
  tracerate      VARCHAR2(40),
  evaluationrate VARCHAR2(40),
  finintorgguid  VARCHAR2(40),
  updatetime     VARCHAR2(17)
)
partition by list (PROVINCE)
subpartition by list (YEAR)
(
  partition P87 values (''87'')
    tablespace EFMIS
  (
    subpartition P87_Y2016 values (''2016'') tablespace EFMIS
  )
)';
-- Create/Recreate primary, unique and foreign key constraints 
execute immediate 'alter table PERF_T_WORKTASKASSIGN
  add constraint PK_PERF_WORKTASKASSIGN primary key (GUID, PROVINCE, YEAR)
  using index ';
   end if;
execute immediate '
create or replace view V_PERF_T_WORKTASKASSIGN as
select * from PERF_T_WORKTASKASSIGN t where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
  and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';
