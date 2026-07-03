 i integer;
begin
  --绩效目标调整主表
  select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_PROVISION_INDICATOR';
  if i=0 then
   execute immediate '
create table PERF_PROVISION_INDICATOR
(
  guid           VARCHAR2(40) not null,
  code           VARCHAR2(200),
  explain        VARCHAR2(200),
  weight         NUMBER(5,2),
  islinked       NUMBER(1),
  agencyguid     VARCHAR2(40),
  wfstatus       VARCHAR2(40),
  status         NUMBER(1),
  createtime     VARCHAR2(17) not null,
  updatetime     VARCHAR2(17),
  creater        VARCHAR2(40) not null,
  province       VARCHAR2(32) not null,
  year           NUMBER(4) not null,
  ordernum       NUMBER(9),
  finintorgguid  VARCHAR2(40),
  mainguid       VARCHAR2(40),
  superid        VARCHAR2(40),
  levelno        NUMBER(2),
  rule           VARCHAR2(200),
  computesign    VARCHAR2(40),
  meterunit      VARCHAR2(200),
  tindex         VARCHAR2(300),
  wfid           VARCHAR2(40),
  proguid        VARCHAR2(40),
  targetvalue    VARCHAR2(1000),
  kpi_id         VARCHAR2(38) not null,
  mof_div_code   VARCHAR2(9) not null,
  fiscal_year    VARCHAR2(4) not null,
  pro_code       VARCHAR2(21) not null,
  kpi_lv1        VARCHAR2(300) not null,
  kpi_lv2        VARCHAR2(300) not null,
  kpi_lv3        VARCHAR2(300) not null,
  kpi_content    VARCHAR2(2000),
  kpi_evalstd    VARCHAR2(2000),
  kpi_val        VARCHAR2(1000) not null,
  kpi_remark     VARCHAR2(2000),
  version        VARCHAR2(38) default 1 not null,
  version_name   VARCHAR2(400) default 1 not null,
  sub_mof_code   VARCHAR2(9),
  update_time    VARCHAR2(17) not null,
  is_deleted     NUMBER(1) default 2 not null,
  create_time    VARCHAR2(17) not null,
  agency_code    VARCHAR2(21),
  findex         VARCHAR2(300),
  sindex         VARCHAR2(300),
  name           VARCHAR2(80),
  indexval       VARCHAR2(1000),
  yearflag       VARCHAR2(9),
  kpivalsource   VARCHAR2(32),
  value_remark   VARCHAR2(2000),
  value_desc     VARCHAR2(4000),
  fromguid       VARCHAR2(40),
  busi_type_code VARCHAR2(6)
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
create index KPIID_PERF_PROVISION_INDICATOR on PERF_PROVISION_INDICATOR (GUID, YEAR, PROVINCE)
';
execute immediate 'alter table PERF_PROVISION_INDICATOR
  add constraint PK_PERF_PROVISION_INDICATOR primary key (KPI_ID)';

end if;
execute immediate '
create or replace view V_PERF_PROVISION_INDICATOR as
select * 
from PERF_PROVISION_INDICATOR t where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
  and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and is_deleted =2';
