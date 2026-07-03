begin
  -- 事前绩效评估申报页面
delete from bus_t_pageconsole where url ='/pmkpi/seeting/evaluation/report';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/seeting/evaluation/report', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.setting.evaluation.report.EvaluationReportPage', 'index', '{header:[header],left:lefttree,main:[toolbutton,queryform,tabpage,datatable]}', null, null, 0);


delete from bus_t_pageconsolecomconfig where url ='/pmkpi/seeting/evaluation/report';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/seeting/evaluation/report', 'pmkpi_evaluation', '{}', 'evaluation', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/seeting/evaluation/report', 'busuidatatable', '{name:''事前绩效评估表'',checkbox:true,title:''事前绩效评估表'',edit:false,addrow:false}', 'datatable', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/seeting/evaluation/report', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/seeting/evaluation/report', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/seeting/evaluation/report', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/seeting/evaluation/report', 'header', '{}', 'header', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/seeting/evaluation/report', 'busdclefttree', '{}', 'lefttree', 'pmkpi', null);

delete from bus_t_pagecomponent where id ='pmkpi_evaluation';
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_evaluation', '事前绩效评估申报', null, '事前绩效评估申报', '/pmkpi/setting/evaluation/evaluationreport.js', 'Ext.lt.pmkpi.evaluation.evaluationreportservice', 'pmkpi', 'pmkpi.setting.evaluation.report.EvaluationReportService');

delete from bus_t_diccolumn where tablecode ='PERF_T_EVALUATION';
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'VD00010', null, '0', 'AGENCYGUID', '1', '2016', '87', 'DEA6B11CA4260AA5E0533315A8C00A7D', 'AGENCYGUID', 'PERF_T_EVALUATION', '单位', 'S', '40', null, null, 1, null, sysdate);
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'AUDITOR', '1', '2016', '87', 'DEA6B11CA4270AA5E0533315A8C00A7D', 'AUDITOR', 'PERF_T_EVALUATION', '审核人', 'S', '40', null, null, 1, null, sysdate);
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'EVALUATIONAUDITTYPE', null, '1', 'AUDITTYPE', '1', '2020', '87', 'DF43FEFABBC47877E0533315A8C09885', 'AUDITTYPE', 'PERF_T_EVALUATION', '审核类型', 'S', '40', null, 1, 1, null, sysdate);
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'BGTAMT', '1', '2016', '87', 'DEA6B11CA4280AA5E0533315A8C00A7D', 'BGTAMT', 'PERF_T_EVALUATION', '当年预算总金额', 'S', '20', 2, null, 1, null, sysdate);
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'BUSTYPE', '1', '2016', '87', 'DEA6B11CA4290AA5E0533315A8C00A7D', 'BUSTYPE', 'PERF_T_EVALUATION', '业务类型', 'S', '32', null, null, 1, null, sysdate);
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values ('092006', '61006100UEw5VQ8y', null, '0', 'CREATER', '1', '2016', '87', 'DEA6B11CA42A0AA5E0533315A8C00A7D', 'CREATER', 'PERF_T_EVALUATION', '创建人', 'S', '40', null, null, 1, null, sysdate);
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'CREATETIME', '1', '2016', '87', 'DEA6B11CA42B0AA5E0533315A8C00A7D', 'CREATETIME', 'PERF_T_EVALUATION', '创建时间', 'S', '20', null, null, 1, null, sysdate);
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, '099003', null, '0', 'FININTORGGUID', '1', '2016', '87', 'DEA6B11CA42C0AA5E0533315A8C00A7D', 'FININTORGGUID', 'PERF_T_EVALUATION', '管理处室', 'S', '50', null, null, 1, null, sysdate);
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'GUID', '1', '2016', '87', 'DEA6B11CA42D0AA5E0533315A8C00A7D', 'GUID', 'PERF_T_EVALUATION', 'GUID', 'S', '32', null, null, 1, null, sysdate);
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'ISLAST', '1', '2016', '87', 'DEA6B11CA42E0AA5E0533315A8C00A7D', 'ISLAST', 'PERF_T_EVALUATION', '是否最后一次调整', 'N', '1', null, null, 1, null, sysdate);
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'ITEMS', '1', '2016', '87', 'DEF3C2B2B2FE34E4E0533315A8C0940F', 'ITEMS', 'PERF_T_EVALUATION', '评估事项', 'S', '4000', null, null, 1, null, sysdate);
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'LASTUPDATETIME', '1', '2016', '87', 'DEA6B11CA42F0AA5E0533315A8C00A7D', 'LASTUPDATETIME', 'PERF_T_EVALUATION', '最后操作时间', 'S', '20', null, null, 1, null, sysdate);
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'PROGUID', '1', '2016', '87', 'DEA6B11CA4300AA5E0533315A8C00A7D', 'PROGUID', 'PERF_T_EVALUATION', '项目guid', 'S', '40', null, null, 1, null, sysdate);
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'PROVINCE', '1', '2016', '87', 'DEA6B11CA4310AA5E0533315A8C00A7D', 'PROVINCE', 'PERF_T_EVALUATION', '区划', 'S', '9', null, null, 1, null, sysdate);
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'PRO_CODE', '1', '2016', '87', 'DEA6B11CA4320AA5E0533315A8C00A7D', 'PRO_CODE', 'PERF_T_EVALUATION', '项目编码', 'S', '40', null, null, 1, null, sysdate);
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'PRO_NAME', '1', '2016', '87', 'DEA6B11CA4330AA5E0533315A8C00A7D', 'PRO_NAME', 'PERF_T_EVALUATION', '项目名称', 'S', '200', null, null, 1, null, sysdate);
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'PRO_TOTAL_AMT', '1', '2016', '87', 'DEF92D8E55D52F41E0533315A8C0C4FB', 'PRO_TOTAL_AMT', 'PERF_T_EVALUATION', '项目总金额', 'N', '20', 2, 1, 1, null, sysdate);
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'RESULT', '1', '2016', '87', 'DEF3C2B2B2FF34E4E0533315A8C0940F', 'RESULT', 'PERF_T_EVALUATION', '评估结果', 'S', '4000', null, null, 1, null, sysdate);
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'STATUS', '1', '2016', '87', 'DEA6B11CA4370AA5E0533315A8C00A7D', 'STATUS', 'PERF_T_EVALUATION', '状态', 'N', '3', null, null, 1, null, sysdate);
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'UPDATETIME', '1', '2016', '87', 'DEA6B11CA4380AA5E0533315A8C00A7D', 'UPDATETIME', 'PERF_T_EVALUATION', '创建时间', 'S', '20', null, null, 1, null, sysdate);
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'WFID', '1', '2016', '87', 'DEA6B11CA4390AA5E0533315A8C00A7D', 'WFID', 'PERF_T_EVALUATION', '工作流guid', 'S', '40', null, null, 1, null, sysdate);
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'PMKPIWFSTATUS', null, '0', 'WFSTATUS', '1', '2016', '87', 'DEA6B11CA43A0AA5E0533315A8C00A7D', 'WFSTATUS', 'PERF_T_EVALUATION', '工作流状态', 'S', '100', null, null, 1, null, sysdate);
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'YEAR', '1', '2016', '87', 'DEA6B11CA43B0AA5E0533315A8C00A7D', 'YEAR', 'PERF_T_EVALUATION', '年度', 'S', '4', null, null, 1, null, sysdate);

delete from bus_t_dictable t where t.tablecode ='PERF_T_EVALUATION';
insert into bus_t_dictable (YEAR, PROVINCE, TABLECODE, NAME, REMARK, TABLETYPE, VERSION, DBTABNAME, APPID, EXP, TABLEPART, ISSHOW, DBIMPFLAG, ISSYS, ISUSES, VIEWTABLENAME, DBVERSION, DATASYNC, HASTRIGGER, SYNCCLASSNAME, STATUS)
values ('2016', '87', 'PERF_T_EVALUATION', '事前绩效评估申报表', '事前绩效评估申报表', 2, 1, 'PERF_T_EVALUATION', 'pmkpi', null, '0', 1, null, 1, 1, null, sysdate, 1, 1, null, '1');


-- 事前绩效评估审核页面
delete from bus_t_pageconsole where url ='/pmkpi/seeting/evaluation/audit';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/seeting/evaluation/audit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.setting.evaluation.audit.EvaluationAuditPage', 'index', '{header:[header],left:lefttree,main:[toolbutton,queryform,tabpage,datatable]}', null, null, 0);

delete from bus_t_pageconsolecomconfig where url ='/pmkpi/seeting/evaluation/audit';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/seeting/evaluation/audit', 'pmkpi_evaluationaudit', '{}', 'evaluationaudit', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/seeting/evaluation/audit', 'busqueryform', '{key:''/pmkpi/seeting/evaluation/report'',name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/seeting/evaluation/audit', 'busdclefttree', '{}', 'lefttree', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/seeting/evaluation/audit', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/seeting/evaluation/audit', 'header', '{}', 'header', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/seeting/evaluation/audit', 'busuidatatable', '{key:''/pmkpi/seeting/evaluation/report'',name:''事前绩效评估表'',checkbox:true,title:''事前绩效评估表'',edit:false,addrow:false}', 'datatable', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/seeting/evaluation/audit', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

delete from bus_t_pagecomponent where id ='pmkpi_evaluationaudit';
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_evaluationaudit', '事前绩效评估审核', null, '事前绩效评估审核', '/pmkpi/setting/evaluation/evaluationaudit.js', 'Ext.lt.pmkpi.evaluation.evaluationauditservice', 'pmkpi', 'pmkpi.setting.evaluation.audit.EvaluationAuditService');


-- 事前绩效评估查询页面
delete from bus_t_pageconsole where url ='/pmkpi/seeting/evaluation/query';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/seeting/evaluation/query', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.setting.evaluation.query.EvaluationQueryPage', 'index', '{header:[header],left:lefttree,main:[toolbutton,queryform,datatable]}', null, null, 0);

delete from bus_t_pageconsolecomconfig where url ='/pmkpi/seeting/evaluation/query';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/seeting/evaluation/query', 'pmkpi_evaluationquery', '{}', 'evaluationquery', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/seeting/evaluation/query', 'busuidatatable', '{name:''事前绩效评估表'',checkbox:true,title:''事前绩效评估表'',edit:false,addrow:false}', 'datatable', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/seeting/evaluation/query', 'busqueryform', '{key:''/pmkpi/seeting/evaluation/report'',name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/seeting/evaluation/query', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/seeting/evaluation/query', 'header', '{}', 'header', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/seeting/evaluation/query', 'busdclefttree', '{}', 'lefttree', 'pmkpi', null);



delete from bus_t_pagecomponent where id ='pmkpi_evaluationquery';
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_evaluationquery', '事前绩效评估查询', null, '事前绩效评估查询', '/pmkpi/setting/evaluation/evaluationquery.js', 'Ext.lt.pmkpi.evaluation.evaluationqueryservice', 'pmkpi', 'pmkpi.setting.evaluation.query.EvaluationQueryService');


--申报——选择项目
delete from bus_t_pageconsole where url ='/pmkpi/evaluation/report/procheck';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/evaluation/report/procheck', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.setting.evaluation.report.EvaluationReportPage', 'check', '{main:[datatable,queryform],footer:[toolbutton]}', null, null, 0);

delete from bus_t_pageconsolecomconfig where url ='/pmkpi/evaluation/report/procheck';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/report/procheck', 'pmkpi_evaluationcheck', '{}', 'evaluationcheck', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/report/procheck', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/report/procheck', 'busuidatatable', '{name:''事前绩效评估申报表'',checkbox:true,title:''事前绩效评估申报表'',edit:false,addrow:false}', 'datatable', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/report/procheck', 'busqueryform', '{key:''/pmkpi/program/report/list'',name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''table'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

delete from bus_t_pagecomponent where id ='pmkpi_evaluationcheck';
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_evaluationcheck', '事前绩效评估申报', null, '事前绩效评估申报', '/pmkpi/setting/evaluation/evaluationreportcheck.js', 'Ext.lt.pmkpi.evaluation.evaluationreportcheckservice', 'pmkpi', 'pmkpi.setting.evaluation.report.EvaluationCheckService');


--申报——填报修改
delete from bus_t_pageconsole where url ='/pmkpi/evaluation/report/proedit';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/evaluation/report/proedit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.tabfream.TabfreamPage', 'editindex', '{main:[tabpage],footer:[toolbutton]}', null, null, 0);

delete from bus_t_pageconsolecomconfig where url ='/pmkpi/evaluation/report/proedit';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/report/proedit', 'pmkpi_tabfreamedit', '{}', 'tabfreamedit', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/report/proedit', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/report/proedit', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);


--事前绩效评估基本信息
delete from bus_t_pageconsole where url ='/pmkpi/report/evaluationinfo';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/report/evaluationinfo', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.setting.evaluation.editinfo.EvaluationInfoPage', 'index', '{main:[editform]}', null, null, 0);

delete from bus_t_pageconsolecomconfig where url ='/pmkpi/report/evaluationinfo';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/report/evaluationinfo', 'pmkpi_evaluationinfo', '{}', 'evaluationinfo', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/report/evaluationinfo', 'buseditform', '{}', 'editform', 'pmkpi', null);

delete from bus_t_pagecomponent where id ='pmkpi_evaluationinfo';
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_evaluationinfo', '事前绩效评估信息', null, '事前绩效评估信息', '/pmkpi/setting/evaluation/editinfo/evaluationinfo.js', 'Ext.lt.pmkpi.evaluation.evaluationinfoservice', 'pmkpi', 'pmkpi.setting.evaluation.editinfo.EvaluationInfoService');


--事前绩效评估审核意见页面
delete from bus_t_pageconsole where url ='/pmkpi/audit/index/evaluation';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/audit/index/evaluation', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.setting.evaluation.audit.EvaluationOpinionAuditPage', 'index', '{main:[editform],footer:[toolbutton]}', null, null, 0);

delete from bus_t_pageconsolecomconfig where url ='/pmkpi/audit/index/evaluation';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/audit/index/evaluation', 'buseditform', '{title:''审核意见''}', 'editform', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/audit/index/evaluation', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/audit/index/evaluation', 'pmkpi_auditevaluation', '{}', 'auditevaluation', 'pmkpi', null);

delete from bus_t_pagecomponent where id ='pmkpi_auditevaluation';
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_auditevaluation', '事前绩效评估审核', null, '事前绩效评估审核', '/pmkpi/setting/evaluation/evaluationopinion.js', 'Ext.lt.pmkpi.evaluation.evaluationopinion', 'pmkpi', 'pmkpi.setting.evaluation.audit.EvaluationOpinionAuditService');


