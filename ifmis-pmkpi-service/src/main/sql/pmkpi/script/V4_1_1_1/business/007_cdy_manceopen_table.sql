
  i number;
begin
  select count(*) into i from user_tab_cols t where t.TABLE_NAME='PERF_T_MANCEOPEN' and t.column_name='XMLY';
  if i=0 then
     execute immediate 'alter table PERF_T_MANCEOPEN add xmly VARCHAR2(40)';
  end if;
  
  select count(*) into i from user_tab_cols t where t.TABLE_NAME='PERF_T_MANCEOPEN' and t.column_name='MANAGE_MOF_DEP_CODE';
  if i=0 then
     execute immediate 'alter table PERF_T_MANCEOPEN add manage_mof_dep_code varchar2(40)';
  end if;
  
  select count(*) into i from user_tab_cols t where t.TABLE_NAME='PERF_T_MANCEOPEN' and t.column_name='FININTORGGUID';
  if i=0 then
     execute immediate 'alter table PERF_T_MANCEOPEN add finintorgguid varchar2(40)';
  end if;
  
  select count(*) into i from user_tab_cols t where t.TABLE_NAME='PERF_T_MANCEOPEN' and t.column_name='DEPT_CODE';
  if i=0 then
     execute immediate 'alter table PERF_T_MANCEOPEN add dept_code varchar2(40)';
  end if;
  
  select count(*) into i from user_tab_cols t where t.TABLE_NAME='PERF_T_MANCEOPEN' and t.column_name='AGENCY_CODE';
  if i=0 then
     execute immediate 'alter table PERF_T_MANCEOPEN add agency_code varchar2(40)';
  end if;
  
  select count(*) into i from user_tab_cols t where t.TABLE_NAME='PERF_T_MANCEOPEN' and t.column_name='PRO_KIND_CODE';
  if i=0 then
     execute immediate 'alter table PERF_T_MANCEOPEN add pro_kind_code varchar2(40)';
  end if;
  
  select count(*) into i from user_tab_cols t where t.TABLE_NAME='PERF_T_MANCEOPEN' and t.column_name='PRO_NAME';
  if i=0 then
     execute immediate 'alter table PERF_T_MANCEOPEN add pro_name varchar2(200)';
  end if;
  
  select count(*) into i from user_tab_cols t where t.TABLE_NAME='PERF_T_MANCEOPEN' and t.column_name='MONEY';
  if i=0 then
     execute immediate 'alter table PERF_T_MANCEOPEN add money NUMBER(20,2)';
  end if;
  
  select count(*) into i from user_tab_cols t where t.TABLE_NAME='PERF_T_MANCEOPEN' and t.column_name='ISTBJX';
  if i=0 then
     execute immediate 'alter table PERF_T_MANCEOPEN add istbjx varchar2(40)';
  end if;

execute immediate 'create or replace view v_perf_t_manceopen as
select *
from PERF_T_MANCEOPEN where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and is_deleted = ''2''';
