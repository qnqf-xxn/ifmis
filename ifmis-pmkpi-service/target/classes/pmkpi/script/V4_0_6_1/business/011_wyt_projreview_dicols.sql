begin
  --事前绩效评估页面，业务处室字段注册数据源
delete from bus_t_diccolumn where tablecode ='PERF_T_PROJREVIEW' and columncode ='FININTORGGUID';
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, '099003', null, '1', 'FININTORGGUID', '1', null, null, 'B9BA41AEEA100621E053B11FA8C03800', 'FININTORGGUID', 'PERF_T_PROJREVIEW', '财政处室', 'S', '32', null, 1, 1, null, sysdate);
