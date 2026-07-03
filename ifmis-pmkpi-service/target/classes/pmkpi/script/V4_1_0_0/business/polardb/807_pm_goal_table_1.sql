v_sql varchar2(2000);
ln_i integer;
begin
	v_sql :='CREATE OR REPLACE VIEW V_PM_PERF_GOAL_INFO AS
SELECT *
FROM PM_PERF_GOAL_INFO T WHERE YEAR = GLOBAL_MULTYEAR_CZ.V_PMYEAR
  AND PROVINCE = GLOBAL_MULTYEAR_CZ.V_PMDIVID AND T.IS_DELETED=2 AND T.IS_BACKUP =2';
	select fn_alterview('V_PM_PERF_GOAL_INFO',v_sql) into ln_i;
	if ln_i = 0 then
	    return;
	end if;
	
	v_sql :='CREATE OR REPLACE VIEW V_PM_PERF_GOAL_TEMP AS
SELECT *
FROM PM_PERF_GOAL_TEMP  
WHERE PROVINCE = GLOBAL_MULTYEAR_CZ.V_PMDIVID AND IS_DELETED =2';
	select fn_alterview('V_PM_PERF_GOAL_TEMP',v_sql) into ln_i;
	if ln_i = 0 then
	    return;
	end if;