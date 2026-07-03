
i number;
begin
  select count(1) into i from user_tables where table_name = 'PERF_TMP_INDICATOR';
  if i = 0 then
     execute immediate '
	create global temporary table PERF_TMP_INDICATOR
	(
	  fguid    VARCHAR2(50),
	  fcode    VARCHAR2(100),
	  fname    VARCHAR2(200),
	  superid  VARCHAR2(50),
	  guid     VARCHAR2(50),
	  sindex   VARCHAR2(50),
	  name     VARCHAR2(200),
	  mainguid VARCHAR2(50)
	)
	on commit delete rows';
  end if;
  
  select count(1) into i from user_tables where table_name = 'PERF_TMP_AUDIT';
  if i = 0 then
     execute immediate '
	create global temporary table PERF_TMP_AUDIT
	(
	  proguid VARCHAR2(50),
	  remark  VARCHAR2(400),
	  flag    NUMBER(1),
	  procode VARCHAR2(50)
	)
	on commit delete rows';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'PM_PERF_GOAL_INFO' and column_name = 'FROMGUID';
  if i = 0 then
     execute immediate 'alter table PM_PERF_GOAL_INFO add FROMGUID varchar2(40)';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'PM_PERF_INDICATOR' and column_name = 'FROMGUID';
  if i = 0 then
     execute immediate 'alter table PM_PERF_INDICATOR add FROMGUID varchar2(40)';
  end if;

execute immediate '
create or replace view v_pm_perf_goal_info as
select * from pm_perf_goal_info
where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and is_deleted = 2';

execute immediate '
create or replace view v_pm_perf_indicator as
select * from pm_perf_indicator
where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and is_deleted = 2';


delete from bus_t_diccolumn where COLUMNCODE = 'FROMGUID' and TABLECODE IN ('PM_PERF_GOAL_INFO','PM_PERF_INDICATOR');

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'FROMGUID', '1', '2016', '87', sys_guid(), 'FROMGUID', 'PM_PERF_GOAL_INFO', 'fromguid', 'S', '40', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'FROMGUID', '1', '2016', '87', sys_guid(), 'FROMGUID', 'PM_PERF_INDICATOR', 'fromguid', 'S', '40', null, 1, 1, null, sysdate);