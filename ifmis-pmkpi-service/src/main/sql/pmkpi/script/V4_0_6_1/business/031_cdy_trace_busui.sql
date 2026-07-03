begin
  
delete from bus_t_diccolumn t where t.tablecode='PERF_T_PROINDEXTRACE' and t.columncode in('CODE');
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'CODE', '1', '2023', '87', 'FB7C2EF7328A49E0E0533315A8C09CED', 'CODE', 'PERF_T_PROINDEXTRACE', '±àÂë', 'S', '40', null, 1, 1, null, sysdate);
