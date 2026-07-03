
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
select t.*
  from v_perf_project_info t
 where exists (
 select 1 from v_bgt_pm_annual t1 where
                t1.is_deleted = 2
                and t1.pro_code = t.pro_code
 ) or exists (
 select 1 from v_bgt_tra t2 where
                t2.is_deleted = 2
                and t2.fin_audit_money > 0
                and t2.agency_code not like ''300%''
                and t2.pro_code = t.pro_code
 )
 union
  select *
    from v_perf_project_info b
   where exists (select 1
            from v_perf_t_deptperfmiddeclare nz  --年中追加项目
           where nz.pro_code = b.pro_code
             and nz.wfstatus = ''011'')
 ';
 end if;
