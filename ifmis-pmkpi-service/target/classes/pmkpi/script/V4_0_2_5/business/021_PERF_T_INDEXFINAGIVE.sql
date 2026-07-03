 i number;
begin
select count(*) into i from user_tables t where t.TABLE_NAME='PERF_T_INDEXFINAGIVE';
  if i=0 then
     execute immediate '
create table PERF_T_INDEXFINAGIVE
(
  guid        VARCHAR2(40) not null,
  agencycode  VARCHAR2(40),
  agencyguid  VARCHAR2(40),
  agencyname  VARCHAR2(40),
  elonecode   VARCHAR2(40),
  eloneguid   VARCHAR2(40),
  elonename   VARCHAR2(200),
  eltwocode   VARCHAR2(40),
  eltwoname   VARCHAR2(200),
  eltwoguid   VARCHAR2(40),
  elementcode VARCHAR2(40),
  wfid        VARCHAR2(40),
  wfstatus    VARCHAR2(40),
  is_deleted  NUMBER(1),
  createtime  VARCHAR2(17) not null,
  updatetime  VARCHAR2(17) default to_char(sysdate,''yyyyMMddHH24miss''),
  creater     VARCHAR2(40) not null,
  province    VARCHAR2(32) not null,
  year        NUMBER(4) not null
)';
-- Create/Recreate primary, unique and foreign key constraints 
execute immediate 'alter table PERF_T_INDEXFINAGIVE
  add constraint pk_perf_INDEXFINAGIVE primary key (GUID)';
end if;

execute immediate '
create or replace view v_perf_t_indexfinagive as
select * FROM PERF_T_INDEXFINAGIVE T
      WHERE  province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and is_deleted =2
';
