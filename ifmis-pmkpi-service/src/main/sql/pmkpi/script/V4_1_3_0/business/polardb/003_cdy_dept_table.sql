  i number;
  v_sql varchar2(2000);
  ln_i integer;
begin
  select count(*) into i from user_tab_columns t where t.table_name ='BGT_PERF_GOAL_INFO' and t.column_name='END_YEAR';
  if i=0 then
    execute immediate 'alter table BGT_PERF_GOAL_INFO add END_YEAR VARCHAR2(4)';
  end if;
  
  select count(*) into i from user_tab_columns t where t.table_name ='BGT_PERF_INDICATOR' and t.column_name='ISFIXED';
  if i=0 then
    execute immediate 'alter table BGT_PERF_INDICATOR add ISFIXED NUMBER(1)';
  end if;
  
  select count(*) into i from user_tab_columns t where t.table_name ='BGT_PERF_INDICATOR' and t.column_name='CODE';
  if i>0 then
    execute immediate 'alter table BGT_PERF_INDICATOR modify code VARCHAR2(300)';
  end if;
  
  select count(*) into i from user_tab_columns t where t.table_name ='BGT_PERF_INDICATOR' and t.column_name='LV1_PERF_IND_CODE';
  if i>0 then
    execute immediate 'alter table BGT_PERF_INDICATOR modify lv1_perf_ind_code VARCHAR2(300)';
  end if;
  
  select count(*) into i from user_tab_columns t where t.table_name ='BGT_PERF_INDICATOR' and t.column_name='LV2_PERF_IND_CODE';
  if i>0 then
    execute immediate 'alter table BGT_PERF_INDICATOR modify lv2_perf_ind_code VARCHAR2(300)';
  end if;
  
  select count(*) into i from user_tab_columns t where t.table_name ='BGT_PERF_INDICATOR' and t.column_name='LV3_PERF_IND_CODE';
  if i>0 then
    execute immediate 'alter table BGT_PERF_INDICATOR modify lv3_perf_ind_code VARCHAR2(300)';
  end if;
  
  select count(*) into i from user_tab_columns t where t.table_name ='PM_PERF_INDICATOR' and t.column_name='LV1_PERF_IND_CODE';
  if i>0 then
    execute immediate 'alter table PM_PERF_INDICATOR modify lv1_perf_ind_code VARCHAR2(300)';
  end if;
  
  select count(*) into i from user_tab_columns t where t.table_name ='PM_PERF_INDICATOR' and t.column_name='LV2_PERF_IND_CODE';
  if i>0 then
    execute immediate 'alter table PM_PERF_INDICATOR modify lv2_perf_ind_code VARCHAR2(300)';
  end if;
  
  select count(*) into i from user_tab_columns t where t.table_name ='PM_PERF_INDICATOR' and t.column_name='LV3_PERF_IND_CODE';
  if i>0 then
    execute immediate 'alter table PM_PERF_INDICATOR modify lv3_perf_ind_code VARCHAR2(300)';
  end if;
  
  select count(*) into i from user_tab_columns t where t.table_name ='PERF_T_ADJUSTINDEX' and t.column_name='LV1_PERF_IND_CODE';
  if i>0 then
    execute immediate 'alter table PERF_T_ADJUSTINDEX modify lv1_perf_ind_code VARCHAR2(300)';
  end if;
  
  select count(*) into i from user_tab_columns t where t.table_name ='PERF_T_ADJUSTINDEX' and t.column_name='LV2_PERF_IND_CODE';
  if i>0 then
    execute immediate 'alter table PERF_T_ADJUSTINDEX modify lv2_perf_ind_code VARCHAR2(300)';
  end if;
  
  select count(*) into i from user_tab_columns t where t.table_name ='PERF_T_ADJUSTINDEX' and t.column_name='LV3_PERF_IND_CODE';
  if i>0 then
    execute immediate 'alter table PERF_T_ADJUSTINDEX modify lv3_perf_ind_code VARCHAR2(300)';
  end if;
  
  select count(*) into i from user_tab_columns t where t.table_name ='PERF_T_PROINDEXTRACE' and t.column_name='CODE';
  if i>0 then
    execute immediate 'alter table PERF_T_PROINDEXTRACE modify code VARCHAR2(300)';
  end if;
  
  select count(*) into i from user_tab_columns t where t.table_name ='PERF_T_SELFPERFINDEX' and t.column_name='CODE';
  if i>0 then
    execute immediate 'alter table PERF_T_SELFPERFINDEX modify code VARCHAR2(300)';
  end if;
 
v_sql :='
create or replace view V_BGT_PERF_GOAL_INFO as
select *
    from BGT_PERF_GOAL_INFO t where year = global_multyear_cz.v_pmyear
      and province = global_multyear_cz.v_pmdivid and t.is_deleted=2 and t.is_backup =2';
select fn_alterview('V_BGT_PERF_GOAL_INFO',v_sql) into ln_i;
if ln_i = 0 then
	return;
end if;	 
 
v_sql :='
CREATE OR REPLACE VIEW V_BGT_PERF_INDICATOR AS
select *
from BGT_PERF_INDICATOR t where year = global_multyear_cz.v_pmyear
      and province = global_multyear_cz.v_pmdivid and is_deleted = 2 and t.is_backup =2';
select fn_alterview('V_BGT_PERF_INDICATOR',v_sql) into ln_i;
if ln_i = 0 then
	return;
end if;		  
