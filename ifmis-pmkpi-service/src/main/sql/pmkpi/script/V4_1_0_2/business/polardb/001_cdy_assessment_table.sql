  i number;
  v_sql varchar2(2000);
  ln_i integer;
begin

  select count(*) into i from user_tab_columns t where t.table_name ='PERF_T_ASSESSMENTTEMP' and t.column_name='BUSTYPE';
  if i=0 then
     execute immediate 'alter table PERF_T_ASSESSMENTTEMP add bustype varchar2(40)';
  end if;

  select count(*) into i from user_tab_columns t where t.table_name ='PERF_T_ASSESSMENT' and t.column_name='BUSTYPE';
  if i=0 then
     execute immediate 'alter table PERF_T_ASSESSMENT add bustype varchar2(40)';
  end if;

	v_sql :='create or replace view v_perf_t_assessmenttemp as
select t.*
  from perf_t_assessmenttemp t
 where province = global_multyear_cz.v_pmdivid';
	select fn_alterview('V_PERF_T_ASSESSMENTTEMP',v_sql) into ln_i;
	if ln_i = 0 then
	    return;
	end if;
	
		v_sql :='create or replace view v_perf_t_assessment as
select t.*
  from perf_t_assessment t
 where t.is_deleted = 2
   and province = global_multyear_cz.v_pmdivid';
	select fn_alterview('V_PERF_T_ASSESSMENT',v_sql) into ln_i;
	if ln_i = 0 then
	    return;
	end if;
	
--execute immediate '
--create or replace view v_perf_t_assessmenttemp as
--select t.*
--  from perf_t_assessmenttemp t
-- where province = global_multyear_cz.v_pmdivid';

--execute immediate '
--create or replace view v_perf_t_assessment as
--select t.*
--  from perf_t_assessment t
-- where t.is_deleted = 2
--   and province = global_multyear_cz.v_pmdivid';
