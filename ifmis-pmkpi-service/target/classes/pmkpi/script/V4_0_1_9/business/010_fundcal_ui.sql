begin

delete from bus_t_Dictable where tablecode = 'PERF_T_FUNDCALINDEX';
insert into bus_t_Dictable (YEAR, PROVINCE, TABLECODE, NAME, REMARK, TABLETYPE, VERSION, DBTABNAME, APPID, EXP, TABLEPART, ISSHOW, DBIMPFLAG, ISSYS, ISUSES, VIEWTABLENAME, DBVERSION, DATASYNC, HASTRIGGER, SYNCCLASSNAME, STATUS)
values ('2016', '87', 'PERF_T_FUNDCALINDEX', '绩效指标与项目测算表', '绩效指标与项目测算表', 2, 1, 'PERF_T_FUNDCALINDEX', 'pmkpi', '', '0', 1, '0', 1, 1, 'V_PERF_T_FUNDCALINDEX', sysdate, 1, null, '', '1');

delete from bus_t_Diccolumn where tablecode = 'PERF_T_FUNDCALINDEX';
insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values ('', '', '', '0', 'GUID', '1', '2017', '1500', sys_guid(), 'GUID', 'PERF_T_FUNDCALINDEX', 'GUID', '', '32', null, null, 1, '', sysdate);
insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values ('', '', '', '0', 'INDEXGUID', '1', '2017', '1500', sys_guid(), 'INDEXGUID', 'PERF_T_FUNDCALINDEX', '指标GUID', '', '32', null, null, 1, '', sysdate);
insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values ('', '', '', '0', 'PROCODE', '1', '2017', '1500', sys_guid(), 'PROCODE', 'PERF_T_FUNDCALINDEX', '项目code', '', '32', null, null, 1, '', sysdate);
insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values ('', '', '', '0', 'FUNDGUID', '1', '2017', '1500', sys_guid(), 'FUNDGUID', 'PERF_T_FUNDCALINDEX', '项目测算GUID', '', '32', null, null, 1, '', sysdate);
insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values ('', '', '', '0', 'YEAR', '1', '2017', '1500', sys_guid(), 'YEAR', 'PERF_T_FUNDCALINDEX', '年', '', '32', null, null, 1, '', sysdate);
insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values ('', '', '', '0', 'PROVINCE', '1', '2017', '1500', sys_guid(), 'PROVINCE', 'PERF_T_FUNDCALINDEX', '区划', '', '32', null, null, 1, '', sysdate);
insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values ('', '', '', '0', 'CREATETIME', '1', '2017', '1500', sys_guid(), 'CREATETIME', 'PERF_T_FUNDCALINDEX', '创建时间', '', '32', null, null, 1, '', sysdate);
insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values ('', '', '', '0', 'UPDATETIME', '1', '2017', '1500', sys_guid(), 'UPDATETIME', 'PERF_T_FUNDCALINDEX', '更新时间', '', '32', null, null, 1, '', sysdate);
insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values ('', '', '', '0', 'IS_DELETED', '1', '2017', '1500', sys_guid(), 'IS_DELETED', 'PERF_T_FUNDCALINDEX', '状态', '', '32', null, null, 1, '', sysdate);

delete from bus_t_Dictable where tablecode = 'V_PERF_T_FUNDCALINDEXVIEW';
insert into bus_t_Dictable (YEAR, PROVINCE, TABLECODE, NAME, REMARK, TABLETYPE, VERSION, DBTABNAME, APPID, EXP, TABLEPART, ISSHOW, DBIMPFLAG, ISSYS, ISUSES, VIEWTABLENAME, DBVERSION, DATASYNC, HASTRIGGER, SYNCCLASSNAME, STATUS)
values ('2016', '87', 'V_PERF_T_FUNDCALINDEXVIEW', '绩效指标与项目测算视图', '绩效指标与项目测算视图', 2, 1, 'V_PERF_T_FUNDCALINDEXVIEW', 'pmkpi', '', '0', 1, '0', 1, 1, 'V_PERF_T_FUNDCALINDEXVIEW', sysdate, 1, null, '', '1');


delete from bus_t_Diccolumn where tablecode = 'V_PERF_T_FUNDCALINDEXVIEW';
insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values ('', '', '', '0', 'GUID', '1', '2017', '1500', sys_guid(), 'GUID', 'V_PERF_T_FUNDCALINDEXVIEW', 'GUID', '', '32', null, null, 1, '', sysdate);
insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values ('', '', '', '0', 'FUNDGUID', '1', '2017', '1500', sys_guid(), 'FUNDGUID', 'V_PERF_T_FUNDCALINDEXVIEW', '项目测算GUID', '', '32', null, null, 1, '', sysdate);
insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values ('', 'PDMDICCODEESTDETAIL', '', '0', 'XMLB', '1', '2017', '1500', sys_guid(), 'XMLB', 'V_PERF_T_FUNDCALINDEXVIEW', '明细项目类别', '', '32', null, null, 1, '', sysdate);
insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values ('', 'PDMDICCODEDRATEMP', '', '0', 'XMLX', '1', '2017', '1500', sys_guid(), 'XMLX', 'V_PERF_T_FUNDCALINDEXVIEW', '项目类型', '', '32', null, null, 1, '', sysdate);
insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values ('', '', '', '0', 'XMMXNR', '1', '2017', '1500', sys_guid(), 'XMMXNR', 'V_PERF_T_FUNDCALINDEXVIEW', '项目明细内容', '', '32', null, null, 1, '', sysdate);
insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values ('', '', '', '0', 'BZY', '1', '2017', '1500', sys_guid(), 'BZY', 'V_PERF_T_FUNDCALINDEXVIEW', '标准', '', '32', null, null, 1, '', sysdate);
insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values ('', '', '', '0', 'BZJS', '1', '2017', '1500', sys_guid(), 'BZJS', 'V_PERF_T_FUNDCALINDEXVIEW', '标准解释', '', '32', null, null, 1, '', sysdate);
insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values ('', '', '', '0', 'JLDW1', '1', '2017', '1500', sys_guid(), 'JLDW1', 'V_PERF_T_FUNDCALINDEXVIEW', '计量单位1', '', '32', null, null, 1, '', sysdate);
insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values ('', '', '', '0', 'SL1', '1', '2017', '1500', sys_guid(), 'SL1', 'V_PERF_T_FUNDCALINDEXVIEW', '数量1', '', '32', null, null, 1, '', sysdate);
insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values ('', '', '', '0', 'JLDW2', '1', '2017', '1500', sys_guid(), 'JLDW2', 'V_PERF_T_FUNDCALINDEXVIEW', '计量单位2', '', '32', null, null, 1, '', sysdate);
insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values ('', '', '', '0', 'SL2', '1', '2017', '1500', sys_guid(), 'SL2', 'V_PERF_T_FUNDCALINDEXVIEW', '数量2', '', '32', null, null, 1, '', sysdate);
insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values ('', '', '', '0', 'ZJLYWY', '1', '2017', '1500', sys_guid(), 'ZJLYWY', 'V_PERF_T_FUNDCALINDEXVIEW', '资金来源', '', '32', null, null, 1, '', sysdate);
insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values ('', '', '', '0', 'WEIGHT', '1', '2017', '1500', sys_guid(), 'WEIGHT', 'V_PERF_T_FUNDCALINDEXVIEW', '权重', '', '32', null, null, 1, '', sysdate);
insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values ('', 'PMKPIZBXS', '', '0', 'COMPUTESIGN', '1', '2017', '1500', sys_guid(), 'COMPUTESIGN', 'V_PERF_T_FUNDCALINDEXVIEW', '计算符号', '', '32', null, null, 1, '', sysdate);
insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values ('', 'PMKPIFRAMEPM001', '', '0', 'FINDEX', '1', '2017', '1500', sys_guid(), 'FINDEX', 'V_PERF_T_FUNDCALINDEXVIEW', '一级指标', '', '32', null, null, 1, '', sysdate);
insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values ('', 'PMKPIFRAME', '', '0', 'SINDEX', '1', '2017', '1500', sys_guid(), 'SINDEX', 'V_PERF_T_FUNDCALINDEXVIEW', '二级指标', '', '32', null, null, 1, '', sysdate);
insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values ('', '', '', '0', 'NAME', '1', '2017', '1500', sys_guid(), 'NAME', 'V_PERF_T_FUNDCALINDEXVIEW', '三级指标', '', '32', null, null, 1, '', sysdate);
insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values ('', '', '', '0', 'CODE', '1', '2017', '1500', sys_guid(), 'CODE', 'V_PERF_T_FUNDCALINDEXVIEW', '编码', '', '32', null, null, 1, '', sysdate);
insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values ('', '', '', '0', 'METERUNIT', '1', '2017', '1500', sys_guid(), 'METERUNIT', 'V_PERF_T_FUNDCALINDEXVIEW', '计量单位', '', '32', null, null, 1, '', sysdate);
insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values ('', '', '', '0', 'LEVELNO', '1', '2017', '1500', sys_guid(), 'LEVELNO', 'V_PERF_T_FUNDCALINDEXVIEW', '级次', '', '32', null, null, 1, '', sysdate);
insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values ('', 'ISTRUE', '', '0', 'IS_ADD', '1', '2017', '1500', sys_guid(), 'IS_ADD', 'V_PERF_T_FUNDCALINDEXVIEW', '是否新增', '', '32', null, null, 1, '', sysdate);
insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values ('', '', '', '0', 'INDEXVAL', '1', '2017', '1500', sys_guid(), 'INDEXVAL', 'V_PERF_T_FUNDCALINDEXVIEW', '指标值', '', '32', null, null, 1, '', sysdate);
insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values ('', '', '', '0', 'YEAR', '1', '2017', '1500', sys_guid(), 'YEAR', 'V_PERF_T_FUNDCALINDEXVIEW', '年', '', '32', null, null, 1, '', sysdate);
insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values ('', '', '', '0', 'PROVINCE', '1', '2017', '1500', sys_guid(), 'PROVINCE', 'V_PERF_T_FUNDCALINDEXVIEW', '区划', '', '32', null, null, 1, '', sysdate);
insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values ('', '', '', '0', 'CREATETIME', '1', '2017', '1500', sys_guid(), 'CREATETIME', 'V_PERF_T_FUNDCALINDEXVIEW', '创建时间', '', '32', null, null, 1, '', sysdate);
insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values ('', '', '', '0', 'UPDATETIME', '1', '2017', '1500', sys_guid(), 'UPDATETIME', 'V_PERF_T_FUNDCALINDEXVIEW', '更新时间', '', '32', null, null, 1, '', sysdate);


delete from Bus_t_Pageconsolecomconfig where url = '/pmkpi/fundcalindex/index';
insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/fundcalindex/index', 'perf_fundcalindex', '{}', 'fundcalindex', 'pmkpi', '');

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/fundcalindex/index', 'busuidatatable', '{name:''绩效指标与资金测算'',checkbox:true,edit:true,addrow:false}', 'datatable', 'pmkpi', '');

--insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
--values ('/pmkpi/fundcalindex/index', 'header', '{}', 'header', 'pmkpi', '');

--insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
--values ('/pmkpi/fundcalindex/index', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', '');

DELETE from bus_T_pageconsole where url = '/pmkpi/fundcalindex/index';	
insert into Bus_t_Pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/fundcalindex/index', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', '', '', 'pmkpi', 'gov.mof.fasp2.pmkpi.perfprogram.fundCalIndex.FundCalIndexPage', 'index', '{main:[datatable]}', '', '', 0);

DELETE from Bus_t_Pagecomponent where id = 'perf_fundcalindex';
insert into Bus_t_Pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('perf_fundcalindex', '绩效指标与资金测算', '', '绩效指标与资金测算', '/pmkpi/perfprogram/fundCalIndex/fundCalIndex.js', 'Ext.lt.pmkpi.fundCalIndex.index', 'pmkpi', 'pmkpi.fundCalIndex.FundCalIndexService');


delete from p#busfw_t_uitable where key = '/pmkpi/fundcalindex/index';
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG, PROVINCE, YEAR)--'87','2016'
values ('54FE255E2CCF47419A4CF7332AAA2FDA', '/pmkpi/fundcalindex/index', 'V_PERF_T_FUNDCALINDEXVIEW', 100, 1, 0, '', '', 'pmkpi', '{}','87','2016');

--select * from busfw_t_uicolumn where key = '/pmkpi/fundcalindex/index';

delete from p#busfw_t_uicolumn where key = '/pmkpi/fundcalindex/index';


insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/fundcalindex/index', 'GUID', 'GUID', 0, 0, 0, 0, null, 0, 6, null, null, null, null, 150, 0, 's', null, null, '87','2016');
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/fundcalindex/index', 'FUNDGUID', '资金测算ID', 1, 0, 0, 0, null, 0, 6, null, null, null, null, 150, 0, 's', null, null, '87','2016');
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/fundcalindex/index', 'XMLX', '项目类型	', 2, 1, 0, 0, null, 0, 6, null, '#name', null, null, 150, 1, 'tree', null, null, '87','2016');
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/fundcalindex/index', 'XMLB', '明细项目类别', 3, 1, 0, 0, null, 0, 6, null, '#name', null, null, 150, 1, 'tree', null, null, '87','2016');
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/fundcalindex/index', 'XMMXNR', '项目明细内容', 4, 1, 0, 0, null, 0, 6, null, null, null, null, 150, 0, 's', null, null, '87','2016');
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/fundcalindex/index', 'BZY', '标准', 5, 1, 0, 0, null, 0, 6, null, null, null, null, 50, 0, 's', null, null, '87','2016');
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/fundcalindex/index', 'BZJS', '标准解释', 6, 1, 0, 0, null, 0, 6, null, null, null, null, 150, 0, 's', null, null, '87','2016');
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/fundcalindex/index', 'JLDW1', '计量单位1', 7, 1, 0, 0, null, 0, 6, '[''标准依据1'']', null, null, null, 50, 0, 's', null, null, '87','2016');
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/fundcalindex/index', 'SL1', '数量1', 8, 1, 0, 0, null, 0, 6, '[''标准依据1'']', null, null, null, 50, 0, 's', null, null, '87','2016');
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/fundcalindex/index', 'JLDW2', '计量单位2', 9, 1, 0, 0, null, 0, 6, '[''标准依据2'']', null, null, null, 50, 0, 's', null, null, '87','2016');
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/fundcalindex/index', 'SL2', '数量2', 10, 1, 0, 0, null, 0, 6, '[''标准依据2'']', null, null, null, 50, 0, 's', null, null, '87','2016');
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/fundcalindex/index', 'ZJLYWY', '资金来源（万元）', 11, 1, 0, 0, null, 0, 6, null, null, null, null, 80, 0, 's', null, null, '87','2016');
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/fundcalindex/index', 'PROCODE', 'PROCODE', 12, 0, 0, 0, null, 0, 6, null, null, null, null, 200, 0, 's', null, null, '87','2016');
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/fundcalindex/index', 'OBLIGATE', '操作', 14, 1, 0, 0, null, 0, 6, null, null, null, null, 100, 0, 's', null, null, '87','2016');
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/fundcalindex/index', 'FINDEX', '一级指标', 15, 1, 0, 0, null, 0, 6, '[''指标名称'']', '#name', null, null, 150, 1, 'tree', null, null, '87','2016');
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/fundcalindex/index', 'SINDEX', '二级指标', 16, 1, 0, 0, null, 0, 6, '[''指标名称'']', '#name', null, null, 150, 1, 'tree', null, null, '87','2016');
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/fundcalindex/index', 'NAME', '三级指标', 17, 1, 0, 0, null, 1, 6, '[''指标名称'']', null, null, null, 150, 0, 's', null, null, '87','2016');
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/fundcalindex/index', 'COMPUTESIGN', '计算符号', 18, 1, 0, 0, null, 1, 6, null, '#name', null, null, 100, 1, 'tree', null, null, '87','2016');
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/fundcalindex/index', 'INDEXVAL', '指标值', 19, 1, 1, 0, null, 1, 6, null, null, null, null, 150, 0, 's', null, null, '87','2016');
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/fundcalindex/index', 'METERUNIT', '计量单位', 20, 1, 0, 0, null, 0, 6, null, null, null, null, 100, 0, 's', null, null, '87','2016');
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/fundcalindex/index', 'WEIGHT', '权重', 21, 1, 1, 1, null, 0, 6, null, null, null, null, 100, 0, 'i', null, null, '87','2016');
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/fundcalindex/index', 'KPI_REMARK', '备注', 22, 1, 1, 0, null, 0, 6, null, null, null, null, null, 0, 's', null, null, '87','2016');
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/fundcalindex/index', 'IS_ADD', '是否新增', 23, 1, 0, 0, null, 0, 6, null, '#name', null, null, 80, 1, 'tree', null, null, '87','2016');
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/fundcalindex/index', 'LEVELNO', '级次', 24, 0, 0, 0, null, 0, 6, null, null, null, null, 150, 0, 's', null, null, '87','2016');









