i integer;
begin
  --绩效目标调整主表
  select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_T_EDITFORMAL';
  if i=0 then
     execute immediate '
create table PERF_T_EDITFORMAL
(
  guid       VARCHAR2(40) not null,
  tablecode  VARCHAR2(30),
  columncode VARCHAR2(50),
  name       VARCHAR2(200),
  value      NUMBER(18,2),
  querysql   VARCHAR2(4000),
  sumcol     VARCHAR2(1000),
  updatetime VARCHAR2(17),
  createtime VARCHAR2(17),
  year       NUMBER(4) not null,
  province   VARCHAR2(40) not null,
  agencyguid VARCHAR2(40),
  ordernum   NUMBER(3)
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
execute immediate 'alter table PERF_T_EDITFORMAL
  add constraint PK_PERF_EDITFORMAL primary key (GUID, YEAR, PROVINCE)
  using index ';
end if;
execute immediate '
create or replace view v_perf_t_editformal as
select * 
from PERF_T_EDITFORMAL where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';
