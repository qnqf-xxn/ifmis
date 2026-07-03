begin

delete from bus_t_diccolumn t where t.tablecode='PERF_T_PROINDEXTRACE' and t.dbcolumncode='METERUNIT';
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'METERUNIT', '1', '2020', '87', 'B785109A5BAE0EC1E0530100007FD5F2', 'METERUNIT', 'PERF_T_PROINDEXTRACE', '计量单位', 'S', '200', null, 1, 1, null, sysdate);
