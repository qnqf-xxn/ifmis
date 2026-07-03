begin
  
delete from p#busfw_t_uieditform where key = '/pmkpi/evaluation/financial/result/edit' and columncode = 'EVALUATEAREA';
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, HEAD, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/evaluation/financial/result/edit', 'V_PERF_T_FINEVALUATION', 'tree', '∆¿º€¡Ï”Ú', 'EVALUATEAREA', 1, null, 0, null, 14, null, null, 'pmkpi', 1, 0, '{"format":"#name"}', 0, 0, 0, null, null, null);
