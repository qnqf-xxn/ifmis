
  i integer;
begin
  --绩效公开主表
  select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_T_MANCEOPEN';
  if i=0 then
     execute immediate '
create table PERF_T_MANCEOPEN
(
  guid           VARCHAR2(40) not null,
  mainguid       VARCHAR2(40),
  pro_code		 VARCHAR2(40),
  agencyguid     VARCHAR2(40),
  isopen		 NUMBER(1),
  openamt		 NUMBER(20,2),
  openurl		 VARCHAR2(2000),
  openreason 	 VARCHAR2(2000),
  bustype        VARCHAR2(40),
  creater        VARCHAR2(32),
  createtime     VARCHAR2(20),
  updatetime     VARCHAR2(20),
  wfstatus       VARCHAR2(50),
  wfid           VARCHAR2(100),
  auditor        VARCHAR2(40),
  lastupdatetime VARCHAR2(20),
  is_deleted     VARCHAR2(10),
  province       VARCHAR2(9) not null,
  year           CHAR(4) not null  
)';
-- Create/Recreate primary, unique and foreign key constraints 
execute immediate 'alter table PERF_T_MANCEOPEN
  add constraint PK_PERF_MANCEOPEN primary key (GUID, YEAR, PROVINCE)
  ';
end if;


execute immediate '
create or replace view V_PERF_T_MANCEOPEN as
select *
from PERF_T_MANCEOPEN where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and is_deleted = ''2'' 
';

