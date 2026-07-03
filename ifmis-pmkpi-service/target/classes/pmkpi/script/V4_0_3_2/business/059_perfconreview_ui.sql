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
values ('D4D3D3E34C66274CE05AAA15A8C0ACDD', '/pmkpi/audit/index/perfconreview', 'PERF_T_PROMONITOR', 'tree', '审核方式', 'CONAUDITTYPE', 1, null, 1, null, 1, null, null, 'pmkpi', 1, null, '{format:''#name''}', 0, 0, 0, '2016', '87');


DELETE FROM P#busfw_t_Uifunction t where t.key='/pmkpi/audit/index/perfconreview';
insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, YEAR, PROVINCE)
values ('C22EB17C9ADF2914E053BAAFA8C0FA19', '/pmkpi/audit/index/perfconreview', '审核', 1, 2, 'searchicon', 'auditperfconreview.audit', null, '审核', 'pmkpi', 'audit', null, null, '2016', '87');

insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, YEAR, PROVINCE)
values ('C22EB17C9AE02914E053BAAFA8C0FA19', '/pmkpi/audit/index/perfconreview', '退回', 1, 3, 'searchicon', 'auditperfconreview.back', null, '退回', 'pmkpi', 'back', null, '{remark:false}', '2016', '87');

insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, YEAR, PROVINCE)
values ('C22EB17C9AE12914E053BAAFA8C0FA19', '/pmkpi/audit/index/perfconreview', '取消', 1, 4, 'searchicon', 'auditperfconreview.close', null, '取消', 'pmkpi', 'close', null, null, '2016', '87');

insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, YEAR, PROVINCE)
values ('C2357FD83C6856C9E053BAAFA8C0CAB0', '/pmkpi/audit/index/perfconreview', '保存', 1, 1, 'searchicon', 'auditperfconreview.save', null, '保存', 'pmkpi', 'save', null, null, '2016', '87');

delete from p#busfw_t_uicolumn where key = '/pmkpi/program/trace/report' and COLUMNCODE = 'CONAUDITTYPE';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,YEAR, PROVINCE)
values ('BF5EDC3A1D83A028E053B11FA8C0F7AA', '/pmkpi/program/trace/report', 'CONAUDITTYPE', '审核结论', 20, 1, 0, 0, null, 0, 6, null, '#name', null, null, 100, 1, 'tree', null, null,2016,87);

delete from p#busfw_t_uicolumn where key = '/pmkpi/program/trace/query' and COLUMNCODE = 'CONAUDITTYPE';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,YEAR, PROVINCE)
values ('BF5EDC3A1D83A028E053B11FA8C0F7BB', '/pmkpi/program/trace/query', 'CONAUDITTYPE', '审核结论', 20, 1, 0, 0, null, 0, 6, null, '#name', null, null, 100, 1, 'tree', null, null,2016,87);

delete from p#busfw_t_uicolumn where key = '/pmkpi/program/trace/report' and COLUMNCODE = 'CONAUDITTYPE';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,YEAR, PROVINCE)
values ('BF5EDC3A1D83A028E053B11FA8C0F7CC', '/pmkpi/program/trace/report', 'CONAUDITTYPE', '审核结论', 20, 1, 0, 0, null, 0, 6, null, '#name', null, null, 100, 1, 'tree', null, null,2016,87);


delete from perf_enum t where elementcode = 'PERFCONREVIEW';

insert into perf_enum (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE, VERSION, APPID, SUPERID, LEVELNO, ISLEAF, REMARK, CREATER, ORDERNUM)
values ('PERFCONREVIEW1', '1', 'PERFCONREVIEW', '项目各年度整改', '1', '20221128162733', '20221128162733', '2016', '87', 1, 'pmkpi', '0', 1, 0, null, null, 1);
insert into perf_enum (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE, VERSION, APPID, SUPERID, LEVELNO, ISLEAF, REMARK, CREATER, ORDERNUM)
values ('PERFCONREVIEW2', '2', 'PERFCONREVIEW', '项目预算调整', '1', '20221128162733', '20221128162733', '2016', '87', 1, 'pmkpi', '0', 1, 0, null, null, 2);
insert into perf_enum (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE, VERSION, APPID, SUPERID, LEVELNO, ISLEAF, REMARK, CREATER, ORDERNUM)
values ('PERFCONREVIEW3', '3', 'PERFCONREVIEW', '项目暂停拨款', '1', '20221128162733', '20221128162733', '2016', '87', 1, 'pmkpi', '0', 1, 0, null, null, 3);
insert into perf_enum (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE, VERSION, APPID, SUPERID, LEVELNO, ISLEAF, REMARK, CREATER, ORDERNUM)
values ('PERFCONREVIEW4', '4', 'PERFCONREVIEW', '项目暂缓实施', '1', '20221128162733', '20221128162733', '2016', '87', 1, 'pmkpi', '0', 1, 0, null, null, 4);
insert into perf_enum (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE, VERSION, APPID, SUPERID, LEVELNO, ISLEAF, REMARK, CREATER, ORDERNUM)
values ('PERFCONREVIEW5', '5', 'PERFCONREVIEW', '项目无问题', '1', '20221128162733', '20221128162733', '2016', '87', 1, 'pmkpi', '0', 1, 0, null, null, 5);



