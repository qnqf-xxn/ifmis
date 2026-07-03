
  i integer;
begin
  --绩效目标调整主表
  select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_T_ADJUST';
  if i=0 then
     execute immediate '
create table PERF_T_ADJUST
(
  guid           VARCHAR2(40) not null,
  proguid        VARCHAR2(40),
  bgtamt         NUMBER(20,2),
  adjustnum      NUMBER(3),
  islast         NUMBER(1),
  adjstatus      VARCHAR2(50) default 0,
  adjustremark   VARCHAR2(4000),
  bustype        VARCHAR2(40),
  auditor        VARCHAR2(40),
  lastupdatetime VARCHAR2(20),
  agencyguid     VARCHAR2(40),
  finintorgguid  VARCHAR2(50),
  creater        VARCHAR2(32),
  createtime     VARCHAR2(20),
  updatetime     VARCHAR2(20),
  wfstatus       VARCHAR2(50),
  wfid           VARCHAR2(100),
  status         NUMBER(1),
  province       VARCHAR2(9) not null,
  year           CHAR(4) not null
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
-- Create/Recreate primary, unique and foreign key constraints 
execute immediate 'alter table PERF_T_ADJUST
  add constraint PK_PERF_ADJUST primary key (GUID, YEAR, PROVINCE)
  using index ';
end if;

--调整目标表
select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_T_ADJUSTGOAL';
  if i=0 then
     execute immediate '
create table PERF_T_ADJUSTGOAL
(
  guid         VARCHAR2(40) not null,
  agencyguid   VARCHAR2(40),
  zqgoal       VARCHAR2(4000),
  ndgoal       VARCHAR2(4000),
  adjustzqgoal VARCHAR2(4000),
  adjustndgoal VARCHAR2(4000),
  mainguid     VARCHAR2(40),
  createtime   VARCHAR2(17) not null,
  updatetime   VARCHAR2(17),
  creater      VARCHAR2(40) not null,
  province     VARCHAR2(40) not null,
  year         NUMBER(4) not null,
  kpi_per_id   VARCHAR2(38) not null,
  mof_div_code VARCHAR2(9) not null,
  fiscal_year  VARCHAR2(4) not null,
  pro_code     VARCHAR2(21),
  kpi_target   VARCHAR2(2000) not null,
  busi_type    VARCHAR2(6),
  version      VARCHAR2(38) default 1,
  version_name VARCHAR2(400) default 1,
  sub_mof_code VARCHAR2(9),
  update_time  VARCHAR2(17) not null,
  is_deleted   NUMBER(1) default 2 not null,
  create_time  VARCHAR2(17) not null,
  agency_code  VARCHAR2(38),
  proguid      VARCHAR2(40)
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
execute immediate 'alter table PERF_T_ADJUSTGOAL
  add constraint PK_PERF_ADJUSTGOAL primary key (GUID, PROVINCE, YEAR)
  using index ';
end if;

--调整指标表
select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_T_ADJUSTINDEX';
  if i=0 then
     execute immediate '
create table PERF_T_ADJUSTINDEX
(
  guid           VARCHAR2(40) not null,
  code           VARCHAR2(200),
  name           VARCHAR2(80),
  explain        VARCHAR2(200),
  weight         NUMBER(5,2),
  islinked       NUMBER(1),
  agencyguid     VARCHAR2(40),
  wfstatus       VARCHAR2(40),
  status         NUMBER(1),
  createtime     VARCHAR2(17) not null,
  updatetime     VARCHAR2(17),
  creater        VARCHAR2(40) not null,
  province       VARCHAR2(32) not null,
  year           NUMBER(4) not null,
  ordernum       NUMBER(9),
  finintorgguid  VARCHAR2(40),
  mainguid       VARCHAR2(40),
  superid        VARCHAR2(40),
  levelno        NUMBER(2),
  rule           VARCHAR2(200),
  computesign    VARCHAR2(40),
  meterunit      VARCHAR2(200),
  tindex         VARCHAR2(40),
  wfid           VARCHAR2(40),
  proguid        VARCHAR2(40),
  targetvalue    VARCHAR2(60),
  kpi_id         VARCHAR2(38) not null,
  mof_div_code   VARCHAR2(9) not null,
  fiscal_year    VARCHAR2(4) not null,
  pro_code       VARCHAR2(21),
  dept_code      VARCHAR2(21) not null,
  kpi_lv1        VARCHAR2(30) not null,
  kpi_lv2        VARCHAR2(30) not null,
  kpi_lv3        VARCHAR2(30) not null,
  kpi_content    VARCHAR2(2000),
  kpi_evalstd    VARCHAR2(2000),
  kpi_val        VARCHAR2(60) not null,
  kpi_remark     VARCHAR2(2000),
  busi_type      VARCHAR2(6),
  version        VARCHAR2(38),
  version_name   VARCHAR2(400),
  sub_mof_code   VARCHAR2(9),
  update_time    VARCHAR2(17) not null,
  is_deleted     NUMBER(1) default 2 not null,
  create_time    VARCHAR2(17) not null,
  agency_code    VARCHAR2(38),
  findex         VARCHAR2(30),
  sindex         VARCHAR2(30),
  indexval       VARCHAR2(60),
  yearflag       VARCHAR2(9),
  adjustindexval VARCHAR2(60),
  adjustremark   VARCHAR2(2000)
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
execute immediate 'alter table PERF_T_ADJUSTINDEX
  add constraint PK_PERF_ADJUSTINDEX primary key (GUID, PROVINCE, YEAR)
  using index';
end if;

execute immediate '
create or replace view v_perf_t_adjust as
select *
from perf_t_adjust where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';

execute immediate '
create or replace view v_perf_t_adjustgoal as
select *
from perf_t_adjustgoal t where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
  and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';

execute immediate '
create or replace view v_perf_t_adjustindex as
select *
from perf_t_adjustindex t where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
  and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';
  
execute immediate '
create or replace view v_perf_project_infoquery as
select t.PRO_ID proguid,
       t.PRO_CODE,
       t.PRO_NAME,
       t.PRO_CAT_CODE,
       t.AGENCY_CODE,
       t.MOF_DEP_CODE,
       t.MOF_DEP_CODE FININTORGGUID,
       t.DEPT_CODE,
       t.MANAGE_DEPT_CODE,
       t.MANAGE_MOF_DEP_CODE,
       t.TRAOBJ_AGENCY_CODE,
       t.CEN_TRA_PRO_CODE,
       t.PRO_SOURCE_CODE,
       t.SETUP_YEAR,
       t.PRO_START_YEAR,
       t.PRO_TERM,
       t.DISTRI_TYPE_CODE,
       t.DRAFT_TEMPLATE_CODE,
       t.PRO_DESC,
       t.EXP_FUNC_CODE,
       t.PRO_TOTAL_AMT,
       t.SCOI_INVEST_FUND,
       t.FUN_RES_CODE,
       t.IS_USESET,
       t.IS_TRACK,
       t.IS_END,
       t.IS_CAPTIAL_CONS_PRO,
       t.IS_SCIENTIFIC,
       t.PRO_DEPREVIEW,
       t.PRO_BGTREVIEW,
       t.DEP_AUD_OPINION_CODE,
       t.MOF_AUD_OPINION_CODE,
       t.CREATE_TIME,
       t.UPDATE_TIME,
       t.VERSION,
       t.VERSION_NAME,
       t.IS_DELETED,
       t.MOF_DIV_CODE,
       t.LASTAUDIT,
       t.STORE_PHASE,
       t.PRO_PHASE,
       t.PRO_LEVONE_ID,
       t.PRO_LEVONE_CODE,
       t.PRO_LEVONE_NAME,
       t.PRO_LEV,
       t.LEADER_NAME,
       t.LEADER_TEL,
       t.LEADER_PHONE,
       t.IS_PERFORM,
       t.IS_ATTACH,
       t.IS_GOVPUR,
       t.IS_BGT,
       t.IS_THIN,
       t.IS_OTHER_EDIT,
       t.IS_WAIT_DIVIDE,
       t.IS_DIVIDE_PRO,
       t.IS_TO_DOWN,
       t.MID_PLAN_YEAR,
       t.ORDERNO1,
       t.ORDERNO2,
       t.ORDERNO3,
       t.ORDERNO4,
       t.VCHTYPEID,
       t.V_COL1,
       t.V_COL2,
       t.V_COL3,
       t.V_COL4,
       t.V_COL5,
       t.V_COL6,
       t.V_COL7,
       t.V_COL8,
       t.V_COL9,
       t.V_COL10,
       t.V_COL11,
       t.V_COL12,
       t.V_COL13,
       t.V_COL14,
       t.V_COL15,
       t.V_COL16,
       t.V_COL17,
       t.V_COL18,
       t.V_COL19,
       t.V_COL20,
       t.V_COL21,
       t.V_COL22,
       t.V_COL23,
       t.V_COL24,
       t.V_COL25,
       t.V_COL26,
       t.V_COL27,
       t.V_COL28,
       t.V_COL29,
       t.V_COL30,
       t.N_COL1,
       t.N_COL2,
       t.N_COL3,
       t.N_COL4,
       t.N_COL5,
       t.N_COL6,
       t.N_COL7,
       t.N_COL8,
       t.YEAR,
       t.ADJSTATUS,
       t.FROMGUID,
       t.ISHISTORY,
       t.ISPUBLISH,
       t.AGENCYGUID,
       t.PROVINCE,
       t.PROJECTKIND from v_perf_project_info t where t.wfstatus=''011''';

execute immediate '
create or replace view v_perf_dept_infoquery as
select t.GUID proguid,
       t.NAME,
       t.CODE,
       t.LINKMAN,
       t.TELEPHONE,
       t.GIST,
       t.FUNCDESC,
       t.AGENCYGUID,
       t.STATUS,
       t.YEAR,
       t.ORDERNUM,
       t.FININTORGGUID,
       t.SUBAGENCYNUM,
       t.THEJOBNUM,
       t.STAFFNUM,
       t.INSTITUTIONSNUM,
       t.FUNCTION,
       t.PERFGOAL,
       t.BUDGETTOTAL,
       t.FINANCIALFUND,
       t.OTHERFUND,
       t.BASICEXPEND,
       t.THREEPUBLICFUND,
       t.SPECIALFUND,
       t.BUDGETAMT,
       t.GOVEFUNCAMT,
       t.TAXRANAMT,
       t.PROJEXPAMT,
       t.GOVTFUNDS,
       t.OTHERFUNDS,
       t.STATECAPITALBUDGET,
       t.PUBBUDGET,
       t.PROVINCE,
       t.CREATETIME CREATE_TIME,
       t.SUMFUNDS from v_perf_t_deptperfdeclare t where t.wfstatus=''011''';
