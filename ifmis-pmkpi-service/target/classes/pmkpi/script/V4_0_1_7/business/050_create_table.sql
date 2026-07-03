i number;
begin
  SELECT COUNT(*) INTO i FROM USER_TABLES T WHERE T.TABLE_NAME='PERF_T_SELFPROFUND';
  if i = 0 then
    execute immediate '
  create table PERF_T_SELFPROFUND
(
  guid         VARCHAR2(40) not null,
  name         VARCHAR2(200),
  amt1         VARCHAR2(200),
  amt2         VARCHAR2(200),
  amt3         VARCHAR2(200),
  amt4         VARCHAR2(200),
  amt5         VARCHAR2(200),
  amt6         VARCHAR2(200),
  amt7         VARCHAR2(200),
  amt8         VARCHAR2(200),
  amt9         VARCHAR2(200),
  ordernum     NUMBER(9),
  mainguid     VARCHAR2(40),
  isedit       VARCHAR2(40),
  agencyguid   VARCHAR2(40),
  agency_code  VARCHAR2(40),
  pro_code     VARCHAR2(40),
  proguid      VARCHAR2(40),
  creater      VARCHAR2(40),
  create_time  VARCHAR2(17),
  update_time  VARCHAR2(17),
  is_deleted   NUMBER(1),
  fiscal_year  VARCHAR2(4) not null,
  mof_div_code VARCHAR2(9) not null,
  year         VARCHAR2(4) not null,
  province     VARCHAR2(9) not null,
  bgtget       VARCHAR2(30),
  economic     VARCHAR2(40)
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
execute immediate '
alter table PERF_T_SELFPROFUND
  add constraint PK_PERF_SELFPROFUND primary key (GUID, PROVINCE, YEAR)';
  end if;
-- 重构视图
execute immediate '
  create or replace view v_perf_t_selfprofund as
  select * from perf_t_selfprofund t  
  where YEAR= global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'') and PROVINCE = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')
';