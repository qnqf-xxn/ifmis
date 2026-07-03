begin
delete from p#busfw_t_uieditform where key = '/pmkpi/evaluation/dept/result/edit';
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('PPP3D19B028F2359E053B11FA8C0BCA2', '/pmkpi/evaluation/dept/result/edit', 'V_PERF_T_DEPTEVALUATION', 's', 'guid', 'GUID', 0, null, 0, null, 1, 0, '0', 'pmkpi', 1, 0, '{}', 0, 0, 0);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('PPP3D19B028E2359E053B11FA8C0BCA2', '/pmkpi/evaluation/dept/result/edit', 'V_PERF_T_DEPTEVALUATION', 'textarea', '存在问题', 'EXISTQUESTION', 1, null, 1, null, 2, 3, '3', 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('PPP3D19B02902359E053B11FA8C0BCA2', '/pmkpi/evaluation/dept/result/edit', 'V_PERF_T_DEPTEVALUATION', 'textarea', '整改措施和建议', 'FEEDBACK', 1, null, 1, null, 3, 3, '3', 'pmkpi', 1, null, '{}', null, null, null);
