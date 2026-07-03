begin
  
delete from bus_t_diccolumn where tablecode = 'PERF_T_ADJUSTINDEX' and columncode in ('ISFROMPARENT','ISAPPLY');
  
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'ISFROMPARENT', '1', '2016', '87', sys_guid(), 'ISFROMPARENT', 'PERF_T_ADJUSTINDEX', '是否为继承一级项目指标', 'N', '1', null, 1, 1, null, sysdate);
  
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'VD00001', null, '1', 'ISAPPLY', '1', '2016', '87', sys_guid(), 'ISAPPLY', 'PERF_T_ADJUSTINDEX', '是否适用', 'N', '1', null, 1, 1, null, sysdate);


delete from p#busfw_t_uicolumn where key = '/pmkpi/adjust/report/proedit/index' and columncode ='ISAPPLY';

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/adjust/report/proedit/index', 'ISAPPLY', '是否适用', 50, 0, 1, 0, null, 1, 1, null, '#name', null, null, null, 1, 'tree', null, null, '87', '2016', null, null);



