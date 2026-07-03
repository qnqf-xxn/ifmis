  i number;
  v_sql varchar2(2000);
  ln_i integer;
begin
  select count(*) into i from user_tab_columns t where t.table_name ='PERF_T_DEPTEVALUATION' and t.column_name='AMT1';
  if i=0 then
     execute immediate 'alter table PERF_T_DEPTEVALUATION add AMT1 NUMBER(20,2)';
  end if;
  select count(*) into i from user_tab_columns t where t.table_name ='PERF_T_DEPTEVALUATION' and t.column_name='FUND_TYPE';
  if i=0 then
     execute immediate 'alter table PERF_T_DEPTEVALUATION add FUND_TYPE VARCHAR2(40)';
  end if;


v_sql :='
create or replace view V_PERF_T_DEPTEVALUATION as
select * 
from PERF_T_DEPTEVALUATION t where year = global_multyear_cz.v_pmyear
  and province = global_multyear_cz.v_pmdivid';
  select fn_alterview('V_PERF_T_DEPTEVALUATION',v_sql) into ln_i;
	if ln_i = 0 then
	    return;
	end if;
