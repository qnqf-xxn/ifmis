begin
  
delete from bus_t_diccolumn t where t.tablecode='PERF_T_SYSTEMSET' and t.columncode in('STATUS');
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'VD00001', null, '1', 'STATUS', '1', '2021', '87', '91D5F89FC0C24435BB00738F884B1276', 'STATUS', 'PERF_T_SYSTEMSET', ' «∑Ò∆Ù”√', 'N', '1', null, 1, 1, null, sysdate);
