 i number;
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

execute immediate 'create or replace view V_PERF_T_FIXEDINDEX as
select * from PERF_T_FIXEDINDEX where is_deleted = 2 and year =  global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';


--PM_PERF_INDICATOR（申报指标表增加字段ISFIXED-是否为固化指标）
select count(*) into i from user_tab_columns t where t.table_name ='PM_PERF_INDICATOR' and t.column_name='ISFIXED';
if i=0 then
	execute immediate 'alter table PM_PERF_INDICATOR add ISFIXED NUMBER(1)';
end if;

execute immediate '
create or replace view v_pm_perf_indicator as
select * from pm_perf_indicator t
where YEAR = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'') and PROVINCE = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and is_deleted =2 and is_backup =2';

--PERF_PROVISION_INDICATOR（修订指标表增加字段ISFIXED-是否为固化指标）
select count(*) into i from user_tab_columns t where t.table_name ='PERF_PROVISION_INDICATOR' and t.column_name='ISFIXED';
if i=0 then
	execute immediate 'alter table PERF_PROVISION_INDICATOR add ISFIXED NUMBER(1)';
end if;

execute immediate '
create or replace view V_PERF_PROVISION_INDICATOR as
select *
from PERF_PROVISION_INDICATOR where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
      and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and is_deleted = 2';
	  
--PERF_T_ADJUSTINDEX（调整指标表增加字段ISFIXED-是否为固化指标）
select count(*) into i from user_tab_columns t where t.table_name ='PERF_T_ADJUSTINDEX' and t.column_name='ISFIXED';
if i=0 then
	execute immediate 'alter table PERF_T_ADJUSTINDEX add ISFIXED NUMBER(1)';
end if;

execute immediate '
create or replace view V_PERF_T_ADJUSTINDEX as
select *
 from PERF_T_ADJUSTINDEX t
where YEAR = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'') and PROVINCE = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and t.is_deleted=2';