begin
--审核流程
delete from bus_t_pageconsole where url = '/pmkpi/performanceopen/auditedit';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/performanceopen/auditedit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.performanceopen.audit.PerfOpenAuditPage', 'audit', '{main:[editform],footer:[toolbutton]}', null, null, 0);
--
delete from bus_t_pagecomponent where id = 'pmkpi_openauditedit';
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_openauditedit', '绩效公开审核编辑', null, '绩效公开审核编辑', '/pmkpi/performanceopen/auditopinion.js', 'Ext.lt.pmkpi.performanceopen.auditservice', 'pmkpi', 'pmkpi.performanceopen.PerfAuditEditService');
--审核流程页面
delete from bus_t_pageconsolecomconfig where url = '/pmkpi/performanceopen/auditedit';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/performanceopen/auditedit', 'pmkpi_openauditedit', '{}', 'openauditedit', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/performanceopen/auditedit', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/performanceopen/auditedit', 'buseditform', '{name:''编辑区'',edit:true,columnsize:2}', 'editform', 'pmkpi', null);

delete from p#busfw_t_uifunction where key = '/pmkpi/performanceopen/auditedit';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG,YEAR,PROVINCE)
values (sys_guid(), '/pmkpi/performanceopen/auditedit', '取消', 1, 2, 'searchicon', 'Ext.lt.ui.closeModalWindow', null, '取消', 'pmkpi', 'cancle', null, '{}','2016','87');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG,YEAR,PROVINCE)
values (sys_guid(), '/pmkpi/performanceopen/auditedit', '确认', 1, 1, 'searchicon', 'openauditedit.save', null, '确认', 'pmkpi', 'save', null, '{}','2016','87');

delete from p#busfw_t_uieditform where key = '/pmkpi/performanceopen/auditedit';
insert into  busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE,YEAR,PROVINCE)
values (sys_guid(), '/pmkpi/performanceopen/auditedit', 'PERF_T_EVALUATEAUDIT', 'textarea', '审核意见', 'OPINION', 1, null, 1, null, 2, 2, '3', 'pmkpi', 1, null, '{}', null, null, null,'2016','87');

insert into  busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE,YEAR,PROVINCE)
values (sys_guid(), '/pmkpi/performanceopen/auditedit', 'PERF_T_EVALUATEAUDIT', 'tree', '常用审核意见', 'OLDOPINION', 1, null, 0, null, 3, null, null, 'pmkpi', 1, null, '{format:''#name''}', 0, null, null,'2016','87');

insert into  busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE,YEAR,PROVINCE)
values (sys_guid(), '/pmkpi/performanceopen/auditedit', 'PERF_T_EVALUATEAUDIT', 'tree', '审核操作', 'ORDINARYTYPE', 1, null, 1, null, 1, null, null, 'pmkpi', 1, null, '{format:''#name''}', 0, null, null,'2016','87');
