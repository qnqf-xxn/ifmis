begin

execute immediate '
create or replace view perf_v_dvjkzpdb as 
select t.guid,t.pro_code,t.pro_name,t.agencyguid,t.finintorgguid,t.manage_mof_dep_code,t.pro_id as proguid,
a.guid as jkguid,b.guid as zpguid,
case when a.guid is null then ''否'' else ''是'' end as isjk,
case when b.guid is null then ''否'' else ''是'' end as iszp,
a.taskstage,a.bgtwarn,a.goalwarn,a.compwarn,a.depttask,a.provincetask,a.taskname,a.tasktype,a.year,a.taskguid,
b.score as evalselfscore
from v_perf_project_info t
left join perf_v_promonitor a on t.pro_id = a.proguid --and a.taskguid = ''E28B1121117C39515D081AE65925E072'' --默认展示监控任务id条件
left join perf_v_selfevaltask b on t.pro_id = b.projguid and b.bustype = ''program''
where a.guid is not null--只展示已纳入监控的项目条件
order by t.pro_code';