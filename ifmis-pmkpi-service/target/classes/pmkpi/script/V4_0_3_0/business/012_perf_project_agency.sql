
  i number;
begin
  select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_PROJECT_AGENCY';
  if i=0 then
     execute immediate '
create table PERF_PROJECT_AGENCY
(
  guid        VARCHAR2(40) not null,
  pro_code    VARCHAR2(40) not null,
  agency_code VARCHAR2(40) not null,
  year        VARCHAR2(4) not null,
  province    VARCHAR2(9) not null,
  createtime  VARCHAR2(17) default TO_CHAR(SYSDATE,''YYYYMMDDhh24miss''),
  updatetime  VARCHAR2(17) default TO_CHAR(SYSDATE,''YYYYMMDDhh24miss'')
)';
execute immediate '
alter table PERF_PROJECT_AGENCY
  add constraint PK_PERF_PROJECT_AGENCY primary key (GUID, YEAR, PROVINCE)';
execute immediate '
alter table PERF_PROJECT_AGENCY
  add constraint UK_PERF_PROJECT_AGENCY unique (PRO_CODE)';
end if;

execute immediate '
create or replace view v_perf_project_agency as
select *
from perf_project_agency where province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';
