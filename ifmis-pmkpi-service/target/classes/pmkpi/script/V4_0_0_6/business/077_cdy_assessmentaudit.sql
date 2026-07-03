begin

delete from bus_t_pageconsole t where t.url in('/pmkpi/assessment/evaluate/audit');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/assessment/evaluate/audit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.evaluate.audit.EvaluateAuditPage', 'index', '{main:[],footer:[toolbutton]}', null, null, 0);

delete from bus_t_pagecomponent t where t.id in('pmkpi_evaluateaudit');
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_evaluateaudit', '事前绩效评估审核', null, '事前绩效评估审核', '/pmkpi/evaluate/audit/evaluateaudit.js', 'Ext.lt.pmkpi.evaluate.auditservice', 'pmkpi', 'pmkpi.evaluate.EvaluateAuditService');

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/assessment/evaluate/audit');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/assessment/evaluate/audit', 'pmkpi_evaluateaudit', '{}', 'pmkpievaluateaudit', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/assessment/evaluate/audit', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/assessment/evaluate/audit', 'buseditform', '{columnsize:1}', 'editform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/assessment/evaluate/audit', 'busuidatatable', '{name:''绩效事前评估报告'',checkbox:false,title:''绩效事前评估报告'',edit:false,addrow:false}', 'datatable', 'pmkpi', null);


delete from p#busfw_t_uitable t where key in('/pmkpi/assessment/evaluate/audit');
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('BC4E595CCE2F11C7E053B11FA8C0AD52', '/pmkpi/assessment/evaluate/audit', 'PM_ATTACHMENT', 0, 1, 0, null, null, 'pmkpi', null);

delete from p#busfw_t_uicolumn t where key in('/pmkpi/assessment/evaluate/audit');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BC4E595CCE3011C7E053B11FA8C0AD52', '/pmkpi/assessment/evaluate/audit', 'FILENAME', '附件名称', 2, 1, 0, null, null, null, 1, null, null, null, null, null, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BC4E595CCE3111C7E053B11FA8C0AD52', '/pmkpi/assessment/evaluate/audit', 'CREATERNAME', '上传人', 3, 1, 0, null, null, null, 1, null, null, null, null, null, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BC4E595CCE3211C7E053B11FA8C0AD52', '/pmkpi/assessment/evaluate/audit', 'CREATE_TIME', '上传时间', 4, 1, 0, null, null, null, 1, null, null, null, null, null, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BC4E595CCE3311C7E053B11FA8C0AD52', '/pmkpi/assessment/evaluate/audit', 'MANAGE', '操作', 5, 1, 0, null, null, null, 1, null, 'yyyy-MM-dd hh:mm:ss', null, null, null, 0, 'd', '{}', null);

delete from p#busfw_t_uifunction t where key in('/pmkpi/assessment/evaluate/audit');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BA521F68FFD4C4E0E053B11FA8C0D063', '/pmkpi/assessment/evaluate/audit', '确认', 1, 1, 'searchicon', 'pmkpievaluateaudit.save', null, '确认', 'pmkpi', 'save', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BA521F68FFD5C4E0E053B11FA8C0D063', '/pmkpi/assessment/evaluate/audit', '取消', 1, 2, 'searchicon', 'pmkpievaluateaudit.close', null, '取消', 'pmkpi', 'cancle', null, '{}');
