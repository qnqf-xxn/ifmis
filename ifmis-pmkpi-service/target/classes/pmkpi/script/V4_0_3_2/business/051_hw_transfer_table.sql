 i number;
begin
--1、perf_transfer_project（结转项目表）
select count(1) into i from user_tables t where t.table_name = 'PERF_TRANSFER_PROJECT';
if i=0 then
    execute immediate 'create table PERF_TRANSFER_PROJECT
    (
      guid                VARCHAR2(32) not null,
      busid               VARCHAR2(40) not null,
      pro_code            VARCHAR2(21) not null,
      pro_name            VARCHAR2(180) not null,
      agency_code         VARCHAR2(21) not null,
      agencyguid          VARCHAR2(21),
      pro_total_amt       NUMBER(20,2),
      create_time         VARCHAR2(14) not null,
      update_time         VARCHAR2(14) not null,
      is_deleted          NUMBER(1) not null,
      year                CHAR(4) not null,
      province            VARCHAR2(9) not null,
      manage_dept_code    VARCHAR2(40),
      manage_mof_dep_code VARCHAR2(40),
      finintorgguid       VARCHAR2(40),
      wfstatus            VARCHAR2(100)
    )
    ';
    execute immediate 'alter table PERF_TRANSFER_PROJECT add constraint PK_PERF_TRANSFER_PROJECT primary key (GUID, YEAR, PROVINCE)';
end if;

execute immediate 'create or replace view v_perf_transfer_project as
select
    *
from
    perf_transfer_project
where
    province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and is_deleted = 2
';

--2、perf_transfer_goal（结转目标表）
select count(1) into i from user_tables t where t.table_name = 'PERF_TRANSFER_GOAL';
if i=0 then
    execute immediate 'create table PERF_TRANSFER_GOAL
    (
      guid           VARCHAR2(40) not null,
      pro_code       VARCHAR2(21),
      kpi_target     VARCHAR2(2000),
      agencyguid     VARCHAR2(40),
      agency_code    VARCHAR2(21),
      yearflag       VARCHAR2(1),
      busi_type_code VARCHAR2(6),
      goalname       VARCHAR2(100),
      creater        VARCHAR2(40) not null,
      create_time    VARCHAR2(17) not null,
      update_time    VARCHAR2(17) not null,
      is_deleted     NUMBER(1) default 2 not null,
      province       VARCHAR2(40) not null,
      year           NUMBER(4) not null,
      version        VARCHAR2(38),
      version_name   VARCHAR2(400),
      mof_div_code   VARCHAR2(9)
    )
    ';
    execute immediate 'alter table PERF_TRANSFER_GOAL add constraint PK_PERF_TRANSFER_GOAL primary key (GUID, YEAR, PROVINCE)';
end if;

execute immediate 'create or replace view v_perf_transfer_goal as
select
    *
from
    perf_transfer_goal
where
    year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
    and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and is_deleted = 2
';

--3、perf_transfer_indicator（结转指标表）
select count(1) into i from user_tables t where t.table_name = 'PERF_TRANSFER_INDICATOR';
if i=0 then
    execute immediate 'create table PERF_TRANSFER_INDICATOR
    (
      guid               VARCHAR2(40) not null,
      pro_code           VARCHAR2(21),
      code               VARCHAR2(300),
      explain            VARCHAR2(500),
      weight             NUMBER(5,2),
      islinked           NUMBER(1),
      agencyguid         VARCHAR2(40),
      agency_code        VARCHAR2(21),
      creater            VARCHAR2(40) not null,
      create_time        VARCHAR2(17) not null,
      update_time        VARCHAR2(17) not null,
      is_deleted         NUMBER(1) not null,
      year               NUMBER(4) not null,
      province           VARCHAR2(32) not null,
      ordernum           NUMBER(9),
      finintorgguid      VARCHAR2(40),
      superid            VARCHAR2(40),
      levelno            NUMBER(2),
      rule               VARCHAR2(200),
      computesign        VARCHAR2(40),
      meterunit          VARCHAR2(200),
      tindex             VARCHAR2(300),
      targetvalue        VARCHAR2(1000),
      kpi_val            VARCHAR2(1000) not null,
      kpi_lv1            VARCHAR2(300) not null,
      kpi_lv2            VARCHAR2(300) not null,
      kpi_content        VARCHAR2(2000),
      kpi_evalstd        VARCHAR2(2000),
      kpi_remark         VARCHAR2(2000),
      version            VARCHAR2(38),
      version_name       VARCHAR2(400),
      sub_mof_code       VARCHAR2(9),
      findex             VARCHAR2(300),
      sindex             VARCHAR2(300),
      name               VARCHAR2(1000),
      indexval           VARCHAR2(1000),
      kpivalsource       VARCHAR2(32),
      value_remark       VARCHAR2(2000),
      value_desc         VARCHAR2(4000),
      busi_type_code     VARCHAR2(6),
      opinion_remark     VARCHAR2(4000),
      goalguid           VARCHAR2(40),
      indexstandards     VARCHAR2(2000),
      isstandpush        VARCHAR2(4000),
      computetype        VARCHAR2(4000),
      referenceval       VARCHAR2(1000),
      referencestandards VARCHAR2(2000),
      snindexval         VARCHAR2(1000),
      qnindexval         VARCHAR2(1000),
      endvaltype         VARCHAR2(40),
      endvalsource       VARCHAR2(40),
      valrule            VARCHAR2(40),
      evidencefile       VARCHAR2(40),
      value_change       VARCHAR2(40),
      mof_div_code   VARCHAR2(9)
    )
    ';
    execute immediate 'alter table PERF_TRANSFER_INDICATOR add constraint PK_PERF_TRANSFER_INDICATOR primary key (GUID, YEAR, PROVINCE)';
end if;

execute immediate 'create or replace view v_perf_transfer_indicator as
select
    *
from
    perf_transfer_indicator
where
    year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
    and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and is_deleted = 2
';
