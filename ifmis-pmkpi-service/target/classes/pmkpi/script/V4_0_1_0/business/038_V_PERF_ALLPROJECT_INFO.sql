i integer;
begin
  select count(*) into i from user_tables  t where t.TABLE_NAME='PM_PROJECT_INFO';
  if i=1 then
    execute immediate 'create or replace view V_PERF_ALLPROJECT_INFO as 
    select * from PM_PROJECT_INFO 
    where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'') 
    and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';
  else 
    execute immediate 'create or replace view V_PERF_ALLPROJECT_INFO as 
    select * from PERF_PROJECT_INFO 
    where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'') 
    and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';
  end if;