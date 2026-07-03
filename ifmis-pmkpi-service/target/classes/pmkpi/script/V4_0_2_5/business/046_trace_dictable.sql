begin

delete from bus_t_diccolumn t where t.tablecode='PERF_T_PROTRACEANALYSIS' and t.columncode='MEASURES';
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'MEASURES', '1', '2020', '87', 'B775BB4903F2289BE0530100007F7783', 'MEASURES', 'PERF_T_PROTRACEANALYSIS', '绩效目标执行情况', 'S', '4000', null, 1, 0, null, sysdate);

delete from bus_t_diccolumn t where t.tablecode='PERF_V_PROMONITOR' and t.dbcolumncode='PRO_NAME';