begin
  
execute immediate'
create or replace view perf_v_rectify as
select t.pro_code as procode,t.proguid,t.taskguid,max(isrectify) as isrectify, max(rectifyend) as rectifyend
    from  v_perf_t_rectify t group by proguid,pro_code,taskguid';
