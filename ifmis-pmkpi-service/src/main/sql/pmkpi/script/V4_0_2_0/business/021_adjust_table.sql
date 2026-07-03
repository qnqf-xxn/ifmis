
i number;
begin
  -- Test statements here
  select count(1) into i from user_tab_cols t where t.table_name='PERF_T_ADJUST' and t.column_name='MANAGE_DEPT_CODE';
    if i=0 then
       execute immediate 'alter table PERF_T_ADJUST add manage_dept_code varchar2(40)';
    end if;
    
    -- Test statements here
  select count(1) into i from user_tab_cols t where t.table_name='PERF_T_ADJUST' and t.column_name='MANAGE_MOF_DEP_CODE';
    if i=0 then
       execute immediate 'alter table PERF_T_ADJUST add manage_mof_dep_code varchar2(40)';
    end if;
    
    -- Test statements here
  select count(1) into i from user_tab_cols t where t.table_name='PERF_T_ADJUST' and t.column_name='MOF_DEP_CODE';
    if i=0 then
       execute immediate 'alter table PERF_T_ADJUST add mof_dep_code varchar2(40)';
    end if;
    
    -- Test statements here
  select count(1) into i from user_tab_cols t where t.table_name='PERF_T_ADJUST' and t.column_name='DEPT_CODE';
    if i=0 then
       execute immediate 'alter table PERF_T_ADJUST add dept_code varchar2(40)';
    end if;
    
    -- Test statements here
  select count(1) into i from user_tab_cols t where t.table_name='PERF_T_ADJUST' and t.column_name='AGENCY_CODE';
    if i=0 then
       execute immediate 'alter table PERF_T_ADJUST add agency_code varchar2(40)';
    end if;
    
execute immediate 'create or replace view v_perf_t_adjust as
select *
from perf_t_adjust where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';
