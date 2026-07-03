begin

delete from bus_t_pagecomponent t where t.id in('pmkpi_indexlist');
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_indexlist', '绩效指标录入页面', null, '绩效指标录入页面', '/buscommon/fileimport/js/import.js,/pmkpi/setting/indexlib/indexrplist.js', 'Ext.lt.pmkpi.indexlist', 'pmkpi', 'pmkpi.setting.indexlib.report.IndexRpService');


delete from p#busfw_t_uieditform t where t.key='/pmkpi/deptperformance/report/editindex' and t.columncode='KPIVALSOURCE';
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('C0CBBAAFE7D31AB2E053B11FA8C08E3B', '/pmkpi/deptperformance/report/editindex', 'V_PM_PERF_INDICATOR', 'tree', '指标值', 'KPIVALSOURCE', 0, null, 1, null, 4, null, null, 'pmkpi', 1, null, '{format:''#name''}', null, null, null);

delete from p#busfw_t_uieditform t where t.key='/pmkpi/adjust/report/proedit/editindex' and t.columncode='KPIVALSOURCE';
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('C0DD64C271EF3784E053B11FA8C0A051', '/pmkpi/adjust/report/proedit/editindex', 'V_PERF_T_ADJUSTINDEX', 'tree', '指标值', 'KPIVALSOURCE', 0, null, 1, null, 4, null, null, 'pmkpi', 1, null, '{format:''#name''}', null, null, null);

update p#busfw_t_uifunction t set t.isvisiable=1, t.name='指标推荐',t.title='指标推荐' where key='/pmkpi/adjust/report/edit/index' and t.code='recom';