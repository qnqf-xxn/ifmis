 i number;
begin
  
--PERF_T_TYPICALCASE£¨µäÐÍ°¸Àý£©
select count(1) into i from user_tables t where t.table_name = 'PERF_T_TYPICALCASE';
if i=0 then
    execute immediate 'create table PERF_T_TYPICALCASE
	(
	  guid           VARCHAR2(40) not null,
	  name           VARCHAR2(500) not null,
	  createtime     VARCHAR2(17) not null,
	  updatetime     VARCHAR2(17) not null,
	  describe       VARCHAR2(4000),
	  status         VARCHAR2(40),
	  creater        VARCHAR2(40),
	  province       VARCHAR2(40) not null,
	  year           NUMBER(4) not null,
	  code           VARCHAR2(100),
	  wfid           VARCHAR2(40),
	  lastupdatetime VARCHAR2(17),
	  wfstatus       VARCHAR2(40),
	  is_deleted     NUMBER(1),
	  auditor        VARCHAR2(40),
	  bustype        VARCHAR2(40),
	  casetype       VARCHAR2(40)
	)
    ';
    execute immediate 'alter table PERF_T_TYPICALCASE add constraint PK_PERF_T_TYPICALCASE primary key (GUID, YEAR, PROVINCE)';
end if;

execute immediate 'create or replace view V_PERF_T_TYPICALCASE as 
select * from PERF_T_TYPICALCASE t where t.province = global_multyear_cz.v_pmdivid and t.is_deleted = 2';

execute immediate 'create or replace view V_PERF_T_TYPICALCASEALL as 
select * from PERF_T_TYPICALCASE t where t.is_deleted = 2';  
