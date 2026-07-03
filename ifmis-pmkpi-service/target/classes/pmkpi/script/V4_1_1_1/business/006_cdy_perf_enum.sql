
 i number(1);
begin


select count(*) into i from user_constraints t where t.table_name = upper('PERF_ENUM') and t.constraint_type = 'P';
  if i > 0 then
    execute immediate 'alter table PERF_ENUM drop constraint PK_PERF_ENUM cascade';
    select count(*) into i from user_indexes t where table_name=upper('PERF_ENUM') and t.index_name='PK_PERF_ENUM'; 
    if i > 0 then
       execute immediate 'drop index PK_PERF_ENUM';
    end if;

    execute immediate 'alter table PERF_ENUM add constraint PK_PERF_ENUM primary key (GUID, PROVINCE, ELEMENTCODE) using index';
  else
    execute immediate 'alter table PERF_ENUM add constraint PK_PERF_ENUM primary key (GUID, PROVINCE, ELEMENTCODE) using index';
  end if;
