  i number;
  v_sql varchar2(2000);
  ln_i integer;
begin
  
--PERF_T_FIXEDINDEX（固化指标表）
select count(1) into i from user_tables t where t.table_name = 'PERF_T_FIXEDINDEX';
if i=0 then
    execute immediate 'create table PERF_T_FIXEDINDEX
	(
	  guid        VARCHAR2(40) not null,
	  code        VARCHAR2(300),
	  name        VARCHAR2(1000),
	  FINDEX     VARCHAR2(38),
	  SINDEX     VARCHAR2(38),
	  ordernum    NUMBER(9),
	  remark      VARCHAR2(2000),
	  status      NUMBER,
	  update_time VARCHAR2(17),
	  is_deleted  NUMBER(1) not null,
	  create_time VARCHAR2(17),
	  frametype   VARCHAR2(40) not null,
	  year        NUMBER(4) not null,
	  province    VARCHAR2(9) not null,
	  weight      NUMBER(18,2),
	  indexval    VARCHAR2(1000),
	  computesign VARCHAR2(40),
	  meterunit   VARCHAR2(40),
	  isedit      VARCHAR2(40),
	  yearflag    VARCHAR2(9)
	)
    ';
    execute immediate 'alter table PERF_T_FIXEDINDEX add constraint PK_PERF_T_FIXEDINDEX primary key (GUID, YEAR, PROVINCE)';
end if;

v_sql :='create or replace view V_PERF_T_FIXEDINDEX as
select * from PERF_T_FIXEDINDEX where is_deleted = 2 and year =  global_multyear_cz.v_pmyear
and province = global_multyear_cz.v_pmdivid';

select fn_alterview('V_PERF_T_FIXEDINDEX',v_sql) into ln_i;
	if ln_i = 0 then
	    return;
	end if;


--PM_PERF_INDICATOR（申报指标表增加字段ISFIXED-是否为固化指标）
select count(*) into i from user_tab_columns t where t.table_name ='PM_PERF_INDICATOR' and t.column_name='ISFIXED';
if i=0 then
	execute immediate 'alter table PM_PERF_INDICATOR add ISFIXED NUMBER(1)';
end if;

v_sql :='
create or replace view V_PM_PERF_INDICATOR as
select * from PM_PERF_INDICATOR t
where YEAR = global_multyear_cz.v_pmyear and PROVINCE = global_multyear_cz.v_pmdivid and is_deleted =2 and is_backup =2';
select fn_alterview('V_PM_PERF_INDICATOR',v_sql) into ln_i;
	if ln_i = 0 then
	    return;
	end if;
	
--PERF_PROVISION_INDICATOR（修订指标表增加字段ISFIXED-是否为固化指标）
select count(*) into i from user_tab_columns t where t.table_name ='PERF_PROVISION_INDICATOR' and t.column_name='ISFIXED';
if i=0 then
	execute immediate 'alter table PERF_PROVISION_INDICATOR add ISFIXED NUMBER(1)';
end if;

v_sql :='
create or replace view V_PERF_PROVISION_INDICATOR as
select *
from PERF_PROVISION_INDICATOR where year = global_multyear_cz.v_pmyear
      and province = global_multyear_cz.v_pmdivid and is_deleted = 2';
select fn_alterview('V_PERF_PROVISION_INDICATOR',v_sql) into ln_i;
	if ln_i = 0 then
	    return;
	end if;	

--PERF_T_ADJUSTINDEX（调整指标表增加字段ISFIXED-是否为固化指标）
select count(*) into i from user_tab_columns t where t.table_name ='PERF_T_ADJUSTINDEX' and t.column_name='ISFIXED';
if i=0 then
	execute immediate 'alter table PERF_T_ADJUSTINDEX add ISFIXED NUMBER(1)';
end if;
v_sql :='CREATE OR REPLACE VIEW V_PERF_T_ADJUSTINDEX AS
SELECT *
 FROM PERF_T_ADJUSTINDEX T
WHERE YEAR = GLOBAL_MULTYEAR_CZ.V_PMYEAR AND PROVINCE = GLOBAL_MULTYEAR_CZ.V_PMDIVID AND T.IS_DELETED=2';
	select fn_alterview('V_PERF_T_ADJUSTINDEX',v_sql) into ln_i;
	if ln_i = 0 then
	    return;
	end if;	