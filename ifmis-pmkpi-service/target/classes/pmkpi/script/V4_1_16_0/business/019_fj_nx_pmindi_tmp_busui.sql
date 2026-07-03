begin

--dic
delete from bus_t_diccolumn where tablecode ='PM_PERF_INDICATOR_TEMP' and columncode ='INDSOURCE';

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'PERFINDSOURCE', null, '1', 'INDSOURCE', '1', '2016', '87', sys_guid(), 'INDSOURCE', 'PM_PERF_INDICATOR_TEMP', '指标来源', 'S', '40', null, 1, 1, null, sysdate);

