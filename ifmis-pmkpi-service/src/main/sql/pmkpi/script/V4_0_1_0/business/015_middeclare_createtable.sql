i integer;
begin
  --绩效目标调整主表
  select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_T_DEPTPERFMIDDECLARE';
  if i=0 then
     execute immediate '
create table PERF_T_DEPTPERFMIDDECLARE
(
  guid           VARCHAR2(40) not null,
  pro_name       VARCHAR2(200),
  pro_code       VARCHAR2(200),
  linkman        VARCHAR2(50),
  telephone      VARCHAR2(30),
  gist           VARCHAR2(500),
  funcdesc       VARCHAR2(3000),
  agencyguid     VARCHAR2(40),
  wfstatus       VARCHAR2(40),
  status         NUMBER(1),
  createtime     VARCHAR2(17) not null,
  updatetime     VARCHAR2(17) default to_char(sysdate,''yyyyMMddHH24miss''),
  creater        VARCHAR2(40) not null,
  province       VARCHAR2(32) not null,
  year           NUMBER(4) not null,
  ordernum       NUMBER(9),
  finintorgguid  VARCHAR2(40),
  wfid           VARCHAR2(40),
  auditor        VARCHAR2(32),
  lastupdatetime VARCHAR2(17)
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
execute immediate 'alter table PERF_T_DEPTPERFMIDDECLARE
  add constraint PK_PERF_T_DEPTPERFMIDDECLARE primary key (GUID, YEAR, PROVINCE)
  using index ';
   end if;
execute immediate '
create or replace view V_PERF_T_DEPTPERFMIDDECLARE as
select * 
from PERF_T_DEPTPERFMIDDECLARE t where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
  and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';
