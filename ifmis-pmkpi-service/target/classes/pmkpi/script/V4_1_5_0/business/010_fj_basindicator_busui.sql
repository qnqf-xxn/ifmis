begin
  
delete from bus_t_diccolumn where tablecode = 'BAS_PERF_INDICATOR' and columncode in ('INDEXSTANDARDSVAL1', 'INDEXSTANDARDSVAL2', 'INDEXSTANDARDSVAL3', 'INDEXSTANDARDSVAL4', 'INDEXSTANDARDSVAL5');
  
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'INDEXSTANDARDSVAL1', '1', '2016', '87', sys_guid(), 'INDEXSTANDARDSVAL1', 'BAS_PERF_INDICATOR', '计划标准指标值', 'S', '400', null, 1, 1, null, sysdate);
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'INDEXSTANDARDSVAL2', '1', '2016', '87', sys_guid(), 'INDEXSTANDARDSVAL2', 'BAS_PERF_INDICATOR', '历史标准指标值', 'S', '400', null, 1, 1, null, sysdate);
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'INDEXSTANDARDSVAL3', '1', '2016', '87', sys_guid(), 'INDEXSTANDARDSVAL3', 'BAS_PERF_INDICATOR', '行业标准指标值', 'S', '400', null, 1, 1, null, sysdate);
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'INDEXSTANDARDSVAL4', '1', '2016', '87', sys_guid(), 'INDEXSTANDARDSVAL4', 'BAS_PERF_INDICATOR', '国际标准指标值', 'S', '400', null, 1, 1, null, sysdate);
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'INDEXSTANDARDSVAL5', '1', '2016', '87', sys_guid(), 'INDEXSTANDARDSVAL5', 'BAS_PERF_INDICATOR', '其他标准指标值', 'S', '400', null, 1, 1, null, sysdate);


delete from p#busfw_t_uicolumn where key = '/pmkpi/indexlib/deptlist' and columncode in ('INDEXSTANDARDSVAL1', 'INDEXSTANDARDSVAL2', 'INDEXSTANDARDSVAL3', 'INDEXSTANDARDSVAL4', 'INDEXSTANDARDSVAL5');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/indexlib/deptlist', 'INDEXSTANDARDSVAL1', '计划标准指标值', 31, 0, 0, null, null, null, 1, null, null, null, null, null, 0, 's', '{}', null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/indexlib/deptlist', 'INDEXSTANDARDSVAL2', '历史标准指标值', 32, 0, 0, null, null, null, 1, null, null, null, null, null, 0, 's', '{}', null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/indexlib/deptlist', 'INDEXSTANDARDSVAL3', '行业标准指标值', 33, 0, 0, null, null, null, 1, null, null, null, null, null, 0, 's', '{}', null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/indexlib/deptlist', 'INDEXSTANDARDSVAL4', '国际标准指标值', 34, 0, 0, null, null, null, 1, null, null, null, null, null, 0, 's', '{}', null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/indexlib/deptlist', 'INDEXSTANDARDSVAL5', '其他标准指标值', 35, 0, 0, null, null, null, 1, null, null, null, null, null, 0, 's', '{}', null, '87', '2016', null, null);


delete from p#busfw_t_uieditform where key = '/pmkpi/indexlib/edit' and columncode in ('INDEXSTANDARDSVAL1', 'INDEXSTANDARDSVAL2', 'INDEXSTANDARDSVAL3', 'INDEXSTANDARDSVAL4', 'INDEXSTANDARDSVAL5');

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR, HEAD, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/indexlib/edit', 'V_BAS_PERF_INDICATOR', 's', '计划标准指标值', 'INDEXSTANDARDSVAL1', 0, null, 0, null, 61, null, null, 'pmkpi', 1, null, '{}', null, null, null, '87', '2016', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR, HEAD, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/indexlib/edit', 'V_BAS_PERF_INDICATOR', 's', '历史标准指标值', 'INDEXSTANDARDSVAL2', 0, null, 0, null, 62, null, null, 'pmkpi', 1, null, '{}', null, null, null, '87', '2016', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR, HEAD, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/indexlib/edit', 'V_BAS_PERF_INDICATOR', 's', '行业标准指标值', 'INDEXSTANDARDSVAL3', 0, null, 0, null, 63, null, null, 'pmkpi', 1, null, '{}', null, null, null, '87', '2016', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR, HEAD, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/indexlib/edit', 'V_BAS_PERF_INDICATOR', 's', '国际标准指标值', 'INDEXSTANDARDSVAL4', 0, null, 0, null, 64, null, null, 'pmkpi', 1, null, '{}', null, null, null, '87', '2016', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR, HEAD, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/indexlib/edit', 'V_BAS_PERF_INDICATOR', 's', '其他标准指标值', 'INDEXSTANDARDSVAL5', 0, null, 0, null, 65, null, null, 'pmkpi', 1, null, '{}', null, null, null, '87', '2016', null, null, null);


delete from p#busfw_t_uicolumn where key = '/pmkpi/indexlib/list' and columncode in ('INDEXSTANDARDSVAL1', 'INDEXSTANDARDSVAL2', 'INDEXSTANDARDSVAL3', 'INDEXSTANDARDSVAL4', 'INDEXSTANDARDSVAL5');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/indexlib/list', 'INDEXSTANDARDSVAL1', '计划标准指标值', 31, 0, 0, null, null, null, 1, null, null, null, null, null, 0, 's', '{}', null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/indexlib/list', 'INDEXSTANDARDSVAL2', '历史标准指标值', 32, 0, 0, null, null, null, 1, null, null, null, null, null, 0, 's', '{}', null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/indexlib/list', 'INDEXSTANDARDSVAL3', '行业标准指标值', 33, 0, 0, null, null, null, 1, null, null, null, null, null, 0, 's', '{}', null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/indexlib/list', 'INDEXSTANDARDSVAL4', '国际标准指标值', 34, 0, 0, null, null, null, 1, null, null, null, null, null, 0, 's', '{}', null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/indexlib/list', 'INDEXSTANDARDSVAL5', '其他标准指标值', 35, 0, 0, null, null, null, 1, null, null, null, null, null, 0, 's', '{}', null, '87', '2016', null, null);


delete from p#busfw_t_uieditform where key = '/pmkpi/indexlib/commedit' and columncode in ('INDEXSTANDARDSVAL1', 'INDEXSTANDARDSVAL2', 'INDEXSTANDARDSVAL3', 'INDEXSTANDARDSVAL4', 'INDEXSTANDARDSVAL5');

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR, HEAD, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/indexlib/commedit', 'V_BAS_PERF_INDICATOR', 's', '计划标准指标值', 'INDEXSTANDARDSVAL1', 0, null, 0, null, 61, null, null, 'pmkpi', 1, null, '{}', null, null, null, '87', '2016', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR, HEAD, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/indexlib/commedit', 'V_BAS_PERF_INDICATOR', 's', '历史标准指标值', 'INDEXSTANDARDSVAL2', 0, null, 0, null, 62, null, null, 'pmkpi', 1, null, '{}', null, null, null, '87', '2016', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR, HEAD, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/indexlib/commedit', 'V_BAS_PERF_INDICATOR', 's', '行业标准指标值', 'INDEXSTANDARDSVAL3', 0, null, 0, null, 63, null, null, 'pmkpi', 1, null, '{}', null, null, null, '87', '2016', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR, HEAD, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/indexlib/commedit', 'V_BAS_PERF_INDICATOR', 's', '国际标准指标值', 'INDEXSTANDARDSVAL4', 0, null, 0, null, 64, null, null, 'pmkpi', 1, null, '{}', null, null, null, '87', '2016', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR, HEAD, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/indexlib/commedit', 'V_BAS_PERF_INDICATOR', 's', '其他标准指标值', 'INDEXSTANDARDSVAL5', 0, null, 0, null, 65, null, null, 'pmkpi', 1, null, '{}', null, null, null, '87', '2016', null, null, null);



delete from p#busfw_t_uicolumn where key = '/pmkpi/program/prjindex/recomindex' and columncode in ('INDEXSTANDARDSVAL1', 'INDEXSTANDARDSVAL2', 'INDEXSTANDARDSVAL3', 'INDEXSTANDARDSVAL4', 'INDEXSTANDARDSVAL5');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/prjindex/recomindex', 'INDEXSTANDARDSVAL1', '计划标准指标值', 41, 0, 0, null, null, null, 1, null, null, null, null, null, 0, 's', '{}', null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/prjindex/recomindex', 'INDEXSTANDARDSVAL2', '历史标准指标值', 42, 0, 0, null, null, null, 1, null, null, null, null, null, 0, 's', '{}', null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/prjindex/recomindex', 'INDEXSTANDARDSVAL3', '行业标准指标值', 43, 0, 0, null, null, null, 1, null, null, null, null, null, 0, 's', '{}', null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/prjindex/recomindex', 'INDEXSTANDARDSVAL4', '国际标准指标值', 44, 0, 0, null, null, null, 1, null, null, null, null, null, 0, 's', '{}', null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/prjindex/recomindex', 'INDEXSTANDARDSVAL5', '其他标准指标值', 45, 0, 0, null, null, null, 1, null, null, null, null, null, 0, 's', '{}', null, '87', '2016', null, null);




