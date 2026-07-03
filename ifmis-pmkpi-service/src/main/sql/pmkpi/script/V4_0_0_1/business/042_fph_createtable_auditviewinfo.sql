
 
  i integer;
begin
  select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_T_CUSTOMAUDITVIEW';
  if i=0 then
     execute immediate '
create table PERF_T_CUSTOMAUDITVIEW
(
  guid       VARCHAR2(40) not null,
  code       VARCHAR2(100) not null,
  name       VARCHAR2(500) not null,
  classify   VARCHAR2(40) not null,
  createtime VARCHAR2(17),
  updatetime VARCHAR2(17),
  status     NUMBER(1),
  year       NUMBER(4),
  province   VARCHAR2(40),
  appid      VARCHAR2(32),
  remarkbf   CLOB,
  remark     CLOB
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
execute immediate 'alter table PERF_T_CUSTOMAUDITVIEW
  add constraint PERF_T_CUSTOMAUDITVIEW primary key (GUID)
  using index ';
  end if;


  select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_T_AUDITDEFINE';
  if i=0 then
     execute immediate '
create table PERF_T_AUDITDEFINE
(
  guid        VARCHAR2(40) not null,
  code        VARCHAR2(40) not null,
  name        VARCHAR2(255) not null,
  explain     VARCHAR2(2000),
  auditsql    CLOB,
  year        NUMBER(4) not null,
  agencyguid  VARCHAR2(40),
  wfid        VARCHAR2(40),
  wfstatus    VARCHAR2(40),
  creater     VARCHAR2(40),
  createtime  VARCHAR2(17),
  updatetime  VARCHAR2(17),
  province    VARCHAR2(40),
  ordernum    NUMBER(9),
  status      NUMBER(1),
  procedure   VARCHAR2(1000),
  auditdetype VARCHAR2(20),
  isalltable  NUMBER(1),
  recordadopt NUMBER(1),
  checkflag   NUMBER(1),
  viewguid    VARCHAR2(40),
  auditbeanid VARCHAR2(200),
  remark      NUMBER(1)
)';
 
execute immediate 'alter table PERF_T_AUDITDEFINE
  add constraint PK_PERF_AUDITDEFINE primary key (GUID)
  using index ';
  end if;


  select count(*) into i from user_tab_columns t where t.table_name ='PERF_T_DEPTPERFDECLARE' and t.column_name='BUDGETAMT';
  if i=0 then
     execute immediate 'alter table PERF_T_DEPTPERFDECLARE add budgetamt NUMBER(20,5)';
  end if;
  
  select count(*) into i from user_tab_columns t where t.table_name ='PERF_T_DEPTPERFDECLARE' and t.column_name='GOVEFUNCAMT';
  if i=0 then
     execute immediate 'alter table PERF_T_DEPTPERFDECLARE add govefuncamt NUMBER(20,5)';
  end if;
  
  select count(*) into i from user_tab_columns t where t.table_name ='PERF_T_DEPTPERFDECLARE' and t.column_name='TAXRANAMT';
  if i=0 then
     execute immediate 'alter table PERF_T_DEPTPERFDECLARE add taxranamt NUMBER(20,5)';
  end if;
  
  select count(*) into i from user_tab_columns t where t.table_name ='PERF_T_DEPTPERFDECLARE' and t.column_name='PROJEXPAMT';
  if i=0 then
     execute immediate 'alter table PERF_T_DEPTPERFDECLARE add projexpamt NUMBER(20,5)';
  end if;

execute immediate '
create or replace view v_perf_t_deptperfdeclare as
select *
from perf_t_deptperfdeclare where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
  and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';
