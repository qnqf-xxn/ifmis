begin

execute immediate '
CREATE OR REPLACE VIEW bgt_330000.v_perf_fund_project
 AS
 SELECT 1 AS ordernum,
    t.agency_code,
    t.agency_name,
    t.pro_code,
    t.pro_name,
    t.year,
    t.province,
    max(t.month) AS month,
    t.name,
    sum(t.amt3) AS amt3,
    sum(t.amt4) AS amt4,
    sum(t.amt1) AS amt1,
    sum(t.amt2) AS amt2,
        DECODE(  (sum(nvl(t.amt2, (0)::numeric)) + nvl(((max((t.amt1)::text))::character varying)::numeric, (0)::numeric))
            , (0)::numeric
            , (0)::numeric
            , round(((sum(nvl(t.amt4, (0)::numeric)) / (sum(nvl(t.amt2, (0)::numeric)) + nvl(((max((t.amt1)::text))::character varying)::numeric, (0)::numeric))) * (100)::numeric), 2)
        ) AS bgtget,
    ''1''::text AS isedit,
	t1.taskguid
   FROM ((bgt_330000.v_perf_t_promonitor t1
     LEFT JOIN bgt_330000.v_perf_t_taskset t2 ON (((t1.taskguid)::text = (t2.guid)::text)))
     LEFT JOIN bgt_330000.perf_t_profund t ON (((t1.pro_code)::text = (t.pro_code)::text)))
  WHERE (((t.year)::text = (bgt_330000.global_multyear_cz.v_pmyear)::text) AND (t.month <= (t2.taskstage)::numeric) AND ((t.province)::text = (bgt_330000.global_multyear_cz.v_pmdivid)::text) AND (t.is_deleted = (2)::numeric))
  GROUP BY t.agency_code, t.agency_name, t.pro_code, t.pro_name, t.year, t.province, t.name,t1.taskguid
  ';