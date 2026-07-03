begin

select fn_alterview('v_perf_randomquality', 'CREATE OR REPLACE VIEW v_perf_randomquality
 AS
 SELECT t.guid,
    t.superid,
    t.qualityname,
    t.qualitynameexp,
    t.qualityweight,
    t.qualitystand,
    t.levelno,
    t.isleaf,
    t.ordernum,
    t1.projguid,
    t1.scroe,
    t1.buckle,
    t1.pro_code,
    t.year,
    t.province,
    t2.name,
    t2.code,
    t2.bustype
   FROM v_perf_t_randomquality t
     LEFT JOIN v_perf_t_randomquality_score t1 ON t.guid = t1.mainguid
     LEFT JOIN v_perf_t_randomquality_type t2 ON t.mainguid = t2.guid
  ORDER BY t.ordernum');
  
  select fn_alterview('v_perf_t_randomcomment_proj','
  CREATE OR REPLACE VIEW v_perf_t_randomcomment_proj
 AS
 SELECT t3.guid,
    m.projguid AS perfgoalguid,
    m.projguid,
    m.guid AS selfguid,
    m.year,
    m.province,
    m.name AS projname,
    m.name,
    m.pro_code,
    m.manage_mof_dep_code,
    m.finintorgguid,
    m.agencyguid AS agency_code,
    m.agencyguid,
    m.bustype,
	m.pro_lev as prolev,
	t3.issubmit,
    t3.wfid,
	t3.isscope,
    t3.wfstatus,
    t3.createtime,
    t3.creater,
    t3.creater AS budgetgoalcreator,
    t3.auditor,
    t3.lastupdatetime,
    t3.meachguid,
    t3.meachguid AS meachname,
    t3.isobject,
    t3.israndom,
    m.score AS selfscore,
    m.selfresult,
    s.score,
    ((0.4 * nvl(s.score, (0)::numeric)) + (0.6 * nvl(r.score, (0)::numeric))) AS actualscore,
        CASE
            WHEN (((0.4 * nvl(s.score, (0)::numeric)) + (0.6 * nvl(r.score, (0)::numeric))) >= (90)::numeric) THEN ''优''::text
            WHEN ((((0.4 * nvl(s.score, (0)::numeric)) + (0.6 * nvl(r.score, (0)::numeric))) >= (80)::numeric) AND (((0.4 * nvl(s.score, (0)::numeric)) + (0.6 * nvl(r.score, (0)::numeric))) < (90)::numeric)) THEN ''良''::text
            WHEN ((((0.4 * nvl(s.score, (0)::numeric)) + (0.6 * nvl(r.score, (0)::numeric))) >= (60)::numeric) AND (((0.4 * nvl(s.score, (0)::numeric)) + (0.6 * nvl(r.score, (0)::numeric))) < (80)::numeric)) THEN ''中''::text
            WHEN (((0.4 * nvl(s.score, (0)::numeric)) + (0.6 * nvl(r.score, (0)::numeric))) < (60)::numeric) THEN ''差''::text
            ELSE NULL::text
        END AS randomresult,
    t2.amt1 AS budgetamount,
    t2.amt3 AS execratenum,
    (t2.amt4 + nvl(t2.amt6, (0)::numeric)) AS execamount,
    nvl(t2.amt6, (0)::numeric) AS amt6,
    t2.bgtget AS execrate
   FROM ((((perf_v_selfevaltask m
     LEFT JOIN ( SELECT v_perf_t_selfprofund.mainguid,
            sum(v_perf_t_selfprofund.amt1) AS amt1,
            sum(v_perf_t_selfprofund.amt3) AS amt3,
            sum(v_perf_t_selfprofund.amt4) AS amt4,
            nvl(sum(v_perf_t_selfprofund.amt6), (0)::numeric) AS amt6,
            to_char((((sum(v_perf_t_selfprofund.amt4) + nvl(sum(v_perf_t_selfprofund.amt6), (0)::numeric)) /
                DECODE(  (sum(v_perf_t_selfprofund.amt2) + sum(v_perf_t_selfprofund.amt1))
                    , (0)::numeric
                    , (1)::numeric
                    , (sum(v_perf_t_selfprofund.amt2) + sum(v_perf_t_selfprofund.amt1))
                )) * (100)::numeric), ''FM990.00''::text) AS bgtget
           FROM v_perf_t_selfprofund
          GROUP BY v_perf_t_selfprofund.mainguid) t2 ON (((t2.mainguid)::text = (m.guid)::text)))
     LEFT JOIN v_perf_t_randomcomment t3 ON (((m.pro_code)::text = (t3.pro_code)::text)))
     LEFT JOIN ( SELECT c.pro_code,
            sum((c.scroe)::numeric) AS score
           FROM v_perf_randomquality c
          WHERE ((c.levelno)::text = ''2''::text)
          GROUP BY c.pro_code) s ON (((s.pro_code)::text = (m.pro_code)::text)))
     LEFT JOIN ( SELECT c.mainguid,
            sum((c.score)::numeric) AS score
           FROM v_perf_t_randomindex c
          WHERE ((c.levelno)::text = ''3''::text)
          GROUP BY c.mainguid) r ON (((r.mainguid)::text = (m.guid)::text)))
  WHERE ((m.wfstatus)::text = ''011''::text)');
  
    select fn_alterview('v_perf_randomproblem','CREATE OR REPLACE VIEW v_perf_randomproblem
 AS
 SELECT t.*,
    p.agency_code,
    p.actualscore,
    p.randomresult,
    p.selfguid
   FROM (v_perf_t_randomproblem t
     LEFT JOIN v_perf_t_randomcomment_proj p ON (((t.mainguid) = (p.selfguid))))');
