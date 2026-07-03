i integer;
begin
  --绩效目标调整主表
  select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_ENUM';
  if i=0 then
     execute immediate '
create table PERF_ENUM
(
  guid        VARCHAR2(64) not null,
  code        VARCHAR2(100),
  elementcode VARCHAR2(100),
  name        VARCHAR2(200),
  status      CHAR(1),
  createtime  VARCHAR2(17),
  updatetime  VARCHAR2(17),
  year        CHAR(4),
  province    VARCHAR2(9) not null,
  version     NUMBER(9),
  appid       VARCHAR2(100),
  superid     VARCHAR2(38),
  levelno     NUMBER(2) default 1,
  isleaf      NUMBER(1) default 1,
  remark      VARCHAR2(4000),
  creater     VARCHAR2(40),
  ordernum    NUMBER(9)
)';
-- Create/Recreate primary, unique and foreign key constraints 
execute immediate 'alter table PERF_ENUM
  add constraint PERF_ENUM primary key (GUID, PROVINCE)
  using index';
end if;
execute immediate '
create or replace view v_perf_enum as
select * FROM PERF_ENUM T
      WHERE T.PROVINCE = global_multyear_cz.Secu_f_Global_Parm(''DIVID'')';
