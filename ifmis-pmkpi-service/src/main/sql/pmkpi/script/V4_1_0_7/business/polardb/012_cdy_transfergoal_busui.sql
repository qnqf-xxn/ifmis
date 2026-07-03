begin

delete from p#busfw_t_uieditform t where t.key='/pmkpi/transfer/transfergoal' and t.columncode='PRO_NAME';
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, HEAD, ISEDITCTRL, EDITCTRLMSG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/transfer/transfergoal', 'V_PERF_TRANSFER_GOAL', 's', 'ÏîÄ¿Ãû³Æ', 'PRO_NAME', 0, null, 1, null, 1, null, null, 'pmkpi', 1, null, '{}', null, null, null, null, null, null, '2016','87');

update p#busfw_t_uieditform t set t.isedit=0 where t.key='/pmkpi/transfer/transfergoal' and t.columncode='KPI_TARGET';