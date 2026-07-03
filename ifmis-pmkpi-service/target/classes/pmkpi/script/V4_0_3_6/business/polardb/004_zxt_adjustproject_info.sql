-- View: bgt_330000.v_perf_adjustproject_info

-- DROP VIEW bgt_330000.v_perf_adjustproject_info;

CREATE OR REPLACE VIEW bgt_330000.v_perf_adjustproject_info
 AS
 SELECT t.*
   FROM v_perf_project_info t
where exists (
 select 1 from v_bgt_pm_annual t1 where
                t1.is_deleted = 2
                and t1.pro_code = t.pro_code
 ) or exists (
 select 1 from v_bgt_tra t2 where
                t2.is_deleted = 2
                --and t2.fin_audit_money > 0
                and t2.pro_code = t.pro_code
 );