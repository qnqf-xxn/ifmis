CREATE OR REPLACE VIEW perf_v_expdeptself
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
	t1.rectification,
	t1.deviationanaly,
	t1.selfaddinfo,
    round(t4.amt1sum, 2) AS amt1sum,
    round(t4.amt3sum, 2) AS amt3sum,
    round(t4.amt4sum, 2) AS amt4sum,
    round(t4.amt6sum, 2) AS amt6sum,
    t4.bgtgetsum,
    t.guid,
    t.code,
    t.name,
    t.evalstatus,
    t.evalstart,
    t.evalend,
    t.c1,
    t.c2,
    t.c3,
    t.c4,
    t.c5,
    t.c6,
    t.c7,
    t.c8,
    t.c9,
    t.c10,
    t.c11,
    t.c12,
    t.c13,
    t.agencyguid,
    t.wfstatus,
    t.status,
    t.createtime,
    t.updatetime,
    t.creater,
    t.province,
    t.year,
    t.ordernum,
    t.finintorgguid,
    t.wfid,
    t.auditor,
    t.lastupdatetime,
    t.month,
    t.perfgoalguid,
    t.projguid,
    t.bustype,
    t.prokind,
    t.remainingdays,
    t.is_deleted,
    t.pro_code,
    t.manage_dept_code,
    t.manage_mof_dep_code,
    t.mof_dep_code,
    t.dept_code,
    t.bgtget,
    t.pro_lev,
    t.pro_total_amt,
    t.bgtamt,
    t.budgetamount,
    t.execamount,
    t.rectifytype,
    t.ybystzh,
    t.warndays,
    t.score,
    t.selfresult,
    t.warn
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
           FROM v_perf_t_selfperfindex where levelno = '3'
          GROUP BY v_perf_t_selfperfindex.mainguid) t5 ON (((t5.mainguid)::text = (t.guid)::text)))
     LEFT JOIN ( SELECT v_bgt_perf_indicator.agencyguid,
            sum(nvl(v_bgt_perf_indicator.score, (0)::numeric)) AS actualweightsum
           FROM v_bgt_perf_indicator
          WHERE ((v_bgt_perf_indicator.is_deleted = '2'::numeric))
          GROUP BY v_bgt_perf_indicator.agencyguid) t6 ON (((t6.agencyguid)::text = (t.code)::text)))
     LEFT JOIN ( SELECT *
           FROM v_bgt_perf_goal_info
          WHERE ((is_deleted = (2)::numeric))) goal ON (((goal.agencyguid)::text = (t.code)::text)))
  WHERE ((t.bustype)::text = 'dept'::text);