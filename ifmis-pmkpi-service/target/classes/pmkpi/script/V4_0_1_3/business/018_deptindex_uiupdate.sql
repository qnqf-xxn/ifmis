begin
delete from bus_t_diccolumn where COLUMNCODE = 'KPI_REMARK' and TABLECODE='PM_PERF_INDICATOR_TEMP';
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values ('BE10034', null, null, '0', 'KPI_REMARK', '1', null, null, 'AE7A5056883C2B55E05306PPP8C08935', 'KPI_REMARK', 'PM_PERF_INDICATOR_TEMP', '备注', 'S', '2000', null, 1, null, null, sysdate);

update bus_t_diccolumn t set t.name = '参考指标值' where t.tablecode = 'PM_PERF_INDICATOR' and t.columncode = 'VALUE_DESC';
