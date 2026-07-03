begin

delete from bus_t_diccolumn where tablecode = 'PERF_T_SELFPROFUND' and columncode = 'DEVIATIONANALYSIS';
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'DEVIATIONANALYSIS', '1', '2020', '87', '9FA388095DE73896677B231D3E366AB1', 'DEVIATIONANALYSIS', 'PERF_T_SELFPROFUND', '偏差原因分析', 'S', '200', null, 1, 1, null, sysdate);


delete from p#busfw_t_uicolumn where key = '/pmkpi/perfself/apply/edit/bdgpay' and columncode = 'DEVIATIONANALYSIS';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/perfself/apply/edit/bdgpay', 'DEVIATIONANALYSIS', '偏差原因', 14, 0, 1, null, null, 0, 1, null, null, null, null, null, 0, 's', '{}', null, null, null, '2016','87');
