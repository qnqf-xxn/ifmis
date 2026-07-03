  i integer;
begin
  select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_T_RECTIFY';
  if i=0 then
     execute immediate '
create table PERF_T_RECTIFY
(
  guid            VARCHAR2(40) not null,
  state           NUMBER default 0 not null,
  rectifycontent  CLOB,
  orgid           VARCHAR2(40),
  rectifyorgid    VARCHAR2(40),
  accept          NUMBER default 0,
  createuid       VARCHAR2(40),
  createuname     VARCHAR2(100),
  updateuid       VARCHAR2(40),
  updateuname     VARCHAR2(100),
  updatetime      VARCHAR2(20),
  lastupdatetime  VARCHAR2(20),
  delstatus       VARCHAR2(2) default ''0'' not null,
  deluid          VARCHAR2(40),
  deluname        VARCHAR2(100),
  deltime         VARCHAR2(20),
  province        VARCHAR2(9) not null,
  year            VARCHAR2(4) not null,
  billtypeid      VARCHAR2(40),
  wfstatus        VARCHAR2(40),
  creater         VARCHAR2(40),
  auditor         VARCHAR2(40),
  timestamp       VARCHAR2(40),
  wfid            VARCHAR2(40),
  rectifytitle    VARCHAR2(2000),
  projname        VARCHAR2(2000),
  projlevel       VARCHAR2(40),
  createtime      VARCHAR2(40),
  iscomplete      VARCHAR2(32),
  status          VARCHAR2(4),
  agencyguid      VARCHAR2(40),
  proguid         VARCHAR2(40),
  finintorgguid   VARCHAR2(40),
  mainguid        VARCHAR2(40),
  bustype         NUMBER(1),
  projcode        VARCHAR2(40),
  feedbackcontent CLOB,
  isfinal         NUMBER(1),
  type            VARCHAR2(40),
  evalmeach       VARCHAR2(64),
  feedbackdesc    VARCHAR2(4000),
  rectifydesc     VARCHAR2(4000)
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
execute immediate 'alter table PERF_T_RECTIFY
  add constraint PK_PERF_T_RECTIFY primary key (GUID, YEAR, PROVINCE)
  using index ';
   end if;
   
execute immediate '
create or replace view v_PERF_T_RECTIFY as
select *
from PERF_T_RECTIFY t where YEAR= global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'') and PROVINCE = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';
