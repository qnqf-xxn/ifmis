
 
  i integer;
begin
  select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_TMP_AUDITERRORINFO';
  if i=0 then
     execute immediate '
  create global temporary table PERF_TMP_AUDITERRORINFO
  (
    guid       VARCHAR2(40) not null,
    busguid  VARCHAR2(40),
    remark   VARCHAR2(500)
  )
  on commit delete rows';
  end if;
  
  select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_TMP_AUDITDEFINEWHERESQL';
  if i=0 then
     execute immediate '
    create global temporary table PERF_TMP_AUDITDEFINEWHERESQL
    (
      KEY       VARCHAR2(100),
      VALUE  VARCHAR2(500)
    )
    on commit delete rows';
  end if;

  select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_T_DEPTTASK';
  if i=0 then
     execute immediate '
create table PERF_T_DEPTTASK
(
  guid       VARCHAR2(40) not null,
  agencyguid VARCHAR2(40),
  name       varchar2(500),
  context    varchar2(4000),
  totalamt     number(20,2),
  financialfund    number(20,2),
  otherfund  number(20,2),      
  mainguid   VARCHAR2(40),
  createtime VARCHAR2(17) not null,
  updatetime VARCHAR2(17),
  creater    VARCHAR2(40) not null,
  province   VARCHAR2(40) not null,
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
execute immediate 'alter table PERF_T_DEPTTASK
  add constraint PK_PERF_DEPTTASK primary key (GUID, YEAR, PROVINCE)
  using index ';
  end if;


execute immediate 'create or replace view v_perf_t_depttask as
select *
from PERF_T_DEPTTASK where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
  and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';