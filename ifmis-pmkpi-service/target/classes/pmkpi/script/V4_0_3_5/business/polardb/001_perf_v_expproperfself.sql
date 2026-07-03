-- View: bgt_330000.perf_v_expproperfself

-- DROP VIEW bgt_330000.perf_v_expproperfself;

CREATE OR REPLACE VIEW bgt_330000.perf_v_expproperfself
 AS
 SELECT t.guid AS busguid,
    t2.name AS bmname,
    t2.code AS bmcode,
    t3.code AS dwcode,
    t3.name AS dwname,
    t5.scoresum,
    t6.actualweightsum,
    goal.kpi_target AS yeargoal,
    t1.allyeargoal,
    round(t4.amt1sum, 2) AS amt1sum,
    round(t4.amt3sum, 2) AS amt3sum,
    round(t4.amt4sum, 2) AS amt4sum,
    round(t4.amt6sum, 2) AS amt6sum,
    t4.bgtgetsum,
    t.*
   FROM (((((((perf_v_selfevaltask t
     LEFT JOIN v_perf_selfdeptdesc t1 ON (((t.guid)::text = (t1.mainguid)::text)))
     LEFT JOIN fasp_t_pubagency t2 ON ((("left"(t.agencyguid, 3))::text = (t2.code)::text)))
     LEFT JOIN fasp_t_pubagency t3 ON (((t.agencyguid)::text = (t3.code)::text)))
     LEFT JOIN ( SELECT perf_v_expselfprofund.busguid,
            sum(perf_v_expselfprofund.amt1) AS amt1sum,
            sum(perf_v_expselfprofund.amt3) AS amt3sum,
            sum(perf_v_expselfprofund.amt4) AS amt4sum,
            sum(perf_v_expselfprofund.amt5) AS amt5sum,
            sum(perf_v_expselfprofund.amt6) AS amt6sum,
                CASE
                    WHEN ((nvl(sum(perf_v_expselfprofund.amt4), (0)::numeric) + nvl(sum(perf_v_expselfprofund.amt6), (0)::numeric)) = (0)::numeric) THEN '0%'::text
                    ELSE ((round((((sum(perf_v_expselfprofund.amt4) + nvl(sum(perf_v_expselfprofund.amt6), (0)::numeric)) / sum(perf_v_expselfprofund.amt3)) * (100)::numeric), 2))::text || '%'::text)
                END AS bgtgetsum
           FROM perf_v_expselfprofund
          GROUP BY perf_v_expselfprofund.busguid) t4 ON (((t4.busguid)::text = (t.guid)::text)))
     LEFT JOIN ( SELECT v_perf_t_selfperfindex.mainguid,
            sum(nvl(v_perf_t_selfperfindex.score, (0)::numeric)) AS scoresum
           FROM v_perf_t_selfperfindex
          GROUP BY v_perf_t_selfperfindex.mainguid) t5 ON (((t5.mainguid)::text = (t.guid)::text)))
     LEFT JOIN ( SELECT v_pm_perf_indicator.pro_code,
            sum(nvl(v_pm_perf_indicator.weight, (0)::numeric)) AS actualweightsum
           FROM v_pm_perf_indicator where yearflag = '0' and is_deleted = '2'
          GROUP BY v_pm_perf_indicator.pro_code) t6 ON (((t6.pro_code)::text = (t.code)::text)))
     LEFT JOIN ( SELECT v_pm_perf_goal_info.guid,
            v_pm_perf_goal_info.agencyguid,
            v_pm_perf_goal_info.zqgoal,
            v_pm_perf_goal_info.ndgoal,
            v_pm_perf_goal_info.mainguid,
            v_pm_perf_goal_info.createtime,
            v_pm_perf_goal_info.updatetime,
            v_pm_perf_goal_info.creater,
            v_pm_perf_goal_info.province,
            v_pm_perf_goal_info.year,
            v_pm_perf_goal_info.kpi_per_id,
            v_pm_perf_goal_info.mof_div_code,
            v_pm_perf_goal_info.fiscal_year,
            v_pm_perf_goal_info.pro_code,
            v_pm_perf_goal_info.kpi_target,
            v_pm_perf_goal_info.version,
            v_pm_perf_goal_info.version_name,
            v_pm_perf_goal_info.sub_mof_code,
            v_pm_perf_goal_info.update_time,
            v_pm_perf_goal_info.is_deleted,
            v_pm_perf_goal_info.create_time,
            v_pm_perf_goal_info.agency_code,
            v_pm_perf_goal_info.proguid,
            v_pm_perf_goal_info.fromguid,
            v_pm_perf_goal_info.yearflag,
            v_pm_perf_goal_info.busi_type_code,
            v_pm_perf_goal_info.fromisdel
           FROM v_pm_perf_goal_info
          WHERE (((v_pm_perf_goal_info.yearflag)::text = '0'::text) AND (v_pm_perf_goal_info.is_deleted = (2)::numeric))) goal ON (((goal.pro_code)::text = (t.pro_code)::text)))
  WHERE ((t.bustype)::text = 'program'::text);

