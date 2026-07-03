BEGIN


-- page
delete from bus_t_pageconsolecomconfig where url = '/pmkpi/protrace/thirdaudit/opinion/index';

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/protrace/thirdaudit/opinion/index', 'pmkpi_jxyindex', '{}', 'jxyindex', 'pmkpi', null, null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/protrace/thirdaudit/opinion/index', 'busuidatatable', '{name:''绩效评价指标'',checkbox:true,title:''绩效评价指标'',edit:false ,addrow:false}', 'datatable', 'pmkpi', null, null);

delete from bus_t_pageconsole where url = '/pmkpi/protrace/thirdaudit/opinion/index' ;

insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/protrace/thirdaudit/opinion/index', 'template8', '/busfw/common/template/template_defautl.jsp', '/busfw/common/template/template_default.js,/pmkpi/common/perfcommon.js,/pmkpi/common/perfutil.js,/pmkpi/common/ueditor/ueditor.config.js,/pmkpi/common/ueditor/ueditor.all.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfprotrace.thirdaudit.ProTraceThirdAuditPage', 'jxyindex', '{main:[datatable]}', null, null, 0);


delete from bus_t_pagecomponent where id = 'pmkpi_jxyindex' ;

insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_jxyindex', '绩效云绩效评价指标', null, '绩效云绩效评价指标', '/pmkpi/perfprotrace/thirdaudit/index.js', 'Ext.lt.pmkpi.index', 'pmkpi', 'pmkpi.perfprotrace.thirdaudit.ProIndexService');


-- ui
delete from p#busfw_t_uifunction where key = '/pmkpi/program/trace/thirdaudit' and code = 'getResult' and province='87' and year='2016';

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/trace/thirdaudit', '同步绩效云数据', 1, 10, 'searchicon', 'protracethirdaudit.getResult', null, '同步绩效云', 'pmkpi', 'getResult', null, '{}', '87', '2016', null, null);

delete from p#busfw_t_uitabpage where key = '/pmkpi/protrace/thirdaudit/opinion' and code = 'index' and province='87' and year='2016'; 

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, PROVINCE, YEAR, DEFAULTFILTER, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), 'pmkpi', '/pmkpi/protrace/thirdaudit/opinion', '绩效评价指标', 'index', 1, 2, 'nomal', 'tabfreamedit.clickTabpage', null, '绩效评价指标', null, '', '{url:''/pmkpi/protrace/thirdaudit/opinion/index.page''}', null, '0', 'indexiframe', null, null, null, null, null, '87', '2016', null, null, null);

delete from p#busfw_t_uifunction where key = '/pmkpi/evaluation/financial/resultupload' and code = 'getResult' and province='87' and year='2016';

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/evaluation/financial/resultupload', '同步绩效云数据', 1, 10, 'searchicon', 'finevaluationresult.getResult', null, '同步绩效云', 'pmkpi', 'getResult', null, '{}', '87', '2016', null, null);

delete from p#busfw_t_uitabpage where key = '/pmkpi/evaluation/financial/result/editnx' and code = 'index' and province='87' and year='2016'; 

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, PROVINCE, YEAR, DEFAULTFILTER, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), 'pmkpi', '/pmkpi/evaluation/financial/result/editnx', '绩效评价指标', 'index', 1, 2, 'nomal', 'tabfreamedit.clickTabpage', null, '绩效评价指标', null, '', '{url:''/pmkpi/protrace/thirdaudit/opinion/index.page''}', null, '0', 'indexiframe', null, null, null, null, null, '87', '2016', null, null, null);



delete from p#busfw_t_uitable where key = '/pmkpi/protrace/thirdaudit/opinion/index' and province='87' and year='2016';

insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/protrace/thirdaudit/opinion/index', 'V_PERF_T_JXY_INDICATOR', 100, 0, null, null, null, 'pmkpi', '{}', '87', '2016');

delete from p#busfw_t_uicolumn where key = '/pmkpi/protrace/thirdaudit/opinion/index' and province='87' and year='2016';

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/protrace/thirdaudit/opinion/index', 'IND_ID', '主键', 0, 0, 0, null, null, null, 1, null, null, null, null, null, 0, 's', '{}', null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/protrace/thirdaudit/opinion/index', 'IND_CODE1', '一级指标编码', 1, 1, 0, null, null, null, 1, null, null, null, null, null, 0, 's', '{}', null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/protrace/thirdaudit/opinion/index', 'IND_NAME1', '一级指标名称', 2, 1, 0, null, null, null, 1, null, null, null, null, null, 0, 's', '{}', null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/protrace/thirdaudit/opinion/index', 'IND_CODE2', '二级指标编码', 3, 1, 0, null, null, null, 1, null, null, null, null, null, 0, 's', '{}', null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/protrace/thirdaudit/opinion/index', 'IND_NAME2', '二级指标名称', 4, 1, 0, null, null, null, 1, null, null, null, null, null, 0, 's', '{}', null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/protrace/thirdaudit/opinion/index', 'IND_CODE3', '三级指标编码', 5, 1, 0, null, null, null, 1, null, null, null, null, null, 0, 's', '{}', null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/protrace/thirdaudit/opinion/index', 'IND_NAME3', '三级指标名称', 6, 1, 0, null, null, null, 1, null, null, null, null, null, 0, 's', '{}', null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/protrace/thirdaudit/opinion/index', 'KPI_SCORE', '得分', 7, 1, 0, null, null, null, 1, null, null, null, null, null, 0, 's', '{}', null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/protrace/thirdaudit/opinion/index', 'KPI_CONTENT', '指标解释', 8, 1, 0, null, null, null, 1, null, null, null, null, null, 0, 's', '{}', null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/protrace/thirdaudit/opinion/index', 'KPI_EVALSTD', '评分标准', 9, 1, 0, null, null, null, 1, null, null, null, null, null, 0, 's', '{}', null, '87', '2016', null, null);



-- dic
delete from bus_t_dictable where tablecode = 'PERF_T_JXY_INDICATOR';

insert into bus_t_dictable (YEAR, PROVINCE, TABLECODE, NAME, REMARK, TABLETYPE, VERSION, DBTABNAME, APPID, EXP, TABLEPART, ISSHOW, DBIMPFLAG, ISSYS, ISUSES, VIEWTABLENAME, DBVERSION, DATASYNC, HASTRIGGER, SYNCCLASSNAME, STATUS)
values ('2016', '87', 'PERF_T_JXY_INDICATOR', '绩效云评价指标表', '绩效云评价指标表', 2, 1, 'V_PERF_T_JXY_INDICATOR', 'pmkpi', null, '0', 1, null, 1, 1, null, sysdate, 1, 1, null, '1');

delete from bus_t_diccolumn where tablecode = 'PERF_T_JXY_INDICATOR' ;

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'IND_ID', '1', '2016', '87', sys_guid(), 'IND_ID', 'PERF_T_JXY_INDICATOR', 'IND_ID', 'S', '40', null, null, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'PRO_CODE', '1', '2016', '87', sys_guid(), 'PRO_CODE', 'PERF_T_JXY_INDICATOR', '项目编码', 'S', '40', null, null, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'IND_CODE1', '1', '2016', '87', sys_guid(), 'IND_CODE1', 'PERF_T_JXY_INDICATOR', '一级指标编码', 'S', '40', null, null, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'IND_NAME1', '1', '2016', '87', sys_guid(), 'IND_NAME1', 'PERF_T_JXY_INDICATOR', '一级指标名称', 'S', '500', null, null, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'IND_CODE2', '1', '2016', '87', sys_guid(), 'IND_CODE2', 'PERF_T_JXY_INDICATOR', '二级指标编码', 'S', '40', null, null, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'IND_NAME2', '1', '2016', '87',  sys_guid(), 'IND_NAME2', 'PERF_T_JXY_INDICATOR', '二级指标名称', 'S', '500', null, null, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'IND_CODE3', '1', '2016', '87', sys_guid(), 'IND_CODE3', 'PERF_T_JXY_INDICATOR', '三级指标编码', 'S', '40', null, null, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'IND_NAME3', '1', '2016', '87',  sys_guid(), 'IND_NAME3', 'PERF_T_JXY_INDICATOR', '三级指标名称', 'S', '500', null, null, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'YEAR', '1', '2016', '87',  sys_guid(), 'YEAR', 'PERF_T_JXY_INDICATOR', '年份', 'S', '40', null, null, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'PROVINCE', '1', '2016', '87',  sys_guid(), 'PROVINCE', 'PERF_T_JXY_INDICATOR', '区划', 'S', '40', null, null, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'KPI_SCORE', '1', '2016', '87',  sys_guid(), 'KPI_SCORE', 'PERF_T_JXY_INDICATOR', '得分', 'S', '20', null, null, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'KPI_CONTENT', '1', '2016', '87',  sys_guid(), 'KPI_CONTENT', 'PERF_T_JXY_INDICATOR', '指标解释', 'S', '2000', null, null, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'KPI_EVALSTD', '1', '2016', '87',  sys_guid(), 'KPI_EVALSTD', 'PERF_T_JXY_INDICATOR', '评分标准', 'S', '2000', null, null, 1, null, sysdate);

