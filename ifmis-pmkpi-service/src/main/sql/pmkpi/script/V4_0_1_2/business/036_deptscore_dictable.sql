begin

delete from bus_t_diccolumn t where t.tablecode in('PERF_T_DEPTSCORE') and t.DBCOLUMNCODE='TYPE';
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'TYPE', '1', '2016', '87', 'C36011C2EBF944F0E053B11FA8C05A6E', 'TYPE', 'PERF_T_DEPTSCORE', '¿‡–Õ', 'S', '32', null, null, 1, null, sysdate);
