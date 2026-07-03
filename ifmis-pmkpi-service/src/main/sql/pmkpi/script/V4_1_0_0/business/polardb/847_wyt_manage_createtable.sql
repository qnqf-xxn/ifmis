  i number;
begin
  --绩效考核指标表
select count(1) into i from user_tables where table_name = 'PERF_MANAGE_EVAL_SCORE';
  if i = 0 then
     execute immediate '
        create table PERF_MANAGE_EVAL_SCORE
        (
          eval_dtl_id        VARCHAR2(38) not null,
          fiscal_year        VARCHAR2(4) not null,
          mof_div_code       VARCHAR2(9) not null,
          mof_div_name       VARCHAR2(360) not null,
          examinee_type_code VARCHAR2(4) not null,
          examinee_type_name VARCHAR2(100) not null,
          sub_mof_div_code   VARCHAR2(9),
          sub_mof_div_name   VARCHAR2(360),
          dept_code          VARCHAR2(21),
          dept_name          VARCHAR2(300),
          mof_dep_code       VARCHAR2(6) not null,
          mof_dep_name       VARCHAR2(90) not null,
          ori_div_code       VARCHAR2(9),
          ori_div_name       VARCHAR2(360),
          parent_id          VARCHAR2(38),
          level_no           NUMBER(2) not null,
          is_leaf            NUMBER(1) not null,
          ind_code           VARCHAR2(300) not null,
          ind_name           VARCHAR2(1000) not null,
          ind_desc           VARCHAR2(2000),
          kpi_evalstd        VARCHAR2(2000) not null,
          ind_weight         NUMBER(18,6) not null,
          remark             VARCHAR2(2000),
          is_last_inst       NUMBER(1) not null,
          update_time        VARCHAR2(17) not null,
          is_deleted         NUMBER(1) not null,
          create_time        VARCHAR2(17) not null
      )';
    execute immediate 'comment on column PERF_MANAGE_EVAL_SCORE.eval_dtl_id
      is ''考核评分表主键''';
     execute immediate 'comment on column PERF_MANAGE_EVAL_SCORE.fiscal_year
      is ''考核年度''';
     execute immediate 'comment on column PERF_MANAGE_EVAL_SCORE.mof_div_code
      is ''财政区划代码''';
     execute immediate 'comment on column PERF_MANAGE_EVAL_SCORE.mof_div_name
      is ''财政区划名称''';
     execute immediate 'comment on column PERF_MANAGE_EVAL_SCORE.examinee_type_code
      is ''考核对象类型代码  1下级财政  2本级部门  3本级财政''';
     execute immediate 'comment on column PERF_MANAGE_EVAL_SCORE.examinee_type_name
      is ''考核对象类型名称''';
     execute immediate 'comment on column PERF_MANAGE_EVAL_SCORE.sub_mof_div_code
      is ''下级财政区划代码''';
     execute immediate 'comment on column PERF_MANAGE_EVAL_SCORE.sub_mof_div_name
      is ''下级财政区划名称''';
     execute immediate 'comment on column PERF_MANAGE_EVAL_SCORE.dept_code
      is ''部门编码''';
     execute immediate 'comment on column PERF_MANAGE_EVAL_SCORE.dept_name
      is ''部门名称''';
     execute immediate 'comment on column PERF_MANAGE_EVAL_SCORE.mof_dep_code
      is ''主管处室代码''';
     execute immediate 'comment on column PERF_MANAGE_EVAL_SCORE.mof_dep_name
      is ''主管处室名称''';
     execute immediate 'comment on column PERF_MANAGE_EVAL_SCORE.ori_div_code
      is ''来源方财政区划代码''';
     execute immediate 'comment on column PERF_MANAGE_EVAL_SCORE.ori_div_name
      is ''来源方财政区划名称''';
     execute immediate 'comment on column PERF_MANAGE_EVAL_SCORE.parent_id
      is ''父级节点id''';
     execute immediate 'comment on column PERF_MANAGE_EVAL_SCORE.level_no
      is ''级次''';
     execute immediate 'comment on column PERF_MANAGE_EVAL_SCORE.is_leaf
      is ''是否末级''';
     execute immediate 'comment on column PERF_MANAGE_EVAL_SCORE.ind_code
      is ''指标代码''';
     execute immediate 'comment on column PERF_MANAGE_EVAL_SCORE.ind_name
      is ''指标名称''';
     execute immediate 'comment on column PERF_MANAGE_EVAL_SCORE.ind_desc
      is ''指标说明''';
     execute immediate 'comment on column PERF_MANAGE_EVAL_SCORE.kpi_evalstd
      is ''评(扣)分标准''';
     execute immediate 'comment on column PERF_MANAGE_EVAL_SCORE.ind_weight
      is ''分值''';
     execute immediate 'comment on column PERF_MANAGE_EVAL_SCORE.remark
      is ''备注''';
     execute immediate 'comment on column PERF_MANAGE_EVAL_SCORE.is_last_inst
      is ''是否终审''';
     execute immediate 'comment on column PERF_MANAGE_EVAL_SCORE.update_time
      is ''更新时间''';
     execute immediate 'comment on column PERF_MANAGE_EVAL_SCORE.is_deleted
      is ''是否删除''';
     execute immediate 'comment on column PERF_MANAGE_EVAL_SCORE.create_time
      is ''创建时间''';

     execute immediate '
    create index IND_PERF_MANAGE_EVAL_SCORE on PERF_MANAGE_EVAL_SCORE (EVAL_DTL_ID, FISCAL_YEAR, MOF_DIV_CODE)';

     execute immediate '
    alter table PERF_MANAGE_EVAL_SCORE
      add constraint PK_PERF_MANAGE_EVAL_SCORE primary key (EVAL_DTL_ID)';
 end if;

--绩效考核评价表
    select count(1) into i from user_tables where table_name = 'PERF_MANAGE_EVAL';
      if i = 0 then
         execute immediate '
    create table PERF_MANAGE_EVAL
    (
      eval_id            VARCHAR2(38) not null,
      fiscal_year        VARCHAR2(4) not null,
      mof_div_code       VARCHAR2(9) not null,
      mof_div_name       VARCHAR2(360) not null,
      sub_mof_div_code   VARCHAR2(9),
      sub_mof_div_name   VARCHAR2(360),
      dept_code          VARCHAR2(21),
      dept_name          VARCHAR2(300),
      ori_div_code       VARCHAR2(9),
      ori_div_name       VARCHAR2(360),
      examinee_type_code VARCHAR2(4) not null,
      examinee_type_name VARCHAR2(100) not null,
      ind_code           VARCHAR2(300) not null,
      ind_name           VARCHAR2(1000) not null,
      ind_score          NUMBER(16,6) not null,
      eval_score         NUMBER(16,6),
      exist_problems     VARCHAR2(2000),
      rectify_step       VARCHAR2(2000),
      mof_aud_opinion    VARCHAR2(2000),
      remark             VARCHAR2(2000),
      is_last_inst       NUMBER(1) not null,
      update_time        VARCHAR2(17) not null,
      is_deleted         NUMBER(1) not null,
      create_time        VARCHAR2(17) not null
    )';

    execute immediate 'comment on column PERF_MANAGE_EVAL.eval_id
      is ''绩效考核表主键''';
    execute immediate 'comment on column PERF_MANAGE_EVAL.fiscal_year
      is ''考核年度''';
    execute immediate 'comment on column PERF_MANAGE_EVAL.mof_div_code
      is ''财政区划代码''';
    execute immediate 'comment on column PERF_MANAGE_EVAL.mof_div_name
      is ''财政区划名称''';
    execute immediate 'comment on column PERF_MANAGE_EVAL.sub_mof_div_code
      is ''下级财政区划代码''';
    execute immediate 'comment on column PERF_MANAGE_EVAL.sub_mof_div_name
      is ''下级财政区划名称''';
    execute immediate 'comment on column PERF_MANAGE_EVAL.dept_code
      is ''部门编码''';
    execute immediate 'comment on column PERF_MANAGE_EVAL.dept_name
      is ''部门名称''';
    execute immediate 'comment on column PERF_MANAGE_EVAL.ori_div_code
      is ''来源方财政区划代码''';
    execute immediate 'comment on column PERF_MANAGE_EVAL.ori_div_name
      is ''来源方财政区划名称''';
    execute immediate 'comment on column PERF_MANAGE_EVAL.examinee_type_code
      is ''考核对象类型代码''';
    execute immediate 'comment on column PERF_MANAGE_EVAL.examinee_type_name
      is ''考核对象类型名称''';
    execute immediate 'comment on column PERF_MANAGE_EVAL.ind_code
      is ''指标编码''';
    execute immediate 'comment on column PERF_MANAGE_EVAL.ind_name
      is ''指标名称''';
    execute immediate 'comment on column PERF_MANAGE_EVAL.ind_score
      is ''自评得分''';
    execute immediate 'comment on column PERF_MANAGE_EVAL.eval_score
      is ''评定得分''';
    execute immediate 'comment on column PERF_MANAGE_EVAL.exist_problems
      is ''存在问题''';
    execute immediate 'comment on column PERF_MANAGE_EVAL.rectify_step
      is ''整改建议''';
    execute immediate 'comment on column PERF_MANAGE_EVAL.mof_aud_opinion
      is ''财政审核意见''';
    execute immediate 'comment on column PERF_MANAGE_EVAL.remark
      is ''备注''';
    execute immediate 'comment on column PERF_MANAGE_EVAL.is_last_inst
      is ''是否终审''';
    execute immediate 'comment on column PERF_MANAGE_EVAL.update_time
      is ''更新时间''';
    execute immediate 'comment on column PERF_MANAGE_EVAL.is_deleted
      is ''是否删除''';
    execute immediate 'comment on column PERF_MANAGE_EVAL.create_time
      is ''创建时间''';

    execute immediate '
    create index IND_PERF_MANAGE_EVAL on PERF_MANAGE_EVAL (EVAL_ID, FISCAL_YEAR, MOF_DIV_CODE)';

    execute immediate '
    alter table PERF_MANAGE_EVAL
      add constraint PK_PERF_MANAGE_EVAL primary key (EVAL_ID)';
    end if;
    
--绩效考核附件表    
select count(1) into i from user_tables where table_name = 'PERF_MANAGE_FILE';
  if i = 0 then
    execute immediate '   
      create table PERF_MANAGE_FILE
      (
        file_id      VARCHAR2(38) not null,
        fiscal_year  VARCHAR2(4) not null,
        file_name    VARCHAR2(50) not null,
        full_path    VARCHAR2(300) not null,
        ori_div_code VARCHAR2(9),
        ori_div_name VARCHAR2(360),
        dept_code    VARCHAR2(21),
        dept_name    VARCHAR2(300),
        is_last_inst NUMBER(1) not null,
        update_time  VARCHAR2(17) not null,
        is_deleted   NUMBER(1) not null,
        create_time  VARCHAR2(17) not null,
        mof_div_code VARCHAR2(9) not null,
        mof_div_name VARCHAR2(360) not null
      )';
  execute immediate ' comment on column PERF_MANAGE_FILE.file_id
    is ''附件主键''';
  execute immediate ' comment on column PERF_MANAGE_FILE.fiscal_year
    is ''考核年度''';
  execute immediate ' comment on column PERF_MANAGE_FILE.file_name
    is ''附件名称''';
  execute immediate ' comment on column PERF_MANAGE_FILE.full_path
    is ''附件路径''';
  execute immediate ' comment on column PERF_MANAGE_FILE.ori_div_code
    is ''来源方财政区划代码''';
  execute immediate ' comment on column PERF_MANAGE_FILE.ori_div_name
    is ''来源方财政区划名称''';
  execute immediate ' comment on column PERF_MANAGE_FILE.dept_code
    is ''部门(单位)编码''';
  execute immediate ' comment on column PERF_MANAGE_FILE.dept_name
    is ''部门(单位)名称''';
  execute immediate ' comment on column PERF_MANAGE_FILE.is_last_inst
    is ''是否终审''';
  execute immediate ' comment on column PERF_MANAGE_FILE.update_time
    is ''更新时间''';
  execute immediate ' comment on column PERF_MANAGE_FILE.is_deleted
    is ''是否删除''';
  execute immediate ' comment on column PERF_MANAGE_FILE.create_time
    is ''创建时间''';
  execute immediate ' comment on column PERF_MANAGE_FILE.mof_div_code
    is ''财政区划代码''';
  execute immediate ' comment on column PERF_MANAGE_FILE.mof_div_name
    is ''财政区划名称''';

  execute immediate ' alter table PERF_MANAGE_FILE
    add constraint PK_PERF_MANAGE_FILE primary key (FILE_ID)';
  end if;
  
  --重构视图
  execute immediate '
  create or replace view v_perf_manage_eval_score as
    select t.*
    from PERF_MANAGE_EVAL_SCORE t
    where t.fiscal_year = global_multyear_cz.v_pmyear
        and t.mof_div_code = global_multyear_cz.v_pmdivid and t.is_deleted=2';
  
  execute immediate '
  create or replace view v_perf_manage_eval as
  select t.*
  from PERF_MANAGE_EVAL t
  where t.fiscal_year = global_multyear_cz.v_pmyear
      and t.mof_div_code = global_multyear_cz.v_pmdivid and t.is_deleted=2';
      
 execute immediate 'create or replace view v_perf_manage_file as
  select t.*
  from PERF_MANAGE_FILE t
  where t.fiscal_year = global_multyear_cz.v_pmyear
      and t.mof_div_code = global_multyear_cz.v_pmdivid and t.is_deleted=2';
