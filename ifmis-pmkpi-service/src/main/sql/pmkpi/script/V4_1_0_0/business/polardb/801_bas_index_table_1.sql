v_sql varchar2(2000);
ln_i integer;
begin
	v_sql :='CREATE OR REPLACE VIEW V_BAS_PERF_INDICATOR AS
SELECT *
FROM BAS_PERF_INDICATOR T
WHERE PROVINCE = GLOBAL_MULTYEAR_CZ.V_PMDIVID AND IS_DELETED =2';
	select fn_alterview('V_BAS_PERF_INDICATOR',v_sql) into ln_i;
	if ln_i = 0 then
	    return;
	end if;