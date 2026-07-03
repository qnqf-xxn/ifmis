    i number;
begin

--1、监控分析
--添加字段  TREATMENT_MEASURE(处理措施)
select count(*) into i from user_tab_columns t where t.table_name ='PERF_T_PROTRACEANALYSIS' and t.column_name='TREATMENT_MEASURE';
if i=1 then
 execute immediate 'alter table PERF_T_PROTRACEANALYSIS drop(TREATMENT_MEASURE)';
end if;

--添加字段  APPRESULT_DETAILS(处理措施和结果运用情况)
select count(*) into i from user_tab_columns t where t.table_name ='PERF_T_PROTRACEANALYSIS' and t.column_name='APPRESULT_DETAILS';
if i=0 then
 execute immediate 'alter table PERF_T_PROTRACEANALYSIS add(APPRESULT_DETAILS VARCHAR2(4000))';
end if;

--重构试图
execute immediate'create or replace view v_perf_t_protraceanalysis as
select
    *
from
    perf_t_protraceanalysis
where
    year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
    and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')
';

--dic
delete from bus_t_diccolumn where tablecode = 'PERF_T_PROTRACEANALYSIS' and columncode in ('TREATMENT_MEASURE','APPRESULT_DETAILS');
-- insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
-- values (null, null, null, '1', 'TREATMENT_MEASURE', '1', '2016', '87', 'EED47FE19AB00202E0533315A8C02FDB', 'TREATMENT_MEASURE', 'PERF_T_PROTRACEANALYSIS', '处理措施', 'S', '4000', null, 1, 1, null, sysdate);
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'APPRESULT_DETAILS', '1', '2016', '87', 'EED47FE19AB30202E0533315A8C02FDB', 'APPRESULT_DETAILS', 'PERF_T_PROTRACEANALYSIS', '处理措施和结果运用情况', 'S', '4000', null, 1, 1, null, sysdate);

