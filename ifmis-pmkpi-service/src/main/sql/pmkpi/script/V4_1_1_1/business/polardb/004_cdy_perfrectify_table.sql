  i number;
  v_sql varchar2(2000);
  ln_i integer;
begin
  select count(*) into i from user_tab_cols t where t.TABLE_NAME='PERF_T_RECTIFY' and t.column_name='FEEDBACKAMT';
  if i=0 then
     execute immediate 'alter table PERF_T_RECTIFY add FEEDBACKAMT NUMBER(18,2)';
  end if;
  
  select count(*) into i from user_tab_cols t where t.TABLE_NAME='PERF_T_RECTIFY' and t.column_name='FEEDBACKREMARK';
  if i=0 then
     execute immediate 'alter table PERF_T_RECTIFY add FEEDBACKREMARK VARCHAR2(4000)';
  end if;

  v_sql :='
create or replace view V_PERF_T_RECTIFY as
select *
from PERF_T_RECTIFY t where year = global_multyear_cz.v_pmyear
  and province = global_multyear_cz.v_pmdivid';
select fn_alterview('V_PERF_T_RECTIFY',v_sql) into ln_i;
	if ln_i = 0 then
	    return;
	end if;	  
