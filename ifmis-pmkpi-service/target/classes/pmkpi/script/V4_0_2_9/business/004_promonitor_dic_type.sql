begin	
	
delete from bus_t_diccolumn where tablecode = 'PERF_T_PROMONITOR' and columncode = 'TYPE';
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'TYPE', '1', '2020', '87', 'CFB0962F965E4925E0533315A8C01D2D', 'TYPE', 'PERF_T_PROMONITOR', '监控项目类型', 'S', '100', null, 1, 1, null, sysdate);
