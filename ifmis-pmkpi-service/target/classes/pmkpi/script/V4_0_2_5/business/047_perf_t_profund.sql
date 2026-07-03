i number;
begin
  -- 新建临时表  备份数据
  select count(*) into i from user_tables t where t.TABLE_NAME ='PERF_T_PROFUND_ONE';
   if i = 0 then
    --有数据，新加临时表，保存原表数据
    execute immediate'create table PERF_T_PROFUND_ONE as select * from PERF_T_PROFUND';
  end if;
  
  -- 删除原来的表
  select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_T_PROFUND';
   if i>0 then
       execute immediate'drop table PERF_T_PROFUND';
   end if;
  
  --重构表 
  select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_T_PROFUND';
    if i=0 then
       execute immediate '
  create table PERF_T_PROFUND
  (
    guid         VARCHAR2(40) not null,
    name         VARCHAR2(200),
    totalamt     NUMBER(20,2),
    amt1         NUMBER(20,2),
    amt2         NUMBER(20,2),
    amt3         NUMBER(20,2),
    amt4         NUMBER(20,2),
    amt5         NUMBER(20,2),
    amt6         NUMBER(20,2),
    amt7         NUMBER(20,2),
    amt8         NUMBER(20,2),
    amt9         NUMBER(20,2),
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
    startdate    VARCHAR2(17),
    bgtsource    VARCHAR2(200)
  )';
  execute immediate 'alter table PERF_T_PROFUND
    add constraint PERF_T_PROFUND primary key (GUID)';
   end if;
   
-- 数据插入到新表中
  execute immediate '
  delete from PERF_T_PROFUND ';
  execute immediate '
  insert into PERF_T_PROFUND (GUID, NAME, TOTALAMT, AMT1, AMT2, AMT3, AMT4, AMT5, AMT6, AMT7, AMT8, AMT9, ORDERNUM, ISEDIT, AGENCYGUID, AGENCY_CODE, CREATER, CREATE_TIME, UPDATE_TIME, IS_DELETED, FISCAL_YEAR, MOF_DIV_CODE, YEAR, PROVINCE, BGTGET, DEPT_NAME, DEPT_CODE, PRO_NAME, PRO_CODE, MONTH, AGENCY_NAME, PROGUID, ENDDATE, SCORE, STARTDATE, BGTSOURCE)
  select * from PERF_T_PROFUND_ONE';
  -- 删除临时表
  execute immediate '
  drop table PERF_T_PROFUND_ONE';
