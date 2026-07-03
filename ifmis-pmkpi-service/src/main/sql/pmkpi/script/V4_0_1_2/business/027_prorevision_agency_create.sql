 i integer;
begin
  --绩效目标调整主表
  select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_PROREVISION_AGENCY';
  if i=0 then
   execute immediate '
create table PERF_PROREVISION_AGENCY
(
  guid          VARCHAR2(40) not null,
  code          VARCHAR2(40) not null,
  name          VARCHAR2(100) not null,
  update_time   VARCHAR2(20) default TO_DATE(TO_CHAR(SYSDATE,''YYYYMMDD''), ''YYYYMMDD''),
  status        NUMBER(1),
  create_time   VARCHAR2(20) default TO_DATE(TO_CHAR(SYSDATE,''YYYYMMDD''), ''YYYYMMDD''),
  creater       VARCHAR2(50),
  finintorgguid VARCHAR2(40),
  superid       VARCHAR2(40),
  levelno      NUMBER(2) default 1 not null
)';
execute immediate '
alter table PERF_PROREVISION_AGENCY
  add constraint PK_PERF_PROREVISION_AGENCY primary key (GUID)
';
end if;
