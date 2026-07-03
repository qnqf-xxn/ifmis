  i number;
  v_sql varchar2(2000);
  ln_i integer;
begin
  

v_sql :='
create or replace view V_PERF_T_ADJUSTGOAL as
select *
 from PERF_T_ADJUSTGOAL t
where YEAR = global_multyear_cz.v_pmyear
and PROVINCE = global_multyear_cz.v_pmdivid and t.is_deleted=2 and t.sub_mof_div_code is null';
select fn_alterview('V_PERF_T_ADJUSTGOAL',v_sql) into ln_i;
if ln_i = 0 then
	return;
end if;

v_sql :='
create or replace view V_PERF_T_ADJUSTINDEX as
select *
 from PERF_T_ADJUSTINDEX t
where YEAR = global_multyear_cz.v_pmyear 
and PROVINCE = global_multyear_cz.v_pmdivid and t.is_deleted=2 and t.sub_mof_div_code is null';
select fn_alterview('V_PERF_T_ADJUSTINDEX',v_sql) into ln_i;
if ln_i = 0 then
	return;
end if;

v_sql :='
create or replace view V_PERF_T_ADJUSTALLGOAL as
select *
 from PERF_T_ADJUSTGOAL t
where YEAR = global_multyear_cz.v_pmyear  
and PROVINCE = global_multyear_cz.v_pmdivid and t.is_deleted=2';
select fn_alterview('V_PERF_T_ADJUSTALLGOAL',v_sql) into ln_i;
if ln_i = 0 then
	return;
end if;

v_sql :='
create or replace view V_PERF_T_ADJUSTALLINDEX as
select *
 from PERF_T_ADJUSTINDEX t
where YEAR = global_multyear_cz.v_pmyear
and PROVINCE = global_multyear_cz.v_pmdivid and t.is_deleted=2';
select fn_alterview('V_PERF_T_ADJUSTALLINDEX',v_sql) into ln_i;
if ln_i = 0 then
	return;
end if;
