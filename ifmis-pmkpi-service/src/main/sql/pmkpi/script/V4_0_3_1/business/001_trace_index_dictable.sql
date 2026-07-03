begin

delete from bus_t_diccolumn where tablecode = 'PERF_T_PROINDEXTRACE' and columncode = 'GOALGUID';
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'GOALGUID', '1', '2021', '87', '75354CEFE6DE6A1579D7BAFF1B6179BF', 'GOALGUID', 'PERF_T_PROINDEXTRACE', '关联目标id(湖北)', 'S', '40', null, 1, 1, null, sysdate);

--表字段注册
delete from bus_t_diccolumn where tablecode = 'PERF_T_PROINDEXTRACE' and columncode = 'COMPDEVIATE';
insert into Bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'COMPDEVIATE', '1', '2016', '87', sys_guid(), 'COMPDEVIATE', 'PERF_T_PROINDEXTRACE', '全年预计完成情况偏离度', 'S', '40', null, 1, 1, null, sysdate);

delete from bus_t_diccolumn where tablecode = 'PERF_T_PROMONITOR' and columncode = 'COMPDEVIATE';
insert into Bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'COMPDEVIATE', '1', '2016', '87', sys_guid(), 'COMPDEVIATE', 'PERF_T_PROMONITOR', '全年预计完成情况偏离度', 'S', '40', null, 1, 1, null, sysdate);

delete from bus_t_diccolumn where tablecode = 'PERF_T_PROMONITOR' and columncode = 'COMPWARN';
insert into Bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'COMPWARN', '1', '2016', '87', sys_guid(), 'COMPWARN', 'PERF_T_PROMONITOR', '全年预计完成情况偏离度预警', 'S', '40', null, 1, 1, null, sysdate);
