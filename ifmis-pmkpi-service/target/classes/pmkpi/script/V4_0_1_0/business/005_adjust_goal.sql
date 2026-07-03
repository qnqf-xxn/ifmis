begin

delete from p#busfw_t_uieditform t where key in('/pmkpi/adjust/report/proedit/goal') and t.columncode='ADJUSTREMARK';
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('BA167C07B4BC4655E053B11FA8C02221', '/pmkpi/adjust/report/proedit/goal', 'V_PERF_T_ADJUST', 'textarea', '调整说明', 'ADJUSTREMARK', 1, null, 1, null, 1, 3, '2', 'pmkpi', 1, null, '{}', null, null, null);

