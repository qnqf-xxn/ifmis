begin
  
delete from bus_t_diccolumn where tablecode = 'PM_PERF_INDICATOR' and columncode in ('ISFROMPARENT','ISAPPLY');
  
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'ISFROMPARENT', '1', '2016', '87', sys_guid(), 'ISFROMPARENT', 'PM_PERF_INDICATOR', '是否为继承一级项目指标', 'N', '1', null, 1, 1, null, sysdate);
  
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'VD00001', null, '1', 'ISAPPLY', '1', '2016', '87', sys_guid(), 'ISAPPLY', 'PM_PERF_INDICATOR', '是否适用', 'N', '1', null, 1, 1, null, sysdate);

delete from bus_t_diccolumn where tablecode = 'PM_PERF_INDICATOR_TEMP' and columncode in ('ISFROMPARENT','ISAPPLY');
  
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'ISFROMPARENT', '1', '2016', '87', sys_guid(), 'ISFROMPARENT', 'PM_PERF_INDICATOR_TEMP', '是否为继承一级项目指标', 'N', '1', null, 1, 1, null, sysdate);
  
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'VD00001', null, '1', 'ISAPPLY', '1', '2016', '87', sys_guid(), 'ISAPPLY', 'PM_PERF_INDICATOR_TEMP', '是否适用', 'N', '1', null, 1, 1, null, sysdate);



delete from p#busfw_t_uicolumn where key = '/pmkpi/program/report/treeindex' and columncode ='ISAPPLY';

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/report/treeindex', 'ISAPPLY', '是否适用', 50, 0, 1, 0, null, 1, 1, null, '#name', null, null, null, 1, 'tree', null, null, '87', '2016', null, null);


delete from p#busfw_t_uifunction where key = '/pmkpi/program/report/treeindex' and code ='getparentproindex';

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/report/treeindex', '获取最新一级项目指标', 0, 14, 'keepicon', 'prjtreeindex.getparentproindex', null, '获取最新一级项目指标', 'pmkpi', 'getparentproindex', null, null, '87', '2016', null, null);


