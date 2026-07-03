  i number;
  v_sql varchar2(2000);
  ln_i integer;
begin

--项目年度资金视图，用于判断是否可删除年中追加项目绩效 V_PERF_PROJECT_BGTYEAR
v_sql :='
create or replace view V_PERF_PROJECT_BGTYEAR as
select mof_div_code,mof_div_name,fiscal_year,agency_code,agency_name,pro_code,pro_name,apply_up from bgt_pm_annual t
where t.is_deleted=''2'' and t.pro_kind_code in (''22'',''3'') and t.is_backup=''2'' and t.apply_up<>0 and t.is_assigned=''2''
and t.mof_div_code = global_multyear_cz.v_pmdivid and t.fiscal_year = global_multyear_cz.v_pmyear';
select fn_alterview('V_PERF_PROJECT_BGTYEAR',v_sql) into ln_i;
if ln_i = 0 then
	return;
end if;
