begin
  
delete from p#busfw_t_uitable t where key in('/pmkpi/intoindexlib/index');
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/intoindexlib/index', 'V_BAS_PERF_INDICATOR', 100, 0, 0, '', '', 'pmkpi', '{}', '87', '2016');

delete from p#busfw_t_uicolumn t where key in('/pmkpi/intoindexlib/index');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/intoindexlib/index', 'PERF_IND_CODE', '指标编码', 1, 0, 0, null, '', null, 1, '', '', '', null, null, 0, 's', '{}', '', '87', '2016', null, '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/intoindexlib/index', 'AGENCY_CODE', '预算部门', 2, 0, 0, null, '', null, 1, '', '#code-#name', '', null, null, 1, 'tree', '{}', '', '87', '2016', null, '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/intoindexlib/index', 'INDUSTRYCATEGORY', '类别', 4, 1, 1, null, '', 1, 1, '', '#code-#name', '', null, 170, 1, 'tree', '{bustype:"program"}', '', '87', '2016', null, '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/intoindexlib/index', 'FINDEX', '一级指标', 11, 1, 0, null, '', null, 1, '', '#name', '', null, 150, 1, 'tree', '{}', '', '87', '2016', null, '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/intoindexlib/index', 'SINDEX', '二级指标', 12, 1, 0, null, '', null, 1, '', '#name', '', null, 150, 1, 'tree', '{}', '', '87', '2016', null, '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/intoindexlib/index', 'NAME', '指标名称', 13, 1, 0, 0, '', null, 1, '[''三级指标'']', '', '', null, 150, 0, 's', '{}', '', '87', '2016', null, '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/intoindexlib/index', 'COMPUTESIGN', '计算符号', 14, 1, 0, null, '', null, 1, '[''三级指标'']', '#name', '', null, 150, 1, 'tree', '{}', '', '87', '2016', null, '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/intoindexlib/index', 'INDEXVAL', '参考值', 15, 1, 1, null, '', null, 1, '[''三级指标'']', '', '', null, 150, 0, 's', '{}', '', '87', '2016', null, '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/intoindexlib/index', 'METERUNIT', '计量单位', 16, 1, 0, null, '', null, 1, '[''三级指标'']', '', '', null, 150, 0, 's', '{}', '', '87', '2016', null, '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/intoindexlib/index', 'FUNDUSE', '资金用途', 17, 1, 1, null, '', 1, 1, '', '', '', null, 150, 0, 's', '{}', '', '87', '2016', null, '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/intoindexlib/index', 'INDEXSTANDARDS', '绩效标准', 19, 1, 1, null, '', null, 1, '', '#name', '', null, 150, 1, 'tree', '{}', '', '87', '2016', null, '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/intoindexlib/index', 'KEYWORD', '关键词', 20, 1, 1, null, '', null, 1, '', '', '', null, 150, 0, 's', '{}', '', '87', '2016', null, '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/intoindexlib/index', 'VALUE_DESC', '指标值说明', 21, 1, 1, null, '', 1, 1, '', '', '', null, 200, 0, 's', '{}', '', '87', '2016', null, '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/intoindexlib/index', 'EXPLAIN', '指标解释', 22, 1, 1, null, '', null, 1, '', '', '', null, 200, 0, 's', '{}', '', '87', '2016', null, '');

delete from p#busfw_t_uifunction t where key in('/pmkpi/program/report/treeindex','/pmkpi/deptperformance/report/perfindex') and t.code in('intoindexlib');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/deptperformance/report/perfindex', '纳入指标库', 0, 20, 'keepicon', 'deptindex.intoindexlib', null, '纳入指标库', 'pmkpi', 'intoindexlib', '', '{workflow:"2F62B0E1A972408B8330D3653F836522"}', '87', '2016', null, '');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/report/treeindex', '纳入指标库', 0, 20, 'keepicon', 'prjtreeindex.intoindexlib', null, '纳入指标库', 'pmkpi', 'intoindexlib', '', '{workflow:"2F62B0E1A972408B8330D3653F836522"}', '87', '2016', null, '');

delete from p#busfw_t_uifunction t where key in('/pmkpi/intoindexlib/index');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/intoindexlib/index', '纳入指标库', 1, 1, 'Nofinishicon', 'intoindexlibcommon.initindex', null, '纳入指标库', 'pmkpi', '', '', '{}', '87', '2016', null, '');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/intoindexlib/index', '取消', 1, 2, 'Nofinishicon', 'Ext.lt.ui.closeModalWindow', null, '取消', 'pmkpi', '', '', '', '87', '2016', null, '');

