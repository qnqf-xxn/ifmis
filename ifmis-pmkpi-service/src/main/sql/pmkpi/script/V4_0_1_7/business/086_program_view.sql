
i number;
begin

select count(*) into i from user_tables  t where t.TABLE_NAME='PM_PROJECT_INFO';
if i=1 then
execute immediate '
create or replace view v_perf_project_info as
select t.*
  from pm_project_info t
 where province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') 
 and nvl(t.lastaudit, 2) = 1 and t.is_deleted=2';
end if;
