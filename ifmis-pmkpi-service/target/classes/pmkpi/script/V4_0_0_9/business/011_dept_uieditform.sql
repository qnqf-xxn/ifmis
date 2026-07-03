begin
delete FROM p#Busfw_t_Uieditform t where t.key in('/pmkpi/perfself/apply/editdept/selfdesc');

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('BE47B1712157EF62E053B11FA8C04FC6', '/pmkpi/perfself/apply/editdept/selfdesc', 'V_PERF_SELFDEPTDESC', 's', '主键ID', 'GUID', 0, null, 0, null, 1, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('BE47B1712156EF62E053B11FA8C04FC6', '/pmkpi/perfself/apply/editdept/selfdesc', 'V_PERF_SELFDEPTDESC', 's', '自评得分', 'SCORE', 1, null, 0, null, 2, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('BE47B1712155EF62E053B11FA8C04FC6', '/pmkpi/perfself/apply/editdept/selfdesc', 'V_PERF_SELFDEPTDESC', 's', '自评结论', 'SELFRESULT', 1, null, 0, null, 3, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('BE47B1712154EF62E053B11FA8C04FC6', '/pmkpi/perfself/apply/editdept/selfdesc', 'V_PERF_SELFDEPTDESC', 's', '预警规则', 'WARN', 0, null, 0, null, 3, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('BE47B1712153EF62E053B11FA8C04FC6', '/pmkpi/perfself/apply/editdept/selfdesc', 'V_PERF_SELFDEPTDESC', 'textarea', '绩效目标', 'YEARGOAL', 1, null, 0, null, 4, 3, '4', 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('BE47B1712152EF62E053B11FA8C04FC6', '/pmkpi/perfself/apply/editdept/selfdesc', 'V_PERF_SELFDEPTDESC', 'textarea', '全年目标完成情况', 'ALLYEARGOAL', 1, null, 1, null, 5, 3, '4', 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('BE47B1712158EF62E053B11FA8C04FC6', '/pmkpi/perfself/apply/editdept/selfdesc', 'V_PERF_SELFDEPTDESC', 'textarea', '绩效目标偏离原因分析', 'RECTIFICATION', 1, null, 0, null, 6, 3, '4', 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('BE47B1712159EF62E053B11FA8C04FC6', '/pmkpi/perfself/apply/editdept/selfdesc', 'V_PERF_SELFDEPTDESC', 'textarea', '整改措施及建议', 'DEVIATIONANALY', 1, null, 0, null, 7, 3, '4', 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('BE47B171215AEF62E053B11FA8C04FC6', '/pmkpi/perfself/apply/editdept/selfdesc', 'V_PERF_SELFDEPTDESC', 'textarea', '其他需说明问题', 'SELFADDINFO', 1, null, 0, null, 8, 3, '4', 'pmkpi', 1, null, '{}', null, null, null);
