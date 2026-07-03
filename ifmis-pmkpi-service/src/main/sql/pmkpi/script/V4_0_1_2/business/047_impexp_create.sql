
i integer;
begin
  --绩效管理工作考核任务表
  select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_T_IMPEXPSUB';
  if i=0 then
     execute immediate '
create table PERF_T_IMPEXPSUB
(
  guid       VARCHAR2(32) not null,
  columncode VARCHAR2(50),
  csid       VARCHAR2(100),
  name       VARCHAR2(100),
  ordernum   NUMBER,
  head       VARCHAR2(2000),
  format     VARCHAR2(200),
  type       VARCHAR2(50),
  mainguid   VARCHAR2(32),
  colwidth   NUMBER,
  province   VARCHAR2(9) not null,
  year       VARCHAR2(4) not null
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
execute immediate 'alter table PERF_T_IMPEXPSUB
  add constraint PK_PERF_IMPEXPSUB primary key (GUID, PROVINCE, YEAR)
  using index';
execute immediate 'alter table PERF_T_IMPEXPSUB
  add constraint UK_PERF_IMPEXPSUB unique (COLUMNCODE, MAINGUID, YEAR, PROVINCE)
  using index';
end if;

execute immediate 'create or replace view v_perf_t_impexpsub as
select *
from perf_t_impexpsub
  where province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')';
