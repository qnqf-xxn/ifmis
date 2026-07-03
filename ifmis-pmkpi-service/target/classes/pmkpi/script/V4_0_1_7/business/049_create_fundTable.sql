-- 监控、自评页面 预算执行情况页签的取数表
 i number;
begin
select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_T_PROFUND';
  if i=0 then
     execute immediate '
create table PERF_T_PROFUND
(
  guid         VARCHAR2(40) not null,
  name         VARCHAR2(200),
  totalamt     VARCHAR2(200),
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
  isedit       VARCHAR2(40),
  agencyguid   VARCHAR2(40),
  agency_code  VARCHAR2(40),
  creater      VARCHAR2(40),
  create_time  VARCHAR2(17),
  update_time  VARCHAR2(17),
  is_deleted   NUMBER(1),
  fiscal_year  VARCHAR2(4) not null,
  mof_div_code VARCHAR2(9) not null,
  year         VARCHAR2(4) not null,
  province     VARCHAR2(9) not null,
  bgtget       VARCHAR2(30),
  dept_name    VARCHAR2(200),
  dept_code    VARCHAR2(40),
  pro_name     VARCHAR2(200),
  pro_code     VARCHAR2(40),
  month        NUMBER(2),
  agency_name  VARCHAR2(200),
  proguid      VARCHAR2(40),
  enddate      VARCHAR2(17),
  score        VARCHAR2(40),
  startdate    VARCHAR2(17)
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
execute immediate 'alter table PERF_T_PROFUND
  add constraint PERF_T_PROFUND primary key (GUID)';
 end if;