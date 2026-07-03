begin

execute immediate '
CREATE OR REPLACE VIEW bgt_330000.perf_t_randomcomment_proj
AS SELECT t3.guid,
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
    ''program''::text AS bustype,
        CASE
            WHEN t3.issubmit::text = ''1''::text THEN ''1''::text
            ELSE ''0''::text
        END AS issubmit,
    t3.wfid,
        CASE
            WHEN t3.isscope::text = ''1''::text THEN 1
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
    0.4 * nvl(s.score, 0::numeric) + 0.6 * nvl(r.score, 0::numeric) AS actualscore,
        CASE
            WHEN (0.4 * nvl(s.score, 0::numeric) + 0.6 * nvl(r.score, 0::numeric)) >= 90::numeric THEN ''ÓÅ''::text
            WHEN (0.4 * nvl(s.score, 0::numeric) + 0.6 * nvl(r.score, 0::numeric)) >= 80::numeric AND (0.4 * nvl(s.score, 0::numeric) + 0.6 * nvl(r.score, 0::numeric)) < 90::numeric THEN ''Á¼''::text
            WHEN (0.4 * nvl(s.score, 0::numeric) + 0.6 * nvl(r.score, 0::numeric)) >= 60::numeric AND (0.4 * nvl(s.score, 0::numeric) + 0.6 * nvl(r.score, 0::numeric)) < 80::numeric THEN ''ÖÐ''::text
            WHEN (0.4 * nvl(s.score, 0::numeric) + 0.6 * nvl(r.score, 0::numeric)) < 60::numeric THEN ''²î''::text
            ELSE NULL::text
        END AS randomresult
   FROM bgt_330000.perf_v_selfevaltask m
     LEFT JOIN bgt_330000.v_perf_project_info t1 ON m.projguid::text = t1.pro_id::text
     LEFT JOIN bgt_330000.perf_t_randomcomment t3 ON m.projguid::text = t3.perfgoalguid::text
     LEFT JOIN ( SELECT c.projguid,
            sum(c.scroe::numeric) AS score
           FROM bgt_330000.perf_v_randomquality c
          WHERE c.levelno::text = ''2''::text
          GROUP BY c.projguid) s ON s.projguid::text = t1.pro_id::text
     LEFT JOIN ( SELECT c.mainguid,
            sum(c.score::numeric) AS score
           FROM bgt_330000.perf_t_randomindex c
          WHERE c.levelno::text = ''3''::text
          GROUP BY c.mainguid) r ON r.mainguid::text = m.guid::text
  WHERE m.wfstatus::text = ''011''::text';
  
  
execute immediate '  
  create or replace view perf_v_randomquality_type as
select a.*,
       b.name,
       b.code,
       b.status
  from PERF_T_RANDOMQUALITY a
  left join PERF_T_RANDOMQUALITY_TYPE b
    on a.mainguid = b.GUID';