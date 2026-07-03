
  i integer;
begin

  select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_T_PAGEMENU';
  if i=0 then
  execute immediate '
create table PERF_T_PAGEMENU
(
  guid       VARCHAR2(40) not null,
  code       VARCHAR2(50),
  name       VARCHAR2(200),
  uikey      VARCHAR2(2000),
  superguid  VARCHAR2(40),
  levelno    NUMBER(2),
  isleaf     NUMBER(1),
  ordernum   NUMBER(9),
  status     NUMBER(1),
  createtime VARCHAR2(17) default to_char(sysdate,''yyyyMMddHH24miss''),
  updatetime VARCHAR2(17) default to_char(sysdate,''yyyyMMddHH24miss''),
  creater    VARCHAR2(40),
  province   VARCHAR2(9),
  year       VARCHAR2(4)
)';
execute immediate '
comment on table PERF_T_PAGEMENU
  is ''“≥√Ê≈‰÷√≤Àµ•±Ì''';
execute immediate '
alter table PERF_T_PAGEMENU
  add constraint PERF_T_PAGEMENU primary key (GUID)
  using index';

 end if;
