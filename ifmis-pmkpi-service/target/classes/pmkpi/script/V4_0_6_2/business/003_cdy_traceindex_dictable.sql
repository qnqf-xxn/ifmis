begin
  
delete from bus_t_diccolumn t where t.columncode='CREATE_TIME' and t.tablecode='PERF_T_PROINDEXTRACE';
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'CREATE_TIME', '1', '2020', '87', 'B785109A5B9E0EC1E0530100007FD5F2', 'CREATE_TIME', 'PERF_T_PROINDEXTRACE', '创建时间', 'S', '17', null, 1, 1, null, sysdate);
