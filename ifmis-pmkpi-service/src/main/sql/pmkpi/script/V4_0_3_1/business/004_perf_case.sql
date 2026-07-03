begin
  --案例表字段注册
delete from bus_t_diccolumn t where t.tablecode='PERF_T_CASE' and t.columncode in('ADJUSTGUID');
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'ADJUSTGUID', '1', '2016', '87', 'E2A5CA708BFC131DE0533315A8C01809', 'ADJUSTGUID', 'PERF_T_CASE', '调整前guid', 'S', '40', null, 1, 0, null, sysdate);
