
 i number;
begin
select count(*) into i from user_tables t where t.table_name ='PERF_T_APPRAISAL';
if i=0 then
execute immediate 'create table PERF_T_APPRAISAL
(
  guid           VARCHAR2(32) not null,
  fileguid1      VARCHAR2(4000),
  fileguid2      VARCHAR2(4000),
  fileguid3      VARCHAR2(4000),
  fileguid4      VARCHAR2(4000),
  fileguid5      VARCHAR2(4000),
  fileguid6      VARCHAR2(4000),
  fileguid7      VARCHAR2(4000),
  fileguid8      VARCHAR2(4000),
  agencyguid     VARCHAR2(40),
  finintorgguid  VARCHAR2(40),
  wfid           VARCHAR2(40),
  wfstatus       VARCHAR2(40),
  auditor        VARCHAR2(32),
  lastupdatetime VARCHAR2(17),
  createtime     VARCHAR2(17) not null,
  updatetime     VARCHAR2(17),
  creater        VARCHAR2(40) not null,
  province       VARCHAR2(32) not null,
  year           NUMBER(4) not null
)';

execute immediate 'alter table PERF_T_APPRAISAL
  add constraint PK_PERF_T_APPRAISAL primary key (GUID, PROVINCE, YEAR)';
end if;

execute immediate '
create or replace view v_perf_t_appraisal as
select *
from perf_t_appraisal t where t.year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
          and t.province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';
