--declare
 i number;
begin
select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_INSTRUCTOR';
  if i=0 then
     execute immediate '
create table PERF_INSTRUCTOR
(
  guid         VARCHAR2(40) not null,
  code         VARCHAR2(100),
  name         VARCHAR2(200),
  sex          VARCHAR2(40),
  age          VARCHAR2(40),
  education    VARCHAR2(40),
  political    VARCHAR2(40),
  specialty    VARCHAR2(400),
  workplace    VARCHAR2(200),
  occupation        VARCHAR2(40),
  job        VARCHAR2(40),
  phone        VARCHAR2(40),
  email        VARCHAR2(100),
  tel          VARCHAR2(40),
  address      VARCHAR2(400),
  resume      VARCHAR2(4000),
  treatise     VARCHAR2(4000),
  employopinion     VARCHAR2(4000),
  financeopinion     VARCHAR2(4000),
  status       CHAR(1),
  creater      VARCHAR2(40),
  createtime   VARCHAR2(17),
  updatetime   VARCHAR2(17),
  year         CHAR(4) not null,
  province     VARCHAR2(9) not null
 )';
execute immediate 'alter table PERF_INSTRUCTOR
  add constraint PERF_INSTRUCTOR primary key (GUID, YEAR, PROVINCE)';
  
execute immediate '
CREATE OR REPLACE VIEW v_perf_instructor AS
select * from PERF_INSTRUCTOR
where province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')';  

 end if;
 
 select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_LEGALPERSON';
  if i=0 then
     execute immediate '
create table PERF_LEGALPERSON
(
  guid         VARCHAR2(40) not null,
  mainguid     VARCHAR2(40) not null,
  code         VARCHAR2(100),
  name         VARCHAR2(200),
  SEX          VARCHAR2(40),
  EDUCATION    VARCHAR2(40),
  MAJOR        VARCHAR2(40),
  POLITICAL    VARCHAR2(40),
  JOB        VARCHAR2(40),
  OCCUPATION        VARCHAR2(40),
  EMAIL        VARCHAR2(100),
  TEL          VARCHAR2(40),
  PHONE        VARCHAR2(40),
  STATUS       CHAR(1),
  CREATER      VARCHAR2(40),
  CREATETIME   VARCHAR2(17),
  UPDATETIME   VARCHAR2(17),
  year         CHAR(4) not null,
  province     VARCHAR2(9) not null
 )';
execute immediate 'alter table PERF_LEGALPERSON
  add constraint PERF_LEGALPERSON primary key (GUID, YEAR, PROVINCE)';
  
execute immediate '
CREATE OR REPLACE VIEW v_perf_legalperson AS
select * from PERF_LEGALPERSON
where province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')';  

 end if;
 
 
 select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_EVALUATOR';
  if i=0 then
     execute immediate '
create table PERF_EVALUATOR
(
  guid         VARCHAR2(40) not null,
  mainguid     VARCHAR2(40) not null,
  code         VARCHAR2(100),
  name         VARCHAR2(200),
  SEX          VARCHAR2(40),
  EDUCATION    VARCHAR2(40),
  MAJOR        VARCHAR2(40),
  POLITICAL    VARCHAR2(40),
  JOB        VARCHAR2(40),
  OCCUPATION        VARCHAR2(40),
  EMAIL        VARCHAR2(100),
  TEL          VARCHAR2(40),
  PHONE        VARCHAR2(40),
  nationality  VARCHAR2(200),
  WORKPLACE    VARCHAR2(200),
  TYPE         VARCHAR2(40),
  STATUS       CHAR(1),
  CREATER      VARCHAR2(40),
  CREATETIME   VARCHAR2(17),
  UPDATETIME   VARCHAR2(17),
  year         CHAR(4) not null,
  province     VARCHAR2(9) not null
 )';
execute immediate 'alter table PERF_EVALUATOR
  add constraint PERF_EVALUATOR primary key (GUID, YEAR, PROVINCE)';
  
execute immediate '
CREATE OR REPLACE VIEW v_perf_evaluator AS
select * from PERF_EVALUATOR
where province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')';  

 end if;
 

select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_BRANCH';
  if i=0 then
     execute immediate '
create table PERF_BRANCH
(
  guid         VARCHAR2(40) not null,
  mainguid     VARCHAR2(40) not null,
  code         VARCHAR2(100),
  name         VARCHAR2(200),
  linkman            VARCHAR2(50),
  WORKPLACE    VARCHAR2(200),
  RANGE        VARCHAR2(200),
  reviewersum  VARCHAR2(10),
  EMAIL        VARCHAR2(100),
  TEL          VARCHAR2(40),
  FAX          VARCHAR2(100),
  STATUS       CHAR(1),
  CREATER      VARCHAR2(40),
  CREATETIME   VARCHAR2(17),
  UPDATETIME   VARCHAR2(17),
  year         CHAR(4) not null,
  province     VARCHAR2(9) not null
 )';
execute immediate 'alter table PERF_BRANCH
  add constraint PERF_BRANCH primary key (GUID, YEAR, PROVINCE)';
  
execute immediate '
CREATE OR REPLACE VIEW v_perf_branch AS
select * from PERF_BRANCH
where province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')';  

 end if;
 

select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_INTERMEDIARYFUNDS';
  if i=0 then
     execute immediate '
create table PERF_INTERMEDIARYFUNDS
(
  guid         VARCHAR2(40) not null,
  mainguid     VARCHAR2(40) not null,
  proname      VARCHAR2(100),
  PROJTYPE      VARCHAR2(200),
  CAPITALSCALE   NUMBER(20,5),
  CHARGE         NUMBER(20,5),
  CATEGORY        VARCHAR2(200),
  STATUS       CHAR(1),
  CREATER      VARCHAR2(40),
  CREATETIME   VARCHAR2(17),
  UPDATETIME   VARCHAR2(17),
  year         CHAR(4) not null,
  province     VARCHAR2(9) not null
 )';
execute immediate 'alter table PERF_INTERMEDIARYFUNDS
  add constraint PERF_INTERMEDIARYFUNDS primary key (GUID, YEAR, PROVINCE)';
  
execute immediate '
CREATE OR REPLACE VIEW v_perf_intermediaryfunds AS
select * from PERF_INTERMEDIARYFUNDS
where province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')';  

 end if;
--end; 
