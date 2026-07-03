i number;
begin
  select count(1) into i from user_tables where table_name = 'PAY_PERF_MONITOR_TASK';
  if i = 0 then
     execute immediate '
    create table PAY_PERF_MONITOR_TASK
    (
      perf_task_id        VARCHAR2(38) not null,
      fiscal_year         VARCHAR2(4) not null,
      mof_div_code        VARCHAR2(9) not null,
      mof_div_name        VARCHAR2(360) not null,
      perf_task_no        VARCHAR2(100) not null,
      perf_type_code      VARCHAR2(1) not null,
      perf_type_name      VARCHAR2(40) not null,
      perf_task_title     VARCHAR2(200) not null,
      perf_task_dsec      VARCHAR2(2000) not null,
      task_end_date       VARCHAR2(17) not null,
      dept_code           VARCHAR2(21),
      dept_name           VARCHAR2(150),
      agency_code         VARCHAR2(21),
      agency_name         VARCHAR2(300),
      pro_code            VARCHAR2(21),
      pro_name            VARCHAR2(180),
      is_last_inst        NUMBER(1) not null,
      create_time         VARCHAR2(17) not null,
      update_time         VARCHAR2(17) not null,
      is_deleted          NUMBER(1) not null
    )';

    execute immediate 'comment on column PAY_PERF_MONITOR_TASK.perf_task_id
      is ''监控任务主键''';
    execute immediate 'comment on column PAY_PERF_MONITOR_TASK.fiscal_year
      is ''预算年度''';
    execute immediate 'comment on column PAY_PERF_MONITOR_TASK.mof_div_code
      is ''财政区划代码''';
    execute immediate 'comment on column PAY_PERF_MONITOR_TASK.mof_div_name
      is ''财政区划名称''';
    execute immediate 'comment on column PAY_PERF_MONITOR_TASK.perf_task_no
      is ''监控任务编号''';
    execute immediate 'comment on column PAY_PERF_MONITOR_TASK.perf_type_code
      is ''绩效监控类型编码''';
    execute immediate 'comment on column PAY_PERF_MONITOR_TASK.perf_type_name
      is ''绩效监控类型名称''';
    execute immediate 'comment on column PAY_PERF_MONITOR_TASK.perf_task_title
      is ''监控任务标题''';
    execute immediate 'comment on column PAY_PERF_MONITOR_TASK.perf_task_dsec
      is ''监控任务内容''';
    execute immediate 'comment on column PAY_PERF_MONITOR_TASK.task_end_date
      is ''报送截止日期''';
    execute immediate 'comment on column PAY_PERF_MONITOR_TASK.dept_code
      is ''部门代码''';
    execute immediate 'comment on column PAY_PERF_MONITOR_TASK.dept_name
      is ''部门名称''';
    execute immediate 'comment on column PAY_PERF_MONITOR_TASK.agency_code
      is ''单位代码''';
    execute immediate 'comment on column PAY_PERF_MONITOR_TASK.agency_name
      is ''单位名称''';
    execute immediate 'comment on column PAY_PERF_MONITOR_TASK.pro_code
      is ''项目代码''';
    execute immediate 'comment on column PAY_PERF_MONITOR_TASK.pro_name
      is ''项目名称''';
    execute immediate 'comment on column PAY_PERF_MONITOR_TASK.is_last_inst
      is ''是否终审''';
    execute immediate 'comment on column PAY_PERF_MONITOR_TASK.create_time
      is ''创建时间''';
    execute immediate 'comment on column PAY_PERF_MONITOR_TASK.update_time
      is ''更新时间''';
    execute immediate 'comment on column PAY_PERF_MONITOR_TASK.is_deleted
      is ''是否删除''';
      
    execute immediate '
    create index IDX_PERF_MONITOR_TASK_01 on PAY_PERF_MONITOR_TASK (perf_task_id, fiscal_year, mof_div_code)';

    execute immediate '
    alter table PAY_PERF_MONITOR_TASK
      add constraint PK_PERF_MONITOR_TASK primary key (PERF_TASK_ID)';
      
  end if;

  select count(1) into i from user_tables where table_name = 'PAY_PERF_MONITOR_INFO';
  if i = 0 then
    execute immediate '
    create table PAY_PERF_MONITOR_INFO
    (
      perf_mon_id        VARCHAR2(38) not null,
      fiscal_year        VARCHAR2(4) not null,
      mof_div_code       VARCHAR2(9) not null,
      mof_div_name       VARCHAR2(360) not null,
      perf_task_id       VARCHAR2(38) not null,
      perf_mon_no        VARCHAR2(100) not null,
      perf_type_code     VARCHAR2(1) not null,
      perf_type_name     VARCHAR2(40) not null,
      agency_code        VARCHAR2(21) not null,
      agency_name        VARCHAR2(300) not null,
      dept_code          VARCHAR2(21) not null,
      dept_name          VARCHAR2(150) not null,
      pro_code           VARCHAR2(21),
      pro_name           VARCHAR2(180),
      kpi_target         VARCHAR2(2000) not null,
      pro_bgt_comp       NUMBER(16,4) not null,
      est_pro_bgt_annual NUMBER(16,4) not null,
      lv1_perf_ind_code  VARCHAR2(20) not null,
      lv1_perf_ind_name  VARCHAR2(1000) not null,
      lv2_perf_ind_code  VARCHAR2(20) not null,
      lv2_perf_ind_name  VARCHAR2(1000) not null,
      lv3_perf_ind_code  VARCHAR2(20) not null,
      lv3_perf_ind_name  VARCHAR2(1000) not null,
      kpi_val            VARCHAR2(1000) not null,
      perf_comp          VARCHAR2(2000) not null,
      est_perf_annual    VARCHAR2(2000) not null,
      ana_dev_reasons    VARCHAR2(2000) not null,
      complete_rate      NUMBER(16,4) not null,
      perf_send_date     VARCHAR2(17),
      is_perf_rectify    NUMBER(1),
      rectify_advise     VARCHAR2(2000),
      rectify_epilog     VARCHAR2(2000),
      is_last_inst       NUMBER(1) not null,
      create_time        VARCHAR2(17) not null,
      update_time        VARCHAR2(17) not null,
      is_deleted         NUMBER(1) not null
    )';

    execute immediate 'comment on column PAY_PERF_MONITOR_INFO.mof_div_name
      is ''财政区划名称''';
    execute immediate 'comment on column PAY_PERF_MONITOR_INFO.perf_task_id
      is ''监控任务主键''';
    execute immediate 'comment on column PAY_PERF_MONITOR_INFO.perf_mon_no
      is ''监控信息编号''';
    execute immediate 'comment on column PAY_PERF_MONITOR_INFO.perf_type_code
      is ''绩效监控类型编码''';
    execute immediate 'comment on column PAY_PERF_MONITOR_INFO.perf_type_name
      is ''绩效监控类型名称''';
    execute immediate 'comment on column PAY_PERF_MONITOR_INFO.agency_code
      is ''单位代码''';
    execute immediate 'comment on column PAY_PERF_MONITOR_INFO.agency_name
      is ''单位名称''';
    execute immediate 'comment on column PAY_PERF_MONITOR_INFO.dept_code
      is ''部门代码''';
    execute immediate 'comment on column PAY_PERF_MONITOR_INFO.dept_name
      is ''部门名称''';
    execute immediate 'comment on column PAY_PERF_MONITOR_INFO.pro_code
      is ''项目代码''';
    execute immediate 'comment on column PAY_PERF_MONITOR_INFO.pro_name
      is ''项目名称''';
    execute immediate 'comment on column PAY_PERF_MONITOR_INFO.kpi_target
      is ''绩效目标''';
    execute immediate 'comment on column PAY_PERF_MONITOR_INFO.pro_bgt_comp
      is ''项目预算执行情况''';
    execute immediate 'comment on column PAY_PERF_MONITOR_INFO.est_pro_bgt_annual
      is ''项目预算全年预计执行情况''';
    execute immediate 'comment on column PAY_PERF_MONITOR_INFO.lv1_perf_ind_code
      is ''一级绩效指标代码''';
    execute immediate 'comment on column PAY_PERF_MONITOR_INFO.lv1_perf_ind_name
      is ''一级绩效指标名称''';
    execute immediate 'comment on column PAY_PERF_MONITOR_INFO.lv2_perf_ind_code
      is ''二级绩效指标代码''';
    execute immediate 'comment on column PAY_PERF_MONITOR_INFO.lv2_perf_ind_name
      is ''二级绩效指标名称''';
    execute immediate 'comment on column PAY_PERF_MONITOR_INFO.lv3_perf_ind_code
      is ''三级绩效指标代码''';
    execute immediate 'comment on column PAY_PERF_MONITOR_INFO.lv3_perf_ind_name
      is ''三级绩效指标名称''';
    execute immediate 'comment on column PAY_PERF_MONITOR_INFO.kpi_val
      is ''指标值''';
    execute immediate 'comment on column PAY_PERF_MONITOR_INFO.perf_comp
      is ''绩效指标完成情况''';
    execute immediate 'comment on column PAY_PERF_MONITOR_INFO.est_perf_annual
      is ''绩效指标全年预计完成情况''';
    execute immediate 'comment on column PAY_PERF_MONITOR_INFO.ana_dev_reasons
      is ''偏差原因分析''';
    execute immediate 'comment on column PAY_PERF_MONITOR_INFO.complete_rate
      is ''完成目标可能性''';
    execute immediate 'comment on column PAY_PERF_MONITOR_INFO.perf_send_date
      is ''报送日期''';
    execute immediate 'comment on column PAY_PERF_MONITOR_INFO.is_perf_rectify
      is ''是否需要整改''';
    execute immediate 'comment on column PAY_PERF_MONITOR_INFO.rectify_advise
      is ''整改要求和建议''';
    execute immediate 'comment on column PAY_PERF_MONITOR_INFO.rectify_epilog
      is ''整改结果和结论''';
    execute immediate 'comment on column PAY_PERF_MONITOR_INFO.is_last_inst
      is ''是否终审''';
    execute immediate 'comment on column PAY_PERF_MONITOR_INFO.create_time
      is ''创建时间''';
    execute immediate 'comment on column PAY_PERF_MONITOR_INFO.update_time
      is ''更新时间''';
    execute immediate 'comment on column PAY_PERF_MONITOR_INFO.is_deleted
      is ''是否删除''';

    execute immediate '
    create index IDX_PERF_MONITOR_INFO_01 on PAY_PERF_MONITOR_INFO (perf_mon_id, fiscal_year, mof_div_code)';

    execute immediate '
    alter table PAY_PERF_MONITOR_INFO
      add constraint PK_PERF_MONITOR_INFO primary key (PERF_MON_ID)';
      
  end if;

  select count(1) into i from user_tables where table_name = 'PAY_PERF_MONITOR_ATTACH';
  if i = 0 then
     execute immediate '
    create table PAY_PERF_MONITOR_ATTACH
    (
      perf_att_id  VARCHAR2(38) not null,
      fiscal_year  VARCHAR2(4) not null,
      mof_div_code VARCHAR2(38) not null,
      mof_div_name VARCHAR2(360) not null,
      perf_mon_id  VARCHAR2(38) not null,
      file_name    VARCHAR2(50) not null,
      full_path    VARCHAR2(300),
      report_file  VARCHAR2(4000),
      is_last_inst NUMBER(1),
      update_time  VARCHAR2(17) not null,
      is_deleted   NUMBER(1) not null,
      create_time  VARCHAR2(17) not null
    )';

    execute immediate 'comment on column PAY_PERF_MONITOR_ATTACH.perf_att_id
      is ''附件唯一标识''';
    execute immediate 'comment on column PAY_PERF_MONITOR_ATTACH.fiscal_year
      is ''预算年度''';
    execute immediate 'comment on column PAY_PERF_MONITOR_ATTACH.mof_div_code
      is ''财政区划代码''';
    execute immediate 'comment on column PAY_PERF_MONITOR_ATTACH.mof_div_name
      is ''财政区划名称''';
    execute immediate 'comment on column PAY_PERF_MONITOR_ATTACH.perf_mon_id
      is ''监控信息主键''';
    execute immediate 'comment on column PAY_PERF_MONITOR_ATTACH.file_name
      is ''附件名称''';
    execute immediate 'comment on column PAY_PERF_MONITOR_ATTACH.full_path
      is ''附件路径''';
    execute immediate 'comment on column PAY_PERF_MONITOR_ATTACH.report_file
      is ''附件文件''';
    execute immediate 'comment on column PAY_PERF_MONITOR_ATTACH.update_time
      is ''更新时间''';
    execute immediate 'comment on column PAY_PERF_MONITOR_ATTACH.is_deleted
      is ''是否删除''';
    execute immediate 'comment on column PAY_PERF_MONITOR_ATTACH.create_time
      is ''创建时间''';
     
    execute immediate '
    alter table PAY_PERF_MONITOR_ATTACH
      add constraint PK_PERF_MONITOR_ATTACH primary key (PERF_ATT_ID)';

  end if;

execute immediate '
create or replace view v_pay_perf_monitor_task as
select t.*
 from pay_perf_monitor_task t
where t.fiscal_year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'') 
and t.mof_div_code = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')
and t.is_deleted=2';

execute immediate '
create or replace view v_pay_perf_monitor_info as
select t.*
 from pay_perf_monitor_info t
where t.fiscal_year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'') 
and t.mof_div_code = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')
and t.is_deleted=2';

execute immediate '
create or replace view v_pay_perf_monitor_attach as
select t.*
 from pay_perf_monitor_attach t
where t.fiscal_year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'') 
and t.mof_div_code = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')
and t.is_deleted=2';