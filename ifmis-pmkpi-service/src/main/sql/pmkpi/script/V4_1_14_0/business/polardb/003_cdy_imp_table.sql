  i number;
  v_sql varchar2(2000);
  ln_i integer;
begin
  
  select count(*) into i from user_constraints where constraint_name = 'UK_PERF_IMPEXPSUB' and table_name = 'PERF_T_IMPEXPSUB';
  if i=1 then    
  execute immediate 'ALTER TABLE PERF_T_IMPEXPSUB DROP CONSTRAINT UK_PERF_IMPEXPSUB';
  end if;
  
  select count(1) into i from user_tab_cols t where t.table_name='PERF_T_IMPEXPSUB' and t.column_name='REDDEN';
  if i=0 then
    execute immediate 'alter table PERF_T_IMPEXPSUB add redden VARCHAR2(100)';
  end if;
  
v_sql :='
create or replace view V_PERF_T_IMPEXPSUB as
select *
from perf_t_impexpsub where year = global_multyear_cz.v_pmyear
and province = global_multyear_cz.v_pmdivid';
select fn_alterview('V_PERF_T_IMPEXPSUB',v_sql) into ln_i;
if ln_i = 0 then
	return;
end if;