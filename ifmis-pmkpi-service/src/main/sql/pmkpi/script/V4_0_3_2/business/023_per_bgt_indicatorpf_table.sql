 i number;
begin

--perf_bgt_indicatorpf（批复项目指标表）
select count(1) into i from user_tables t where t.table_name = 'PERF_BGT_INDICATORPF';
if i=0 then
    execute immediate 'create table PERF_BGT_INDICATORPF
    (
      guid               VARCHAR2(40) not null,
      kpi_id             VARCHAR2(38) not null,
      mainguid           VARCHAR2(40),
      code               VARCHAR2(300),
      explain            VARCHAR2(500),
      weight             NUMBER(5,2),
      islinked           NUMBER(1),
      agencyguid         VARCHAR2(40),
      wfstatus           VARCHAR2(40),
      status             NUMBER(1),
      creater            VARCHAR2(40) not null,
      createtime         VARCHAR2(17) not null,
      create_time        VARCHAR2(17) not null,
      updatetime         VARCHAR2(17),
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
      wfid               VARCHAR2(40),
      targetvalue        VARCHAR2(1000),
      mof_div_code       VARCHAR2(9) not null,
      fiscal_year        VARCHAR2(4),
      pro_code           VARCHAR2(21),
      kpi_val            VARCHAR2(1000) not null,
      kpi_lv1            VARCHAR2(300) not null,
      kpi_lv2            VARCHAR2(300) not null,
      kpi_lv3            VARCHAR2(300),
      kpi_content        VARCHAR2(2000),
      kpi_evalstd        VARCHAR2(2000),
      kpi_remark         VARCHAR2(2000),
      version            VARCHAR2(38),
      version_name       VARCHAR2(400),
      sub_mof_code       VARCHAR2(9),
      agency_code        VARCHAR2(21),
      findex             VARCHAR2(300),
      sindex             VARCHAR2(300),
      name               VARCHAR2(1000),
      indexval           VARCHAR2(1000),
      yearflag           VARCHAR2(9),
      kpivalsource       VARCHAR2(32),
      value_remark       VARCHAR2(2000),
      value_desc         VARCHAR2(4000),
      fromguid           VARCHAR2(40),
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
      pro_name           VARCHAR2(300)
    )
    ';
    execute immediate 'alter table PERF_BGT_INDICATORPF add constraint PK_PERF_BGT_INDICATORPF primary key (GUID, YEAR, PROVINCE)';
end if;

execute immediate '
create or replace view v_perf_bgt_indicatorpf as
select
    *
from
    perf_bgt_indicatorpf
where
    year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
    and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and is_deleted = 2
';


