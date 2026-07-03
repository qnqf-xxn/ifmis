begin

delete from bus_t_diccolumn t where t.tablecode='PERF_T_WORKEVALUATETASK' and t.columncode='TASKYEAR';
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'TASKYEAR', '1', '2020', '87', 'C30F1E265265FDF7E053B11FA8C0FA88', 'TASKYEAR', 'PERF_T_WORKEVALUATETASK', '¿¼ºËÄê¶È', 'S', '4', null, 1, 1, null, sysdate);
