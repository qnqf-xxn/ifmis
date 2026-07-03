i integer;
begin
  --待办参数信息表
  select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_PENDINGTASK';
  if i=0 then
     execute immediate '
create table PERF_PENDINGTASK
(
  guid     VARCHAR2(32) not null,
  key      VARCHAR2(300),
  name      VARCHAR2(300),
  param    VARCHAR2(300),
  status   NUMBER(1),
  province VARCHAR2(32),
  year     NUMBER(4)
)';
-- Create/Recreate primary, unique and foreign key constraints 
execute immediate 'alter table PERF_PENDINGTASK
  add constraint PK_PERF_PENDINGTASK primary key (GUID, PROVINCE, YEAR)
  using index ';
end if;
execute immediate '
create or replace view V_PERF_PENDINGTASK as
select * 
from PERF_PENDINGTASK t';  
