begin

delete from bus_t_diccolumn t where t.tablecode='PERF_T_FINEVALUATION' and t.dbcolumncode='UPDATETIME';
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'UPDATETIME', '1', '2016', '87', 'EB8299ED15CD13B5E0533315A8C0D8F6', 'UPDATETIME', 'PERF_T_FINEVALUATION', 'ÐÞ¸ÄÊ±¼ä', 'S', '17', null, null, 1, null, sysdate);
