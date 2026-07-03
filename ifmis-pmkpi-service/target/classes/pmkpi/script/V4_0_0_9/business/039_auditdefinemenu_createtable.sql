i integer;
begin
  --绩效目标调整主表
  select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_T_AUDITDEFINEMENU';
  if i=0 then
     execute immediate '
create table PERF_T_AUDITDEFINEMENU
(
  guid       VARCHAR2(40) not null,
  code       VARCHAR2(50),
  name       VARCHAR2(200),
  remark     VARCHAR2(2000),
  superid    VARCHAR2(32),
  levelno    NUMBER(2),
  isleaf     NUMBER(1),
  ordernum   NUMBER(9),
  status     NUMBER(1),
  createtime VARCHAR2(17) default to_char(sysdate,''yyyyMMddHH24miss''),
  updatetime VARCHAR2(17) default to_char(sysdate,''yyyyMMddHH24miss''),
  creater    VARCHAR2(40),
  province   VARCHAR2(32),
  year       NUMBER(4)
)
comment on table PERF_T_AUDITDEFINEMENU
  is ''审核定义菜单表'';
  alter table PERF_T_AUDITDEFINEMENU
  add constraint PERF_T_AUDITDEFINEMENU primary key (GUID)
  using index';
-- Create/Recreate primary, unique and foreign key constraints 
execute immediate 'alter table PERF_T_AUDITDEFINEMENU
  add constraint PK_PERF_ADJUST primary key (GUID)
  using index ';
end if;
