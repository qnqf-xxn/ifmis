begin
--部门评价 表字段注册添加pro_code字段
delete from bus_t_diccolumn where tablecode ='PERF_T_DEPTEVALUATION' and columncode = 'PRO_CODE';
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'PRO_CODE', '1', '2016', '87', 'BDPP032C9E8777B9E053B11FA8C041F0', 'PRO_CODE', 'PERF_T_DEPTEVALUATION', '项目编码', 'S', '40', null, null, 1, null,sysdate);

