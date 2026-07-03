begin
--编辑区
delete from p#busfw_t_uieditform where key ='/pmkpi/deptperformance/report/editindex' and columncode = 'KPIVALSOURCE';
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('BA67A26DD9E23875E0PPB11FA8C0360D', '/pmkpi/deptperformance/report/editindex', 'V_BGT_PERF_INDICATOR', 'tree', '指标值', 'KPIVALSOURCE', 0, null, 1, null, 4, null, null, 'pmkpi', 1, null, '{format:''#name'',filtersql:''remark=\''#COMPUTESIGN\''''}', 0, 1, null);


--表字段注册
delete from bus_t_diccolumn where tablecode ='BGT_PERF_INDICATOR' and columncode ='KPIVALSOURCE';
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'KPIVALSOURCE', null, '1', 'KPIVALSOURCE', '1', '2021', '87', 'BA6A94194222D03FE053B11FA8C057C0', 'KPIVALSOURCE', 'BGT_PERF_INDICATOR', '定量其他值', 'S', '40', null, 1, 0, null, sysdate);


