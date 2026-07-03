begin
 -- 项目类型字段
delete from bus_t_diccolumn where tablecode ='BAS_PERF_INDICATOR' and columncode='PRO_TYPE';
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'INDEXCOMFUNCHuBei', null, '0', 'PRO_TYPE', '1', '2016', '87', 'DFA9EA86A97047A5E0533315A8C02B84', 'PRO_TYPE', 'BAS_PERF_INDICATOR', '项目类型', 'S', '40', null, 1, 1, null, sysdate);
 --项目名称字段
delete from bus_t_diccolumn where tablecode ='BAS_PERF_INDICATOR' and columncode='PRO_NAME';
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'PRO_NAME', '1', '2021', '87', 'C086DF3C477B339CE053B11FA8C0862A', 'PRO_NAME', 'BAS_PERF_INDICATOR', '项目名称', 'S', '500', null, 1, 0, null, sysdate);

