
  i integer;
begin
  select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_T_CASE';
  if i=0 then
     execute immediate '
create table PERF_T_CASE
(
  GUID        VARCHAR2(40) not null,
  NAME        VARCHAR2(500) not null,
  AGENCYGUID  VARCHAR2(40),
  CASETYPE    VARCHAR2(40),
  DESCRIBE    VARCHAR2(4000),
  FRAMESYSTEM VARCHAR2(40),
  FUNDUSE     VARCHAR2(40),
  STAGE       VARCHAR2(40),
  CREATETIME  VARCHAR2(17) not null,
  UPDATETIME  VARCHAR2(17) not null,
  SCOPE       VARCHAR2(40),
  STATUS      VARCHAR2(40),
  TYPE        VARCHAR2(40),
  CREATER     VARCHAR2(40),
  PROVINCE    VARCHAR2(40) not null,
  YEAR        NUMBER(4) not null,
  CODE        VARCHAR2(100)
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
execute immediate 'alter table PERF_T_CASE
  add constraint PK_PERF_CASE primary key (GUID, YEAR, PROVINCE)
  using index ';

  end if;


  select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_T_MODEL';
  if i=0 then
     execute immediate '
create table PERF_T_MODEL
(
  GUID        VARCHAR2(40) not null,
  NAME        VARCHAR2(500) not null,
  CASETYPE    VARCHAR2(32),
  DESCRIBE    VARCHAR2(4000),
  FRAMESYSTEM VARCHAR2(40),
  STAGE       VARCHAR2(40),
  CREATETIME  VARCHAR2(17) not null,
  UPDATETIME  VARCHAR2(17) not null,
  PROVINCE    VARCHAR2(40) not null,
  YEAR        NUMBER(4) not null,
  CODE        VARCHAR2(100)
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
execute immediate 'alter table PERF_T_MODEL
  add constraint PK_PERF_MODEL primary key (GUID, YEAR, PROVINCE)
  using index ';

  end if;


  select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_T_CASEMODELINDEX';
  if i=0 then
     execute immediate '
create table PERF_T_CASEMODELINDEX
(
  GUID          VARCHAR2(40) not null,
  CODE          VARCHAR2(50),
  NAME          VARCHAR2(200),
  TARGETTYPE    VARCHAR2(40),
  FILLYEAR      NUMBER(4),
  FRAME         VARCHAR2(40),
  FINDEX        VARCHAR2(40),
  SINDEX        VARCHAR2(40),
  MAINGUID      VARCHAR2(40),
  ISTEMP        VARCHAR2(40),
  TINDEX        VARCHAR2(40),
  INDEXVALUE    VARCHAR2(500),
  MIDDLEVALUE   VARCHAR2(500),
  INDEXTYPE     VARCHAR2(40),
  FRAMESYSTEM   VARCHAR2(40),
  INDEXREMARK   VARCHAR2(1000),
  CALCULATEBY   VARCHAR2(40),
  COMPUTESIGN   VARCHAR2(40),
  TARGETVALUE   VARCHAR2(200),
  TARGETUNIT    VARCHAR2(200),
  TARGETREMARK  CLOB,
  CALCTYPE      VARCHAR2(40),
  CALCFORMULA   VARCHAR2(500),
  CALCDISPLAY   VARCHAR2(500),
  CALCEXPLAIN   CLOB,
  SCORETYPE     VARCHAR2(32),
  SCOREDISPLAY  VARCHAR2(500),
  SCOREFORMULA  VARCHAR2(500),
  SCOREEXPLAIN  CLOB,
  AGENCYGUID    VARCHAR2(40),
  FININTORGGUID VARCHAR2(40),
  ORDERNUM      NUMBER(9),
  CREATETIME    VARCHAR2(17) not null,
  UPDATETIME    VARCHAR2(17),
  CREATER       VARCHAR2(40) not null,
  PROVINCE      VARCHAR2(40),
  STATUS        NUMBER(1),
  YEAR          NUMBER(4),
  SEQ           NUMBER(9),
  METERUNIT     VARCHAR2(100),
  WEIGHT        NUMBER(5,2)
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
execute immediate 'alter table PERF_T_CASEMODELINDEX
  add constraint PERF_PK_CASEMODELINDEX primary key (GUID)
  using index ';

  end if;


  select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_T_SYSTEMSET';
  if i=0 then
     execute immediate '
create table PERF_T_SYSTEMSET
(
  PARAMCODE  VARCHAR2(100) not null,
  PARAMNAME  VARCHAR2(200),
  PARAMVALUE VARCHAR2(1000) not null,
  REMARK     VARCHAR2(2000) not null,
  APPID      VARCHAR2(10),
  GUID       VARCHAR2(40) not null,
  ORDERNUM   NUMBER(5) not null,
  YEAR       NUMBER(4) not null,
  PROVINCE   VARCHAR2(32) not null,
  STATUS     NUMBER(1)
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
execute immediate 'alter table PERF_T_SYSTEMSET
  add constraint PERF_T_SYSTEMSET primary key (GUID, YEAR, PROVINCE)
  using index ';

  end if;


  select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_TMP_RULEGUIDS';
  if i=0 then
     execute immediate '
create global temporary table PERF_TMP_RULEGUIDS
(
  GUID VARCHAR2(40)
)
on commit delete rows';
  end if;


execute immediate 'create or replace view v_perf_t_case as
select *
from PERF_T_CASE where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
  and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';
  

execute immediate 'create or replace view v_perf_t_model as
select *
from PERF_T_MODEL where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
  and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';
  

execute immediate 'create or replace view v_perf_t_casemodelindex as
select *
from PERF_T_CASEMODELINDEX where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
  and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';



execute immediate 'create or replace view v_perf_t_systemset as
select *
from PERF_T_SYSTEMSET where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'') 
and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';
