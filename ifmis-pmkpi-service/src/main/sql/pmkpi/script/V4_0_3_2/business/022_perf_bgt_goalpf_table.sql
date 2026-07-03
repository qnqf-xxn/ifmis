 i number;
begin
--perf_bgt_goalpf（批复项目目标表）
select count(1) into i from user_tables t where t.table_name = 'PERF_BGT_GOALPF';
if i=0 then
    execute immediate 'create table PERF_BGT_GOALPF
    (
      guid           VARCHAR2(40) not null,
      agencyguid     VARCHAR2(40),
      zqgoal         VARCHAR2(4000),
      ndgoal         VARCHAR2(4000),
      mainguid       VARCHAR2(40),
      creater        VARCHAR2(40) not null,
      createtime     VARCHAR2(17) not null,
      create_time    VARCHAR2(17) not null,
      updatetime     VARCHAR2(17),
      update_time    VARCHAR2(17) not null,
      is_deleted     NUMBER(1) default 2 not null,
      province       VARCHAR2(40) not null,
      year           NUMBER(4) not null,
      kpi_per_id     VARCHAR2(38) not null,
      mof_div_code   VARCHAR2(9),
      fiscal_year    VARCHAR2(4),
      pro_code       VARCHAR2(21),
      kpi_target     VARCHAR2(2000),
      version        VARCHAR2(38),
      version_name   VARCHAR2(400),
      sub_mof_code   VARCHAR2(9),
      agency_code    VARCHAR2(21),
      yearflag       VARCHAR2(1),
      busi_type_code VARCHAR2(6),
      goalname       VARCHAR2(100),
      status         NUMBER(1),
      fromguid       VARCHAR2(40)
    )
    ';
    execute immediate 'comment on column PERF_BGT_GOALPF.kpi_per_id is ''项目绩效目标主键''';
    execute immediate 'comment on column PERF_BGT_GOALPF.mof_div_code is ''财政区划代码''';
    execute immediate 'comment on column PERF_BGT_GOALPF.fiscal_year is ''预算年度''';
    execute immediate 'comment on column PERF_BGT_GOALPF.pro_code is ''项目代码''';
    execute immediate 'comment on column PERF_BGT_GOALPF.kpi_target is ''绩效目标''';
    execute immediate 'comment on column PERF_BGT_GOALPF.version is ''版本号''';
    execute immediate 'comment on column PERF_BGT_GOALPF.version_name is ''版本说明''';
    execute immediate 'comment on column PERF_BGT_GOALPF.sub_mof_code is ''下级财政区划代码''';
    execute immediate 'comment on column PERF_BGT_GOALPF.update_time is ''更新时间''';
    execute immediate 'comment on column PERF_BGT_GOALPF.is_deleted is ''是否删除1是2否''';
    execute immediate 'comment on column PERF_BGT_GOALPF.create_time is ''创建时间''';
    execute immediate 'alter table PERF_BGT_GOALPF add constraint PK_PERF_BGT_GOALPF primary key (GUID, YEAR, PROVINCE)';
end if;

execute immediate '
create or replace view v_perf_bgt_goalpf as
select
    *
from
    perf_bgt_goalpf
where
    year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
    and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and is_deleted = 2
';


