begin
delete from p#Busfw_t_Uieditform t where t.KEY='/pmkpi/perfself/apply/editdept/selfinfo' and t.COLUMNCODE = 'SELFGRADE';

insert into Busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/perfself/apply/editdept/selfinfo', 'V_PERF_T_EVALUATEINFO', 's', 'µÈ¼¶', 'SELFGRADE', 0, null, 0, null, 8, null, null, 'pmkpi', 0, null, '{}', 0, 0, 0, '87', '2016');