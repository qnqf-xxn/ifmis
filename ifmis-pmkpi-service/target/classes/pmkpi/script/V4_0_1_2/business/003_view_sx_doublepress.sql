begin
   execute immediate '
create or replace view v_perf_project_review as
select t.*,t1.pro_name from V_PERF_T_REVIEW t left join V_PERF_PROJECT_INFO t1 on t.proguid = t1.pro_id';
