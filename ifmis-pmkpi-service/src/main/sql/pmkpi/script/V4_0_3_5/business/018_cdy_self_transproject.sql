
i number;
begin
  execute immediate '
  create or replace view v_perf_self_transproject as
  select t.*
  from v_perf_project_info t where
  exists(select 1 from v_perf_transfer_project a where a.wfstatus=''011'' and t.pro_code=a.pro_code)';

  select count(*) into i from user_views  t where t.VIEW_NAME='V_BGT_PM_ANNUAL';
  if i=1 then
    execute immediate '
create or replace view v_perf_self_transproject as
select t.pro_id,
       t.pro_code,
       t.pro_name,
       decode(k.agency_code, null, t.agency_code, k.agency_code) as agency_code,
       t.dept_code,
       decode(k.agency_code, null, t.agency_code, k.agency_code) as agencyguid,
       t.mof_dep_code,
       t.manage_dept_code,
       t.manage_mof_dep_code,
       t.finintorgguid,
       t.pro_cat_code,
       t.pro_lev,
       t.guid,
       t.year,
       t.province,
       t.pro_total_amt,
       nvl((select sum(t1.cur_amt) from v_bgt_pm_annual t1 where
                t1.is_deleted = 2
                and t1.pro_code = t.pro_code
                and nvl(t1.cur_amt,0)<>0),0) +
       nvl((select sum(t2.cur_amt) from v_bgt_tra t2 where
                t2.is_deleted = 2
                and t2.fin_audit_money > 0
                and t2.agency_code not like ''300%''
                and t2.pro_code = t.pro_code
                and nvl(t2.cur_amt,0)<>0),0)  as bgtamt --µ±ÄêÔ¤Ëã½ð¶î
  from v_perf_project_info t
  left join v_perf_project_agency k
    on t.pro_code = k.pro_code
 where (exists (
 select 1 from v_bgt_pm_annual t1 where
                t1.is_deleted = 2
                and t1.pro_code = t.PRO_CODE
 ) or exists (
 select 1 from v_bgt_tra t2 where
                t2.is_deleted = 2
                and t2.fin_audit_money > 0
                and t2.agency_code not like ''300%''
                and t2.pro_code = t.pro_code
 ))
 and exists(select 1 from v_perf_transfer_project a where a.wfstatus=''011'' and t.pro_code=a.pro_code)
';
  end if;
