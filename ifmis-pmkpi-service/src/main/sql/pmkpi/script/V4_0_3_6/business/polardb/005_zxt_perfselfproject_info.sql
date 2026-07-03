CREATE OR REPLACE VIEW bgt_330000.v_perf_perfselfproject_info
 AS
    SELECT t.*,
  nvl((select sum(t1.reply_amt) from bgt_330000.v_bgt_pm_annual t1 where
                t1.is_deleted = 2
                and t1.pro_code = t.pro_code
                and nvl(t1.reply_amt,0)<>0),0) +
       nvl((select sum(t2.reply_amt) from bgt_330000.v_bgt_tra t2 where
                t2.is_deleted = 2
                and t2.pro_code = t.pro_code
                and nvl(t2.reply_amt,0)<>0),0)  as bgtamt --µ±ÄêÔ¤Ëã½ð¶î
   FROM bgt_330000.v_perf_project_info t
   WHERE t.pro_cat_code in('22','3') 
 and (EXISTS (select 1 from bgt_330000.perf_t_profund a where a.pro_code =t.pro_code 
  and a.fiscal_year =bgt_330000.global_multyear_cz.v_pmyear group by a.pro_code having sum(amt3)<>0
  ) or exists (
 SELECT 1 FROM bgt_330000.v_perf_t_deptperfmiddeclare t3 where 
	 			t3.wfstatus = '011'
	 			and t3.pro_code = t.pro_code 
 ) or t.pro_lev = '1')