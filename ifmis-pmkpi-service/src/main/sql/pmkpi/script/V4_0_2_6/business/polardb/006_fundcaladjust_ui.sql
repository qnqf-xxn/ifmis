begin 

delete from Bus_t_Pageconsolecomconfig where url = '/pmkpi/fundcalindex/adjustindex';
insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION,PROVINCE)
values ('/pmkpi/fundcalindex/adjustindex', 'perf_fundcaladjustindex', '{}', 'fundcaladjustindex', 'pmkpi', '','87');

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION,PROVINCE)
values ('/pmkpi/fundcalindex/adjustindex', 'busuidatatable', '{name:''绩效指标与资金测算'',checkbox:true,edit:true,addrow:false}', 'datatable', 'pmkpi', '','87');

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION,PROVINCE)
values ('/pmkpi/fundcalindex/adjustindex', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null,'87');


DELETE from bus_T_pageconsole where url = '/pmkpi/fundcalindex/adjustindex';	
insert into Bus_t_Pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND,PROVINCE)
values ('/pmkpi/fundcalindex/adjustindex', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', '', '', 'pmkpi', 'gov.mof.fasp2.pmkpi.perfprogram.fundCalIndex.adjust.FundCalAdjustIndexPage', 'index', '{main:[toolbutton,datatable]}', '', '', 0,'87');

DELETE from Bus_t_Pagecomponent where id = 'perf_fundcaladjustindex';
insert into Bus_t_Pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE,PROVINCE)
values ('perf_fundcaladjustindex', '绩效指标与资金测算', '', '绩效指标与资金测算', '/pmkpi/perfprogram/fundCalIndex/fundCalAdjustIndex.js', 'Ext.lt.pmkpi.fundCalAdjustIndex.index', 'pmkpi', 'pmkpi.fundCalIndex.FundCalAdjustIndexService','87');


DELETE FROM BUSFW_T_UITABPAGE WHERE KEY = '/pmkpi/adjust/report/proedit' and code = 'fundcalindex';
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER,YEAR,PROVINCE)
values (SYS_GUID(), 'pmkpi', '/pmkpi/adjust/report/proedit', '绩效指标调整', 'fundcalindex', 1, 5, 'nomal', 'tabfreamedit.clickTabpage', null, '绩效指标调整', null, '保存', '{url:''/pmkpi/fundcalindex/adjustindex.page''}', null, '0', 'fundcalindexiframe', null, null, null, null, null, null,'2022','331081000');

delete from bus_t_diccolumn t where t.tablecode in('V_PERF_T_FUNDCALINDEXVIEW') and t.dbcolumncode='STATUS';
insert into bus_t_diccolumn (COLUMNID, DBCOLUMNCODE, COLUMNCODE, NAME, TABLECODE, DATATYPE, DATALENGTH, SCALE, NULLABLE, DEFAULTVALUE, DEID, CSID, ISSYS, ISUSES, VERSION)
values ('55DC17531D0B418E9B7F38A93804BA92', 'STATUS', 'STATUS', 'STATUS', 'V_PERF_T_FUNDCALINDEXVIEW', 'N', '1', null, 1, null, null, 'PMKPIDATATYPE', '1', '1', '1');

delete from p#busfw_t_uitable where key = '/pmkpi/fundcalindex/adjustindex';
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG, PROVINCE, YEAR)--'87','2016'
values ('54FE255E2CCF47419A4CF7332AAA2FDA', '/pmkpi/fundcalindex/adjustindex', 'V_PERF_T_FUNDCALINDEXVIEW', 100, 1, 0, '', '', 'pmkpi', '{}','87','2016');



delete from p#busfw_t_uicolumn where key = '/pmkpi/fundcalindex/adjustindex';

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/fundcalindex/adjustindex', 'GUID', 'GUID', 0, 0, 0, 0, null, 0, 6, null, null, null, null, 150, 0, 's', null, null, '87','2016');
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/fundcalindex/adjustindex', 'FUNDGUID', '资金测算ID', 1, 0, 0, 0, null, 0, 6, null, null, null, null, 150, 0, 's', null, null, '87','2016');
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/fundcalindex/adjustindex', 'XMLX', '项目类型	', 2, 1, 0, 0, null, 0, 6, null, '#name', null, null, 150, 1, 'tree', null, null, '87','2016');
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/fundcalindex/adjustindex', 'XMLB', '明细项目类别', 3, 1, 0, 0, null, 0, 6, null, '#name', null, null, 150, 1, 'tree', null, null, '87','2016');
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/fundcalindex/adjustindex', 'XMMXNR', '项目明细内容', 4, 1, 0, 0, null, 0, 6, null, null, null, null, 150, 0, 's', null, null, '87','2016');
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/fundcalindex/adjustindex', 'BZY', '标准', 5, 1, 0, 0, null, 0, 6, null, null, null, null, 50, 0, 's', null, null, '87','2016');
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/fundcalindex/adjustindex', 'BZJS', '标准解释', 6, 1, 0, 0, null, 0, 6, null, null, null, null, 150, 0, 's', null, null, '87','2016');
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/fundcalindex/adjustindex', 'JLDW1', '计量单位1', 7, 1, 0, 0, null, 0, 6, '[''标准依据1'']', null, null, null, 50, 0, 's', null, null, '87','2016');
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/fundcalindex/adjustindex', 'SL1', '数量1', 8, 1, 0, 0, null, 0, 6, '[''标准依据1'']', null, null, null, 50, 0, 's', null, null, '87','2016');
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/fundcalindex/adjustindex', 'JLDW2', '计量单位2', 9, 1, 0, 0, null, 0, 6, '[''标准依据2'']', null, null, null, 50, 0, 's', null, null, '87','2016');
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/fundcalindex/adjustindex', 'SL2', '数量2', 10, 1, 0, 0, null, 0, 6, '[''标准依据2'']', null, null, null, 50, 0, 's', null, null, '87','2016');
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/fundcalindex/adjustindex', 'ZJLYWY', '资金来源（万元）', 11, 1, 0, 0, null, 0, 6, null, null, null, null, 80, 0, 's', null, null, '87','2016');
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/fundcalindex/adjustindex', 'PROCODE', 'PROCODE', 12, 0, 0, 0, null, 0, 6, null, null, null, null, 200, 0, 's', null, null, '87','2016');
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/fundcalindex/adjustindex', 'OBLIGATE', '操作1', 13, 1, 0, 0, null, 0, 6, null, null, null, null, 60, 0, 's', null, null, '87','2016');
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/fundcalindex/adjustindex', 'OBLIGATE1', '操作2', 14, 1, 0, 0, null, 0, 6, null, null, null, null, 60, 0, 's', null, null, '87','2016');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/fundcalindex/adjustindex', 'STATUS', '数据状态', 15, 1, 0, 0, null, 0, null, null, '#name', null, null, 80, 1, 'tree', null, null, '87','2016');
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/fundcalindex/adjustindex', 'FINDEX', '一级指标', 16, 1, 0, 0, null, 0, 6, '[''指标名称'']', '#name', null, null, 150, 1, 'tree', null, null, '87','2016');
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/fundcalindex/adjustindex', 'SINDEX', '二级指标', 17, 1, 0, 0, null, 0, 6, '[''指标名称'']', '#name', null, null, 150, 1, 'tree', null, null, '87','2016');
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/fundcalindex/adjustindex', 'NAME', '三级指标', 18, 1, 0, 0, null, 1, 6, '[''指标名称'']', null, null, null, 150, 0, 's', null, null, '87','2016');
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/fundcalindex/adjustindex', 'COMPUTESIGN', '计算符号', 19, 1, 0, 0, null, 1, 6, null, '#name', null, null, 100, 1, 'tree', null, null, '87','2016');
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/fundcalindex/adjustindex', 'INDEXVAL', '指标值', 20, 1, 0, 0, null, 1, 6, null, null, null, null, 150, 0, 's', null, null, '87','2016');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/fundcalindex/adjustindex', 'ADJUSTINDEXVAL', '调整后指标值', 21, 1, 1, 1, null, 1, null, null, null, null, null, 150, 0, 's', null, null, '87','2016');
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/fundcalindex/adjustindex', 'METERUNIT', '计量单位', 22, 1, 0, 0, null, 0, 6, null, null, null, null, 100, 0, 's', null, null, '87','2016');
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/fundcalindex/adjustindex', 'WEIGHT', '权重', 23, 1, 0, 1, null, 0, 6, null, null, null, null, 100, 0, 'i', null, null, '87','2016');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/fundcalindex/adjustindex', 'ADJUSTWEIGHT', '调整后权重', 24, 1, 1, 1, null, 1, null, null, null, null, null, 150, 0, 's', null, null, '87','2016');
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/fundcalindex/adjustindex', 'KPI_REMARK', '备注', 25, 1, 1, 0, null, 0, 6, null, null, null, null, null, 0, 's', null, null, '87','2016');
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/fundcalindex/adjustindex', 'IS_ADD', '是否新增', 26, 0, 0, 0, null, 0, 6, null, '#name', null, null, 80, 1, 'tree', null, null, '87','2016');
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/fundcalindex/adjustindex', 'LEVELNO', '级次', 27, 0, 0, 0, null, 0, 6, null, null, null, null, 150, 0, 's', null, null, '87','2016');


delete from p#busfw_t_uifunction t where key in('/pmkpi/fundcalindex/adjustindex');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values ('BA0A0BDBBC09FD6DE053B11FA8C09B71', '/pmkpi/fundcalindex/adjustindex', '修改指标', 1, 1, 'keepicon', 'fundcaladjustindex.mod', null, '修改指标', 'pmkpi', 'mod', null, null, '87', '2016');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values ('BA0A0BDBBC0AFD6DE053B11FA8C09B71', '/pmkpi/fundcalindex/adjustindex', '删除指标', 1, 2, 'keepicon', 'fundcaladjustindex.del', null, '删除指标', 'pmkpi', 'del', null, null, '87', '2016');
