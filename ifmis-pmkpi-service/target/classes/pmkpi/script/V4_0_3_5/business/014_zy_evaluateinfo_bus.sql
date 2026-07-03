begin
  
delete from bus_t_pageconsolecomconfig where url = '/pmkpi/perfself/apply/edit/selfinfo';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/apply/edit/selfinfo', 'pmkpi_selfinfo', '{}', 'selfinfo', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/apply/edit/selfinfo', 'buseditform', '{headsort:false,name:''评价基本信息'',edit:true,title:''评价基本信息'',nextSibling:false,table:"V_PERF_T_EVALUATEINFO"}', 'editform', 'pmkpi', null);


delete from bus_t_pageconsole where url = '/pmkpi/perfself/apply/edit/selfinfo';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/perfself/apply/edit/selfinfo', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfself.page.PerfSelfApplyPage', 'selfinfo', '{main:[editform]}', null, null, 0);


delete from bus_t_pagecomponent where id = 'pmkpi_selfinfo';
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_selfinfo', '评价基本信息', null, '评价基本信息', '/pmkpi/perfself/selfinfo.js', 'Ext.lt.pmkpi.selfinfo', 'pmkpi', 'pmkpi.perfSelf.tab.SelfInfoService');





delete from bus_t_pageconsolecomconfig where url = '/pmkpi/perfself/apply/editdept/selfinfo';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/apply/editdept/selfinfo', 'pmkpi_selfinfo', '{}', 'selfinfo', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/apply/editdept/selfinfo', 'buseditform', '{headsort:false,name:''评价基本信息'',edit:true,title:''评价基本信息'',nextSibling:false,table:"V_PERF_T_EVALUATEINFO"}', 'editform', 'pmkpi', null);


delete from bus_t_pageconsole where url = '/pmkpi/perfself/apply/editdept/selfinfo';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/perfself/apply/editdept/selfinfo', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfself.page.PerfSelfApplyPage', 'selfinfo', '{main:[editform]}', null, null, 0);




delete from bus_t_dictable where tablecode = 'PERF_T_EVALUATEINFO';
insert into bus_t_dictable (YEAR, PROVINCE, TABLECODE, NAME, REMARK, TABLETYPE, VERSION, DBTABNAME, APPID, EXP, TABLEPART, ISSHOW, DBIMPFLAG, ISSYS, ISUSES, VIEWTABLENAME, DBVERSION, DATASYNC, HASTRIGGER, SYNCCLASSNAME, STATUS)
values ('2016', '87', 'PERF_T_EVALUATEINFO', '评价基本信息', '评价基本信息', 2, 1, 'PERF_T_EVALUATEINFO', 'pmkpi', null, '0', 1, null, 1, 1, 'V_PERF_T_EVALUATEINFO', sysdate, 1, 1, null, '1');






delete from bus_t_diccolumn where tablecode = 'PERF_T_EVALUATEINFO';
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'BUSTYPE', '1', '2021', '87', sys_guid(), 'BUSTYPE', 'PERF_T_EVALUATEINFO', '业务类型', 'S', '40', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'CREATER', '1', '2021', '87', sys_guid(), 'CREATER', 'PERF_T_EVALUATEINFO', '创建人', 'S', '40', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'CREATETIME', '1', '2021', '87', sys_guid(), 'CREATETIME', 'PERF_T_EVALUATEINFO', '创建时间', 'S', '17', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'EVALUATEMODE', null, '1', 'EVALUATE_MODE', '1', '2016', '87', sys_guid(), 'EVALUATE_MODE', 'PERF_T_EVALUATEINFO', '评价组织实施方式', 'S', '40', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'EVALUATETYPE', null, '1', 'EVALUATE_TYPE', '1', '2016', '87', sys_guid(), 'EVALUATE_TYPE', 'PERF_T_EVALUATEINFO', '评价类型', 'S', '40', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'JXFUNDTYPE', null, '1', 'FUND_TYPE_CODE', '1', '2016', '87', sys_guid(), 'FUND_TYPE_CODE', 'PERF_T_EVALUATEINFO', '项目资金性质', 'S', '40', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'GRADE', '1', '2021', '87', sys_guid(), 'GRADE', 'PERF_T_EVALUATEINFO', '评价结论(等级)', 'S', '40', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'GUID', '1', '2021', '87', sys_guid(), 'GUID', 'PERF_T_EVALUATEINFO', '主键', 'S', '40', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'INSTITUTION_NAME', '1', '2021', '87', sys_guid(), 'INSTITUTION_NAME', 'PERF_T_EVALUATEINFO', '第三方机构名称', 'S', '200', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'LINES', null, '1', 'LINES', '1', '2016', '87', sys_guid(), 'LINES', 'PERF_T_EVALUATEINFO', '线上线下', 'S', '40', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'MAINGUID', '1', '2021', '87', sys_guid(), 'MAINGUID', 'PERF_T_EVALUATEINFO', '关联id', 'S', '40', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'NAME', '1', '2021', '87', sys_guid(), 'NAME', 'PERF_T_EVALUATEINFO', '名称', 'S', '200', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'PROVINCE', '1', '2021', '87', sys_guid(), 'PROVINCE', 'PERF_T_EVALUATEINFO', '省', 'S', '40', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'SCORE', '1', '2021', '87', sys_guid(), 'SCORE', 'PERF_T_EVALUATEINFO', '评价结论(分数)', 'N', '6', 2, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'UPDATETIME', '1', '2021', '87', sys_guid(), 'UPDATETIME', 'PERF_T_EVALUATEINFO', '更新时间', 'S', '17', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'YEAR', '1', '2021', '87', sys_guid(), 'YEAR', 'PERF_T_EVALUATEINFO', '年度', 'S', '40', null, 1, 1, null, sysdate);




delete from bus_t_diccolumn where tablecode = 'PERF_T_FINEVALUATION' and columncode in ('LINES','INSTITUTION_NAME','EVALUATE_MODE','FUND_TYPE_CODE','EVALUATE_TYPE');
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'EVALUATEMODE', null, '1', 'EVALUATE_MODE', '1', '2016', '87', sys_guid(), 'EVALUATE_MODE', 'PERF_T_FINEVALUATION', '评价组织实施方式', 'S', '40', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'EVALUATETYPE', null, '1', 'EVALUATE_TYPE', '1', '2016', '87', sys_guid(), 'EVALUATE_TYPE', 'PERF_T_FINEVALUATION', '评价类型', 'S', '40', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'JXFUNDTYPE', null, '1', 'FUND_TYPE_CODE', '1', '2016', '87', sys_guid(), 'FUND_TYPE_CODE', 'PERF_T_FINEVALUATION', '项目资金性质', 'S', '40', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'INSTITUTION_NAME', '1', '2021', '87', sys_guid(), 'INSTITUTION_NAME', 'PERF_T_FINEVALUATION', '第三方机构名称', 'S', '200', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'LINES', null, '1', 'LINES', '1', '2016', '87', sys_guid(), 'LINES', 'PERF_T_FINEVALUATION', '线上线下', 'S', '40', null, 1, 1, null, sysdate);



delete from BUS_T_DICCOLUMN where tablecode = 'PERF_T_ADJUST' and columncode = 'PRO_LEV';
insert into BUS_T_DICCOLUMN (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'PRO_LEV', '1', '2016', '87', sys_guid(), 'PRO_LEV', 'PERF_T_ADJUST', '项目级次', 'S', '2', null, 1, 1, null, sysdate);


