i integer;
begin
  --绩效目标调整主表
  select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_T_EVALUATETEMP';
  if i=0 then
     execute immediate '
create table PERF_T_EVALUATETEMP
(
  guid       VARCHAR2(40) not null,
  code       VARCHAR2(50),
  name       VARCHAR2(100),
  explain    VARCHAR2(1000),
  evalstd    VARCHAR2(2000),
  score      NUMBER(5,2),
  remark     VARCHAR2(4000),
  bustype    VARCHAR2(40),
  audittype  VARCHAR2(40),
  createtime VARCHAR2(17),
  updatetime VARCHAR2(17),
  year       VARCHAR2(4) not null,
  province   VARCHAR2(9) not null,
  levelno    NUMBER(2),
  isleaf     NUMBER(1),
  superid    VARCHAR2(40),
  ordernum   NUMBER(9),
  isadd      VARCHAR2(1)
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
execute immediate 'alter table PERF_T_EVALUATETEMP
  add constraint PK_PERF_EVALUATETEMP primary key (GUID, YEAR, PROVINCE)
  using index ';
   end if;
execute immediate '
create or replace view v_perf_t_evaluatetemp as
select * 
from PERF_T_EVALUATETEMP t where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
  and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';
