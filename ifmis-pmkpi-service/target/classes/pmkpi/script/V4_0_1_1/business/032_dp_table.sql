
  i integer;
begin
  select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_PROJECT_INFODP';
  if i=0 then
     execute immediate '
      create table PERF_PROJECT_INFODP
(
  GUID           VARCHAR2(40) not null,
  PRO_ID         VARCHAR2(40) not null,
  PRO_CODE       VARCHAR2(40),
  PRO_NAME       VARCHAR2(360),
  PRO_LEV        VARCHAR2(9),
  TASKFLAG       VARCHAR2(40),
  AGENCY_CODE    VARCHAR2(40),
  WFSTATUS       VARCHAR2(40),
  WFID           VARCHAR2(40),
  LASTUPDATETIME VARCHAR2(40),
  AUDITOR        VARCHAR2(40),
  PROVINCE       VARCHAR2(9) not null,
  YEAR           CHAR(4) not null,
  CREATER        VARCHAR2(40),
  CREATE_TIME    VARCHAR2(40),
  UPDATE_TIME    VARCHAR2(40),
  AGENCYGUID     VARCHAR2(40),
  REMARK         VARCHAR2(2000)
)';

execute immediate 'create or replace view V_PERF_PROJECT_INFODP as
select * from PERF_PROJECT_INFODP where province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';
end if;

execute immediate 'create or replace view V_PERF_PROJECT_INFODPVIEW as
select t.*,t1.MOF_DEP_CODE from V_PERF_PROJECT_INFODP t left join V_PERF_PROJECT_INFO t1 on t.PRO_ID = t1.PRO_ID';
