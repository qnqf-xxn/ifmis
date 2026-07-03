i number;
begin
  select count(*) into i from user_tables  t where t.table_name='PM_PROJECT_INFO';
    if i=1 then
      execute immediate'
      create or replace view v_perf_project_info as
select t.pro_id,t.pro_code,t.pro_name,t.pro_cat_code,t.agency_code,t.agency_name,t.mof_dep_code,t.mof_dep_name,t.finintorgguid,t.pro_phase,
      t.dept_code,t.dept_name,t.bgt_dept_code as manage_dept_code,t.bgt_mof_dep_code as manage_mof_dep_code,t.create_time,t.update_time,t.version,t.version_name,t.is_deleted,t.guid,t.mof_div_code,t.lastaudit,t.wfstatus,
      t.wfid,t.creater,t.lastupdatetime,t.auditor,t.province,t.year,t.adjstatus,t.fromguid,t.ishistory,t.agency_code as agencyguid,t.projectkind,t.level_no,t.level_no as pro_lev, t.setup_year,t.bgt_mof_dep_code,t.bgt_mof_dep_name,t.bgt_dept_code,
      t.bgt_dept_name,t.pro_total_amt,t.pro_total_amt_old,t.no_fin_fund,t.pro_term,t.pro_operator,t.pro_operator_tel,parent_pro_id,t.parent_pro_code,parent_pro_name,t.is_leaf,t.fun_res_code,t.track_pro_code,t.track_pro_name,t.cen_tra_pro_code,t.cen_tra_pro_name
      ,pro_start_year,t.v_col1,t.v_col2,t.v_col3,t.v_col4,t.v_col5,parent_pro_code as pro_levone_code,
      t.traobj_agency_code, t.pro_source_code, t.distri_type_code, t.draft_template_code, t.pro_desc, t.exp_func_code,
      t.is_useset, t.is_track, t.is_end, t.is_captial_cons_pro, t.is_scientific, t.pro_depreview, t.pro_bgtreview, t.dep_aud_opinion_code,
      t.mof_aud_opinion_code, t.store_phase, t.leader_phone, t.is_perform, t.is_attach, t.is_govpur,
      t.is_bgt, t.is_thin, t.is_other_edit, t.is_wait_divide, t.is_divide_pro, t.is_to_down, t.mid_plan_year, t.orderno1,
      t.orderno2, t.orderno3, t.orderno4, t.vchtypeid, t.v_col6, t.v_col7, t.v_col8, t.v_col9, t.v_col10, t.v_col11,
      t.v_col12, t.v_col13, t.v_col14, t.v_col15, t.v_col16, t.v_col17, t.v_col18, t.v_col19, t.v_col20, t.v_col21,
      t.v_col22, t.v_col23, t.v_col24, t.v_col25, t.v_col26, t.v_col27, t.v_col28, t.v_col29, t.v_col30, t.n_col1,
      t.n_col2, t.n_col3, t.n_col4, t.n_col5, t.n_col6, t.n_col7, t.n_col8, t.ispublish, t.is_fromup, t.pro_tra_status,
      t.sub_agency_name, t.is_urgent, t.qksfbs, t.zdzjjqpt, t.directfunds, t.subsidy, t.sub_mof_div_code, t.pro_grade,
      t.pro_bases, t.pro_other, t.pro_bases_type, t.is_increase_people_money, t.integrate_category, t.is_outsave,
      t.is_bgt_append, t.generate_flag, t.sup_bgt_doc_no, t.is_carryover, t.bdg_detail_flag, t.v_col31, t.v_col32,
      t.v_col33, t.v_col34, t.v_col35, t.v_col36, t.v_col37, t.v_col38, t.v_col39, t.v_col40, t.is_from_copy,
      t.from_copy_guid, '''' as is_midplan, t.is_fromdept, '''' as is_infin, t.grade_num, t.mof_div_name, t.pro_cat_name,
      t.fun_res_name, t.distri_type_name, t.traobj_agency_name, t.pro_source_name, t.draft_template_name,
      t.curexpenditure_type_name, t.captial_cons_pro_type_name, t.prov_aud_opinion_name, t.up_mof_div_name,
      t.gd_bond, t.is_backup, t.pro_address, t.curexpenditure_type_code, t.captial_cons_pro_type_code, t.dept_stock_code,
      t.is_submit_upmofpro, t.up_mof_div_code, t.prov_bgtreview, t.prov_aud_opinion_code, t.mofdpt_bgtreview,
      t.mofdpt_aud_opinion_code, t.threesafe_symbolcat_code, t.threesafe_symbolcat_name, t.prov_aud_opinion_remark,
      t.mofdpt_aud_opinion_name, t.manage_mof_dep_name, t.manage_dept_name, t.bonds_procat_code, t.bonds_procat_name,
      t.loangrant_procat_code, t.loangrant_procat_name,t.pro_operator as leader_name,t.pro_operator_tel as leader_tel,
      t.parent_pro_id as pro_levone_id,t.parent_pro_name as pro_levone_name,'''' as bank_loan_fund,'''' as scoi_invest_fund
from pm_project_info t
where t.is_backup=2
and nvl(t.lastaudit, 2) = 1
and t.is_deleted=2
and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';
       
    end if;