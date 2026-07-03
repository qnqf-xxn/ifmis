
  i integer;
begin
  select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_T_FINEVALUATION';
  if i=0 then
execute immediate '
create table PERF_T_FINEVALUATION
(
  guid              VARCHAR2(40) not null,
  code              VARCHAR2(40),
  name              VARCHAR2(500),
  pro_start_year    VARCHAR2(40),
  endtime           VARCHAR2(40),
  evalmeach         VARCHAR2(40),
  leader_name       VARCHAR2(50),
  projectcon        VARCHAR2(500),
  leader_phone      VARCHAR2(500),
  projamt           NUMBER(20,2),
  pro_total_amt     NUMBER(20,2),
  bustype           VARCHAR2(32),
  year              VARCHAR2(40) not null,
  province          VARCHAR2(40) not null,
  proguid           VARCHAR2(40),
  agencyguid        VARCHAR2(40),
  finintorgguid     VARCHAR2(40),
  createtime        VARCHAR2(40),
  creater           VARCHAR2(40),
  lastupdatetime    VARCHAR2(40),
  wfstatus          VARCHAR2(40),
  wfid              VARCHAR2(40),
  status            NUMBER(1) default 1,
  isobject          NUMBER(1) default 2,
  isentrust         NUMBER(1) default 2,
  isrelease         NUMBER(1) default 2,
  isresult          NUMBER(1) default 2,
  auditor           VARCHAR2(40),
  budgetgoalcreator VARCHAR2(20),
  existquestion     VARCHAR2(4000),
  feedback          VARCHAR2(4000),
  isnotice          NUMBER(1) default 2,
  opinion           VARCHAR2(4000),
  category          VARCHAR2(40)
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

execute immediate 'comment on column PERF_T_FINEVALUATION.guid
  is ''主键''';
execute immediate 'comment on column PERF_T_FINEVALUATION.code
  is ''项目编码''';
execute immediate 'comment on column PERF_T_FINEVALUATION.name
  is ''项目名称''';
execute immediate 'comment on column PERF_T_FINEVALUATION.pro_start_year
  is ''开始日期''';
execute immediate 'comment on column PERF_T_FINEVALUATION.endtime
  is ''截止日期''';
execute immediate 'comment on column PERF_T_FINEVALUATION.evalmeach
  is ''组织评价机构''';
execute immediate 'comment on column PERF_T_FINEVALUATION.leader_name
  is ''项目负责人''';
execute immediate 'comment on column PERF_T_FINEVALUATION.projectcon
  is ''项目联系人''';
execute immediate 'comment on column PERF_T_FINEVALUATION.leader_phone
  is ''联系人电话''';
execute immediate 'comment on column PERF_T_FINEVALUATION.projamt
  is ''当年预算金额''';
execute immediate 'comment on column PERF_T_FINEVALUATION.pro_total_amt
  is ''项目总金额''';
execute immediate 'comment on column PERF_T_FINEVALUATION.bustype
  is ''绩效类型''';
execute immediate 'comment on column PERF_T_FINEVALUATION.year
  is ''年份''';
execute immediate 'comment on column PERF_T_FINEVALUATION.province
  is ''区划''';
execute immediate 'comment on column PERF_T_FINEVALUATION.agencyguid
  is ''单位guid''';
execute immediate 'comment on column PERF_T_FINEVALUATION.finintorgguid
  is ''处室guid''';
execute immediate 'comment on column PERF_T_FINEVALUATION.createtime
  is ''创建时间''';
execute immediate 'comment on column PERF_T_FINEVALUATION.creater
  is ''创建人''';
execute immediate 'comment on column PERF_T_FINEVALUATION.lastupdatetime
  is ''更新时间''';
execute immediate 'comment on column PERF_T_FINEVALUATION.wfstatus
  is ''流程状态''';
execute immediate 'comment on column PERF_T_FINEVALUATION.wfid
  is ''流程id''';
execute immediate 'comment on column PERF_T_FINEVALUATION.status
  is ''数据状态''';
execute immediate 'comment on column PERF_T_FINEVALUATION.isobject
  is ''是否确定''';
execute immediate 'comment on column PERF_T_FINEVALUATION.isentrust
  is ''是否委托''';
execute immediate 'comment on column PERF_T_FINEVALUATION.isrelease
  is ''是否下达''';
execute immediate 'comment on column PERF_T_FINEVALUATION.isresult
  is ''是否上传''';
execute immediate 'comment on column PERF_T_FINEVALUATION.budgetgoalcreator
  is ''填报人''';
execute immediate 'comment on column PERF_T_FINEVALUATION.isnotice
  is ''是否接收通知''';
execute immediate 'comment on column PERF_T_FINEVALUATION.opinion
  is ''反馈意见''';
execute immediate '
alter table PERF_T_FINEVALUATION
  add constraint PK_PERF_T_FINEVALUATION primary key (GUID, YEAR, PROVINCE)
  using index';

 end if;
 
select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_T_FINEVALCATEGORY';
  if i=0 then
execute immediate '
create table PERF_T_FINEVALCATEGORY
(
  guid       VARCHAR2(40) not null,
  code       VARCHAR2(20) not null,
  name       VARCHAR2(200) not null,
  remark     VARCHAR2(200),
  superguid  VARCHAR2(32),
  levelno    NUMBER(1),
  isleaf     NUMBER(2),
  ordernum   NUMBER(9),
  status     NUMBER(1) default 1,
  createtime VARCHAR2(17) default TO_CHAR(SYSDATE,''YYYYMMDD''),
  updatetime VARCHAR2(17) default TO_CHAR(SYSDATE,''YYYYMMDD''),
  year       NUMBER(4) default TO_CHAR(SYSDATE,''YYYY'') not null,
  province   VARCHAR2(32) default ''87'' not null
)partition by list (PROVINCE)
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

execute immediate '
alter table PERF_T_FINEVALCATEGORY
  add constraint PK_PERF_FINEVALCATEGORY primary key (GUID, YEAR, PROVINCE)
  using index ';
 end if;
 
execute immediate '
 CREATE OR REPLACE VIEW V_PERF_T_FINEVALUATION AS
SELECT *
FROM PERF_T_FINEVALUATION
 WHERE YEAR = GLOBAL_MULTYEAR_CZ.SECU_F_GLOBAL_PARM(''YEAR'')
   AND PROVINCE = GLOBAL_MULTYEAR_CZ.SECU_F_GLOBAL_PARM(''DIVID'')';

execute immediate '
create or replace view v_perf_t_finevalcategory as
select *
from perf_t_finevalcategory t where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
  and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';

