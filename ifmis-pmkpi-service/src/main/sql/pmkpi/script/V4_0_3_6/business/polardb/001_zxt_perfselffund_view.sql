begin


--自评预算执行情况(项目支出)
execute immediate '
CREATE OR REPLACE VIEW v_perf_selfbdgpay_project
 AS
 SELECT t.name,
        CASE
            WHEN t.name = ''预算内'' THEN 1
            WHEN t.name = ''其他资金'' THEN 2
            WHEN t.name = ''专户资金'' THEN 3
            ELSE 9
        END AS ordernum,
    t.pro_code,
    max(nvl(t.amt1, 0)) AS amt1,
    sum(nvl(t.amt2, 0)) AS amt2,
    (nvl(sum(t.amt2), 0) + nvl(((max((t.amt1)))), 0)) AS amt3,
    sum(nvl(t.amt4, 0)) AS amt4,
	case when (nvl(sum(t.amt2), 0) + nvl(((max((t.amt1)))), 0)) = 0 then 100
		 when sum(nvl(t.amt4, 0)) = 0 then 0 else
        DECODE((nvl(sum(t.amt2), 0) + nvl((max(t.amt1)), 0))
            , 0
            , 0
            , round(((sum(t.amt4) / (nvl(sum(t.amt2), 0) + nvl((max(t.amt1)), 0))) * 100), 2)
        ) end AS bgtget,
    '''' AS score,
    t.year,
    t.province
   FROM perf_t_profund t
  WHERE t.year = bgt_330000.global_multyear_cz.v_pmyear
		 AND t.province = bgt_330000.global_multyear_cz.v_pmdivid
		 AND t.pro_code = bgt_330000.PERF_FUNDPAY_VIEW.v_procode
		  AND t.is_deleted = 2
  GROUP BY t.name, t.pro_code, t.year, t.province
';

--自评预算执行情况(部门)
execute immediate '
CREATE OR REPLACE VIEW v_perf_selfbdgpay_dept
 AS
 SELECT k.name,
        CASE
            WHEN k.name = ''预算内'' THEN 1
            WHEN k.name = ''其他资金'' THEN 2
            WHEN k.name = ''专户资金'' THEN 3
            ELSE 9
        END AS ordernum,
    k.agencyguid,
    sum(nvl((k.amt1), 0)) AS amt1,
    sum(nvl(k.amt2, 0)) AS amt2,
    (sum(nvl((k.amt1), 0)) + sum(nvl(k.amt2, 0))) AS amt3,
    sum(k.amt4) AS amt4,
	case when (sum(nvl((k.amt1), 0)) + sum(nvl(k.amt2, 0))) = 0 then 100
		 when sum(nvl(k.amt4, 0)) = 0 then 0 else
        DECODE(  (sum(nvl((k.amt1), 0)) + nvl(sum(k.amt2), 0))
            , 0
            , 0
            , round(((sum(k.amt4) / (sum(nvl((k.amt1), 0)) + nvl(sum(k.amt2), 0))) * 100), 2)
        ) end AS bgtget,
    '''' AS score,
    k.year,
    k.province
   FROM ( SELECT t.name,
            t.pro_code,
            t.agencyguid,
            max((t.amt1)) AS amt1,
            sum(t.amt2) AS amt2,
            (nvl(sum(t.amt2), 0) + nvl((max(t.amt1)), 0)) AS amt3,
            sum(t.amt4) AS amt4,
            t.year,
            t.province
           FROM ( SELECT t_1.guid,
                    t_1.name,
                    t_1.amt1,
                    t_1.amt2,
                    t_1.amt3,
                    t_1.amt4,
                    t_1.year,
                    t_1.province,
                    t_1.pro_code,
                    substr(t_1.agencyguid, 0, 3) AS agencyguid
                   FROM perf_t_profund t_1) t
          WHERE t.year = bgt_330000.global_multyear_cz.v_pmyear
		 AND t.province = bgt_330000.global_multyear_cz.v_pmdivid
		 AND t.agencyguid = bgt_330000.PERF_FUNDPAY_VIEW.v_agencyguid
          GROUP BY t.name, t.agencyguid, t.pro_code, t.year, t.province) k
  GROUP BY k.name, k.agencyguid, k.year, k.province
';

