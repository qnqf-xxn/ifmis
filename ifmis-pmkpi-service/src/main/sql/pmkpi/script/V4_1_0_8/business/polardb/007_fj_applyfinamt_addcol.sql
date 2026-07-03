  i number;
  v_sql varchar2(2000);
  ln_i integer;
begin
  
--项目申报目标表添加申请财政资金字段
 select count(*) into i from user_tab_columns t where t.table_name ='PM_PERF_GOAL_INFO' and t.column_name='APPLYFINAMT';
  if i=0 then
     execute immediate 'alter table PM_PERF_GOAL_INFO add APPLYFINAMT NUMBER(20,2)';
  end if;
  
--重构视图
v_sql :='
create or replace view V_PM_PERF_GOAL_INFO as
select *
from PM_PERF_GOAL_INFO 
where year = global_multyear_cz.v_pmyear and province = global_multyear_cz.v_pmdivid and is_deleted = 2 
and t.is_backup = 2 and nvl(t.is_adj, 2) = 2';
select fn_alterview('V_PM_PERF_GOAL_INFO',v_sql) into ln_i;
	if ln_i = 0 then
	    return;
	end if;	

  
--项目修订目标表添加申请财政资金字段
 select count(*) into i from user_tab_columns t where t.table_name ='PERF_PROVISION_GOAL_INFO' and t.column_name='APPLYFINAMT';
  if i=0 then
     execute immediate 'alter table PERF_PROVISION_GOAL_INFO add APPLYFINAMT NUMBER(20,2)';
  end if;
  
--重构视图
v_sql :='
create or replace view V_PERF_PROVISION_GOAL_INFO as
select *
from PERF_PROVISION_GOAL_INFO t 
where year = global_multyear_cz.v_pmyear and province = global_multyear_cz.v_pmdivid and t.is_deleted=2';
select fn_alterview('V_PERF_PROVISION_GOAL_INFO',v_sql) into ln_i;
	if ln_i = 0 then
	    return;
	end if;	  
  
--项目调整目标表添加申请财政资金字段
 select count(*) into i from user_tab_columns t where t.table_name ='PERF_T_ADJUSTGOAL' and t.column_name='APPLYFINAMT';
  if i=0 then
     execute immediate 'alter table PERF_T_ADJUSTGOAL add APPLYFINAMT NUMBER(20,2)';
  end if;
  
--重构视图
v_sql :='
create or replace view V_PERF_T_ADJUSTGOAL as
select *
from PERF_T_ADJUSTGOAL t 
where YEAR = global_multyear_cz.v_pmyear and PROVINCE = global_multyear_cz.v_pmdivid and t.is_deleted=2';
select fn_alterview('V_PERF_T_ADJUSTGOAL',v_sql) into ln_i;
	if ln_i = 0 then
	    return;
	end if;	