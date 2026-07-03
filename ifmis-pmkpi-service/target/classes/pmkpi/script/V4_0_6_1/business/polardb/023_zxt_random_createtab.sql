
  i integer;
begin
  --抽评随机抽取设置表
  select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_T_RANDOM';
  if i=0 then
     execute immediate '
	 CREATE TABLE PERF_T_RANDOM
	(
		guid VARCHAR2(40) not null,
		random VARCHAR2(40),
		bustype VARCHAR2(40)
	)
';
  end if;

