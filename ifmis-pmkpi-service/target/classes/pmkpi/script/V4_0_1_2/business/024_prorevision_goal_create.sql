 i integer;
begin
  --绩效目标调整主表
  select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_PROVISION_GOAL_INFO';
  if i=0 then
   execute immediate '
create table PERF_PROVISION_GOAL_INFO
(
  guid           VARCHAR2(40) not null,
  agencyguid     VARCHAR2(40),
  zqgoal         VARCHAR2(4000),
  ndgoal         VARCHAR2(4000),
  mainguid       VARCHAR2(40),
  createtime     VARCHAR2(17) not null,
  updatetime     VARCHAR2(17),
  creater        VARCHAR2(40) not null,
  province       VARCHAR2(40) not null,
  year           NUMBER(4) not null,
  kpi_per_id     VARCHAR2(38) not null,
  mof_div_code   VARCHAR2(9) not null,
  fiscal_year    VARCHAR2(4) not null,
  pro_code       VARCHAR2(21) not null,
  kpi_target     VARCHAR2(2000) not null,
  busi_type_code VARCHAR2(6),
  version        VARCHAR2(38) default 1 not null,
  version_name   VARCHAR2(400) default 1 not null,
  sub_mof_code   VARCHAR2(9),
  update_time    VARCHAR2(17) not null,
  is_deleted     NUMBER(1) default 2 not null,
  create_time    VARCHAR2(17) not null,
  agency_code    VARCHAR2(38),
  yearflag       VARCHAR2(1),
  proguid        VARCHAR2(40),
  adj_batch_no   VARCHAR2(6)
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
create index KPIID_PERF_PROVISION_GOALINFO on PERF_PROVISION_GOAL_INFO (GUID, YEAR, PROVINCE)
';
execute immediate 'alter table PERF_PROVISION_GOAL_INFO
  add constraint PK_PERF_PROVISION_GOAL_INFO primary key (KPI_PER_ID)';
execute immediate 'alter table PERF_PROVISION_GOAL_INFO
  add constraint PERF_PROVISION_GOAL_UNIQUE unique (PROGUID, YEARFLAG, MAINGUID, PROVINCE, YEAR)';
end if;
execute immediate '
create or replace view V_PERF_PROVISION_GOAL_INFO as
select * 
from PERF_PROVISION_GOAL_INFO t where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
  and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and is_deleted =2';
