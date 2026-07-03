begin
delete from bus_t_diccolumn where tablecode = 'PERF_T_EVALUATETEMP' and columncode = 'ISTOTAL';
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'ISLEAF', null, '1', 'ISTOTAL', '1', '2016', '87', 'BCAC8374PPP4A4B3E053B11FA8C0F8B7', 'ISTOTAL', 'PERF_T_EVALUATETEMP', '是否合计', 'S', '3', null, 1, 1, null, sysdate);

delete from p#busfw_t_uicolumn where key = '/pmkpi/setting/tempdataset' and columncode = 'ISTOTAL';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B84E0D56D6127E46E07301PP077F8888', '/pmkpi/setting/tempdataset', 'ISTOTAL', '是否合计', 28, 1, 1, 0, null, 0, null, null, '#name', null, null, 100, 1, 'tree', null, null);

