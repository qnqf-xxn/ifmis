
 i number(1);
begin


select count(*) into i from user_constraints t where t.table_name = upper('PERF_ENUM') and t.constraint_type = 'P';
  if i > 0 then
    execute immediate 'alter table PERF_ENUM drop constraint PK_PERF_ENUM_CONSTRAINT';
    select count(*) into i from user_indexes t where table_name=upper('PERF_ENUM') and t.index_name='PK_PERF_ENUM_CONSTRAINT'; 
    if i > 0 then
       execute immediate 'drop index PK_PERF_ENUM_CONSTRAINT';
    end if;

    execute immediate 'alter table PERF_ENUM add constraint PK_PERF_ENUM_CONSTRAINT primary key (GUID, PROVINCE, ELEMENTCODE)';
  else
    execute immediate 'alter table PERF_ENUM add constraint PK_PERF_ENUM_CONSTRAINT primary key (GUID, PROVINCE, ELEMENTCODE)';
  end if;
