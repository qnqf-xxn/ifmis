--项目绩效自评信息表  (PM_PERF_SELF_EVAL)

i number;
begin
  select count(1) into i from user_tables where table_name = 'PM_PERF_SELF_EVAL';
  if i = 0 then
     execute immediate '
    create table PM_PERF_SELF_EVAL
    (
      eval_id                 VARCHAR2(38) not null,
      fiscal_year             VARCHAR2  (4) not null,
      mof_div_code            VARCHAR2(9) not null,
      mof_div_name            VARCHAR2(360) not null,
      dept_code               VARCHAR2(21),
      dept_name               VARCHAR2(300),
      agency_code             VARCHAR2(21) not null,
      agency_name             VARCHAR2(300) not null,
      pro_code                VARCHAR2(21) not null,
      pro_name                VARCHAR2(180) not null,
      devi_analy              VARCHAR2(2000),
      application_advise      VARCHAR2(2000),
      total_eval_value        NUMBER(16,6) not null,
      dept_score              NUMBER(16,6),
      dept_suggest            VARCHAR2(2000),
      dep_aud_opinion         VARCHAR2(2000),
      mof_aud_opinion         VARCHAR2(2000),
      is_last_inst            NUMBER(1) not null,
      update_time             VARCHAR2(17) not null,
      is_deleted              NUMBER(1) not null,
      create_time             VARCHAR2(17) not null
    )';

    execute immediate 'comment on column PM_PERF_SELF_EVAL.eval_id
      is ''自评信息主键''';
    execute immediate 'comment on column PM_PERF_SELF_EVAL.fiscal_year
      is ''评价年度''';
    execute immediate 'comment on column PM_PERF_SELF_EVAL.mof_div_code
      is ''财政区划代码''';
    execute immediate 'comment on column PM_PERF_SELF_EVAL.mof_div_name
      is ''财政区划名称''';
    execute immediate 'comment on column PM_PERF_SELF_EVAL.dept_code
      is ''部门代码''';
    execute immediate 'comment on column PM_PERF_SELF_EVAL.dept_name
      is ''部门名称''';
    execute immediate 'comment on column PM_PERF_SELF_EVAL.agency_code
      is ''单位代码''';
    execute immediate 'comment on column PM_PERF_SELF_EVAL.agency_name
      is ''单位名称''';
    execute immediate 'comment on column PM_PERF_SELF_EVAL.pro_code
      is ''项目代码''';
    execute immediate 'comment on column PM_PERF_SELF_EVAL.pro_name
      is ''项目名称''';
    execute immediate 'comment on column PM_PERF_SELF_EVAL.devi_analy
      is ''偏差分析及整改措施''';
    execute immediate 'comment on column PM_PERF_SELF_EVAL.application_advise
      is ''结果应用建议''';
    execute immediate 'comment on column PM_PERF_SELF_EVAL.total_eval_value
      is ''单位自评得分''';
    execute immediate 'comment on column PM_PERF_SELF_EVAL.dept_score
      is ''主管部门评分''';
    execute immediate 'comment on column PM_PERF_SELF_EVAL.dept_suggest
      is ''主管部门处理意见''';
    execute immediate 'comment on column PM_PERF_SELF_EVAL.dep_aud_opinion
      is ''部门审核意见''';
    execute immediate 'comment on column PM_PERF_SELF_EVAL.mof_aud_opinion
      is ''财政审核意见''';
    execute immediate 'comment on column PM_PERF_SELF_EVAL.is_last_inst
      is ''是否终审''';
    execute immediate 'comment on column PM_PERF_SELF_EVAL.update_time
      is ''更新时间''';
    execute immediate 'comment on column PM_PERF_SELF_EVAL.is_deleted
      is ''是否删除''';
    execute immediate 'comment on column PM_PERF_SELF_EVAL.create_time
      is ''创建时间''';
      
    execute immediate '
    create index IDX_PM_PERF_SELF_EVAL on PM_PERF_SELF_EVAL (EVAL_ID)';

    execute immediate '
    alter table PM_PERF_SELF_EVAL
      add constraint PK_PM_PERF_SELF_EVAL primary key (EVAL_ID)';
      
  end if;

--项目绩效目标单位自评表
  select count(1) into i from user_tables where table_name = 'PM_SELF_EVAL_GOAL';
  if i = 0 then
    execute immediate '
    create table PM_SELF_EVAL_GOAL
    (
      eval_kpi_id               VARCHAR2(38) not null,
      eval_id               VARCHAR2(38) not null,
      kpi_per_id             VARCHAR2(38) not null,
      fiscal_year             VARCHAR2(4) not null,
      mof_div_code            VARCHAR2(9) not null,
      mof_div_name            VARCHAR2(360) not null,
      dept_code               VARCHAR2(21),
      dept_name               VARCHAR2(300),
      agency_code             VARCHAR2(21) not null,
      agency_name             VARCHAR2(300) not null,
      pro_code                VARCHAR2(21) not null,
      pro_name                VARCHAR2(180) not null,
      kpi_target             VARCHAR2(2000) not null,
      goal_comp             VARCHAR2(2000) not null,
      is_last_inst            NUMBER(1) not null,
      update_time             VARCHAR2(17) not null,
      is_deleted              NUMBER(1) not null,
      create_time             VARCHAR2(17) not null
    )';

    execute immediate 'comment on column PM_SELF_EVAL_GOAL.eval_kpi_id
      is ''自评绩效目标主键''';
    execute immediate 'comment on column PM_SELF_EVAL_GOAL.eval_id
      is ''绩效自评信息表主键''';
    execute immediate 'comment on column PM_SELF_EVAL_GOAL.kpi_per_id
      is ''项目绩效目标主键''';
    execute immediate 'comment on column PM_SELF_EVAL_GOAL.fiscal_year
      is ''评价年度''';
    execute immediate 'comment on column PM_SELF_EVAL_GOAL.mof_div_code
      is ''财政区划代码''';
    execute immediate 'comment on column PM_SELF_EVAL_GOAL.mof_div_name
      is ''财政区划名称''';
    execute immediate 'comment on column PM_SELF_EVAL_GOAL.dept_code
      is ''部门代码''';
    execute immediate 'comment on column PM_SELF_EVAL_GOAL.dept_name
      is ''部门名称''';
    execute immediate 'comment on column PM_SELF_EVAL_GOAL.agency_code
      is ''单位代码''';
    execute immediate 'comment on column PM_SELF_EVAL_GOAL.agency_name
      is ''单位名称''';
    execute immediate 'comment on column PM_SELF_EVAL_GOAL.pro_code
      is ''项目代码''';
    execute immediate 'comment on column PM_SELF_EVAL_GOAL.pro_name
      is ''项目名称''';
    execute immediate 'comment on column PM_SELF_EVAL_GOAL.kpi_target
      is ''绩效年度绩效预期目标''';
    execute immediate 'comment on column PM_SELF_EVAL_GOAL.goal_comp
      is ''绩效年度目标完成情况''';
    execute immediate 'comment on column PM_SELF_EVAL_GOAL.is_last_inst
      is ''是否终审''';
    execute immediate 'comment on column PM_SELF_EVAL_GOAL.update_time
      is ''更新时间''';
    execute immediate 'comment on column PM_SELF_EVAL_GOAL.is_deleted
      is ''是否删除''';
    execute immediate 'comment on column PM_SELF_EVAL_GOAL.create_time
      is ''创建时间''';
    

    execute immediate '
    create index IDX_PM_SELF_EVAL_GOAL on PM_SELF_EVAL_GOAL (EVAL_KPI_ID, FISCAL_YEAR, MOF_DIV_CODE)';

    execute immediate '
    alter table PM_SELF_EVAL_GOAL
      add constraint PK_PM_SELF_EVAL_GOAL primary key (EVAL_KPI_ID)';
      
  end if;

--项目绩效指标单位自评表
  select count(1) into i from user_tables where table_name = 'PM_SELF_EVAL_INDICATOR';
  if i = 0 then
     execute immediate '
    create table PM_SELF_EVAL_INDICATOR
    (
      eval_ind_id               VARCHAR2(38) not null,
      eval_id                   VARCHAR2(38) not null,
      fiscal_year               VARCHAR2(4) not null,
      mof_div_code              VARCHAR2(9) not null,
      mof_div_name              VARCHAR2(360) not null,
      kpi_id                    VARCHAR2(38),
      dept_code                 VARCHAR2(21),
      dept_name                 VARCHAR2(300),
      agency_code               VARCHAR2(21) not null,
      agency_name               VARCHAR2(300) not null,
      pro_code                  VARCHAR2(21) not null,
      pro_name                  VARCHAR2(180) not null,
      lv1_perf_ind_code         VARCHAR2(300) not null,
      lv1_perf_ind_name         VARCHAR2(1000) not null,
      lv2_perf_ind_code         VARCHAR2(300) not null,
      lv2_perf_ind_name         VARCHAR2(1000) not null,
      lv3_perf_ind_code         VARCHAR2(300) not null,
      lv3_perf_ind_name         VARCHAR2(1000) not null,
      kpi_val                   VARCHAR2(1000) not null,
      ind_comp                  VARCHAR2(2000) not null,
      kpi_evalstd               VARCHAR2(2000),
      ind_weight                NUMBER(16,4) not null,
      eval_score                NUMBER(16,6) not null,
      devi_analy                VARCHAR2(2000),
      application_advise        VARCHAR2(2000),
      is_last_inst              NUMBER(1) not null,
      update_time               VARCHAR2(17) not null,
      is_deleted                NUMBER(1) not null,
      create_time               VARCHAR2(17) not null
    )';

    execute immediate 'comment on column PM_SELF_EVAL_INDICATOR.EVAL_IND_ID
      is ''自评指标主键''';
    execute immediate 'comment on column PM_SELF_EVAL_INDICATOR.EVAL_ID
      is ''绩效自评信息表主键''';
    execute immediate 'comment on column PM_SELF_EVAL_INDICATOR.FISCAL_YEAR
      is ''评价年度''';
    execute immediate 'comment on column PM_SELF_EVAL_INDICATOR.MOF_DIV_CODE
      is ''财政区划代码''';
    execute immediate 'comment on column PM_SELF_EVAL_INDICATOR.MOF_DIV_NAME
      is ''财政区划名称''';
    execute immediate 'comment on column PM_SELF_EVAL_INDICATOR.KPI_ID
      is ''项目绩效指标主键''';
    execute immediate 'comment on column PM_SELF_EVAL_INDICATOR.DEPT_CODE
      is ''部门代码''';
    execute immediate 'comment on column PM_SELF_EVAL_INDICATOR.DEPT_NAME
      is ''部门名称''';
    execute immediate 'comment on column PM_SELF_EVAL_INDICATOR.AGENCY_CODE
      is ''单位代码''';
    execute immediate 'comment on column PM_SELF_EVAL_INDICATOR.AGENCY_NAME
      is ''单位名称''';
    execute immediate 'comment on column PM_SELF_EVAL_INDICATOR.PRO_CODE
      is ''项目代码''';
    execute immediate 'comment on column PM_SELF_EVAL_INDICATOR.PRO_NAME
      is ''项目名称''';
    execute immediate 'comment on column PM_SELF_EVAL_INDICATOR.LV1_PERF_IND_CODE
      is ''一级绩效指标代码''';
    execute immediate 'comment on column PM_SELF_EVAL_INDICATOR.LV1_PERF_IND_NAME
      is ''一级绩效指标名称''';
    execute immediate 'comment on column PM_SELF_EVAL_INDICATOR.LV2_PERF_IND_CODE
      is ''二级绩效指标代码''';
    execute immediate 'comment on column PM_SELF_EVAL_INDICATOR.LV2_PERF_IND_NAME
      is ''二级绩效指标名称''';
    execute immediate 'comment on column PM_SELF_EVAL_INDICATOR.LV3_PERF_IND_CODE
      is ''三级绩效指标代码''';
    execute immediate 'comment on column PM_SELF_EVAL_INDICATOR.LV3_PERF_IND_NAME
      is ''三级绩效指标名称''';
    execute immediate 'comment on column PM_SELF_EVAL_INDICATOR.KPI_VAL
      is ''指标值''';
    execute immediate 'comment on column PM_SELF_EVAL_INDICATOR.IND_COMP
      is ''指标值完成情况''';
    execute immediate 'comment on column PM_SELF_EVAL_INDICATOR.KPI_EVALSTD
      is ''评(扣)分标准''';
    execute immediate 'comment on column PM_SELF_EVAL_INDICATOR.IND_WEIGHT
      is ''权重''';
    execute immediate 'comment on column PM_SELF_EVAL_INDICATOR.EVAL_SCORE
      is ''自评得分''';
    execute immediate 'comment on column PM_SELF_EVAL_INDICATOR.DEVI_ANALY
      is ''偏差分析及整改措施''';
    execute immediate 'comment on column PM_SELF_EVAL_INDICATOR.APPLICATION_ADVISE
      is ''结果应用建议''';
    execute immediate 'comment on column PM_SELF_EVAL_INDICATOR.IS_LAST_INST
      is ''是否终审''';
    execute immediate 'comment on column PM_SELF_EVAL_INDICATOR.UPDATE_TIME
      is ''更新时间''';
    execute immediate 'comment on column PM_SELF_EVAL_INDICATOR.IS_DELETED
      is ''是否删除''';
    execute immediate 'comment on column PM_SELF_EVAL_INDICATOR.CREATE_TIME
      is ''创建时间''';
     
    execute immediate '
    create index IDX_PM_SELF_INDICATOR on PM_SELF_EVAL_INDICATOR (EVAL_IND_ID, FISCAL_YEAR, MOF_DIV_CODE)';

    execute immediate '
    alter table PM_SELF_EVAL_INDICATOR
      add constraint PK_PM_SELF_EVAL_INDICATOR primary key (EVAL_IND_ID)';

  end if;



--项目预算执行完成情况
  select count(1) into i from user_tables where table_name = 'PM_PERF_SELF_BGT';
  if i = 0 then
     execute immediate '
    create table PM_PERF_SELF_BGT
    (
      bgt_eval_id               VARCHAR2(38) not null,
      fiscal_year               VARCHAR2(4) not null,
      mof_div_code              VARCHAR2(9) not null,
      mof_div_name              VARCHAR2(360) not null,
      agency_code               VARCHAR2(21) not null,
      agency_name               VARCHAR2(300) not null,
      pro_code                  VARCHAR2(21) not null,
      pro_name                  VARCHAR2(180) not null,
      found_type_code           VARCHAR2(6) not null,
      found_type_name           VARCHAR2(30) not null,
      reply_amt                 NUMBER(18,2),
      year_adj_amt              NUMBER(18,2),
      cur_amt                   NUMBER(18,2),
      year_exe_amt              NUMBER(18,2),
      exe_amt_rate              NUMBER(16,4),
      exe_score                 NUMBER(16,6),
      is_last_inst              NUMBER(1) not null,
      update_time               VARCHAR2(17) not null,
      is_deleted                NUMBER(1) not null,
      create_time               VARCHAR2(17) not null
      )';

    execute immediate 'comment on column PM_PERF_SELF_BGT.bgt_eval_id
      is ''项目资金执行表主键''';
    execute immediate 'comment on column PM_PERF_SELF_BGT.fiscal_year
      is ''评价年度''';
    execute immediate 'comment on column PM_PERF_SELF_BGT.MOF_DIV_CODE
      is ''财政区划代码''';
    execute immediate 'comment on column PM_PERF_SELF_BGT.MOF_DIV_NAME
      is ''财政区划名称''';
    execute immediate 'comment on column PM_PERF_SELF_BGT.AGENCY_CODE
      is ''单位代码''';
    execute immediate 'comment on column PM_PERF_SELF_BGT.AGENCY_NAME
      is ''单位名称''';
    execute immediate 'comment on column PM_PERF_SELF_BGT.PRO_CODE
      is ''项目代码''';
    execute immediate 'comment on column PM_PERF_SELF_BGT.PRO_NAME
      is ''项目名称''';
    execute immediate 'comment on column PM_PERF_SELF_BGT.found_type_code
      is ''资金来源代码''';
    execute immediate 'comment on column PM_PERF_SELF_BGT.found_type_name
      is ''资金来源名称''';
    execute immediate 'comment on column PM_PERF_SELF_BGT.reply_amt
      is ''年初批复数''';
    execute immediate 'comment on column PM_PERF_SELF_BGT.year_adj_amt
      is ''年度调整金额''';
    execute immediate 'comment on column PM_PERF_SELF_BGT.cur_amt
      is ''变动后预算数''';
    execute immediate 'comment on column PM_PERF_SELF_BGT.year_exe_amt
      is ''全年执行数''';
    execute immediate 'comment on column PM_PERF_SELF_BGT.exe_amt_rate
      is ''资金执行率''';
    execute immediate 'comment on column PM_PERF_SELF_BGT.exe_score
      is ''资金执行得分''';
    execute immediate 'comment on column PM_PERF_SELF_BGT.is_last_inst
      is ''是否终审''';
    execute immediate 'comment on column PM_PERF_SELF_BGT.update_time
      is ''更新时间''';
    execute immediate 'comment on column PM_PERF_SELF_BGT.is_deleted
      is ''是否删除''';
    execute immediate 'comment on column PM_PERF_SELF_BGT.create_time
      is ''创建时间''';
      
     
    execute immediate '
    create index IDX_PM_PERF_SELF_BGT on PM_PERF_SELF_BGT (BGT_EVAL_ID)';

    execute immediate '
    alter table PM_PERF_SELF_BGT
      add constraint PK_PM_PERF_SELF_BGT primary key (BGT_EVAL_ID)';

  end if;





--绩效评价附件表
  select count(1) into i from user_tables where table_name = 'PERF_PUBLIC_FILE';
  if i = 0 then
     execute immediate '
    create table PERF_PUBLIC_FILE
    (
      file_id                   VARCHAR2(38) not null,
      eval_id                   VARCHAR2(38) not null,
      fiscal_year               VARCHAR2(4) not null,
      mof_div_code              VARCHAR2(9) not null,
      mof_div_name              VARCHAR2(360) not null,
      file_name                 VARCHAR2(50) not null,
      full_path                 VARCHAR2(300) not null,
      report_type_code          VARCHAR2(2) not null,
      report_type_name          VARCHAR2(100) not null,
      is_last_inst              NUMBER(1) not null,
      update_time               VARCHAR2(17) not null,
      is_deleted                NUMBER(1) not null,
      create_time               VARCHAR2(17) not null
      )';

    execute immediate 'comment on column PERF_PUBLIC_FILE.file_id
      is ''附件唯一标识''';
    execute immediate 'comment on column PERF_PUBLIC_FILE.eval_id
      is ''绩效表主键''';
    execute immediate 'comment on column PERF_PUBLIC_FILE.fiscal_year
      is ''评价年度''';
    execute immediate 'comment on column PERF_PUBLIC_FILE.mof_div_code
      is ''财政区划代码''';
    execute immediate 'comment on column PERF_PUBLIC_FILE.mof_div_name
      is ''财政区划名称''';
    execute immediate 'comment on column PERF_PUBLIC_FILE.file_name
      is ''附件名称''';
    execute immediate 'comment on column PERF_PUBLIC_FILE.full_path
      is ''附件路径''';
    execute immediate 'comment on column PERF_PUBLIC_FILE.report_type_code
      is ''绩效评价报告类型代码''';
    execute immediate 'comment on column PERF_PUBLIC_FILE.report_type_name
      is ''绩效评价报告类型名称''';
    execute immediate 'comment on column PERF_PUBLIC_FILE.is_last_inst
      is ''是否终审''';
    execute immediate 'comment on column PERF_PUBLIC_FILE.update_time
      is ''更新时间''';
    execute immediate 'comment on column PERF_PUBLIC_FILE.is_deleted
      is ''是否删除''';
    execute immediate 'comment on column PERF_PUBLIC_FILE.create_time
      is ''创建时间''';
      
     
    execute immediate '
    create index IDX_PERF_PUBLIC_FILE on PERF_PUBLIC_FILE (FILE_ID)';

    execute immediate '
    alter table PERF_PUBLIC_FILE
      add constraint PK_PERF_PUBLIC_FILE primary key (FILE_ID)';

  end if;












execute immediate '
create or replace view v_pm_perf_self_eval as
select t.*
 from pm_perf_self_eval t
where t.fiscal_year = global_multyear_cz.v_pmyear
and t.mof_div_code = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')
and t.is_deleted=2';

execute immediate '
create or replace view v_pm_self_eval_goal as
select t.*
 from pm_self_eval_goal t
where t.fiscal_year = global_multyear_cz.v_pmyear
and t.mof_div_code = global_multyear_cz.v_pmdivid
and t.is_deleted=2';

execute immediate '
create or replace view v_pm_self_eval_indicator as
select t.*
 from pm_self_eval_indicator t
where t.fiscal_year = global_multyear_cz.v_pmyear
and t.mof_div_code = global_multyear_cz.v_pmdivid
and t.is_deleted=2';

execute immediate '
create or replace view v_pm_perf_self_bgt as
select t.*
 from pm_perf_self_bgt t
where t.fiscal_year = global_multyear_cz.v_pmyear
and t.mof_div_code = global_multyear_cz.v_pmdivid
and t.is_deleted=2';

execute immediate '
create or replace view v_perf_public_file as
select t.*
 from perf_public_file t
where t.fiscal_year = global_multyear_cz.v_pmyear
and t.mof_div_code = global_multyear_cz.v_pmdivid
and t.is_deleted=2';
