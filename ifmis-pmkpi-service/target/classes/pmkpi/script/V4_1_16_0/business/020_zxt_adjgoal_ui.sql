BEGIN

delete from p#busfw_t_uieditform where key = '/pmkpi/adjust/report/proedit/goal' and COLUMNCODE = 'ADJREASON' and province='87' and year='2016';

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR, HEAD, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/adjust/report/proedit/goal', 'V_PERF_T_ADJUSTGOAL', 'tree', '调整原因', 'ADJREASON', 0, null, 0, null, 5, null, null, 'pmkpi', 1, 0, '{"format":"#name"}', 0, 0, 0, '87', '2016', null, null, null);
