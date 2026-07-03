i number;
begin


select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_COMPONET_POWER';
if i=0 then
  execute immediate '
create table PERF_COMPONET_POWER (
  GUID VARCHAR2(52)   not null,
  ROLEGUID VARCHAR2(52),
  COMPONENTID VARCHAR2(52),
  BUTTONGUID VARCHAR2(52),
  MENUGUID VARCHAR2(52),
  ISVISIABLE VARCHAR2(2),
  YEAR VARCHAR2(20)  not null,
  PROVINCE VARCHAR2(42)  not null,
  CREATETIME VARCHAR2(20),
  UPDATETIME VARCHAR2(20),
  KEY VARCHAR2(42) 
)';
execute immediate '
alter table PERF_COMPONET_POWER 
  add constraint PERF_COMPONET_POWER primary key (GUID,YEAR,PROVINCE)';

end if;


  select count(*) into i from user_tab_columns t where t.TABLE_NAME='PERF_COMPONET_POWER' and t.COLUMN_NAME='ISEDIT';
  if i = 0 then
execute immediate'alter table PERF_COMPONET_POWER add ISEDIT VARCHAR2(35)';
  end if;



  select count(*) into i from user_tab_columns t where t.TABLE_NAME='PERF_COMPONET_POWER' and t.COLUMN_NAME='ID';
  if i = 0 then
execute immediate'alter table PERF_COMPONET_POWER add ID VARCHAR2(35)';
  end if;


execute immediate '
  create or replace view V_PERF_COMPONET_POWER as
  select * from perf_componet_power t
  where YEAR= global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'') and PROVINCE = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')
';