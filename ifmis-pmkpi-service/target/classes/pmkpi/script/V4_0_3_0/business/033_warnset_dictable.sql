begin

delete from bus_t_diccolumn t where t.tablecode='PERF_T_WARNSET' and t.columncode in('STATUS');
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'VD00001', null, '1', 'STATUS', '1', '2021', '87', 'E98B8C38A9601723E0535064A8C04DAE', 'STATUS', 'PERF_T_WARNSET', ' «∑Ò∆Ù”√', 'N', '1', null, 1, 1, null, sysdate);
