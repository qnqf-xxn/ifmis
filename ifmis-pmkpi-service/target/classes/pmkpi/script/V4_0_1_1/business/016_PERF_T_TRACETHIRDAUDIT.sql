i integer;
begin
  --绩效目标调整主表
  select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_T_TRACETHIRDAUDIT';
  if i=0 then
     execute immediate '
create table PERF_T_TRACETHIRDAUDIT
(
  guid        VARCHAR2(40) not null,
  taskguid    VARCHAR2(40),
  proguid     VARCHAR2(40),
  mainguid    VARCHAR2(40),
  status      NUMBER(1),
  agencyguid  VARCHAR2(40),
  agency_code VARCHAR2(40),
  creater     VARCHAR2(40),
  create_time VARCHAR2(17),
  update_time VARCHAR2(17),
  year        VARCHAR2(4) not null,
  province    VARCHAR2(9) not null,
  audittype   VARCHAR2(40),
  problem     VARCHAR2(4000),
  rectify     VARCHAR2(4000),
  bustype     VARCHAR2(40)
)
partition by list (PROVINCE)
subpartition by list (YEAR)
(
  partition P87 values (''87'')
    tablespace EFMIS
  (
    subpartition P87_Y2016 values (''2016'') tablespace EFMIS
  )
)';
-- Create/Recreate primary, unique and foreign key constraints 
execute immediate 'alter table PERF_T_TRACETHIRDAUDIT
  add constraint PK_PERF_T_TRACETHIRDAUDIT primary key (GUID, PROVINCE, YEAR)
  using index ';
   end if;
execute immediate '
create or replace view V_PERF_T_TRACETHIRDAUDIT as
select * 
from PERF_T_TRACETHIRDAUDIT t where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
  and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';

select count(1) into i from user_tab_cols t where t.table_name='PERF_T_PROMONITOR' and t.column_name='AUDITTYPE';
if i=0 then
   execute immediate 'alter table PERF_T_PROMONITOR add AUDITTYPE VARCHAR2(40)';
end if;

DELETE FROM Bus_t_Diccolumn t where t.tablecode='PERF_T_PROMONITOR' and t.columncode='AUDITTYPE';
insert into Bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'TRACEAUDITTYPE', null, '1', 'AUDITTYPE', '1', '2020', '87', 'C231A8592DD172DDE053B11FA8C02791', 'AUDITTYPE', 'PERF_T_PROMONITOR', '审核类型', 'S', '40', null, 1, 1, null, sysdate);

execute immediate 'create or replace view v_perf_t_promonitor as
select * from perf_t_promonitor t where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'') and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';
