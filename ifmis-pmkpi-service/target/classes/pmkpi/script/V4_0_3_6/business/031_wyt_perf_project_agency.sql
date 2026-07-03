i number; 
begin
  --项目变更单位维护表 删除唯一约束
  select count(*) into i from user_constraints t where t.table_name = 'PERF_PROJECT_AGENCY' and t.constraint_type = 'U';
  if i > 0 then
    execute immediate 'ALTER TABLE PERF_PROJECT_AGENCY DROP CONSTRAINT UK_PERF_PROJECT_AGENCY';
  end if;
  
  --添加索引
  select count(*) into i from user_indexes t where table_name='PERF_PROJECT_AGENCY' and t.index_name='UK_PERF_PROJECT_AGENCY'; 
  if i = 0 then
      execute immediate 'create unique index UK_PERF_PROJECT_AGENCY on PERF_PROJECT_AGENCY (PRO_CODE,YEAR,PROVINCE)';
  end if;   
