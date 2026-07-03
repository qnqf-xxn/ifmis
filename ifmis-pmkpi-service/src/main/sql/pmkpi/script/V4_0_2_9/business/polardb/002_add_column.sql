begin

delete from bus_t_diccolumn where tablecode = 'BGT_PERF_INDICATOR' and DBCOLUMNCODE = 'KPI_VAL2023';
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'KPI_VAL2023', '1', '2016', '87', 'DC6CDA3FCA8B298QW0533315A8C0D61D', 'KPI_VAL2023', 'BGT_PERF_INDICATOR', '2023指标值', 'S', '1000', null, 1, 1, null, sysdate);

delete from p#busfw_t_uicolumn where  key = '/pmkpi/deptZJformance/report/editindex' AND COLUMNCODE = 'KPI_VAL2023';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,province,year)
values (sys_guid(), '/pmkpi/deptZJformance/report/editindex', 'KPI_VAL2023', '2023指标值', 15, 0, 1, null, null, 1, null, null, null, null, null, 150, 0, 's', '{}', null,'87','2016');


delete from bus_t_diccolumn where tablecode = 'PERF_BGT_LINKBGTINFO' and DBCOLUMNCODE = 'KPI_VAL2023';
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'KPI_VAL2023', '1', '2016', '87', 'DC6CDA3FCA8B298QW0A33315A8C0D61D', 'KPI_VAL2023', 'PERF_BGT_LINKBGTINFO', '2023指标值', 'S', '1000', null, 1, 1, null, sysdate);

delete from p#busfw_t_uicolumn where  key = '/pmkpi/deptZJformance/report/editbudget' AND COLUMNCODE = 'KPI_VAL2023';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,province,year)
values (sys_guid(), '/pmkpi/deptZJformance/report/editbudget', 'KPI_VAL2023', '2023年指标值', 6, 0, 0, null, null, 1, null, null, null, null, null, 150, 0, 's', '{}', null,'87','2016');
