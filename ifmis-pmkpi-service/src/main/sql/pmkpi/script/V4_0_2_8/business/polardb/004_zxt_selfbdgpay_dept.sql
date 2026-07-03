begin

execute immediate '
CREATE OR REPLACE VIEW bgt_330000.v_perf_selfbdgpay_dept
 AS
 SELECT k.name,
        CASE
            WHEN ((k.name)::text = ''预算内''::text) THEN 1
            WHEN ((k.name)::text = ''其他资金''::text) THEN 2
            WHEN ((k.name)::text = ''专户资金''::text) THEN 3
            ELSE 9
        END AS ordernum,
    k.agencyguid,
    sum(nvl(((k.amt1)::character varying)::numeric, (0)::numeric)) AS amt1,
    sum(nvl(k.amt2, (0)::numeric)) AS amt2,
    (sum(nvl(((k.amt1)::character varying)::numeric, (0)::numeric)) + sum(nvl(k.amt2, (0)::numeric))) AS amt3,
    sum(k.amt4) AS amt4,
        DECODE(  (sum(nvl(((k.amt1)::character varying)::numeric, (0)::numeric)) + nvl(sum(k.amt2), (0)::numeric))
            , (0)::numeric
            , (0)::numeric
            , round(((sum(k.amt4) / (sum(nvl(((k.amt1)::character varying)::numeric, (0)::numeric)) + nvl(sum(k.amt2), (0)::numeric))) * (100)::numeric), 2)
        ) AS bgtget,
    ''::text AS score,
    k.year,
    k.province,
	k.month
   FROM ( SELECT t.name,
            t.pro_code,
            t.agencyguid,
            max((t.amt1)::text) AS amt1,
            sum(t.amt2) AS amt2,
            (nvl(sum(t.amt2), (0)::numeric) + nvl(((max((t.amt1)::text))::character varying)::numeric, (0)::numeric)) AS amt3,
            sum(t.amt4) AS amt4,
            t.year,
            t.province,
		    t.month
           FROM (select t.guid,t.name,t.amt1,t.amt2,t.amt3,t.amt4,t.year,t.province,t.month,t.pro_code,substr(t.agencyguid,0,3) as agencyguid from perf_t_profund t) t
          WHERE (((t.year)::text = (bgt_330000.global_multyear_cz.v_pmyear)::text) AND ((t.province)::text = (bgt_330000.global_multyear_cz.v_pmdivid)::text))
          GROUP BY t.name, t.agencyguid, t.pro_code, t.year, t.province,t.month) k
  GROUP BY k.name, k.agencyguid, k.year, k.province,k.month
  ';