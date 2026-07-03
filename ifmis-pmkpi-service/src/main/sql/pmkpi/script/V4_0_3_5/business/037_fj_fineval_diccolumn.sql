begin

--财政评价项目确定修改项目-关联项目报错 补充创建时间字段注册信息
delete from bus_t_diccolumn where TABLECODE = 'PERF_T_FINEVARELATION' and COLUMNCODE = 'CREATE_TIME';

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'CREATE_TIME', '1', '2016', '87', sys_guid(), 'CREATE_TIME', 'PERF_T_FINEVARELATION', '创建时间', 'S', '17', null, 1, 1, null,sysdate);