 i integer;
begin
  --绩效目标调整主表
  select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_T_PROVISIONDECLARE';
  if i=0 then
   execute immediate '
create table PERF_T_PROVISIONDECLARE
(
  guid           VARCHAR2(40) not null,
  proguid        VARCHAR2(40),
  bgtamt         NUMBER(20,2),
  revisionnum    NUMBER(3),
  islast         NUMBER(1),
  revisionstatus VARCHAR2(50) default 0,
  auditor        VARCHAR2(40),
  lastupdatetime VARCHAR2(20),
  agencyguid     VARCHAR2(40),
  finintorgguid  VARCHAR2(50),
  creater        VARCHAR2(32),
  createtime     VARCHAR2(20),
  updatetime     VARCHAR2(20),
  wfstatus       VARCHAR2(50),
  wfid           VARCHAR2(100),
  status         NUMBER(1),
  province       VARCHAR2(9) not null,
  year           CHAR(4) not null,
  revisionremark VARCHAR2(4000),
  bustype        VARCHAR2(40),
  pro_code       VARCHAR2(40),
  pro_name       VARCHAR2(40)
)
partition by list (PROVINCE)
subpartition by list (YEAR)
(
  partition P87 values (''87'')
  (
    subpartition P87_Y2016 values (''2016'')
  )
)';
execute immediate '
alter table PERF_T_PROVISIONDECLARE
  add constraint PK_PERF_T_PROVISIONDECLARE primary key (GUID, YEAR, PROVINCE)
';


end if;
execute immediate '
create or replace view V_PERF_T_PROVISIONDECLARE as
select * 
from PERF_T_PROVISIONDECLARE t where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
  and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';
