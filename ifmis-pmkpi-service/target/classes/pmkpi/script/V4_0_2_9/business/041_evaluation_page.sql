begin
  --页面配置
delete from bus_t_pageconsole where url ='/pmkpi/evaluation/audit';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/evaluation/audit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.setting.evaluation.proaudit.ProEvaluationAuditPage', 'index', '{main:[editform],footer:[toolbutton]}', null, null, null);

delete from bus_t_pageconsolecomconfig where url ='/pmkpi/evaluation/audit';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/audit', 'pmkpi_proaudit', '{}', 'proaudit', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/audit', 'buseditform', '{title:''事前绩效评估审核'',tablecode:''V_PERF_T_EVALUATIONAUDIT''}', 'editform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/audit', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);


delete from bus_t_pagecomponent where id ='pmkpi_proaudit';
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_proaudit', '项目库事前绩效评估审核', null, '项目库事前绩效评估审核', '/pmkpi/setting/evaluation/proaudit/proevaluationaudit.js', 'Ext.lt.pmkpi.evaluation.proauditservice', 'pmkpi', 'pmkpi.setting.evaluation.proaudit.ProEvaluationAuditService');

--表注册
delete from bus_t_dictable where tablecode ='V_PERF_T_EVALUATIONAUDIT';
insert into bus_t_dictable (YEAR, PROVINCE, TABLECODE, NAME, REMARK, TABLETYPE, VERSION, DBTABNAME, APPID, EXP, TABLEPART, ISSHOW, DBIMPFLAG, ISSYS, ISUSES, VIEWTABLENAME, DBVERSION, DATASYNC, HASTRIGGER, SYNCCLASSNAME, STATUS)
values ('2016', '87', 'V_PERF_T_EVALUATIONAUDIT', '项目库事前绩效评估审核表', '项目库事前绩效评估审核表', 2, 1, 'V_PERF_T_EVALUATIONAUDIT', 'pmkpi', null, '0', 1, null, 1, 1, null, sysdate, 1, 1, null, '1');

--列表字段注册
delete from bus_t_diccolumn where tablecode ='V_PERF_T_EVALUATIONAUDIT';
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'VD00010', null, '0', 'AGENCYGUID', '1', '2016', '87', 'E3991ECCF7155F91E0533315A8C0587C', 'AGENCYGUID', 'V_PERF_T_EVALUATIONAUDIT', '单位', 'S', '40', null, null, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values ('092006', '61006100UEw5VQ8y', null, '0', 'CREATER', '1', '2016', '87', 'E3991ECCF7165F91E0533315A8C0587C', 'CREATER', 'V_PERF_T_EVALUATIONAUDIT', '创建人', 'S', '40', null, null, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'CREATETIME', '1', '2016', '87', 'E3991ECCF7175F91E0533315A8C0587C', 'CREATETIME', 'V_PERF_T_EVALUATIONAUDIT', '创建时间', 'S', '20', null, null, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, '099003', null, '0', 'FININTORGGUID', '1', '2016', '87', 'E3991ECCF7185F91E0533315A8C0587C', 'FININTORGGUID', 'V_PERF_T_EVALUATIONAUDIT', '管理处室', 'S', '50', null, null, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'GUID', '1', '2016', '87', 'E3991ECCF7195F91E0533315A8C0587C', 'GUID', 'V_PERF_T_EVALUATIONAUDIT', 'GUID', 'S', '32', null, null, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'ISLEAF', null, '1', 'ISPDM', '1', '2016', '87', 'E3991ECCF7235F91E0533315A8C0587C', 'ISPDM', 'V_PERF_T_EVALUATIONAUDIT', '是否纳入项目库', 'S', '100', null, null, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'LASTUPDATETIME', '1', '2016', '87', 'E3991ECCF71A5F91E0533315A8C0587C', 'LASTUPDATETIME', 'V_PERF_T_EVALUATIONAUDIT', '最后操作时间', 'S', '20', null, null, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'VD00010', null, '1', 'MANAGE_DEPT_CODE', '1', '2016', '87', 'E3991ECCF7265F91E0533315A8C0587C', 'MANAGE_DEPT_CODE', 'V_PERF_T_EVALUATIONAUDIT', '主管部门代码', 'S', '21', null, null, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'OPINIONS', '1', '2016', '87', 'E3991ECCF7245F91E0533315A8C0587C', 'OPINIONS', 'V_PERF_T_EVALUATIONAUDIT', '存在问题及修改意见', 'S', '100', null, null, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'ORGANIZATION', '1', '2016', '87', 'E3991ECCF7215F91E0533315A8C0587C', 'ORGANIZATION', 'V_PERF_T_EVALUATIONAUDIT', '评估机构', 'S', '100', null, null, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'PROGUID', '1', '2016', '87', 'E3991ECCF71B5F91E0533315A8C0587C', 'PROGUID', 'V_PERF_T_EVALUATIONAUDIT', '项目guid', 'S', '40', null, null, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'PROVINCE', '1', '2016', '87', 'E3991ECCF71C5F91E0533315A8C0587C', 'PROVINCE', 'V_PERF_T_EVALUATIONAUDIT', '区划', 'S', '9', null, null, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'PRO_CODE', '1', '2016', '87', 'E3991ECCF71D5F91E0533315A8C0587C', 'PRO_CODE', 'V_PERF_T_EVALUATIONAUDIT', '项目编码', 'S', '40', null, null, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'SCORE', '1', '2016', '87', 'E3991ECCF7225F91E0533315A8C0587C', 'SCORE', 'V_PERF_T_EVALUATIONAUDIT', '评估得分', 'S', '100', null, null, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'UPDATETIME', '1', '2016', '87', 'E3991ECCF71E5F91E0533315A8C0587C', 'UPDATETIME', 'V_PERF_T_EVALUATIONAUDIT', '创建时间', 'S', '20', null, null, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'WFID', '1', '2016', '87', 'E3991ECCF7255F91E0533315A8C0587C', 'WFID', 'V_PERF_T_EVALUATIONAUDIT', '工作流guid', 'S', '40', null, null, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'PMKPIWFSTATUS', null, '0', 'WFSTATUS', '1', '2016', '87', 'E3991ECCF71F5F91E0533315A8C0587C', 'WFSTATUS', 'V_PERF_T_EVALUATIONAUDIT', '工作流状态', 'S', '100', null, null, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'YEAR', '1', '2016', '87', 'E3991ECCF7205F91E0533315A8C0587C', 'YEAR', 'V_PERF_T_EVALUATIONAUDIT', '年度', 'S', '4', null, null, 1, null, sysdate);




--编辑区
delete from p#busfw_t_uieditform where key ='/pmkpi/evaluation/audit';
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, HEAD)
values (sys_guid(), '/pmkpi/evaluation/audit', 'V_PERF_T_EVALUATIONAUDIT', 's', '评估机构', 'ORGANIZATION', 1, null, 1, null, 7, null, null, 'pmkpi', 1, null, '{}', null, null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, HEAD)
values (sys_guid(), '/pmkpi/evaluation/audit', 'V_PERF_T_EVALUATIONAUDIT', 's', '评估得分', 'SCORE', 1, null, 1, null, 8, null, null, 'pmkpi', 1, null, '{}', null, null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, HEAD)
values (sys_guid(), '/pmkpi/evaluation/audit', 'V_PERF_T_EVALUATIONAUDIT', 'tree', '是否纳入项目库', 'ISPDM', 1, null, 1, null, 6, null, null, 'pmkpi', 1, null, '{}', null, null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, HEAD)
values (sys_guid(), '/pmkpi/evaluation/audit', 'V_PERF_T_EVALUATIONAUDIT', 'textarea', '存在问题及修改意见', 'OPINIONS', 1, null, 1, null, 9, 3, '3', 'pmkpi', 1, null, '{}', null, null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, HEAD)
values (sys_guid(), '/pmkpi/evaluation/audit', 'V_PERF_T_EVALUATIONAUDIT', 's', '评估项目名称', 'PRO_NAME', 1, null, 0, null, 1, null, null, 'pmkpi', 0, null, '{}', null, null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, HEAD)
values (sys_guid(), '/pmkpi/evaluation/audit', 'V_PERF_T_EVALUATIONAUDIT', 'tree', '主管部门', 'MANAGE_DEPT_CODE', 1, null, 0, null, 2, null, null, 'pmkpi', 0, null, '{}', null, null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, HEAD)
values (sys_guid(), '/pmkpi/evaluation/audit', 'V_PERF_T_EVALUATIONAUDIT', 'tree', '项目申报单位', 'AGENCYGUID', 1, null, 0, null, 3, null, null, 'pmkpi', 0, null, '{}', null, null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, HEAD)
values (sys_guid(), '/pmkpi/evaluation/audit', 'V_PERF_T_EVALUATIONAUDIT', 's', '起止时间', 'PRO_START_YEAR', 1, null, 0, null, 4, null, null, 'pmkpi', 0, null, '{}', null, null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, HEAD)
values (sys_guid(), '/pmkpi/evaluation/audit', 'V_PERF_T_EVALUATIONAUDIT', 's', '预算拟安排额度(万元)', 'DECLARATION_AMT', 1, null, 0, null, 5, null, null, 'pmkpi', 0, null, '{}', null, null, null, null);

--按钮区
delete from p#busfw_t_uifunction where key ='/pmkpi/evaluation/audit';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/evaluation/audit', '保存', 1, 1, 'searchicon', 'proaudit.save', null, '保存', 'pmkpi', 'save', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/evaluation/audit', '关闭', 1, 2, 'searchicon', 'Ext.lt.ui.closeModalWindow', null, '关闭', 'pmkpi', 'close', null, '{}');

