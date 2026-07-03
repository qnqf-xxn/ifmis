begin
  
DELETE FROM p#Busfw_t_Uieditform t where t.key='/pmkpi/assessment/evaluate/audit' and t.columncode='GUID';
insert into Busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('1e35ECBBB946CEBC07D00FErc1DB07rt', '/pmkpi/assessment/evaluate/audit', 'PERF_T_EVALUATEAUDIT', 's', 'Ö÷¼ü', 'GUID', 0, null, 0, null, 99, null, null, 'pmkpi', 0, null, '{}', null, null, null);

