begin
  
update p#busfw_t_uieditform set name = '系统计算得分' where key = '/pmkpi/perfself/apply/edit/selfinfo' and columncode = 'SCORE';
update p#busfw_t_uieditform set name = '系统计算得分' where key = '/pmkpi/perfself/apply/editdept/selfinfo' and columncode = 'SCORE';

delete from p#busfw_t_uieditform where key = '/pmkpi/perfself/apply/editdept/selfinfo' and columncode = 'SELFSCORE';
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, HEAD, ISEDITCTRL, EDITCTRLMSG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/perfself/apply/editdept/selfinfo', 'V_PERF_T_EVALUATEINFO', 's', '自评得分', 'SELFSCORE', 1, null, 0, null, 7, null, null, 'pmkpi', 1, null, '{}', null, null, null, null, null, null,'2016','87');

delete from p#busfw_t_uieditform where key = '/pmkpi/perfself/apply/edit/selfinfo' and columncode = 'SELFSCORE';
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, HEAD, ISEDITCTRL, EDITCTRLMSG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/perfself/apply/edit/selfinfo', 'V_PERF_T_EVALUATEINFO', 's', '自评得分', 'SELFSCORE', 1, null, 0, null, 11, null, null, 'pmkpi', 1, null, '{}', null, null, null, null, null, null,'2016','87');


delete from bus_t_diccolumn where tablecode = 'PERF_T_EVALUATEINFO' and columncode = 'SELFSCORE';
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'SELFSCORE', '1', '2016', '87', 'D3104DC747241FA211EE786A7D6D17CD', 'SELFSCORE', 'PERF_T_EVALUATEINFO', '自评得分', 'N', '6', 2, 1, 1, null, sysdate);
