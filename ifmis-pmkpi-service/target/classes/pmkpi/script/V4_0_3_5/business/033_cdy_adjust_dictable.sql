begin

delete from bus_t_diccolumn t where t.tablecode='PERF_T_ADJUST' AND T.COLUMNCODE='NAME';
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'NAME', '1', '2022', '87', 'EE1DC304EC93415FE0535064A8C042D5', 'NAME', 'PERF_T_ADJUST', 'Ãû³Æ', 'S', '1000', null, null, 1, null, sysdate);
