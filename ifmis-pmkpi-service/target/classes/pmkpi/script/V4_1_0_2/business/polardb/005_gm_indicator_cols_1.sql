v_sql varchar2(2000);
ln_i integer;
begin
	v_sql :='create or replace view v_pm_perf_indicator as
select * from pm_perf_indicator t
where year = global_multyear_cz.v_pmyear and province = global_multyear_cz.v_pmdivid and is_deleted =2 and is_backup =2';
	select fn_alterview('V_PM_PERF_INDICATOR',v_sql) into ln_i;
	if ln_i = 0 then
	    return;
	end if;
	
		v_sql :='create or replace view V_PM_PERF_INDICATOR_TEMP as
select * from PM_PERF_INDICATOR_TEMP t
where province = global_multyear_cz.v_pmdivid and is_deleted =2';
	select fn_alterview('V_PM_PERF_INDICATOR_TEMP',v_sql) into ln_i;
	if ln_i = 0 then
	    return;
	end if;
	