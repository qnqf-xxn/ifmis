i integer;
begin
  --绩效目标调整主表
  select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_PROJECT_INFODP';
  if i=0 then
     execute immediate '
create table PERF_PROJECT_INFODP
(
  guid           VARCHAR2(40) not null,
  pro_id         VARCHAR2(40) not null,
  pro_code       VARCHAR2(40),
  pro_name       VARCHAR2(360),
  pro_lev        VARCHAR2(9),
  taskflag       VARCHAR2(40),
  agency_code    VARCHAR2(40),
  wfstatus       VARCHAR2(40),
  wfid           VARCHAR2(40),
  lastupdatetime VARCHAR2(40),
  auditor        VARCHAR2(40),
  province       VARCHAR2(9) not null,
  year           CHAR(4) not null,
  creater        VARCHAR2(40),
  create_time    VARCHAR2(40),
  update_time    VARCHAR2(40),
  agencyguid     VARCHAR2(40),
  remark         VARCHAR2(2000),
  islast         NUMBER(1),
  bdmbefwf       VARCHAR2(40),
  bdmlastwf      VARCHAR2(40),
  action         NUMBER(1),
  is_deleted     NUMBER(1)
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
execute immediate 'alter table PERF_PROJECT_INFODP
  add constraint PERF_PROJECT_INFODP primary key (GUID, PROVINCE, YEAR)
  using index ';
execute immediate '
create or replace view V_PERF_PROJECT_INFODP as
select * 
from PERF_PROJECT_INFODP t where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
  and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and is_deleted <> 1';
end if;
