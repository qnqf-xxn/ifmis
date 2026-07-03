
i number;
begin
  
  select count(1) into i from user_tab_cols t where t.table_name='PERF_T_ADJUST' and t.column_name='ADJUSTSOURCE';
  if i=0 then
    execute immediate 'alter table PERF_T_ADJUST add ADJUSTSOURCE varchar2(40)';
  end if;
  
  select count(1) into i from user_tab_cols t where t.table_name='PERF_T_ADJUST' and t.column_name='DELWFSTATUS';
  if i=0 then
    execute immediate 'alter table PERF_T_ADJUST add DELWFSTATUS varchar2(40)';
  end if;
  
  select count(1) into i from user_tab_cols t where t.table_name='PERF_T_ADJUST' and t.column_name='DELOPINION';
  if i=0 then
    execute immediate 'alter table PERF_T_ADJUST add DELOPINION varchar2(4000)';
  end if;
  
  select count(1) into i from user_tab_cols t where t.table_name='PERF_T_ADJUST' and t.column_name='DELAUDITOPINION';
  if i=0 then
    execute immediate 'alter table PERF_T_ADJUST add DELAUDITOPINION varchar2(4000)';
  end if;
  
  select count(1) into i from user_tab_cols t where t.table_name='PERF_T_ADJUSTINDEX' and t.column_name='INDSOURCE';
  if i=0 then
    execute immediate 'alter table PERF_T_ADJUSTINDEX add INDSOURCE varchar2(40)';
  end if;

execute immediate '
create or replace view v_perf_t_adjust as
select *
 from perf_t_adjust t
where YEAR = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'') and PROVINCE = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';


execute immediate '
create or replace view v_perf_t_adjustindex as
select *
 from PERF_T_ADJUSTINDEX t
where YEAR = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'') and PROVINCE = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') 
and t.is_deleted=2 and t.sub_mof_div_code is null';