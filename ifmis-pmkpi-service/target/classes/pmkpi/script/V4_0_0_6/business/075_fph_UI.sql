begin
  
DELETE FROM P#busfw_t_Uifunction t where t.key='/pmkpi/assessment/evaluate/audit';
insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BA521F68FFD4C4E0E053B11FA8C0D063', '/pmkpi/assessment/evaluate/audit', '保存', 1, 1, 'searchicon', 'pmkpievaluateAuditService.save', null, '保存', 'pmkpi', 'save', null, '{}');

insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BA521F68FFD5C4E0E053B11FA8C0D063', '/pmkpi/assessment/evaluate/audit', '取消', 1, 2, 'searchicon', 'pmkpievaluateAuditService.close', null, '取消', 'pmkpi', 'cancle', null, '{}');


DELETE FROM P#busfw_t_Uieditform t where t.key='/pmkpi/assessment/evaluate/audit';
insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('1FF75408D51A40CCB2FCF751CB17AE22', '/pmkpi/assessment/evaluate/audit', 'PERF_T_EVALUATEAUDIT', 'tree', '审核操作', 'AUDITTYPE', 1, null, 1, null, 1, null, null, 'pmkpi', 1, 0, '{format:''#name''}', 0, 1, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('C9618B1F4DB446E9BE5EC1377A46A468', '/pmkpi/assessment/evaluate/audit', 'PERF_T_EVALUATEAUDIT', 'textarea', '审核意见', 'OPINION', 1, null, 1, null, 5, 1, '3', 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('54EE81489CE1489D8C6069A27123E875', '/pmkpi/assessment/evaluate/audit', 'PERF_T_EVALUATEAUDIT', 'tree', '历史审核意见', 'OLDOPINION', 1, null, 1, null, 7, null, null, 'pmkpi', 1, null, '{format:''#name''}', 0, null, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('56B00CECBBB946CEBC07D00FECD1DB07', '/pmkpi/assessment/evaluate/audit', 'PERF_T_EVALUATEAUDIT', 'tree', '是否第三方参与审核', 'ISAUDIT', 1, null, 1, null, 3, null, null, 'pmkpi', 1, null, '{format:''#name''}', 0, null, null);
