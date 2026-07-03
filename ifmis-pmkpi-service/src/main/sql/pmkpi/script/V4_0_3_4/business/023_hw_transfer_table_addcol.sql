 i number;
begin

--1、perf_transfer_project（结转项目表）
select count(1) into i from user_tab_columns where table_name = 'PERF_TRANSFER_PROJECT' and column_name = 'PRO_NAME';
if i = 1 then
 execute immediate 'alter table PERF_TRANSFER_PROJECT modify PRO_NAME VARCHAR2(360)';
end if;

--2、perf_transfer_goal（结转目标表）
select count(1) into i from user_tab_columns where table_name = 'PERF_TRANSFER_GOAL' and column_name = 'FISCAL_YEAR';
if i = 0 then
 execute immediate 'alter table PERF_TRANSFER_GOAL add FISCAL_YEAR VARCHAR2(4)';
end if;
--刷新历史数据
execute immediate 'update perf_transfer_goal set fiscal_year = year where fiscal_year is null';

delete from bus_t_diccolumn where tablecode = 'PERF_TRANSFER_GOAL' and COLUMNCODE = 'FISCAL_YEAR';
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'FISCAL_YEAR', '1', '2016', '87', 'F39B32BD41F814E2E0533315A8C02EEE', 'FISCAL_YEAR', 'PERF_TRANSFER_GOAL', '预算年度', 'S', '4', null, 1, 1, null, sysdate);

execute immediate 'create or replace view v_perf_transfer_goal as
select
    *
from
    perf_transfer_goal
where
    year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
    and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and is_deleted = 2
';

--3、perf_transfer_indicator（结转指标表）
select count(1) into i from user_tab_columns where table_name = 'PERF_TRANSFER_INDICATOR' and column_name = 'KPI_LV3';
if i = 0 then
 execute immediate 'alter table PERF_TRANSFER_INDICATOR add KPI_LV3 VARCHAR2(300)';
end if;
select count(1) into i from user_tab_columns where table_name = 'PERF_TRANSFER_INDICATOR' and column_name = 'FISCAL_YEAR';
if i = 0 then
 execute immediate 'alter table PERF_TRANSFER_INDICATOR add FISCAL_YEAR VARCHAR2(4)';
end if;
--刷新历史数据
execute immediate 'update perf_transfer_indicator set fiscal_year = year where fiscal_year is null';

delete from bus_t_diccolumn where tablecode = 'PERF_TRANSFER_INDICATOR' and COLUMNCODE in('KPI_LV3','FISCAL_YEAR');
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'KPI_LV3', '1', '2016', '87', 'EED47FE19ABF0202E0533315A8C02FDB', 'KPI_LV3', 'PERF_TRANSFER_INDICATOR', '三级指标', 'S', '300', null, 1, 1, null, sysdate);
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'FISCAL_YEAR', '1', '2016', '87', 'F39B32BD41F914E2E0533315A8C02EEE', 'FISCAL_YEAR', 'PERF_TRANSFER_INDICATOR', '预算年度', 'S', '4', null, 1, 1, null, sysdate);

execute immediate 'create or replace view v_perf_transfer_indicator as
select
    *
from
    perf_transfer_indicator
where
    year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
    and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and is_deleted = 2
';
