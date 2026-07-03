begin
delete from bus_t_diccolumn where tablecode = 'PERF_T_FINEVALUATION' and columncode = 'AUDITTYPE';
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'AUDITTYPE', '1', '2016', '87', 'BD25F32C9E7777B9EPP3B11FA8C041F0', 'AUDITTYPE', 'PERF_T_FINEVALUATION', '…Û∫À', 'S', '40', null, null, 1, null, sysdate);

