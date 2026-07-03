
begin

execute immediate '
create or replace view v_perf_t_deptgoaltask as
select t.*,b.GUID as taskguid,b.CONTEXT as task_context,b.ordernum as taskordernum from V_BGT_PERF_GOAL_INFO t 
left join PERF_T_DEPTGOALTASK a on t.GUID = a.goalguid and t.PROVINCE = a.province and t.YEAR = a.year
left join V_PERF_T_DEPTTASK b on b.GUID = a.taskguid and b.PROVINCE = a.province and b.YEAR = a.year
';