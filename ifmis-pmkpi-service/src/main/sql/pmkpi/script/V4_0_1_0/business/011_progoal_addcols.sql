
i integer;
begin
     select count(1) into i from user_tab_cols t where t.table_name='PM_PERF_GOAL_INFO' and t.column_name='YEARFLAG';
     if i=0 then
       execute immediate 'alter table PM_PERF_GOAL_INFO add YEARFLAG VARCHAR2(1)';
       
     end if;
	 
	 select count(1) into i from user_tab_cols t where t.table_name='PERF_T_ADJUSTGOAL' and t.column_name='YEARFLAG';
     if i=0 then
       execute immediate 'alter table PERF_T_ADJUSTGOAL add YEARFLAG VARCHAR2(1)';
       
     end if;
     
     select count(1) into i from user_tab_cols t where t.table_name='PM_PERF_GOAL_TEMP' and t.column_name='YEARFLAG';
     if i=0 then
       execute immediate 'alter table PM_PERF_GOAL_TEMP add YEARFLAG VARCHAR2(40)';
     end if;
	 
	 select count(1) into i from user_tab_cols t where t.table_name='PM_PERF_GOAL_TEMP' and t.column_name='AGENCYGUID';
     if i=0 then
       execute immediate 'alter table PM_PERF_GOAL_TEMP add AGENCYGUID VARCHAR2(1)';
     end if;
	 
	 select count(1) into i from user_tab_cols t where t.table_name='PM_PERF_GOAL_TEMP' and t.column_name='KPI_PER_ID';
     if i=0 then
       execute immediate 'alter table PM_PERF_GOAL_TEMP add KPI_PER_ID VARCHAR2(38)';
     end if;
	 
	 select count(1) into i from user_tab_cols t where t.table_name='PM_PERF_GOAL_TEMP' and t.column_name='MOF_DIV_CODE';
     if i=0 then
       execute immediate 'alter table PM_PERF_GOAL_TEMP add MOF_DIV_CODE VARCHAR2(9)';
     end if;
	 
	 select count(1) into i from user_tab_cols t where t.table_name='PM_PERF_GOAL_TEMP' and t.column_name='FISCAL_YEAR';
     if i=0 then
       execute immediate 'alter table PM_PERF_GOAL_TEMP add FISCAL_YEAR VARCHAR2(4)';
     end if;
	 
	 select count(1) into i from user_tab_cols t where t.table_name='PM_PERF_GOAL_TEMP' and t.column_name='BUSI_TYPE';
     if i=0 then
       execute immediate 'alter table PM_PERF_GOAL_TEMP add BUSI_TYPE VARCHAR2(6)';
     end if;
	 
	 select count(1) into i from user_tab_cols t where t.table_name='PM_PERF_GOAL_TEMP' and t.column_name='VERSION';
     if i=0 then
       execute immediate 'alter table PM_PERF_GOAL_TEMP add VERSION VARCHAR2(38)';
     end if;
	 
	 select count(1) into i from user_tab_cols t where t.table_name='PM_PERF_GOAL_TEMP' and t.column_name='VERSION_NAME';
     if i=0 then
       execute immediate 'alter table PM_PERF_GOAL_TEMP add VERSION_NAME VARCHAR2(400)';
     end if;
	 
	 select count(1) into i from user_tab_cols t where t.table_name='PM_PERF_GOAL_TEMP' and t.column_name='SUB_MOF_CODE';
     if i=0 then
       execute immediate 'alter table PM_PERF_GOAL_TEMP add SUB_MOF_CODE VARCHAR2(9)';
     end if;
	 
	 select count(1) into i from user_tab_cols t where t.table_name='PM_PERF_GOAL_TEMP' and t.column_name='UPDATE_TIME';
     if i=0 then
       execute immediate 'alter table PM_PERF_GOAL_TEMP add UPDATE_TIME VARCHAR2(17)';
     end if;
	 
	 select count(1) into i from user_tab_cols t where t.table_name='PM_PERF_GOAL_TEMP' and t.column_name='IS_DELETED';
     if i=0 then
       execute immediate 'alter table PM_PERF_GOAL_TEMP add IS_DELETED NUMBER(1)';
     end if;
	 
	 select count(1) into i from user_tab_cols t where t.table_name='PM_PERF_GOAL_TEMP' and t.column_name='CREATE_TIME';
     if i=0 then
       execute immediate 'alter table PM_PERF_GOAL_TEMP add CREATE_TIME VARCHAR2(17)';
     end if;
	 
	 select count(1) into i from user_tab_cols t where t.table_name='PM_PERF_GOAL_TEMP' and t.column_name='AGENCY_CODE';
     if i=0 then
       execute immediate 'alter table PM_PERF_GOAL_TEMP add AGENCY_CODE VARCHAR2(38)';
     end if;
	 
	 select count(1) into i from user_tab_cols t where t.table_name='PM_PERF_GOAL_TEMP' and t.column_name='PROGUID';
     if i=0 then
       execute immediate 'alter table PM_PERF_GOAL_TEMP add PROGUID VARCHAR2(38)';
     end if;
	 
	 select count(1) into i from user_tab_cols t where t.table_name='PM_PERF_GOAL_TEMP' and t.column_name='FROMGUID';
     if i=0 then
       execute immediate 'alter table PM_PERF_GOAL_TEMP add FROMGUID VARCHAR2(32)';
     end if;
	 
execute immediate '	
create or replace view v_pm_perf_goal_info as
select *
from pm_perf_goal_info t where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
  and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and t.is_deleted=2';

execute immediate '	
create or replace view v_perf_t_adjustgoal as
select *
from perf_t_adjustgoal t where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
  and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';
