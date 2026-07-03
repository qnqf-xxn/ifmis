begin
delete from p#busfw_t_uieditform  where key in('/pmkpi/program/prjindex/editindex','/pmkpi/adjust/report/proedit/editindex','/pmkpi/deptperformance/report/editindex','/pmkpi/adjust/report/deptedit/editindex'
,'/pmkpi/proadjust/prjindex/editindex','/pmkpi/deptperformance/report/addperfindex') and columncode = 'KPIVALSOURCE';

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('BA67A26DD9E23875E053B11FA8C0360D', '/pmkpi/program/prjindex/editindex', 'V_PM_PERF_INDICATOR', 'tree', '指标值', 'KPIVALSOURCE', 0, null, 1, null, 4, null, null, 'pmkpi', 1, null, '{format:''#name'',filtersql:''remark=\''#COMPUTESIGN\''''}', 0, 1, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('C0DD64C271EF3784E053B11FA8C0A051', '/pmkpi/adjust/report/proedit/editindex', 'V_PERF_T_ADJUSTINDEX', 'tree', '指标值', 'KPIVALSOURCE', 0, null, 1, null, 4, null, null, 'pmkpi', 1, null, '{format:''#name'',filtersql:''remark=\''#COMPUTESIGN\''''}', 0, 1, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('BA67A26DD9E23875E0PPB11FA8C0360D', '/pmkpi/deptperformance/report/editindex', 'V_PM_PERF_INDICATOR', 'tree', '指标值', 'KPIVALSOURCE', 0, null, 1, null, 4, null, null, 'pmkpi', 1, null, '{format:''#name'',filtersql:''remark=\''#COMPUTESIGN\''''}', 0, 1, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('C0DD64C271EF3784E053B11FA8CPP051', '/pmkpi/adjust/report/deptedit/editindex', 'V_PERF_T_ADJUSTINDEX', 'tree', '指标值', 'KPIVALSOURCE', 0, null, 1, null, 4, null, null, 'pmkpi', 1, null, '{format:''#name'',filtersql:''remark=\''#COMPUTESIGN\''''}', 0, 1, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('BA67A26DD9E23875PP53B11FA8C0360D', '/pmkpi/proadjust/prjindex/editindex', 'PM_PERF_INDICATOR', 'tree', '指标值', 'KPIVALSOURCE', 0, null, 1, null, 4, null, null, 'pmkpi', 1, null, '{format:''#name'',filtersql:''remark=\''#COMPUTESIGN\''''}', 0, 1, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('BA67A26DD9E23875E053B11FA8C0360D', '/pmkpi/deptperformance/report/addperfindex', 'BGT_PERF_INDICATOR', 'tree', '指标值', 'KPIVALSOURCE', 0, null, 1, null, 4, null, null, 'pmkpi', 1, null, '{format:''#name'',filtersql:''remark=\''#COMPUTESIGN\''''}', 0, 1, null);
