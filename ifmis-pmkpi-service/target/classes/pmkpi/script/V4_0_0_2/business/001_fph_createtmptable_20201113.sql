
 
  i integer;
begin
  select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_TMP_PARAM';
  if i=0 then
     execute immediate '
create global temporary table PERF_TMP_PARAM
(
  guid VARCHAR2(40) not null
)
on commit delete rows';
  end if;

  select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_TMP_AUDITITEMS';
  if i=0 then
     execute immediate '
create global temporary table PERF_TMP_AUDITITEMS
(
  guid VARCHAR2(40) not null
)
on commit delete rows';
  end if;


