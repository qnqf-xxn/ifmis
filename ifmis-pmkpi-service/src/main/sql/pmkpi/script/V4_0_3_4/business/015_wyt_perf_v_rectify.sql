begin
  execute immediate'
  create or replace view perf_v_rectify as
select t.PRO_CODE as procode,t.PROGUID,t.TASKNAME,max(ISRECTIFY) as ISRECTIFY, max(RECTIFYEND) as RECTIFYEND
    from  v_perf_t_rectify t group by proguid,pro_code,taskname';
