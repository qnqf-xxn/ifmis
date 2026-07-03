 i number(9);
begin
  select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_TMP_WORKTASKASSIGN';
  if i=0 then
     execute immediate '
      create global temporary table PERF_TMP_WORKTASKASSIGN
      (
        guid          VARCHAR2(40) not null,
        agencyguid    VARCHAR2(40),
        tasktype      VARCHAR2(40),
        code          VARCHAR2(40),
        name          VARCHAR2(500),
        year          VARCHAR2(4) not null,
        province      VARCHAR2(9) not null,
        subprovince   VARCHAR2(40),
        finintorgguid VARCHAR2(40),
        score         NUMBER(5,2)
      )
      on commit delete rows ';
 end if;
