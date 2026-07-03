  i number;
  v_sql varchar2(2000);
  ln_i integer;
begin

  select count(*) into i from user_tab_columns t where t.table_name ='PERF_T_RECTIFY' and t.column_name='FINADJUSTADVICE';
  if i=0 then
     execute immediate 'alter table PERF_T_RECTIFY add FINADJUSTADVICE VARCHAR2(40)';
  end if;


  --重构视图
  v_sql :='
create or replace view V_PERF_T_RECTIFY as
select * 
from PERF_T_RECTIFY t where year = global_multyear_cz.v_pmyear
  and province = global_multyear_cz.v_pmdivid';
	select fn_alterview('V_PERF_T_RECTIFY',v_sql) into ln_i;
	if ln_i = 0 then
	    return;
	end if;	  
