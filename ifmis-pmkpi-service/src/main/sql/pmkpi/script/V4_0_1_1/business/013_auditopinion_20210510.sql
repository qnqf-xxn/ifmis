begin
--送审(审核意见)
delete from bus_t_pageconsolecomconfig where url = '/pmkpi/audit/opinion';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/audit/opinion', 'pmkpi_auditopinion', '{}', 'auditopinion', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/audit/opinion', 'buseditform', '{columnsize:1}', 'editform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/audit/opinion', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);


delete from bus_t_pagecomponent where id = 'pmkpi_auditopinion';
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_auditopinion', '审核意见', null, '审核意见', '/pmkpi/perfcommon/auditopinion.js', 'Ext.lt.pmkpi.auditservice', 'pmkpi', 'pmkpi.perfcommon.auditopinion.AuditopinionService');


delete from bus_t_pageconsole where url = '/pmkpi/audit/opinion';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/audit/opinion', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfcommon.auditopinion.AuditopinionPage', 'auditedit', '{main:[editform],footer:[toolbutton]}', null, null, 0);


delete from p#busfw_t_uifunction where key = '/pmkpi/audit/opinion';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('9178F3E1FBC6439286B98F3744E49D40', '/pmkpi/audit/opinion', '取消', 1, 2, 'searchicon', 'Ext.lt.ui.closeModalWindow', null, '取消', 'pmkpi', 'cancle', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('D06B146095B940A69A93A72D259143A6', '/pmkpi/audit/opinion', '确定', 1, 1, 'searchicon', 'auditopinion.confirm', null, '确定', 'pmkpi', 'save', null, '{}');

delete from p#busfw_t_uieditform where key = '/pmkpi/audit/opinion';
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('79beace2f6ef6d03abacb81e0f87f5bd', '/pmkpi/audit/opinion', 'BUSFW_T_DCWORKFLOWLOGS', 'textarea', '意见', 'REMARK', 1, null, 0, null, 1, null, '4', 'pmkpi', 1, null, '{}', null, null, null);


