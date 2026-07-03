 
  i integer;
begin
  
  select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_FILETYPE';
  if i=0 then
     execute immediate '
create table PERF_FILETYPE
(
  guid       VARCHAR2(40) not null,
  code       VARCHAR2(20) not null,
  name       VARCHAR2(200) not null,
  remark     VARCHAR2(200),
  superid    VARCHAR2(40),
  levelno    NUMBER(1),
  isleaf     NUMBER(2),
  ordernum   NUMBER(9),
  status     NUMBER(1) default 1,
  bustype    VARCHAR2(40),
  createtime VARCHAR2(17),
  updatetime VARCHAR2(17),
  year       NUMBER(4) not null,
  province   VARCHAR2(32) not null
)';
-- Create/Recreate primary, unique and foreign key constraints 
execute immediate 'alter table PERF_FILETYPE
  add constraint PK_PERF_FILETYPE primary key (GUID)
  using index ';
   end if;
   
