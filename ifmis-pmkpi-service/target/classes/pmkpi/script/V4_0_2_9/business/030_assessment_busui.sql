begin

delete from p#busfw_t_uieditform t where t.key in('/pmkpi/program/assessment/list');
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, HEAD)
values (sys_guid(), '/pmkpi/program/assessment/list', 'V_PERF_T_ASSESSMENTOPINION', 'textarea', '是否建议安排项目及原因', 'PRORECOMMENDED', 1, null, 0, null, 1, 3, '2', 'pmkpi', 1, null, '{}', null, null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, HEAD)
values (sys_guid(), '/pmkpi/program/assessment/list', 'V_PERF_T_ASSESSMENTOPINION', 'textarea', '是否建议调整及调整意见', 'ADJUSTOPINION', 1, null, 0, null, 2, 3, '2', 'pmkpi', 1, null, '{}', null, null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, HEAD)
values (sys_guid(), '/pmkpi/program/assessment/list', 'V_PERF_T_ASSESSMENTOPINION', 'textarea', '建议安排预算额度', 'ARRANGEBGT', 1, null, 0, null, 3, 3, '2', 'pmkpi', 1, null, '{}', null, null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, HEAD)
values (sys_guid(), '/pmkpi/program/assessment/list', 'V_PERF_T_ASSESSMENTOPINION', 's', 'guid', 'GUID', 0, null, 1, null, 4, null, null, 'pmkpi', 1, null, '{}', null, null, null, null);
