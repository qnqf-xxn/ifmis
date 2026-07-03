begin
delete from bus_t_diccolumn t where t.tablecode='PERF_T_REVIEW' and t.columncode='ISBACK';
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'ISBACK', '1', '2020', '87', 'D882FD707F16757FE0533315A8C02646', 'ISBACK', 'PERF_T_REVIEW', 'ÊÇ·ñÍË»Ø', 'S', '4', null, null, 1, null, sysdate);

