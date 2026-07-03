begin
  
delete from bus_t_diccolumn t where t.tablecode='PM_PERF_INDICATOR' and t.columncode='INDSOURCE';
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'PERFINDSOURCE', null, '1', 'INDSOURCE', '1', '2026', '87', '4A200882B64D7284E063030011AC2921', 'INDSOURCE', 'PM_PERF_INDICATOR', '指标来源', 'S', '40', null, 1, 1, null, sysdate);

delete from fasp_t_dicdssource t where t.elementcode='PERFINDSOURCE';
insert into fasp_t_dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('PERFINDSOURCE', 'PERFINDSOURCE', 'PERFINDSOURCE', '绩效指标来源', '1', null, null, null, '2016', '00', null, null, '1', '2', 'select t.* from perf_t_datasource t where t.elementcode=''INDSOURCE''', null, 1, 'pmkpi');

delete from perf_t_datasource t where t.elementcode='INDSOURCE';
insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('1', '1', '新增指标', null, '0', 1, 1, 1, 'INDSOURCE', 1, '20260204', '20260204', 2026, '87');

insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('2', '2', '指标库引用', null, '0', 1, 1, 2, 'INDSOURCE', 1, '20260204', '20260204', 2026, '87');

delete from perf_t_systemset t where t.paramcode='IS_NINGXIA';
insert into perf_t_systemset (GUID, PARAMCODE, PARAMNAME, PARAMVALUE, REMARK, APPID, ORDERNUM, YEAR, PROVINCE, STATUS)
values ('4A5C9B97D5270804E063030011AC5B82', 'IS_NINGXIA', '是否宁夏', '2', '1是 2否', 'pmkpi', 66, 2016, '87', 1);

delete from p#busfw_t_uicolumn t where t.key in('/pmkpi/program/report/treeindex') and t.COLUMNCODE='INDSOURCE';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/report/treeindex', 'INDSOURCE', '指标来源', 2, 0, 0, 0, null, 0, 1, null, '#name', null, null, null, 1, 'tree', null, null, '87', '2016', null, null);

delete from p#busfw_t_uicolumn t where t.key in('/pmkpi/program/prjindex/recomindex') and t.COLUMNCODE='PRO_NAME';
insert into p#busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/prjindex/recomindex', 'PRO_NAME', '项目名称', 14, 0, 0, 0, null, null, 1, null, null, null, null, null, 0, 's', '{lefttype:''index''}', null, '87', '2016', null, null);

delete from p#busfw_t_uicolumn t where t.key in('/pmkpi/program/prjindex/lastyear') and t.columncode='INDSOURCE';
insert into p#busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/prjindex/lastyear', 'INDSOURCE', '指标来源', 1, 0, 0, 0, null, 0, 1, null, '#name', null, null, null, 1, 'tree', null, null, '87', '2016', null, null);

delete from p#busfw_t_uiqueryform t where t.key in('/pmkpi/program/prjindex/recomindex') and t.COLUMNCODE='PRO_NAME';
insert into p#busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, REQUIREMENT, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/prjindex/recomindex', 'PRO_NAME', '项目名称', 3, 0, 's', null, 0, 0, 'pmkpi', 'V_BAS_PERF_INDICATOR', null, null, '87', '2016', null, null, null);
