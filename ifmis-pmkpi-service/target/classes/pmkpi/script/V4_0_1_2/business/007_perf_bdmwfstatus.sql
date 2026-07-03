i integer;
begin
  --绩效目标调整主表
  select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_BDMWFSTATUS';
  if i=0 then
     execute immediate '
create table PERF_BDMWFSTATUS
(
  guid     VARCHAR2(32) not null,
  bdmwf    VARCHAR2(300),
  perfwf   VARCHAR2(300),
  status   NUMBER(1),
  province VARCHAR2(32),
  year     NUMBER(4) default 0 not null,
  taskflag NUMBER(1),
  ordernum NUMBER(3),
  beforewf VARCHAR2(300)
)
partition by list (PROVINCE)
subpartition by list (YEAR)
(
  partition P87 values (''87'')
  (
    subpartition P87_Y2016 values (''2016'')
  )
)';
-- Create/Recreate primary, unique and foreign key constraints 
execute immediate 'alter table PERF_BDMWFSTATUS
  add constraint PK_PERF_BDMWFSTATUS primary key (GUID, PROVINCE, YEAR)
  using index ';
end if;
execute immediate '
create or replace view V_PERF_BDMWFSTATUS as
select * 
from PERF_BDMWFSTATUS t where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
  and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';