 i integer;
begin
  select count(*) into i from user_tables where table_name = upper('PERF_T_AUDITDEFINEWHERESQL');
if i = 1 then
    execute immediate 'drop table PERF_T_AUDITDEFINEWHERESQL';
end if;
execute immediate'
create table PERF_T_AUDITDEFINEWHERESQL
(
  key   VARCHAR2(100),
  value VARCHAR2(500)
)';
