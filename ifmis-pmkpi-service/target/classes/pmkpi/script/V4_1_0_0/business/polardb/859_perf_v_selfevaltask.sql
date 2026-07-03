v_sql varchar2(5000);
ln_i integer;
begin
	v_sql :='CREATE OR REPLACE VIEW perf_v_selfevaltask
 AS
 SELECT t.*,
    ''2''::text AS rectifytype,
    a.amt1 AS budgetamount,
    a.amt3 AS execratenum,
    a.amt4 AS execamount,
	b.amt3 as ybystzh,
    date_part(''day''::text, (to_date(t.evalend, ''yyyymmdd''::character varying) - to_date(to_char(sysdate, ''yyyymmdd''::character varying), ''yyyymmdd''::character varying))) AS warndays,
        DECODE(  s.score
            , (NULL::text)::numeric
            , (0)::numeric
            , s.score
        ) AS score,
    s.selfresult,
    s.warn
   FROM ((v_perf_t_selfevaltask t
     LEFT JOIN v_perf_t_selfperfdesc s ON (((s.mainguid)::text = (t.guid)::text)))
     LEFT JOIN ( SELECT v_perf_t_selfprofund.mainguid,
            sum(v_perf_t_selfprofund.amt1) AS amt1,
            sum(v_perf_t_selfprofund.amt3) AS amt3,
            sum(v_perf_t_selfprofund.amt4) AS amt4
           FROM v_perf_t_selfprofund
          GROUP BY v_perf_t_selfprofund.mainguid) a ON (((a.mainguid)::text = (t.guid)::text))
     LEFT JOIN ( SELECT v_perf_t_selfprofund.mainguid,
            sum(v_perf_t_selfprofund.amt1) AS amt1,
            sum(v_perf_t_selfprofund.amt3) AS amt3,
            sum(v_perf_t_selfprofund.amt4) AS amt4
           FROM v_perf_t_selfprofund where name in (''一般公共预算资金'',''政府性基金预算资金'')
          GROUP BY v_perf_t_selfprofund.mainguid) b ON (((b.mainguid)::text = (t.guid)::text))		
		)';
	select fn_alterview('PERF_V_SELFEVALTASK',v_sql) into ln_i;
	if ln_i = 0 then
	    return;
	end if;