begin

--表字段注册
delete from bus_t_diccolumn t where t.tablecode = 'PERF_T_ADJUSTINDEX' and t.columncode = 'VALUE_REMARK';
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'VALUE_REMARK', '1', '2021', '87', 'PPPPBB8D6936B4CCE0PPPA05PPPPadw1', 'VALUE_REMARK', 'PERF_T_ADJUSTINDEX', '指标值说明', 'S', '2000', null, 1, 0, null, sysdate);


