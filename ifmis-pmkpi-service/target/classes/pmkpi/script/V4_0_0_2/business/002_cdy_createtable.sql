
  i integer;
begin
  select count(*) into i from user_tables  t where t.TABLE_NAME='BAS_PERF_INDICATOR';
  if i=0 then
     execute immediate '
create table BAS_PERF_INDICATOR
(
  guid          VARCHAR2(40) not null,
  keyword       VARCHAR2(200),
  explain       VARCHAR2(500),
  inspection    VARCHAR2(500),
  calculateby   VARCHAR2(32),
  computesign   VARCHAR2(32),
  targetvalue   VARCHAR2(200),
  targetunit    VARCHAR2(32),
  targetremark  VARCHAR2(4000),
  calctype      VARCHAR2(32),
  calcformula   VARCHAR2(500),
  calcdisplay   VARCHAR2(500),
  calcexplain   VARCHAR2(4000),
  scoretype     VARCHAR2(32),
  scoredisplay  VARCHAR2(500),
  scoreformula  VARCHAR2(500),
  scoreexplain  VARCHAR2(4000),
  creater       VARCHAR2(32) not null,
  createtime    VARCHAR2(17) not null,
  updatetime    VARCHAR2(17),
  status        NUMBER(1),
  year          NUMBER(4) not null,
  province      VARCHAR2(40) not null,
  economic      VARCHAR2(4000),
  expfunc       VARCHAR2(4000),
  filed         VARCHAR2(4000),
  framesystem   VARCHAR2(4000),
  funduse       VARCHAR2(4000),
  hierarchy     VARCHAR2(4000),
  indexremark   VARCHAR2(1000),
  occupation    VARCHAR2(4000),
  ordernum      NUMBER(9),
  meterunit     VARCHAR2(100),
  weight        NUMBER(5,2),
  ind_id        VARCHAR2(38) not null,
  perf_ind_code VARCHAR2(30) not null,
  perf_ind_name VARCHAR2(30) not null,
  is_common_ind VARCHAR2(1) default 1 not null,
  value_desc    VARCHAR2(2000) not null,
  agency_code   VARCHAR2(21),
  kpi_val       VARCHAR2(60) not null,
  mof_div_code  VARCHAR2(9) not null,
  fiscal_year   VARCHAR2(4) not null,
  start_date    VARCHAR2(17) not null,
  end_date      VARCHAR2(17) not null,
  parent_id     VARCHAR2(38),
  level_no      NUMBER(2) default 3 not null,
  is_leaf       NUMBER(1) default 1 not null,
  is_enabled    NUMBER(1) default 1 not null,
  update_time   VARCHAR2(17) not null,
  is_deleted    NUMBER(1) default 2 not null,
  create_time   VARCHAR2(17) not null,
  findex        VARCHAR2(40),
  sindex        VARCHAR2(40),
  agencyguid    VARCHAR2(40),
  indexvalue    VARCHAR2(60),
  code          VARCHAR2(30),
  name          VARCHAR2(30)
)
partition by list (PROVINCE)
subpartition by list (YEAR)
(
  partition P87 values (''87'')
    pctfree 10
    initrans 1
    maxtrans 255
  (
    subpartition P87_Y2016 values (''2016'')
  )
)';
-- Add comments to the columns 
execute immediate 'comment on column BAS_PERF_INDICATOR.ind_id
  is ''绩效指标主键''';
execute immediate 'comment on column BAS_PERF_INDICATOR.perf_ind_code
  is ''绩效指标代码''';
execute immediate 'comment on column BAS_PERF_INDICATOR.perf_ind_name
  is ''绩效指标名称''';
execute immediate 'comment on column BAS_PERF_INDICATOR.is_common_ind
  is ''是否共性指标 1是2否''';
execute immediate 'comment on column BAS_PERF_INDICATOR.value_desc
  is ''指标值说明''';
execute immediate 'comment on column BAS_PERF_INDICATOR.agency_code
  is ''单位代码''';
execute immediate 'comment on column BAS_PERF_INDICATOR.kpi_val
  is ''指标值''';
execute immediate 'comment on column BAS_PERF_INDICATOR.mof_div_code
  is ''财政区划代''';
execute immediate 'comment on column BAS_PERF_INDICATOR.fiscal_year
  is ''预算年度''';
execute immediate 'comment on column BAS_PERF_INDICATOR.start_date
  is ''启用日期''';
execute immediate 'comment on column BAS_PERF_INDICATOR.end_date
  is ''停用日期''';
execute immediate 'comment on column BAS_PERF_INDICATOR.parent_id
  is ''父级节点ID''';
execute immediate 'comment on column BAS_PERF_INDICATOR.level_no
  is ''级次''';
execute immediate 'comment on column BAS_PERF_INDICATOR.is_leaf
  is ''是否末级''';
execute immediate 'comment on column BAS_PERF_INDICATOR.is_enabled
  is ''是否启用''';
execute immediate 'comment on column BAS_PERF_INDICATOR.update_time
  is ''更新时间''';
execute immediate 'comment on column BAS_PERF_INDICATOR.is_deleted
  is ''是否删除 1是2否''';
execute immediate 'comment on column BAS_PERF_INDICATOR.create_time
  is ''创建时间''';
-- Create/Recreate primary, unique and foreign key constraints 
execute immediate 'alter table BAS_PERF_INDICATOR
  add constraint PK_BAS_PERF_INDICATOR primary key (GUID, YEAR, PROVINCE)
  using index ';
   end if;


  select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_T_DEPTINDICATOR';
  if i=0 then
     execute immediate '
create table PERF_T_DEPTINDICATOR
(
  guid          VARCHAR2(40) not null,
  keyword       VARCHAR2(200),
  explain       VARCHAR2(500),
  inspection    VARCHAR2(500),
  calculateby   VARCHAR2(32),
  computesign   VARCHAR2(32),
  targetvalue   VARCHAR2(200),
  targetunit    VARCHAR2(32),
  targetremark  VARCHAR2(4000),
  calctype      VARCHAR2(32),
  calcformula   VARCHAR2(500),
  calcdisplay   VARCHAR2(500),
  calcexplain   VARCHAR2(4000),
  scoretype     VARCHAR2(32),
  scoredisplay  VARCHAR2(500),
  scoreformula  VARCHAR2(500),
  scoreexplain  VARCHAR2(4000),
  creater       VARCHAR2(32) not null,
  createtime    VARCHAR2(17) not null,
  updatetime    VARCHAR2(17),
  status        NUMBER(1),
  year          NUMBER(4) not null,
  province      VARCHAR2(40) not null,
  economic      VARCHAR2(4000),
  expfunc       VARCHAR2(4000),
  filed         VARCHAR2(4000),
  framesystem   VARCHAR2(4000),
  funduse       VARCHAR2(4000),
  hierarchy     VARCHAR2(4000),
  indexremark   VARCHAR2(1000),
  occupation    VARCHAR2(4000),
  ordernum      NUMBER(9),
  meterunit     VARCHAR2(100),
  indexvalue    VARCHAR2(60),
  weight        NUMBER(5,2),
  findex        VARCHAR2(40),
  sindex        VARCHAR2(40),
  ind_id        VARCHAR2(38) not null,
  perf_ind_code VARCHAR2(30) not null,
  perf_ind_name VARCHAR2(30) not null,
  is_common_ind VARCHAR2(1) default 2 not null,
  value_desc    VARCHAR2(2000) not null,
  kpi_val       VARCHAR2(60),
  agency_code   VARCHAR2(21),
  mof_div_code  VARCHAR2(9) not null,
  fiscal_year   VARCHAR2(4) not null,
  start_date    VARCHAR2(17) not null,
  end_date      VARCHAR2(17) not null,
  parent_id     VARCHAR2(38),
  level_no      NUMBER(2) default 3 not null,
  is_leaf       NUMBER(1) default 1 not null,
  is_enabled    NUMBER(1) default 1 not null,
  update_time   VARCHAR2(17) not null,
  is_deleted    NUMBER(1) default 2 not null,
  create_time   VARCHAR2(17) not null,
  code          VARCHAR2(30),
  name          VARCHAR2(30),
  agencyguid    VARCHAR2(40)
)
partition by list (PROVINCE)
subpartition by list (YEAR)
(
  partition P87 values (''87'')
    pctfree 10
    initrans 1
    maxtrans 255
  (
    subpartition P87_Y2016 values (''2016'')
  )
)';
-- Add comments to the columns 
execute immediate 'comment on column PERF_T_DEPTINDICATOR.ind_id
  is ''绩效指标主键''';
execute immediate 'comment on column PERF_T_DEPTINDICATOR.perf_ind_code
  is ''绩效指标代码''';
execute immediate 'comment on column PERF_T_DEPTINDICATOR.perf_ind_name
  is ''绩效指标名称''';
execute immediate 'comment on column PERF_T_DEPTINDICATOR.is_common_ind
  is ''是否共性指标 1是2否''';
execute immediate 'comment on column PERF_T_DEPTINDICATOR.value_desc
  is ''指标值说明''';
execute immediate 'comment on column PERF_T_DEPTINDICATOR.kpi_val
  is ''指标值''';
execute immediate 'comment on column PERF_T_DEPTINDICATOR.agency_code
  is ''单位代码''';
execute immediate 'comment on column PERF_T_DEPTINDICATOR.mof_div_code
  is ''财政区划代''';
execute immediate 'comment on column PERF_T_DEPTINDICATOR.fiscal_year
  is ''预算年度''';
execute immediate 'comment on column PERF_T_DEPTINDICATOR.start_date
  is ''启用日期''';
execute immediate 'comment on column PERF_T_DEPTINDICATOR.end_date
  is ''停用日期''';
execute immediate 'comment on column PERF_T_DEPTINDICATOR.parent_id
  is ''父级节点ID''';
execute immediate 'comment on column PERF_T_DEPTINDICATOR.level_no
  is ''级次''';
execute immediate 'comment on column PERF_T_DEPTINDICATOR.is_leaf
  is ''是否末级''';
execute immediate 'comment on column PERF_T_DEPTINDICATOR.is_enabled
  is ''是否启用''';
execute immediate 'comment on column PERF_T_DEPTINDICATOR.update_time
  is ''更新时间''';
execute immediate 'comment on column PERF_T_DEPTINDICATOR.is_deleted
  is ''是否删除 1是2否''';
execute immediate 'comment on column PERF_T_DEPTINDICATOR.create_time
  is ''创建时间''';
-- Create/Recreate primary, unique and foreign key constraints 
execute immediate 'alter table PERF_T_DEPTINDICATOR
  add constraint PK_PERF_T_DEPTINDICATOR primary key (GUID, YEAR, PROVINCE)
  using index ';
  end if;


  select count(*) into i from user_tables  t where t.TABLE_NAME='PM_PERF_GOAL_INFO';
  if i=0 then
     execute immediate '
create table PM_PERF_GOAL_INFO
(
  guid         VARCHAR2(40) not null,
  agencyguid   VARCHAR2(40),
  zqgoal       VARCHAR2(4000),
  ndgoal       VARCHAR2(4000),
  mainguid     VARCHAR2(40),
  createtime   VARCHAR2(17) not null,
  updatetime   VARCHAR2(17),
  creater      VARCHAR2(40) not null,
  province     VARCHAR2(40) not null,
  year         NUMBER(4) not null,
  kpi_per_id   VARCHAR2(38) not null,
  mof_div_code VARCHAR2(9) not null,
  fiscal_year  VARCHAR2(4) not null,
  pro_code     VARCHAR2(21) not null,
  kpi_target   VARCHAR2(2000) not null,
  busi_type    VARCHAR2(6) not null,
  version      VARCHAR2(38) default 1 not null,
  version_name VARCHAR2(400) default 1 not null,
  sub_mof_code VARCHAR2(9) not null,
  update_time  VARCHAR2(17) not null,
  is_deleted   NUMBER(1) default 2 not null,
  create_time  VARCHAR2(17) not null,
  agency_code  VARCHAR2(38)
)
partition by list (PROVINCE)
subpartition by list (YEAR)
(
  partition P87 values (''87'')
    pctfree 10
    initrans 1
    maxtrans 255
  (
    subpartition P87_Y2016 values (''2016'')
  )
)';
-- Add comments to the columns 
execute immediate 'comment on column PM_PERF_GOAL_INFO.kpi_per_id
  is ''项目绩效目标主键''';
execute immediate 'comment on column PM_PERF_GOAL_INFO.mof_div_code
  is ''财政区划代码''';
execute immediate 'comment on column PM_PERF_GOAL_INFO.fiscal_year
  is ''预算年度''';
execute immediate 'comment on column PM_PERF_GOAL_INFO.pro_code
  is ''项目代码''';
execute immediate 'comment on column PM_PERF_GOAL_INFO.kpi_target
  is ''绩效目标''';
execute immediate 'comment on column PM_PERF_GOAL_INFO.busi_type
  is ''业务类型代码''';
execute immediate 'comment on column PM_PERF_GOAL_INFO.version
  is ''版本号''';
execute immediate 'comment on column PM_PERF_GOAL_INFO.version_name
  is ''版本说明''';
execute immediate 'comment on column PM_PERF_GOAL_INFO.sub_mof_code
  is ''下级财政区划代码''';
execute immediate 'comment on column PM_PERF_GOAL_INFO.update_time
  is ''更新时间''';
execute immediate 'comment on column PM_PERF_GOAL_INFO.is_deleted
  is ''是否删除1是2否''';
execute immediate 'comment on column PM_PERF_GOAL_INFO.create_time
  is ''创建时间''';
-- Create/Recreate primary, unique and foreign key constraints 
execute immediate 'alter table PM_PERF_GOAL_INFO
  add constraint PK_PM_PERF_GOAL_INFO primary key (GUID, YEAR, PROVINCE)
  using index ';
    end if;

  select count(*) into i from user_tables  t where t.TABLE_NAME='PM_PERF_INDICATOR';
  if i=0 then
     execute immediate '
create table PM_PERF_INDICATOR
(
  guid          VARCHAR2(40) not null,
  code          VARCHAR2(200),
  explain       VARCHAR2(200),
  weight        NUMBER(5,2),
  islinked      NUMBER(1),
  agencyguid    VARCHAR2(40),
  wfstatus      VARCHAR2(40),
  status        NUMBER(1),
  createtime    VARCHAR2(17) not null,
  updatetime    VARCHAR2(17),
  creater       VARCHAR2(40) not null,
  province      VARCHAR2(32) not null,
  year          NUMBER(4) not null,
  ordernum      NUMBER(9),
  finintorgguid VARCHAR2(40),
  mainguid      VARCHAR2(40),
  superid       VARCHAR2(40),
  levelno       NUMBER(2),
  rule          VARCHAR2(200),
  computesign   VARCHAR2(40),
  meterunit     VARCHAR2(200),
  tindex        VARCHAR2(40),
  wfid          VARCHAR2(40),
  proguid       VARCHAR2(40),
  targetvalue   VARCHAR2(40),
  kpi_id        VARCHAR2(38) not null,
  mof_div_code  VARCHAR2(9) not null,
  fiscal_year   VARCHAR2(4) not null,
  pro_code      VARCHAR2(21) not null,
  kpi_lv1       VARCHAR2(30) not null,
  kpi_lv2       VARCHAR2(30) not null,
  kpi_lv3       VARCHAR2(30) not null,
  kpi_content   VARCHAR2(2000) not null,
  kpi_evalstd   VARCHAR2(2000) not null,
  kpi_val       VARCHAR2(60) not null,
  kpi_remark    VARCHAR2(2000),
  busi_type     VARCHAR2(6) not null,
  version       VARCHAR2(38) default 1 not null,
  version_name  VARCHAR2(400) default 1 not null,
  sub_mof_code  VARCHAR2(9) not null,
  update_time   VARCHAR2(17) not null,
  is_deleted    NUMBER(1) default 2 not null,
  create_time   VARCHAR2(17) not null,
  agency_code   VARCHAR2(38),
  findex        VARCHAR2(30),
  sindex        VARCHAR2(30),
  name          VARCHAR2(30),
  indexval      VARCHAR2(60)
)
partition by list (PROVINCE)
subpartition by list (YEAR)
(
  partition P87 values (''87'')
    pctfree 10
    initrans 1
    maxtrans 255
  (
    subpartition P87_Y2016 values (''2016'')
  )
)';
-- Add comments to the columns 
execute immediate 'comment on column PM_PERF_INDICATOR.kpi_id
  is ''项目绩效指标主键''';
execute immediate 'comment on column PM_PERF_INDICATOR.mof_div_code
  is ''财政区划代码''';
execute immediate 'comment on column PM_PERF_INDICATOR.fiscal_year
  is ''预算年度''';
execute immediate 'comment on column PM_PERF_INDICATOR.pro_code
  is ''项目代码''';
execute immediate 'comment on column PM_PERF_INDICATOR.kpi_lv1
  is ''一级指标''';
execute immediate 'comment on column PM_PERF_INDICATOR.kpi_lv2
  is ''二级指标''';
execute immediate 'comment on column PM_PERF_INDICATOR.kpi_lv3
  is ''三级指标''';
execute immediate 'comment on column PM_PERF_INDICATOR.kpi_content
  is ''指标内容''';
execute immediate 'comment on column PM_PERF_INDICATOR.kpi_evalstd
  is ''评（扣）分标准''';
execute immediate 'comment on column PM_PERF_INDICATOR.kpi_val
  is ''指标值''';
execute immediate 'comment on column PM_PERF_INDICATOR.kpi_remark
  is ''备注''';
execute immediate 'comment on column PM_PERF_INDICATOR.busi_type
  is ''业务类型代码''';
execute immediate 'comment on column PM_PERF_INDICATOR.version
  is ''版本号''';
execute immediate 'comment on column PM_PERF_INDICATOR.version_name
  is ''版本说明''';
execute immediate 'comment on column PM_PERF_INDICATOR.sub_mof_code
  is ''下级财政区划代码''';
execute immediate 'comment on column PM_PERF_INDICATOR.update_time
  is ''更新时间''';
execute immediate 'comment on column PM_PERF_INDICATOR.is_deleted
  is ''是否删除1是2否''';
execute immediate 'comment on column PM_PERF_INDICATOR.create_time
  is ''创建时间   ''';
-- Create/Recreate primary, unique and foreign key constraints 
execute immediate 'alter table PM_PERF_INDICATOR
  add constraint PK_PM_PERF_INDICATOR primary key (GUID, YEAR, PROVINCE)
  using index ';
  end if;


  select count(*) into i from user_tables  t where t.TABLE_NAME='BGT_PERF_GOAL_INFO';
  if i=0 then
     execute immediate '
create table BGT_PERF_GOAL_INFO
(
  guid         VARCHAR2(40) not null,
  agencyguid   VARCHAR2(40),
  zqgoal       VARCHAR2(4000),
  ndgoal       VARCHAR2(4000),
  mainguid     VARCHAR2(40),
  createtime   VARCHAR2(17) not null,
  updatetime   VARCHAR2(17),
  creater      VARCHAR2(40) not null,
  province     VARCHAR2(40) not null,
  year         NUMBER(4) not null,
  kpi_dep_id   VARCHAR2(38) not null,
  mof_div_code VARCHAR2(9) not null,
  fiscal_year  VARCHAR2(4) not null,
  dept_code    VARCHAR2(21) not null,
  kpi_target   VARCHAR2(2000) not null,
  update_time  VARCHAR2(17) not null,
  is_deleted   NUMBER(1) default 2 not null,
  create_time  VARCHAR2(17) not null
)
partition by list (PROVINCE)
subpartition by list (YEAR)
(
  partition P87 values (''87'')
    pctfree 10
    initrans 1
    maxtrans 255
  (
    subpartition P87_Y2016 values (''2016'')
  )
)';
-- Add comments to the columns 
execute immediate 'comment on column BGT_PERF_GOAL_INFO.kpi_dep_id
  is ''部门绩效目标主键''';
execute immediate 'comment on column BGT_PERF_GOAL_INFO.mof_div_code
  is ''财政区划代码''';
execute immediate 'comment on column BGT_PERF_GOAL_INFO.fiscal_year
  is ''预算年度''';
execute immediate 'comment on column BGT_PERF_GOAL_INFO.dept_code
  is ''部门代码''';
execute immediate 'comment on column BGT_PERF_GOAL_INFO.kpi_target
  is ''绩效目标''';
execute immediate 'comment on column BGT_PERF_GOAL_INFO.update_time
  is ''更新时间''';
execute immediate 'comment on column BGT_PERF_GOAL_INFO.is_deleted
  is ''是否删除''';
execute immediate 'comment on column BGT_PERF_GOAL_INFO.create_time
  is ''创建时间''';
-- Create/Recreate primary, unique and foreign key constraints 
execute immediate 'alter table BGT_PERF_GOAL_INFO
  add constraint PK_BGT_PERF_GOAL_INFO primary key (GUID, YEAR, PROVINCE)
  using index ';
  end if;

  select count(*) into i from user_tables  t where t.TABLE_NAME='BGT_PERF_INDICATOR';
  if i=0 then
     execute immediate '
create table BGT_PERF_INDICATOR
(
  guid          VARCHAR2(40) not null,
  explain       VARCHAR2(200),
  weight        NUMBER(5,2),
  islinked      NUMBER(1),
  agencyguid    VARCHAR2(40),
  wfstatus      VARCHAR2(40),
  status        NUMBER(1),
  createtime    VARCHAR2(17) not null,
  updatetime    VARCHAR2(17),
  creater       VARCHAR2(40) not null,
  province      VARCHAR2(32) not null,
  year          NUMBER(4) not null,
  ordernum      NUMBER(9),
  finintorgguid VARCHAR2(40),
  wfid          VARCHAR2(40),
  mainguid      VARCHAR2(40),
  superid       VARCHAR2(40),
  levelno       NUMBER(2),
  rule          VARCHAR2(200),
  computesign   VARCHAR2(40),
  meterunit     VARCHAR2(200),
  tindex        VARCHAR2(40),
  kpi_id        VARCHAR2(38) not null,
  mof_div_code  VARCHAR2(9) not null,
  fiscal_year   VARCHAR2(4) not null,
  dept_code     VARCHAR2(21) not null,
  kpi_lv1       VARCHAR2(30) not null,
  kpi_lv2       VARCHAR2(30) not null,
  kpi_lv3       VARCHAR2(30) not null,
  kpi_content   VARCHAR2(2000) not null,
  kpi_evalstd   VARCHAR2(2000) not null,
  kpi_val       VARCHAR2(60) not null,
  kpi_remark    VARCHAR2(2000),
  update_time   VARCHAR2(17) not null,
  is_deleted    NUMBER(1) default 2 not null,
  create_time   VARCHAR2(17) not null,
  name          VARCHAR2(30),
  code          VARCHAR2(30),
  findex        VARCHAR2(30),
  sindex        VARCHAR2(30),
  indexval      VARCHAR2(60)
)
partition by list (PROVINCE)
subpartition by list (YEAR)
(
  partition P87 values (''87'')
    pctfree 10
    initrans 1
    maxtrans 255
  (
    subpartition P87_Y2016 values (''2016'')
  )
)';
-- Add comments to the columns 
execute immediate 'comment on column BGT_PERF_INDICATOR.kpi_id
  is ''项目绩效指标主键''';
execute immediate 'comment on column BGT_PERF_INDICATOR.mof_div_code
  is ''财政区划代码''';
execute immediate 'comment on column BGT_PERF_INDICATOR.fiscal_year
  is ''预算年度''';
execute immediate 'comment on column BGT_PERF_INDICATOR.dept_code
  is ''部门代码''';
execute immediate 'comment on column BGT_PERF_INDICATOR.kpi_lv1
  is ''一级指标''';
execute immediate 'comment on column BGT_PERF_INDICATOR.kpi_lv2
  is ''二级指标''';
execute immediate 'comment on column BGT_PERF_INDICATOR.kpi_lv3
  is ''三级指标''';
execute immediate 'comment on column BGT_PERF_INDICATOR.kpi_content
  is ''指标内容''';
execute immediate 'comment on column BGT_PERF_INDICATOR.kpi_evalstd
  is ''评（扣）分标准''';
execute immediate 'comment on column BGT_PERF_INDICATOR.kpi_val
  is ''指标值''';
execute immediate 'comment on column BGT_PERF_INDICATOR.kpi_remark
  is ''备注''';
execute immediate 'comment on column BGT_PERF_INDICATOR.update_time
  is ''更新时间''';
execute immediate 'comment on column BGT_PERF_INDICATOR.is_deleted
  is ''是否删除1是2否''';
execute immediate 'comment on column BGT_PERF_INDICATOR.create_time
  is ''创建时间 ''';
-- Create/Recreate primary, unique and foreign key constraints 
execute immediate 'alter table BGT_PERF_INDICATOR
  add constraint PK_BGT_PERF_INDICATOR primary key (GUID, YEAR, PROVINCE)
  using index ';
  end if;


  select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_T_FRAME';
  if i=0 then
     execute immediate '
create table PERF_T_FRAME
(
  ele_id         VARCHAR2(38) default SYS_GUID(),
  ele_code       VARCHAR2(20),
  ele_name       VARCHAR2(100),
  ele_catalog_id VARCHAR2(38),
  mof_div_code   VARCHAR2(9) default 87,
  parent_id      VARCHAR2(38),
  level_no       NUMBER(2) default 1,
  is_leaf        NUMBER(1) default 1,
  ordernum       NUMBER(9),
  weight         NUMBER(18,2),
  adjust         VARCHAR2(1000),
  frametype      VARCHAR2(40),
  remark         VARCHAR2(2000),
  start_date     VARCHAR2(17) default TO_CHAR(SYSDATE,''YYYYMMDD''),
  end_date       VARCHAR2(17) default TO_CHAR(TO_DATE(''29991231'',''YYYYMMDD'')),
  is_enabled     NUMBER(1) default 1,
  update_time    VARCHAR2(17) default TO_CHAR(SYSDATE,''YYYYMMDD''),
  is_deleted     NUMBER(1) default 2,
  create_time    VARCHAR2(17) default TO_CHAR(SYSDATE,''YYYYMMDD''),
  fiscal_year    VARCHAR2(4)
)
partition by list (MOF_DIV_CODE)
subpartition by list (FISCAL_YEAR)
(
  partition P87 values (''87'')
    pctfree 10
    initrans 1
    maxtrans 255
  (
    subpartition P87_Y2016 values (''2016'')
  )
)';
-- Add comments to the table 
execute immediate 'comment on table PERF_T_FRAME
  is ''绩效指标层次分类''';
-- Add comments to the columns 
execute immediate 'comment on column PERF_T_FRAME.ele_id
  is ''绩效主键''';
execute immediate 'comment on column PERF_T_FRAME.ele_code
  is ''绩效代码''';
execute immediate 'comment on column PERF_T_FRAME.ele_name
  is ''绩效名称''';
execute immediate 'comment on column PERF_T_FRAME.mof_div_code
  is ''财政区划代码''';
execute immediate 'comment on column PERF_T_FRAME.parent_id
  is ''父级节点主键''';
execute immediate 'comment on column PERF_T_FRAME.level_no
  is ''级次''';
execute immediate 'comment on column PERF_T_FRAME.is_leaf
  is ''是否末级''';
execute immediate 'comment on column PERF_T_FRAME.start_date
  is ''启用日期''';
execute immediate 'comment on column PERF_T_FRAME.end_date
  is ''停用日期''';
execute immediate 'comment on column PERF_T_FRAME.is_enabled
  is ''是否启用''';
execute immediate 'comment on column PERF_T_FRAME.update_time
  is ''更新时间''';
execute immediate 'comment on column PERF_T_FRAME.is_deleted
  is ''是否删除''';
execute immediate 'comment on column PERF_T_FRAME.create_time
  is ''创建时间''';
-- Create/Recreate indexes 
execute immediate 'alter table PERF_T_FRAME
  add constraint PK_PERF_T_FRAME primary key (ele_id, mof_div_code, fiscal_year)
  using index ';

  end if;


  select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_T_FRAMESYSTEM';
  if i=0 then
     execute immediate '
create table PERF_T_FRAMESYSTEM
(
  ele_id       VARCHAR2(38) default SYS_GUID(),
  ele_code     VARCHAR2(20),
  ele_name     VARCHAR2(100),
  mof_div_code VARCHAR2(9) default 87,
  parent_id    VARCHAR2(38) default 00,
  level_no     NUMBER(2) default 1,
  is_leaf      NUMBER(1) default 1,
  ordernum     NUMBER(9),
  remark       VARCHAR2(2000),
  start_date   VARCHAR2(17) default TO_CHAR(SYSDATE,''YYYYMMDD''),
  end_date     VARCHAR2(17) default TO_CHAR(TO_DATE(''29991231'',''YYYYMMDD'')),
  is_enabled   NUMBER(1) default 1,
  update_time  VARCHAR2(17) default TO_CHAR(SYSDATE,''YYYYMMDD''),
  is_deleted   NUMBER(1) default 2,
  create_time  VARCHAR2(17) default TO_CHAR(SYSDATE,''YYYYMMDD''),
  fiscal_year  VARCHAR2(4)
)
partition by list (MOF_DIV_CODE)
subpartition by list (FISCAL_YEAR)
(
  partition P87 values (''87'')
    pctfree 10
    initrans 1
    maxtrans 255
  (
    subpartition P87_Y2016 values (''2016'')
  )
)';
execute immediate 'alter table PERF_T_FRAMESYSTEM
  add constraint PK_PERF_T_FRAMESYSTEM primary key (ele_id, mof_div_code, fiscal_year)
  using index ';
  
    end if;
	
  select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_T_DATASOURCE';
  if i=0 then
     execute immediate '
create table PERF_T_DATASOURCE
(
  guid        VARCHAR2(32) not null,
  code        VARCHAR2(20) not null,
  name        VARCHAR2(200) not null,
  remark      VARCHAR2(200),
  superguid   VARCHAR2(32),
  levelno     NUMBER(1),
  isleaf      NUMBER(2),
  ordernum    NUMBER(9),
  elementcode VARCHAR2(30) not null,
  status      NUMBER(1) default 1,
  createtime  VARCHAR2(17) default TO_CHAR(SYSDATE,''YYYYMMDD''),
  updatetime  VARCHAR2(17) default TO_CHAR(SYSDATE,''YYYYMMDD''),
  year        NUMBER(4) default TO_CHAR(SYSDATE,''YYYY''),
  province    VARCHAR2(32) default ''87''
)';
-- Create/Recreate primary, unique and foreign key constraints 
execute immediate 'alter table PERF_T_DATASOURCE
  add constraint PK_PERF_DATASOURCE primary key (GUID, ELEMENTCODE)
  using index ';
   end if;

execute immediate '
create or replace view v_bas_perf_indicator as
select *
from bas_perf_indicator t where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
  and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';
  
execute immediate '
create or replace view v_perf_t_deptindicator as
select *
 from PERF_T_DEPTINDICATOR t where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
  and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';

execute immediate '
create or replace view v_pm_perf_goal_info as
select *
from pm_perf_goal_info t where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
  and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';

execute immediate '
create or replace view v_pm_perf_indicator as
select *
from pm_perf_indicator t where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
  and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';

execute immediate '
create or replace view v_bgt_perf_goal_info as
select *
from bgt_perf_goal_info t where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
  and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';

execute immediate '
create or replace view v_bgt_perf_indicator as
select *
from bgt_perf_indicator t where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
  and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';

execute immediate '
create or replace view v_perf_t_frame as
select
        t.ele_code as guid,
        t.ele_code as code,
        t.ele_name as name,
        t.parent_id as superid,
        t.level_no as levelno,
        t.is_leaf as isleaf,
       t.mof_div_code,
       t.ordernum,
       t.remark,
       t.start_date,
       t.end_date,
       t.is_enabled,
       t.update_time,
       t.is_deleted,
       t.create_time,
       t.fiscal_year,
       t.frametype
 from perf_t_frame t where fiscal_year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
  and mof_div_code = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';

execute immediate '
create or replace view v_perf_t_framesystem as
select
        t.ele_code as guid,
        t.ele_code as code,
        t.ele_name as name,
        t.parent_id as superid,
        t.level_no as levelno,
        t.is_leaf as isleaf,
       t.mof_div_code,
       t.ordernum,
       t.remark,
       t.start_date,
       t.end_date,
       t.is_enabled,
       t.update_time,
       t.is_deleted,
       t.create_time,
       t.fiscal_year
 from perf_t_framesystem t where fiscal_year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
  and mof_div_code = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';


execute immediate '
create or replace view perf_v_allindex as
select t.guid,
       t.keyword,
       t.explain,
       t.inspection,
       t.calculateby,
       t.computesign,
       t.targetvalue,
       t.targetunit,
       t.targetremark,
       t.calctype,
       t.calcformula,
       t.calcdisplay,
       t.calcexplain,
       t.scoretype,
       t.scoredisplay,
       t.scoreformula,
       t.scoreexplain,
       t.creater,
       t.createtime,
       t.updatetime,
       t.status,
       t.year,
       t.province,
       t.economic,
       t.expfunc,
       t.filed,
       t.framesystem,
       t.funduse,
       t.hierarchy,
       t.indexremark,
       t.occupation,
       t.ordernum,
       t.meterunit,
       t.weight,
       t.ind_id,
       t.perf_ind_code,
       t.perf_ind_name,
       t.is_common_ind,
       t.value_desc,
       t.agency_code,
       t.kpi_val,
       t.mof_div_code,
       t.fiscal_year,
       t.start_date,
       t.end_date,
       t.parent_id,
       t.level_no,
       t.is_leaf,
       t.is_enabled,
       t.update_time,
       t.is_deleted,
       t.create_time,
       t.findex,
       t.sindex,
       ''#'' agencyguid,
       t.indexvalue,
       t.code,
       t.name,
       ''2'' type,
       '''' ZHBIAO,
       '''' anli,
       '''' tindex
  from v_bas_perf_indicator t
union all
select d.guid,
       d.keyword,
       d.explain,
       d.inspection,
       d.calculateby,
       d.computesign,
       d.targetvalue,
       d.targetunit,
       d.targetremark,
       d.calctype,
       d.calcformula,
       d.calcdisplay,
       d.calcexplain,
       d.scoretype,
       d.scoredisplay,
       d.scoreformula,
       d.scoreexplain,
       d.creater,
       d.createtime,
       d.updatetime,
       d.status,
       d.year,
       d.province,
       d.economic,
       d.expfunc,
       d.filed,
       d.framesystem,
       d.funduse,
       d.hierarchy,
       d.indexremark,
       d.occupation,
       d.ordernum,
       d.meterunit,
       d.weight,
       d.ind_id,
       d.perf_ind_code,
       d.perf_ind_name,
       d.is_common_ind,
       d.value_desc,
       d.agency_code,
       d.kpi_val,
       d.mof_div_code,
       d.fiscal_year,
       d.start_date,
       d.end_date,
       d.parent_id,
       d.level_no,
       d.is_leaf,
       d.is_enabled,
       d.update_time,
       d.is_deleted,
       d.create_time,
       d.findex,
       d.sindex,
       d.agencyguid,
       d.indexvalue,
       d.code,
       d.name,
       ''1'' type,
       '''' ZHBIAO,
       '''' anli,
       '''' tindex
  from v_perf_t_deptindicator d';

