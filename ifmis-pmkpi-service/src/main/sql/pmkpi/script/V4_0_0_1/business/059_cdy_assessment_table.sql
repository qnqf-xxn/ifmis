
 
  i integer;
begin
  select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_T_ASSESSMENTTEMP';
  if i=0 then
     execute immediate '
create table PERF_T_ASSESSMENTTEMP
(
  guid       VARCHAR2(40) not null,
  code       VARCHAR2(50),
  name       VARCHAR2(200),
  superid    VARCHAR2(32),
  levelno    NUMBER(2),
  isleaf     NUMBER(1),
  ordernum   NUMBER(9),
  weight     NUMBER(5,2),
  fweight     NUMBER(5,2),
  sweight     NUMBER(5,2),
  points      VARCHAR2(4000),
  remark     VARCHAR2(2000),
  agencyguid VARCHAR2(40),
  FININTORGGUID VARCHAR2(40),
  status     NUMBER(1),
  createtime VARCHAR2(17),
  updatetime VARCHAR2(17) not null,
  creater    VARCHAR2(40),
  province   VARCHAR2(32) not null,
  year       NUMBER(4) not null
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
execute immediate 'alter table PERF_T_ASSESSMENTTEMP
  add constraint PK_PERF_ASSESSMENTTEMP primary key (GUID, YEAR, PROVINCE)
  using index ';
 end if;

  select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_T_ASSESSMENT';
  if i=0 then
     execute immediate '
create table PERF_T_ASSESSMENT
(
  guid          VARCHAR2(40) not null,
  mainguid       VARCHAR2(40),
  tempguid       VARCHAR2(40),
  scorenum        NUMBER(5,2),
  agencyguid    VARCHAR2(40),
  finintorgguid VARCHAR2(40),
  status        NUMBER(1),
  createtime    VARCHAR2(17),
  updatetime    VARCHAR2(17) not null,
  creater       VARCHAR2(40),
  province      VARCHAR2(32) not null,
  year          NUMBER(4) not null
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
execute immediate 'alter table PERF_T_ASSESSMENT
  add constraint PK_PERF_ASSESSMENT primary key (GUID, YEAR, PROVINCE)
  using index ';
  end if;

execute immediate 'create or replace view v_PERF_T_ASSESSMENTTEMP as
select *
from PERF_T_ASSESSMENTTEMP t where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
  and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';

execute immediate 'create or replace view v_PERF_T_ASSESSMENT as
select *
from PERF_T_ASSESSMENT t where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
  and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';
