begin
  
delete from p#busfw_t_uieditform where key = '/pmkpi/perfself/apply/edit/selfinfo' and columncode in ('PERCENTILE','EVALUATEAREA');
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, HEAD, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/perfself/apply/edit/selfinfo', 'V_PERF_T_EVALUATEINFO', 's', '百分位值', 'PERCENTILE', 1, null, 0, null, 10, null, null, 'pmkpi', 0, null, '{}', null, null, null, null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, HEAD, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/perfself/apply/edit/selfinfo', 'V_PERF_T_EVALUATEINFO', 'tree', '评价领域', 'EVALUATEAREA', 1, null, 0, null, 11, null, null, 'pmkpi', 1, 0, '{"format":"#name"}', 0, 0, 0, null, null, null);


delete from bus_t_diccolumn where tablecode = 'PERF_T_EVALUATEINFO' and columncode in ('PERCENTILE','EVALUATEAREA');
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'EVALUATEAREA', null, '1', 'EVALUATEAREA', '1', '2016', '87', 'B15C2FA98F5533B2037B95020DF241B3', 'EVALUATEAREA', 'PERF_T_EVALUATEINFO', '评价领域', 'S', '40', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'PERCENTILE', '1', '2021', '87', 'E455A590C18452B81F0EC864DAFB20FF', 'PERCENTILE', 'PERF_T_EVALUATEINFO', '百分位值', 'S', '40', null, 1, 1, null, sysdate);
