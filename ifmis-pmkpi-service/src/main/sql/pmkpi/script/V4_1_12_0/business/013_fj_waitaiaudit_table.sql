i number;
begin

select count(*) into i from user_tables t where t.table_name ='PERF_T_WAITAISUPPORTAUDIT';
if i=0 then
execute immediate '
create table PERF_T_WAITAISUPPORTAUDIT
(
  pro_code   VARCHAR2(40) not null,
  province   VARCHAR2(9) not null,
  year       VARCHAR2(4) not null,
  actioncode VARCHAR2(4000) not null,
  status     VARCHAR2(40)
)';
end if;