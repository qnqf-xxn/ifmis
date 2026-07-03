begin
  
delete from bus_t_diccolumn where tablecode = 'PM_PERF_INDICATOR' and columncode in ('ISALLOWEDIT','ONLYSELF');
  
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'VD00001', null, '1', 'ISALLOWEDIT', '1', '2016', '87', sys_guid(), 'ISALLOWEDIT', 'PM_PERF_INDICATOR', '是否允许编辑', 'N', '1', null, 1, 1, null, sysdate);
  
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'VD00001', null, '1', 'ONLYSELF', '1', '2016', '87', sys_guid(), 'ONLYSELF', 'PM_PERF_INDICATOR', '仅本级适用', 'N', '1', null, 1, 1, null, sysdate);

delete from bus_t_diccolumn where tablecode = 'PM_PERF_INDICATOR_TEMP' and columncode in ('ISALLOWEDIT','ONLYSELF');
  
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'VD00001', null, '1', 'ISALLOWEDIT', '1', '2016', '87', sys_guid(), 'ISALLOWEDIT', 'PM_PERF_INDICATOR_TEMP', '是否允许编辑', 'N', '1', null, 1, 1, null, sysdate);
  
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'VD00001', null, '1', 'ONLYSELF', '1', '2016', '87', sys_guid(), 'ONLYSELF', 'PM_PERF_INDICATOR_TEMP', '仅本级适用', 'N', '1', null, 1, 1, null, sysdate);



delete from p#busfw_t_uicolumn where key = '/pmkpi/program/report/treeindex' and columncode in ('ISALLOWEDIT','ONLYSELF');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/report/treeindex', 'ISALLOWEDIT', '是否允许编辑', 51, 0, 1, 0, null, 1, 1, null, '#name', null, null, null, 1, 'tree', null, null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/report/treeindex', 'ONLYSELF', '仅本级适用', 52, 0, 1, 0, null, 1, 1, null, '#name', null, null, null, 1, 'tree', null, null, '87', '2016', null, null);



delete from p#busfw_t_uifunction where key = '/pmkpi/program/report/treeindex' and CODE ='copytotalindexnoval';

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/program/report/treeindex', '复制总体绩效目标（不带指标值）', 0, 9, 'keepicon', 'Ext.lt.pmkpi.copytotalindex', null, '复制总体绩效目标（不带指标值）', 'pmkpi', 'copytotalindexnoval', null, null, '87', '2016');
