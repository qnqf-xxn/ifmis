 i number;
begin
--1、PERF_T_EVALUATEINFO（评价基本信息表）
select count(1) into i from user_tables t where t.table_name = 'PERF_T_EVALUATEINFO';
if i=0 then
    execute immediate 'create table PERF_T_EVALUATEINFO
    (
      guid                VARCHAR2(32) not null,
      mainguid            VARCHAR2(40) not null,
      name                VARCHAR2(180),--名称
      evaluate_type       VARCHAR2(40),--评价类型
      fund_type_code      VARCHAR2(40),--项目资金性质
      evaluate_mode       VARCHAR2(40),--评价组织实施方式
      institution_name    VARCHAR2(180),--第三方机构名称
      score               NUMBER(5,2),--评价结论(分数)
      grade               VARCHAR2(40),--评价结论(等级)
      bustype             VARCHAR2(40),--业务类型
      lines               VARCHAR2(40),--线上线下
      createtime          VARCHAR2(17) not null,
      updatetime          VARCHAR2(17),
      creater             VARCHAR2(40) not null,
      province            VARCHAR2(32) not null,
      year                NUMBER(4) not null
    )
    ';
    execute immediate 'alter table PERF_T_EVALUATEINFO add constraint PK_PERF_T_EVALUATEINFO primary key (GUID, YEAR, PROVINCE)';
end if;

execute immediate 'create or replace view V_PERF_T_EVALUATEINFO as
select * from PERF_T_EVALUATEINFO t where t.year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
  and t.province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';
