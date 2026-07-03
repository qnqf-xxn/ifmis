i number;
begin


select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_T_MONITORING_IMPORT';
if i=0 then
  execute immediate '
create table PERF_T_MONITORING_IMPORT (
  GUID VARCHAR2(42) not null,
  NAME VARCHAR2(200),
  PRO_CODE VARCHAR2(42),
  MAINGUID VARCHAR2(52),
  ISGOAL VARCHAR2(40),
  DEVIATION VARCHAR2(4000),
  MEASURES VARCHAR2(4000),
  ADJUSTREMARK VARCHAR2(4000),
  YEAR VARCHAR2(25),
  PROVINCE VARCHAR2(45) 
)';
execute immediate '
alter table PERF_T_MONITORING_IMPORT 
  add constraint PERF_T_MONITORING_IMPORT primary key (GUID)';

end if;


execute immediate '
  create or replace view V_PERF_T_MONITORING_IMPORT as
  select * from perf_t_monitoring_import t
  where YEAR= global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'') and PROVINCE = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')
';
