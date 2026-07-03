begin

delete from bus_t_diccolumn t where t.tablecode='PERF_T_FINEVALUATION' and t.columncode ='NAME';
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'NAME', '1', '2016', '87', 'BD25F32C9E8C77B9E053B11FA8C041F0', 'NAME', 'PERF_T_FINEVALUATION', 'ÏîÄ¿Ãû³Æ', 'S', '500', null, null, 1, null, sysdate);

