v_sql varchar2(2000);
ln_i integer;
begin
	v_sql :='CREATE OR REPLACE VIEW V_BGT_PERF_INDICATOR AS
SELECT *
FROM BGT_PERF_INDICATOR T WHERE YEAR = GLOBAL_MULTYEAR_CZ.V_PMYEAR AND
     PROVINCE = GLOBAL_MULTYEAR_CZ.V_PMDIVID AND IS_DELETED = 2 AND T.IS_BACKUP =2';
	select fn_alterview('V_BGT_PERF_INDICATOR',v_sql) into ln_i;
	if ln_i = 0 then
	    return;
	end if;