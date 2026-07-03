 i integer;
begin
  --绩效目标调整主表
  select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_T_DEPTEVALUATION';
  if i=0 then
   execute immediate '
create table PERF_T_DEPTEVALUATION
(
  guid              VARCHAR2(40) not null,
  code              VARCHAR2(40),
  name              VARCHAR2(500),
  pro_start_year    VARCHAR2(40),
  endtime           VARCHAR2(40),
  evalmeach         VARCHAR2(40),
  leader_name       VARCHAR2(50),
  projectcon        VARCHAR2(500),
  leader_phone      VARCHAR2(500),
  projamt           NUMBER(20,2),
  pro_total_amt     NUMBER(20,2),
  bustype           VARCHAR2(32),
  year              VARCHAR2(40) not null,
  province          VARCHAR2(40) not null,
  proguid           VARCHAR2(40),
  agencyguid        VARCHAR2(40),
  finintorgguid     VARCHAR2(40),
  createtime        VARCHAR2(40),
  creater           VARCHAR2(40),
  lastupdatetime    VARCHAR2(40),
  wfstatus          VARCHAR2(40),
  wfid              VARCHAR2(40),
  status            NUMBER(1) default 1,
  isobject          NUMBER(1) default 2,
  isentrust         NUMBER(1) default 2,
  isrelease         NUMBER(1) default 2,
  isresult          NUMBER(1) default 2,
  auditor           VARCHAR2(40),
  budgetgoalcreator VARCHAR2(20),
  existquestion     VARCHAR2(4000),
  feedback          VARCHAR2(4000),
  isnotice          NUMBER(1) default 2,
  opinion           VARCHAR2(4000),
  category          VARCHAR2(40)
)
partition by list (PROVINCE)
subpartition by list (YEAR)
(
  partition P87 values (''87'')
  (
    subpartition P87_Y2016 values (''2016'')
  )
)';
execute immediate '
alter table PERF_T_DEPTEVALUATION
  add constraint PK_PERF_T_DEPTEVALUATION primary key (GUID, YEAR, PROVINCE)
';
end if;
execute immediate '
create or replace view V_PERF_T_DEPTEVALUATION as
select * 
from PERF_T_DEPTEVALUATION t where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
  and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';
