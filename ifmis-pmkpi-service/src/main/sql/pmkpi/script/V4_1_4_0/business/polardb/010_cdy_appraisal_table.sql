  i number;
  v_sql varchar2(2000);
  ln_i integer;
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

v_sql :='
create or replace view V_PERF_T_APPRAISAL as
select *
from perf_t_appraisal t where t.year = global_multyear_cz.v_pmyear
          and t.province = global_multyear_cz.v_pmdivid';
select fn_alterview('V_PERF_T_APPRAISAL',v_sql) into ln_i;
if ln_i = 0 then
	return;
end if;	 