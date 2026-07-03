begin

execute immediate 'CREATE OR REPLACE VIEW v_perf_randomrectify_proj
 AS
 SELECT a.guid,
        CASE
            WHEN ((t1.level_no) = ''1'') THEN ''2''
            WHEN ((t1.level_no) = ''2'') THEN ''1''
            ELSE ''3''
        END AS projtype,
    t1.pro_code AS projcode,
    t1.pro_code,
    t1.pro_name AS projname,
    t1.pro_name,
    t1.mof_dep_code,
    t1.agencyguid,
    --t1.exp_func_code,
    t1.dept_code,
    --t1.ispublish,
    t1.fromguid,
    --t1.pro_grade,
    t1.adjstatus,
    t1.lastupdatetime,
    t1.finintorgguid,
    t1.agency_code AS ysdw,
    t1.agency_code AS dwid,
    t1.finintorgguid AS csid,
    t1.mof_div_code,
    t1.wfid,
    a.perfgoalguid,
    d.isfinal,
    t1.ishistory,
    d.type,
        CASE
            WHEN ((t1.level_no) = ''1'') THEN ''2''
            WHEN ((t1.level_no) = ''2'') THEN ''1''
            ELSE ''3''
        END AS bustype
   FROM (((v_perf_t_randomcomment a
     LEFT JOIN ( SELECT * FROM v_perf_t_rectify
          WHERE (((delstatus) = ''0'') AND (isfinal = ''2''))) d ON (((a.guid) = (d.proguid))))
     LEFT JOIN pm_perf_goal_info b ON (((a.perfgoalguid) = (b.guid))))
     LEFT JOIN v_perf_project_info t1 ON (((b.pro_code) = (t1.pro_code))))
  WHERE ((a.issubmit) = ''1'')';

	
execute immediate '
CREATE OR REPLACE VIEW v_perf_t_randomcomment_proj
 AS
 SELECT t3.guid,
    t1.guid AS perfgoalguid,
    m.projguid,
    m.guid AS selfguid,
    m.year,
    t1.pro_name AS projname,
    t1.pro_name AS name,
    t1.pro_code,
    t1.province,
    t1.finintorgguid,
    t1.agency_code,
    t1.agency_code AS agencyguid,
    m.bustype,
        CASE
            WHEN ((m.pro_lev) = ''1'') THEN ''一级项目''
            WHEN ((m.pro_lev) = ''2'') THEN ''二级项目''
            ELSE ''''
        END AS prolev,
        CASE
            WHEN ((t3.issubmit) = ''1'') THEN ''1''
            ELSE ''0''
        END AS issubmit,
    t3.wfid,
        CASE
            WHEN ((t3.isscope) = ''1'') THEN 1
            ELSE 0
        END AS isscope,
    t3.wfstatus,
    t3.createtime,
    t3.creater,
    t3.auditor,
    t3.lastupdatetime,
    t3.meachguid,
    t3.meachguid AS meachname,
    t3.isobject,
    t3.israndom,
    m.score AS selfscore,
    m.selfresult,
    s.score,
    ((0.4 * nvl(s.score, (0))) + (0.6 * nvl(r.score, (0)))) AS actualscore,
        CASE
            WHEN (((0.4 * nvl(s.score, (0))) + (0.6 * nvl(r.score, (0)))) >= (90)) THEN ''优''
            WHEN ((((0.4 * nvl(s.score, (0))) + (0.6 * nvl(r.score, (0)))) >= (80)) AND (((0.4 * nvl(s.score, (0))) + (0.6 * nvl(r.score, (0)))) < (90))) THEN ''良''
            WHEN ((((0.4 * nvl(s.score, (0))) + (0.6 * nvl(r.score, (0)))) >= (60)) AND (((0.4 * nvl(s.score, (0))) + (0.6 * nvl(r.score, (0)))) < (80))) THEN ''中''
            WHEN (((0.4 * nvl(s.score, (0))) + (0.6 * nvl(r.score, (0)))) < (60)) THEN ''差''
            ELSE NULL
        END AS randomresult,
    t2.amt1 AS budgetamount,
    t2.amt3 AS execratenum,
    (t2.amt4 + nvl(t2.amt6, (0))) AS execamount,
    nvl(t2.amt6, (0)) AS amt6,
    t2.bgtget AS execrate
   FROM (((((perf_v_selfevaltask m
     LEFT JOIN v_perf_project_info t1 ON (((m.projguid) = (t1.pro_id))))
     LEFT JOIN ( SELECT mainguid,
            sum(amt1) AS amt1,
            sum(amt3) AS amt3,
            sum(amt4) AS amt4,
            nvl(sum(amt6), (0)) AS amt6,
            to_char((((sum(amt4) + nvl(sum(amt6), (0))) /
                DECODE(  (sum(amt2) + sum(amt1))
                    , (0)
                    , (1)
                    , (sum(amt2) + sum(amt1))
                )) * (100)), ''FM990.00'') AS bgtget
           FROM v_perf_t_selfprofund
          GROUP BY mainguid) t2 ON (((t2.mainguid) = (m.guid))))
     LEFT JOIN v_perf_t_randomcomment t3 ON (((m.projguid) = (t3.perfgoalguid))))
     LEFT JOIN ( SELECT c.projguid,
            sum((c.scroe)) AS score
           FROM v_perf_randomquality c
          WHERE ((c.levelno) = ''2'')
          GROUP BY c.projguid) s ON (((s.projguid) = (t1.pro_id))))
     LEFT JOIN ( SELECT c.mainguid,
            sum((c.score)) AS score
           FROM v_perf_t_randomindex c
          WHERE ((c.levelno) = ''3'')
          GROUP BY c.mainguid) r ON (((r.mainguid) = (m.guid))))
  WHERE ((m.wfstatus) = ''011'')';
  
execute immediate 'CREATE OR REPLACE VIEW v_perf_randomproblem
 AS
 SELECT t.*,
    p.agency_code,
    p.actualscore,
    p.randomresult,
    p.selfguid
   FROM (v_perf_t_randomproblem t
     LEFT JOIN v_perf_t_randomcomment_proj p ON (((t.mainguid) = (p.selfguid))))';