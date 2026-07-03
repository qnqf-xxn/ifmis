
 i number;
begin
  
  select count(*) into i from user_tables t where t.table_name ='PERF_T_BIMMODNAMECONFIG';
  if i=0 then
    execute immediate '
    create table PERF_T_BIMMODNAMECONFIG
    (
      guid      VARCHAR2(32) not null,
      isagency  VARCHAR2(1),
      colcode   VARCHAR2(100),
      upcolcode VARCHAR2(100),
      tablecode VARCHAR2(32),
      status    NUMBER(1) default 1,
      filtersql VARCHAR2(255),
      remark    VARCHAR2(255),
      isstand   VARCHAR2(1)
    )';
    execute immediate 'alter table PERF_T_BIMMODNAMECONFIG add primary key (GUID)';
  end if;

  select count(*) into i from user_tables t where t.table_name ='PERF_T_BIMMODNAMELOG';
  if i=0 then
    execute immediate '
    create table PERF_T_BIMMODNAMELOG
    (
      guid        VARCHAR2(32) not null,
      msgid       VARCHAR2(32),
      status      NUMBER(1),
      create_time VARCHAR2(17),
      remark      VARCHAR2(255),
      year        VARCHAR2(4),
      province    VARCHAR2(9),
      msgdata     NVARCHAR2(2000)
    )';
    execute immediate 'create index INX_PERF_BIMMODNAMELOG on PERF_T_BIMMODNAMELOG (YEAR, PROVINCE, STATUS)';
    execute immediate 'alter table PERF_T_BIMMODNAMELOG add primary key (GUID)';
  end if;

  select count(*) into i from user_tab_columns t where t.table_name ='PERF_T_DEPTPERFDECLARE' and t.column_name='NAME' and t.data_type='VARCHAR2';
  if i=1 then
    execute immediate 'alter table perf_t_deptperfdeclare modify name NVARCHAR2(360)';
  end if;

  select count(*) into i from user_tab_columns t where t.table_name ='BGT_PERF_GOAL_INFO' and t.column_name='DEPT_NAME' and t.data_type='VARCHAR2';
  if i=1 then
    execute immediate 'alter table bgt_perf_goal_info modify dept_name NVARCHAR2(360)';
  end if;

  select count(*) into i from user_tab_columns t where t.table_name ='BGT_PERF_INDICATOR' and t.column_name='DEPT_NAME' and t.data_type='VARCHAR2';
  if i=1 then
    execute immediate 'alter table bgt_perf_indicator modify dept_name NVARCHAR2(360)';
  end if;

  select count(*) into i from user_tab_columns t where t.table_name ='PM_PERF_GOAL_INFO' and t.column_name='AGENCY_NAME' and t.data_type='VARCHAR2';
  if i=1 then
    execute immediate 'alter table pm_perf_goal_info modify agency_name NVARCHAR2(360)';
  end if;

  select count(*) into i from user_tab_columns t where t.table_name ='PM_PERF_INDICATOR' and t.column_name='AGENCY_NAME' and t.data_type='VARCHAR2';
  if i=1 then
    execute immediate 'alter table pm_perf_indicator modify agency_name NVARCHAR2(360)';
  end if;

  select count(*) into i from user_tab_columns t where t.table_name ='PERF_T_ADJUST' and t.column_name='NAME' and t.data_type='VARCHAR2';
  if i=1 then
    execute immediate 'alter table perf_t_adjust modify name NVARCHAR2(1000)';
  end if;

  select count(*) into i from user_tab_columns t where t.table_name ='PERF_T_ADJUSTGOAL' and t.column_name='AGENCY_NAME' and t.data_type='VARCHAR2';
  if i=1 then
    execute immediate 'alter table perf_t_adjustgoal modify agency_name NVARCHAR2(360)';
  end if;

  select count(*) into i from user_tab_columns t where t.table_name ='PERF_T_ADJUSTGOAL' and t.column_name='DEPT_NAME' and t.data_type='VARCHAR2';
  if i=1 then
    execute immediate 'alter table perf_t_adjustgoal modify dept_name NVARCHAR2(360)';
  end if;

  select count(*) into i from user_tab_columns t where t.table_name ='PERF_T_ADJUSTINDEX' and t.column_name='AGENCY_NAME' and t.data_type='VARCHAR2';
  if i=1 then
    execute immediate 'alter table perf_t_adjustindex modify agency_name NVARCHAR2(360)';
  end if;

  select count(*) into i from user_tab_columns t where t.table_name ='PERF_T_ADJUSTINDEX' and t.column_name='DEPT_NAME' and t.data_type='VARCHAR2';
  if i=1 then
    execute immediate 'alter table perf_t_adjustindex modify dept_name NVARCHAR2(360)';
  end if;

  select count(*) into i from user_tab_columns t where t.table_name ='PERF_T_PROMONITOR' and t.column_name='NAME' and t.data_type='VARCHAR2';
  if i=1 then
    execute immediate 'alter table perf_t_promonitor modify name NVARCHAR2(1000)';
  end if;

  select count(*) into i from user_tab_columns t where t.table_name ='PERF_T_SELFEVALTASK' and t.column_name='NAME' and t.data_type='VARCHAR2';
  if i=1 then
    execute immediate 'alter table perf_t_selfevaltask modify name NVARCHAR2(1000)';
  end if;

  select count(*) into i from user_tab_columns t where t.table_name ='PERF_T_FINEVALUATION' and t.column_name='NAME' and t.data_type='VARCHAR2';
  if i=1 then
    execute immediate 'alter table perf_t_finevaluation modify name NVARCHAR2(1000)';
  end if;

  select count(*) into i from user_tab_columns t where t.table_name ='PAY_PERF_MONITOR_TASK' and t.column_name='AGENCY_NAME' and t.data_type='VARCHAR2';
  if i=1 then
    execute immediate 'alter table pay_perf_monitor_task modify agency_name NVARCHAR2(360)';
  end if;

  select count(*) into i from user_tab_columns t where t.table_name ='PAY_PERF_MONITOR_TASK' and t.column_name='DEPT_NAME' and t.data_type='VARCHAR2';
  if i=1 then
    execute immediate 'alter table pay_perf_monitor_task modify dept_name NVARCHAR2(360)';
  end if;

  select count(*) into i from user_tab_columns t where t.table_name ='PAY_PERF_MONITOR_INFO' and t.column_name='AGENCY_NAME' and t.data_type='VARCHAR2';
  if i=1 then
    execute immediate 'alter table pay_perf_monitor_info modify agency_name NVARCHAR2(360)';
  end if;

  select count(*) into i from user_tab_columns t where t.table_name ='PAY_PERF_MONITOR_INFO' and t.column_name='DEPT_NAME' and t.data_type='VARCHAR2';
  if i=1 then
    execute immediate 'alter table pay_perf_monitor_info modify dept_name NVARCHAR2(360)';
  end if;

  select count(*) into i from user_tab_columns t where t.table_name ='PM_PERF_SELF_EVAL' and t.column_name='AGENCY_NAME' and t.data_type='VARCHAR2';
  if i=1 then
    execute immediate 'alter table pm_perf_self_eval modify agency_name NVARCHAR2(360)';
  end if;

  select count(*) into i from user_tab_columns t where t.table_name ='PM_PERF_SELF_EVAL' and t.column_name='DEPT_NAME' and t.data_type='VARCHAR2';
  if i=1 then
    execute immediate 'alter table pm_perf_self_eval modify dept_name NVARCHAR2(360)';
  end if;

  select count(*) into i from user_tab_columns t where t.table_name ='PM_SELF_EVAL_GOAL' and t.column_name='AGENCY_NAME' and t.data_type='VARCHAR2';
  if i=1 then
    execute immediate 'alter table pm_self_eval_goal modify agency_name NVARCHAR2(360)';
  end if;

  select count(*) into i from user_tab_columns t where t.table_name ='PM_SELF_EVAL_GOAL' and t.column_name='DEPT_NAME' and t.data_type='VARCHAR2';
  if i=1 then
    execute immediate 'alter table pm_self_eval_goal modify dept_name NVARCHAR2(360)';
  end if;

  select count(*) into i from user_tab_columns t where t.table_name ='PM_SELF_EVAL_INDICATOR' and t.column_name='AGENCY_NAME' and t.data_type='VARCHAR2';
  if i=1 then
    execute immediate 'alter table pm_self_eval_indicator modify agency_name NVARCHAR2(360)';
  end if;

  select count(*) into i from user_tab_columns t where t.table_name ='PM_SELF_EVAL_INDICATOR' and t.column_name='DEPT_NAME' and t.data_type='VARCHAR2';
  if i=1 then
    execute immediate 'alter table pm_self_eval_indicator modify dept_name NVARCHAR2(360)';
  end if;

  select count(*) into i from user_tab_columns t where t.table_name ='PM_PERF_SELF_BGT' and t.column_name='AGENCY_NAME' and t.data_type='VARCHAR2';
  if i=1 then
    execute immediate 'alter table pm_perf_self_bgt modify agency_name NVARCHAR2(360)';
  end if;

  select count(*) into i from user_tab_columns t where t.table_name ='PM_PERF_GOV_EVAL' and t.column_name='AGENCY_NAME' and t.data_type='VARCHAR2';
  if i=1 then
    execute immediate 'alter table pm_perf_gov_eval modify agency_name NVARCHAR2(360)';
  end if;

  select count(*) into i from user_tab_columns t where t.table_name ='PM_PERF_GOV_EVAL' and t.column_name='DEPT_NAME' and t.data_type='VARCHAR2';
  if i=1 then
    execute immediate 'alter table pm_perf_gov_eval modify dept_name NVARCHAR2(360)';
  end if;

  select count(*) into i from user_tab_columns t where t.table_name ='PM_PERF_DEPT_EVAL' and t.column_name='AGENCY_NAME' and t.data_type='VARCHAR2';
  if i=1 then
    execute immediate 'alter table pm_perf_dept_eval modify agency_name NVARCHAR2(360)';
  end if;

  select count(*) into i from user_tab_columns t where t.table_name ='PM_PERF_DEPT_EVAL' and t.column_name='DEPT_NAME' and t.data_type='VARCHAR2';
  if i=1 then
    execute immediate 'alter table pm_perf_dept_eval modify dept_name NVARCHAR2(360)';
  end if;
