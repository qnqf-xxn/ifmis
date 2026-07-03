begin
  
delete from bus_t_diccolumn where tablecode = 'PM_PERF_INDICATOR' and columncode in ('SUMTYPE');
  
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'PERFINDEXSUMTYPE', null, '1', 'SUMTYPE', '1', '2016', '87', sys_guid(), 'SUMTYPE', 'PM_PERF_INDICATOR', '汇总方式', 'N', '1', null, 1, 1, null, sysdate);
  

delete from bus_t_diccolumn where tablecode = 'PM_PERF_INDICATOR_TEMP' and columncode in ('SUMTYPE');
  
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'PERFINDEXSUMTYPE', null, '1', 'SUMTYPE', '1', '2016', '87', sys_guid(), 'SUMTYPE', 'PM_PERF_INDICATOR_TEMP', '汇总方式', 'N', '1', null, 1, 1, null, sysdate);


delete from p#busfw_t_uicolumn where key = '/pmkpi/program/report/treeindex' and columncode in ('SUMTYPE');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/report/treeindex', 'SUMTYPE', '汇总方式', 52, 0, 1, 0, null, 1, 1, null, '#name', null, null, null, 1, 'tree', null, null, '87', '2016', null, null);

