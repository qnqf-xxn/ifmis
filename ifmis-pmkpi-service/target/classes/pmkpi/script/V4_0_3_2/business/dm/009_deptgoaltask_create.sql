i number;
begin


select count(*) into i from user_tables where TABLE_NAME = 'PERF_T_DEPTGOALTASK';
if i=0 then
    execute immediate '
    create table PERF_T_DEPTGOALTASK
	(
	  guid       VARCHAR2(40) not null,
	  goalguid   VARCHAR2(40) not null,
	  mainguid   VARCHAR2(40),
	  taskguid   VARCHAR2(40),
	  year       VARCHAR2(4) not null,
      province   VARCHAR2(9) not null,
	  task_context VARCHAR2(100)
	)
    ';
    execute immediate 'alter table PERF_T_DEPTGOALTASK add constraint PK_PERF_T_DEPTGOALTASK primary key (GUID,YEAR,PROVINCE)';
end if;


select count(1) into i from user_tab_cols t where t.table_name='PERF_T_DEPTTASK' and t.column_name='ORDERNUM';
    if i=0 then
    execute immediate 'alter table PERF_T_DEPTTASK add(ORDERNUM NUMBER(9))';
end if;

select count(1) into i from user_tab_cols t where t.table_name='PERF_T_DEPTTASK' and t.column_name='ISEDIT';
    if i=0 then
    execute immediate 'alter table PERF_T_DEPTTASK add(ISEDIT VARCHAR2(40))';
end if;

select count(1) into i from user_tab_columns where table_name = 'PERF_T_DEPTTASK' and column_name = 'BASICFUND';
if i = 0 then
 execute immediate 'alter table PERF_T_DEPTTASK add BASICFUND NUMBER(20,2)';
end if;
  
select count(1) into i from user_tab_columns where table_name = 'PERF_T_DEPTTASK' and column_name = 'PROJECTFUND';
if i = 0 then
 execute immediate 'alter table PERF_T_DEPTTASK add PROJECTFUND NUMBER(20,2)';
end if;

execute immediate '
CREATE OR REPLACE VIEW V_PERF_T_DEPTTASK AS
SELECT
	*
FROM
	PERF_T_DEPTTASK
WHERE
	year = global_multyear_cz.Secu_f_GLOBAL_PARM ( ''YEAR'' )
	AND province = global_multyear_cz.Secu_f_GLOBAL_PARM (''DIVID'')
';


execute immediate '
create or replace view v_perf_t_deptgoaltask as
select t.*,b.GUID as taskguid,b."CONTEXT" as task_context,b.ordernum as taskordernum from V_BGT_PERF_GOAL_INFO t 
left join PERF_T_DEPTGOALTASK a on t.GUID = a.goalguid and t.PROVINCE = a.province and t.YEAR = a.year
left join V_PERF_T_DEPTTASK b on b.GUID = a.taskguid and b.PROVINCE = a.province and b.YEAR = a.year
';

select count(*) into i from user_tables where TABLE_NAME = 'PERF_T_DEPTTOFININTORG';
if i=0 then
    execute immediate '
    create table PERF_T_DEPTTOFININTORG
	(
	  guid       VARCHAR2(40) not null,
	  mainguid   VARCHAR2(40) not null,
	  finitorg   VARCHAR2(40),
	  finitorgname   VARCHAR2(400),
	  isreview   NUMBER(1),
	  year       VARCHAR2(4) not null,
      province   VARCHAR2(9) not null
	)
    ';
    execute immediate 'alter table PERF_T_DEPTTOFININTORG add constraint PK_PERF_T_DEPTTOFININTORG primary key (GUID,YEAR,PROVINCE)';
end if;


delete from bus_t_diccolumn where TABLECODE = 'PERF_T_DEPTTASK' and COLUMNCODE IN ('ORDERNUM','ISEDIT','BASICFUND','PROJECTFUND');

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'ORDERNUM', '1', '2016', '87', sys_guid(), 'ORDERNUM', 'PERF_T_DEPTTASK', '排序', 'S', '40', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'ISEDIT', '1', '2016', '87', sys_guid(), 'ISEDIT', 'PERF_T_DEPTTASK', '是否可编辑', 'S', '40', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'BASICFUND', '1', '2016', '87', sys_guid(), 'BASICFUND', 'PERF_T_DEPTTASK', '基本资金', 'S', '20', null, null, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'PROJECTFUND', '1', '2016', '87', sys_guid(), 'PROJECTFUND', 'PERF_T_DEPTTASK', '项目资金', 'S', '20', null, null, 1, null, sysdate);