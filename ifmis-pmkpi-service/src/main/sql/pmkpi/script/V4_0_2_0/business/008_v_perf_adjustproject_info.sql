
i number;
begin
execute immediate '
create or replace view v_perf_adjustproject_info as
select t.*
  from v_perf_project_info t
 where t.wfstatus=''011''';

select count(*) into i from user_views  t where t.VIEW_NAME='V_BGT_PM_ANNUAL';
if i=1 then
  execute immediate '
  create or replace view v_perf_adjustproject_info as
  select *
    from v_perf_project_info t
   where exists (select 1
            from v_bgt_pm_annual an
           where an.is_deleted = 2
             and an.pro_code = t.pro_code
             and an.pro_code is not null)
  union
  select *
    from v_perf_project_info b
   where exists (select 1
            from v_perf_t_deptperfmiddeclare nz
           where nz.pro_code = b.pro_code
             and nz.wfstatus = ''011'')';    
end if;
