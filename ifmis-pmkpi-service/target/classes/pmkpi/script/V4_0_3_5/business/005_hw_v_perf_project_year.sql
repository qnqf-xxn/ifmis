    i number;
begin

select count(*) into i from user_views  t where t.VIEW_NAME='V_BGT_PM_ANNUAL';
if i=1 then
execute immediate'create or replace view v_perf_project_year as
select
  a.guid,
  a.pro_id,
  a.pro_code,
  a.pro_name,
  a.agencyguid,
  a.agency_code,
  a.dept_code,
  a.finintorgguid,
  a.mof_dep_code,
  a.manage_dept_code,
  a.creater,
  a.create_time,
  a.update_time,
  a.version,
  a.version_name,
  a.mof_div_code,
  a.setup_year,
  a.province,
  a.year,
  a.wfid,
  a.wfstatus,
  a.traobj_agency_code,
  a.cen_tra_pro_code,
  a.pro_source_code,
  a.pro_term,
  a.pro_start_year,
  a.fun_res_code,
  a.pro_cat_code,
  a.distri_type_code,
  a.is_track,
  a.is_captial_cons_pro,
  a.pro_total_amt,
  a.scoi_invest_fund,
  a.pro_desc,
  a.draft_template_code,
  a.is_end,
  a.is_scientific,
  a.is_deleted,
  a.is_useset,
  a.ispublish,
  a.ishistory,
  a.lastupdatetime,
  a.fromguid,
  a.adjstatus,
  a.projectkind,
  a.manage_mof_dep_code,
  b.bgtamt,
  a.pro_lev
from
  v_perf_project_info a,
  (select p.pro_code,
          case
            when p.reply_amt <> 0 then
            p.reply_amt
            when p.reply_amt = 0 and p.fin_audit_money <> 0 then
            p.fin_audit_money
            when p.reply_amt = 0 and p.fin_audit_money = 0 then
            p.apply_up
            else
            0
          end bgtamt
    from (select t.pro_code,
                  sum(t.apply_up) apply_up, --申报数,
                  sum(fin_audit_money) fin_audit_money, --审核数,
                  sum(reply_amt) reply_amt --批复数
            from v_bgt_pm_annual t --部门预算项目
            where t.is_deleted = 2
              and taskguid in
                  (''A69147082E975D0733386A42C3E5F4B5'',
                  ''9EE3A842793449818960559B00660C1B'')
            group by t.pro_code
          union all
          select t.pro_code,
                  sum(t.apply_up) apply_up, --申报数,
                  sum(fin_audit_money) fin_audit_money, --审核数,
                  sum(reply_amt) reply_amt --批复数
            from v_bgt_tra t --转移支付项目
            where t.is_deleted = 2
            group by t.pro_code) p) b
where
  a.pro_code = b.pro_code

union

select
  a.guid,
  a.pro_id,
  a.pro_code,
  a.pro_name,
  a.agencyguid,
  a.agency_code,
  a.dept_code,
  a.finintorgguid,
  a.mof_dep_code,
  a.manage_dept_code,
  a.creater,
  a.create_time,
  a.update_time,
  a.version,
  a.version_name,
  a.mof_div_code,
  a.setup_year,
  a.province,
  a.year,
  a.wfid,
  a.wfstatus,
  a.traobj_agency_code,
  a.cen_tra_pro_code,
  a.pro_source_code,
  a.pro_term,
  a.pro_start_year,
  a.fun_res_code,
  a.pro_cat_code,
  a.distri_type_code,
  a.is_track,
  a.is_captial_cons_pro,
  a.pro_total_amt,
  a.scoi_invest_fund,
  a.pro_desc,
  a.draft_template_code,
  a.is_end,
  a.is_scientific,
  a.is_deleted,
  a.is_useset,
  a.ispublish,
  a.ishistory,
  a.lastupdatetime,
  a.fromguid,
  a.adjstatus,
  a.projectkind,
  a.manage_mof_dep_code,
  a.pro_total_amt as bgtamt,
  a.pro_lev
from
  v_perf_project_info a
where
  exists (select 1 from v_perf_t_deptperfmiddeclare nz where nz.pro_code = a.pro_code and nz.wfstatus = ''011'')   --年中追加项目
';
end if;
