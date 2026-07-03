i number;
begin
  select count(1) into i from user_tab_columns t where t.table_name='PERF_T_RANDOM' and t.column_name='PROVINCE';
  if i=0 then
     execute immediate 'alter table PERF_T_RANDOM add PROVINCE VARCHAR2(32)';
  end if;
  
  select count(1) into i from user_tab_columns t where t.table_name='PERF_T_RANDOM' and t.column_name='YEAR';
  if i=0 then
     execute immediate 'alter table PERF_T_RANDOM add YEAR VARCHAR2(32)';
  end if;
  
  select count(1) into i from user_tables t where t.table_name = 'PERF_T_RANDOM';
  if i=1 then
	 execute immediate 'create or replace view v_PERF_T_RANDOM as
select t.*
  from PERF_T_RANDOM t
 where t.year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'') and
     t.province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';
  end if;
  
  
  select count(1) into i from user_tab_columns t where t.table_name='PERF_T_RANDOMCOMMENT' and t.column_name='PRO_CODE';
  if i=0 then
     execute immediate 'alter table PERF_T_RANDOMCOMMENT add PRO_CODE VARCHAR2(40)';
  end if;
  
  select count(1) into i from user_tables t where t.table_name = 'PERF_T_RANDOMCOMMENT';
  if i=1 then
	 execute immediate 'create or replace view v_PERF_T_RANDOMCOMMENT as
select t.*
  from PERF_T_RANDOMCOMMENT t
 where t.year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'') and
     t.province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';
  end if;

  select count(1) into i from user_tab_columns t where t.table_name='PERF_T_RANDOMQUALITY_SCORE' and t.column_name='PRO_CODE';
  if i=0 then
     execute immediate 'alter table PERF_T_RANDOMQUALITY_SCORE add PRO_CODE VARCHAR2(40)';
  end if;
  
  select count(1) into i from user_tables t where t.table_name = 'PERF_T_RANDOMQUALITY_SCORE';
  if i=1 then
	 execute immediate 'create or replace view v_PERF_T_RANDOMQUALITY_SCORE as
select t.*
  from PERF_T_RANDOMQUALITY_SCORE t
 where t.year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'') and
     t.province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';
  end if;
  
  select count(1) into i from user_tab_columns t where t.table_name='PERF_T_RANDOMPROBLEM' and t.column_name='PRO_CODE';
  if i=0 then
     execute immediate 'alter table PERF_T_RANDOMPROBLEM add PRO_CODE VARCHAR2(40)';
  end if;
  
  select count(1) into i from user_tables t where t.table_name = 'PERF_T_RANDOMPROBLEM';
  if i=1 then
	 execute immediate 'create or replace view v_PERF_T_RANDOMPROBLEM as
select t.*
  from PERF_T_RANDOMPROBLEM t
 where t.year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'') and
     t.province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';
  end if;
  
  select count(1) into i from user_tab_columns t where t.table_name='PERF_T_RANDOMINDEX' and t.column_name='PRO_CODE';
  if i=0 then
     execute immediate 'alter table PERF_T_RANDOMINDEX add PRO_CODE VARCHAR2(40)';
  end if;
  
  select count(1) into i from user_tables t where t.table_name = 'PERF_T_RANDOMINDEX';
  if i=1 then
	 execute immediate 'create or replace view v_PERF_T_RANDOMINDEX as
select t.*
  from PERF_T_RANDOMINDEX t
 where t.year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'') and
     t.province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';
  end if;
