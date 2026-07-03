
  i integer;
begin
  select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_TMP_AUDITERRORINFO';
  if i=0 then
     execute immediate '
  create global temporary table PERF_TMP_AUDITERRORINFO
  (
    guid       VARCHAR2(40) not null,
    busguid  VARCHAR2(40),
    remark   VARCHAR2(500)
  )
  on commit delete rows';
  end if;
  
    select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_TMP_DEPTFUNCERROR';
  if i=0 then
     execute immediate '
  create global temporary table PERF_TMP_DEPTFUNCERROR
  (
    guid       VARCHAR2(40) not null,
    busguid  VARCHAR2(40),
    remark   VARCHAR2(500)
  )
  on commit delete rows';
  end if;
  
  select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_TMP_AUDITDEFINEWHERESQL';
  if i=0 then
     execute immediate '
    create global temporary table PERF_TMP_AUDITDEFINEWHERESQL
    (
      KEY       VARCHAR2(100),
      VALUE  VARCHAR2(500)
    )
    on commit delete rows';
  end if;
