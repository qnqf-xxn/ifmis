begin

--dic
delete from bus_t_diccolumn where tablecode in('PM_PERF_INDICATOR','PM_PERF_INDICATOR_TEMP','PERF_T_ADJUSTINDEX') and columncode ='FRAMEWEIGHT';

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'FRAMEWEIGHT', '1', '2016', '87', sys_guid(), 'FRAMEWEIGHT', 'PM_PERF_INDICATOR', '权重设定值', 'N', '5', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'FRAMEWEIGHT', '1', '2016', '87', sys_guid(), 'FRAMEWEIGHT', 'PM_PERF_INDICATOR_TEMP', '权重设定值', 'N', '5', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'FRAMEWEIGHT', '1', '2016', '87', sys_guid(), 'FRAMEWEIGHT', 'PERF_T_ADJUSTINDEX', '权重设定值', 'N', '5', null, 1, 1, null, sysdate);

delete from bus_t_diccolumn where tablecode in('PM_PERF_INDICATOR','PM_PERF_INDICATOR_TEMP','PERF_T_ADJUSTINDEX') and columncode ='ACTUALWEIGHT';

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'ACTUALWEIGHT', '1', '2016', '87', sys_guid(), 'ACTUALWEIGHT', 'PM_PERF_INDICATOR', '指标分值', 'N', '5', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'ACTUALWEIGHT', '1', '2016', '87', sys_guid(), 'ACTUALWEIGHT', 'PM_PERF_INDICATOR_TEMP', '指标分值', 'N', '5', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'ACTUALWEIGHT', '1', '2016', '87', sys_guid(), 'ACTUALWEIGHT', 'PERF_T_ADJUSTINDEX', '指标分值', 'N', '5', null, 1, 1, null, sysdate);

--ui
delete from p#busfw_t_uicolumn where key in ('/pmkpi/program/report/treeindex','/pmkpi/adjust/report/proedit/index') and columncode ='FRAMEWEIGHT';

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/report/treeindex', 'FRAMEWEIGHT', '权重设定值', 38, 0, 0, 0, null, 0, 1, null, '{unit: 1, dotname: 2, qfw: true}', null, null, null,  0, 'i', '{"viewty":"year"}', null,  '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/adjust/report/proedit/index', 'FRAMEWEIGHT', '权重设定值', 16, 0, 0, 0, null, 0, 1, null, '{unit: 1, dotname: 2, qfw: true}', null, null, null,  0, 'i', null, null,  '87', '2016', null, null);


delete from p#busfw_t_uicolumn where key in ('/pmkpi/program/report/treeindex','/pmkpi/adjust/report/proedit/index') and columncode ='ACTUALWEIGHT';

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/report/treeindex', 'ACTUALWEIGHT', '分值', 39, 0, 1, 0, null, 0, 1, null, '{unit: 1, dotname: 2, qfw: true}', null, null, null,  0, 'i', '{"viewty":"year"}', null,  '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/adjust/report/proedit/index', 'ACTUALWEIGHT', '分值', 17, 0, 1, 0, null, 0, 1, null, '{unit: 1, dotname: 2, qfw: true}', null, null, null,  0, 'i', null, null,  '87', '2016', null, null);
