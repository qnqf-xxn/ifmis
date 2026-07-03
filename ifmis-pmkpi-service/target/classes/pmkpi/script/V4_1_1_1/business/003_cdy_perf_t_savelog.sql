
  i number;
begin
  select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_T_SAVELOG';
  if i=0 then
  execute immediate '
  create table PERF_T_SAVELOG
  (
    guid        VARCHAR2(40) not null,
    pro_id      VARCHAR2(40),
    pro_code    VARCHAR2(40),
    update_time VARCHAR2(17),
    creater     VARCHAR2(40),
    type        VARCHAR2(40)
  )';
  execute immediate 'alter table PERF_T_SAVELOG
    add constraint PK_PERF_SAVELOG primary key (GUID)';
  end if;
