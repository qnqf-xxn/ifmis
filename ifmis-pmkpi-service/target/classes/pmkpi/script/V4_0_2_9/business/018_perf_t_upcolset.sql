
i number;
begin

select count(*) into i from user_tables where TABLE_NAME = 'PERF_T_UPCOLSET';
if i=0 then
    execute immediate '
create table PERF_T_UPCOLSET
(
  guid         VARCHAR2(40) not null,
  tablecode    VARCHAR2(40),
  relevancycol VARCHAR2(100),
  upcoltype    VARCHAR2(10),
  wheresql     VARCHAR2(1000),
  remark       VARCHAR2(1000)
)';
execute immediate 'alter table PERF_T_UPCOLSET
  add constraint PK_PERF_UPCOLSET primary key (GUID)';

end if;
