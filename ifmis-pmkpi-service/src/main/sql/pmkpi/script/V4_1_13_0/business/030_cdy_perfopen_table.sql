
i number;
begin
  
  select count(1) into i from user_tab_cols t where t.table_name='PERF_T_MANCEOPEN' and t.column_name='BGTAMT';
  if i=0 then
    execute immediate 'alter table PERF_T_MANCEOPEN add bgtamt NUMBER(16,4)';
  end if;
  
  select count(1) into i from user_tab_cols t where t.table_name='PERF_T_MANCEOPEN' and t.column_name='APPROVEDBGTAMT';
  if i=0 then
    execute immediate 'alter table PERF_T_MANCEOPEN add approvedbgtamt NUMBER(16,4)';
  end if;
  
  select count(1) into i from user_tab_cols t where t.table_name='PERF_T_MANCEOPEN' and t.column_name='APPROVALRATE';
  if i=0 then
    execute immediate 'alter table PERF_T_MANCEOPEN add approvalrate NUMBER(5,2)';
  end if;
  
  select count(1) into i from user_tab_cols t where t.table_name='PERF_T_MANCEOPEN' and t.column_name='APPROVALTIME';
  if i=0 then
    execute immediate 'alter table PERF_T_MANCEOPEN add approvaltime varchar2(17)';
  end if;
  
  select count(1) into i from user_tab_cols t where t.table_name='PERF_T_MANCEOPEN' and t.column_name='OPENTIME';
  if i=0 then
    execute immediate 'alter table PERF_T_MANCEOPEN add opentime varchar2(17)';
  end if;
  
  select count(1) into i from user_tab_cols t where t.table_name='PERF_T_MANCEOPEN' and t.column_name='OPENRATE';
  if i=0 then
    execute immediate 'alter table PERF_T_MANCEOPEN add openrate NUMBER(5,2)';
  end if;
  
  select count(1) into i from user_tab_cols t where t.table_name='PERF_T_MANCEOPEN' and t.column_name='REMARK';
  if i=0 then
    execute immediate 'alter table PERF_T_MANCEOPEN add remark varchar2(4000)';
  end if;
  
  select count(1) into i from user_tab_cols t where t.table_name='PERF_T_MANCEOPEN' and t.column_name='OPENPROAMT';
  if i=0 then
    execute immediate 'alter table PERF_T_MANCEOPEN add openproamt NUMBER(16,4)';
  end if;
  
  select count(1) into i from user_tab_cols t where t.table_name='PERF_T_MANCEOPEN' and t.column_name='OPENPRONUM';
  if i=0 then
    execute immediate 'alter table PERF_T_MANCEOPEN add openpronum NUMBER(9)';
  end if;
  
  select count(1) into i from user_tab_cols t where t.table_name='PERF_T_MANCEOPEN' and t.column_name='EVALUATEDPRONUM';
  if i=0 then
    execute immediate 'alter table PERF_T_MANCEOPEN add evaluatedpronum NUMBER(9)';
  end if;
  

execute immediate '
create or replace view v_perf_t_manceopen as
select *
 from PERF_T_MANCEOPEN t where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and is_deleted = ''2''';