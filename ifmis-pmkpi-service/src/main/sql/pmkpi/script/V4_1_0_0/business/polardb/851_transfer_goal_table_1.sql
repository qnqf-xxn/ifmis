
v_sql varchar2(2000);
ln_i integer;
begin
	v_sql :='CREATE OR REPLACE VIEW V_PERF_TRANSFER_GOAL AS
SELECT *
FROM PERF_TRANSFER_GOAL T WHERE YEAR = GLOBAL_MULTYEAR_CZ.V_PMYEAR
  AND PROVINCE = GLOBAL_MULTYEAR_CZ.V_PMDIVID AND T.IS_DELETED=2';
	select fn_alterview('V_PERF_TRANSFER_GOAL',v_sql) into ln_i;
	if ln_i = 0 then
	    return;
	end if;