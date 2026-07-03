begin
  
delete from p#busfw_t_uicolumn t where t.key in('/pmkpi/midprogram/query/list') and t.columncode='ISCASE' and province='87' and year='2016';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/midprogram/query/list', 'ISCASE', '是否纳入案例库', 22, 0, 0, null, null, null, 1, null, null, null, null, null, 0, 's', '{}', null, '87', '2016', null, null);

delete from p#busfw_t_uifunction t where t.key in('/pmkpi/midprogram/report/audit') and t.code='intocase' and province='87' and year='2016';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/midprogram/report/audit', '纳入案例库', 0, 12, 'searchicon', 'midprogramaudit.intocase', null, '纳入案例库', 'pmkpi', 'intocase', null, null, '87', '2016', null, null);

update p#busfw_t_uitable t set t.tablecode='V_PERF_T_PROMIDDECLARE' where t.key in('/pmkpi/midprogram/query/list');
