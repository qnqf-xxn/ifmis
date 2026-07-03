begin

delete from bus_t_diccolumn t where t.tablecode='PERF_T_ADJUSTGOAL' and t.columncode='ADJUSTNDGOAL';
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'ADJUSTNDGOAL', '1', '2016', '87', 'B9C975E5A874F59EE053B11FA8C05A36', 'ADJUSTNDGOAL', 'PERF_T_ADJUSTGOAL', '中期目标', 'S', '2000', null, 1, 1, null, sysdate);
