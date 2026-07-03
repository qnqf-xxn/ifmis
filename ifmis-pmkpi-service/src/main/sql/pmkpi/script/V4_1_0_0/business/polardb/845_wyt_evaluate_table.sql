i number;
begin
--绩效部门评价表
select count(*) into i from user_tables  t where t.TABLE_NAME='PM_PERF_DEPT_EVAL';
if i=0 then
  execute immediate'
    create table PM_PERF_DEPT_EVAL
    (
      eval_id         VARCHAR2(38) not null,
      fiscal_year     VARCHAR2(4) not null,
      mof_div_code    VARCHAR2(9) not null,
      mof_div_name    VARCHAR2(360) not null,
      dept_code       VARCHAR2(21),
      dept_name       VARCHAR2(300),
      agency_code     VARCHAR2(21) not null,
      agency_name     VARCHAR2(300) not null,
      pro_code        VARCHAR2(21) not null,
      pro_name        VARCHAR2(180) not null,
      eval_report     VARCHAR2(2000) not null,
      mof_aud_opinion VARCHAR2(2000),
      is_last_inst    NUMBER(1) not null,
      update_time     VARCHAR2(17) not null,
      is_deleted      NUMBER(1) not null,
      create_time     VARCHAR2(17) not null
    )';
-- Add comments to the columns 
execute immediate 'comment on column PM_PERF_DEPT_EVAL.eval_id
  is ''部门评价表主键''';
execute immediate 'comment on column PM_PERF_DEPT_EVAL.fiscal_year
  is ''评价年度''';
execute immediate 'comment on column PM_PERF_DEPT_EVAL.mof_div_code
  is ''财政区划代码''';
execute immediate 'comment on column PM_PERF_DEPT_EVAL.mof_div_name
  is ''财政区划名称''';
execute immediate 'comment on column PM_PERF_DEPT_EVAL.dept_code
  is ''部门代码''';
execute immediate 'comment on column PM_PERF_DEPT_EVAL.dept_name
  is ''部门名称''';
execute immediate 'comment on column PM_PERF_DEPT_EVAL.agency_code
  is ''单位代码''';
execute immediate 'comment on column PM_PERF_DEPT_EVAL.agency_name
  is ''单位名称''';
execute immediate 'comment on column PM_PERF_DEPT_EVAL.pro_code
  is ''项目代码''';
execute immediate 'comment on column PM_PERF_DEPT_EVAL.pro_name
  is ''项目名称''';
execute immediate 'comment on column PM_PERF_DEPT_EVAL.eval_report
  is ''部门评价报告''';
execute immediate 'comment on column PM_PERF_DEPT_EVAL.mof_aud_opinion
  is ''财政审核意见''';
execute immediate 'comment on column PM_PERF_DEPT_EVAL.is_last_inst
  is ''是否终审''';
execute immediate 'comment on column PM_PERF_DEPT_EVAL.update_time
  is ''更新时间''';
execute immediate 'comment on column PM_PERF_DEPT_EVAL.is_deleted
  is ''是否删除''';
execute immediate 'comment on column PM_PERF_DEPT_EVAL.create_time
  is ''创建时间''';
  
execute immediate 'create index IDX_PM_PERF_DEPT_EVAL on PM_PERF_DEPT_EVAL (EVAL_ID)';

execute immediate 'alter table PM_PERF_DEPT_EVAL
  add constraint PK_PM_PERF_DEPT_EVAL primary key (EVAL_ID)';
  end if;
  
  --重构视图
  execute immediate '
    create or replace view v_pm_perf_dept_eval as
    select t.*
    from pm_perf_dept_eval t
    where t.fiscal_year = global_multyear_cz.v_pmyear
    and t.mof_div_code = global_multyear_cz.v_pmdivid and t.is_deleted=2';
    
    
    
--绩效财政评价表
select count(*) into i from user_tables  t where t.TABLE_NAME='PM_PERF_GOV_EVAL';
if i=0 then
execute immediate'
 create table PM_PERF_GOV_EVAL
  (
    eval_id           VARCHAR2(38) not null,
    fiscal_year       VARCHAR2(4) not null,
    mof_div_code      VARCHAR2(9) not null,
    mof_div_name      VARCHAR2(360) not null,
    dept_code         VARCHAR2(21),
    dept_name         VARCHAR2(300),
    agency_code       VARCHAR2(21) not null,
    agency_name       VARCHAR2(300) not null,
    bgt_mof_dep_code  VARCHAR2(6) not null,
    bgt_mof_dep_name  VARCHAR2(60) not null,
    pro_code          VARCHAR2(21) not null,
    pro_name          VARCHAR2(180) not null,
    policy_name       VARCHAR2(180),
    eval_report       VARCHAR2(2000) not null,
    exist_problems    VARCHAR2(2000),
    rectify_step      VARCHAR2(2000),
    rectify_situation VARCHAR2(2000),
    is_last_inst      NUMBER(1) not null,
    update_time       VARCHAR2(17) not null,
    is_deleted        NUMBER(1) not null,
    create_time       VARCHAR2(17) not null
  )';
  -- Add comments to the columns
  execute immediate'comment on column PM_PERF_GOV_EVAL.eval_id
    is ''财政评价表主键''';
  execute immediate'comment on column PM_PERF_GOV_EVAL.fiscal_year
    is ''评价年度''';
  execute immediate'comment on column PM_PERF_GOV_EVAL.mof_div_code
    is ''财政区划代码''';
  execute immediate'comment on column PM_PERF_GOV_EVAL.mof_div_name
    is ''财政区划名称''';
  execute immediate'comment on column PM_PERF_GOV_EVAL.dept_code
    is ''部门代码''';
  execute immediate'comment on column PM_PERF_GOV_EVAL.dept_name
    is ''部门名称''';
  execute immediate'comment on column PM_PERF_GOV_EVAL.agency_code
    is ''单位代码''';
  execute immediate'comment on column PM_PERF_GOV_EVAL.agency_name
    is ''单位名称''';
  execute immediate'comment on column PM_PERF_GOV_EVAL.bgt_mof_dep_code
    is ''资金管理处室代码''';
  execute immediate'comment on column PM_PERF_GOV_EVAL.bgt_mof_dep_name
    is ''资金管理处室名称''';
  execute immediate'comment on column PM_PERF_GOV_EVAL.pro_code
    is ''项目代码''';
  execute immediate'comment on column PM_PERF_GOV_EVAL.pro_name
    is ''项目名称''';
  execute immediate'comment on column PM_PERF_GOV_EVAL.policy_name
    is ''政策名称''';
  execute immediate'comment on column PM_PERF_GOV_EVAL.eval_report
    is ''财政评价报告''';
  execute immediate'comment on column PM_PERF_GOV_EVAL.exist_problems
    is ''存在问题''';
  execute immediate'comment on column PM_PERF_GOV_EVAL.rectify_step
    is ''整改建议''';
  execute immediate'comment on column PM_PERF_GOV_EVAL.rectify_situation
    is ''整改落实情况''';
  execute immediate'comment on column PM_PERF_GOV_EVAL.is_last_inst
    is ''是否终审''';
  execute immediate'comment on column PM_PERF_GOV_EVAL.update_time
    is ''更新时间''';
  execute immediate'comment on column PM_PERF_GOV_EVAL.is_deleted
    is ''是否删除''';
  execute immediate'comment on column PM_PERF_GOV_EVAL.create_time
    is ''创建时间''';

  execute immediate'
     create index IDX_PM_PERF_GOV_EVAL on PM_PERF_GOV_EVAL (EVAL_ID)';
           
  execute immediate'   
  alter table PM_PERF_GOV_EVAL
    add constraint PK_PM_PERF_GOV_EVAL primary key (EVAL_ID)';
end if;

--重构视图
execute immediate'
  create or replace view v_pm_perf_gov_eval as
  select t.*
   from pm_perf_gov_eval t
  where t.fiscal_year = global_multyear_cz.v_pmyear
  and t.mof_div_code = global_multyear_cz.v_pmdivid and t.is_deleted=2';   
          
