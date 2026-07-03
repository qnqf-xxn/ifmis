begin

delete from bus_t_pageconsole t where t.url in('/pmkpi/audit/index/perfconreview');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/audit/index/perfconreview', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', '', '', 'pmkpi', 'gov.mof.fasp2.pmkpi.perfprotrace.audit.PerfConReviewAuditPage', 'index', '{main:[editform],footer:[toolbutton]}', '', '', 0);

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/audit/index/perfconreview');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/audit/index/perfconreview', 'pmkpi_auditperfconreview', '{}', 'auditperfconreview', 'pmkpi', '');

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/audit/index/perfconreview', 'buseditform', '{title:''审核意见''}', 'editform', 'pmkpi', '');

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/audit/index/perfconreview', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', '');

delete from bus_t_pagecomponent t where t.id in('pmkpi_auditperfconreview');
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_auditperfconreview', '监控结论审核', '', '监控结论审核', '/pmkpi/perfprotrace/audit/perfconreview.js', 'Ext.lt.pmkpi.perfprotrace.perfconreview', 'pmkpi', 'pmkpi.perfprotrace.audit.PerfConReviewAuditService');


delete from p#busfw_t_uieditform where key ='/pmkpi/audit/index/perfconreview';
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, YEAR, PROVINCE)
values ('D4D3D3E34C65274CE05AAA15A8C0ACDD', '/pmkpi/audit/index/perfconreview', 'PERF_T_AUDITMAIN', 'textarea', null, 'REMARK', 1, null, 0, null, 2, 1, '6', 'pmkpi', 1, null, '{}', 0, 0, 0, '2016', '87');

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, YEAR, PROVINCE)
values ('D4D3D3E34C66274CE05AAA15A8C0ACDD', '/pmkpi/audit/index/perfconreview', 'PERF_T_PROMONITOR', 'tree', '审核方式', 'AUDITTYPE', 1, null, 1, null, 1, null, null, 'pmkpi', 1, null, '{format:''#name''}', 0, 0, 0, '2016', '87');


DELETE FROM P#busfw_t_Uifunction t where t.key='/pmkpi/audit/index/perfconreview';
insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, YEAR, PROVINCE)
values ('C22EB17C9ADF2914E053BAAFA8C0FA19', '/pmkpi/audit/index/perfconreview', '审核', 1, 2, 'searchicon', 'auditperfconreview.audit', null, '审核', 'pmkpi', 'audit', null, null, '2016', '87');

insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, YEAR, PROVINCE)
values ('C22EB17C9AE02914E053BAAFA8C0FA19', '/pmkpi/audit/index/perfconreview', '退回', 1, 3, 'searchicon', 'auditperfconreview.back', null, '退回', 'pmkpi', 'back', null, '{remark:false}', '2016', '87');

insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, YEAR, PROVINCE)
values ('C22EB17C9AE12914E053BAAFA8C0FA19', '/pmkpi/audit/index/perfconreview', '取消', 1, 4, 'searchicon', 'auditperfconreview.close', null, '取消', 'pmkpi', 'close', null, null, '2016', '87');

insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, YEAR, PROVINCE)
values ('C2357FD83C6856C9E053BAAFA8C0CAB0', '/pmkpi/audit/index/perfconreview', '保存', 1, 1, 'searchicon', 'auditperfconreview.save', null, '保存', 'pmkpi', 'save', null, null, '2016', '87');


delete from perf_t_datasource where elementcode = 'perfconreview';
insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('1', '001', '项目无问题', null, null, null, null, 1, 'perfconreview', 1, '20201229', '20201229', 2016, '87');
insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('2', '002', '需调整目标', null, null, null, null, 2, 'perfconreview', 1, '20201229', '20201229', 2016, '87');
insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('3', '003', '需整改建议', null, null, null, null, 3, 'perfconreview', 1, '20201229', '20201229', 2016, '87');

delete fasp_t_dicdssource where guid in('PMKPIAUDITTYPECFG');
insert into fasp_t_dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('PMKPIAUDITTYPECFG', 'PMKPIAUDITTYPECFG', 'PMKPIAUDITTYPECFG', '绩效审核流程配置', '1', null, null, null, '2016', '87', null, null, null, '1', '[{guid:"opinion",code:"opinion",name:"意见审核"},{guid:"nature",code:"nature",name:"四性审核"},{guid:"traceopinion",code:"traceopinion",name:"监控审核"},{guid:"evaluation",code:"evaluation",name:"评估审核"},{guid:"perfconreview",code:"perfconreview",name:"监控结论审核"}]', sysdate, null, null);

