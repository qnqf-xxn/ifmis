BEGIN

delete from p#busfw_t_uitabpage t where t.key in('/pmkpi/evaluation/financial/result/edit') and code = 'gdIndex';
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER,YEAR,PROVINCE)
values (sys_guid(), 'pmkpi', '/pmkpi/evaluation/financial/result/edit', '债券绩效指标', 'gdIndex', 1, 9, 'nomal', 'tabfreamedit.clickTabpage', null, '债券绩效指标', null, '保存', '{url:''/pmkpi/evaluation/gd/gdindex.page'',action:''gdfinindex.save''}', null, '0', 'gdIndexiframe', null, null, null, null, null, null,'2016','87');

delete from p#busfw_t_uitable t where t.key in('/pmkpi/evaluation/gd/gdindex');
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG,YEAR,PROVINCE)
values (sys_guid(), '/pmkpi/evaluation/gd/gdindex', 'V_PERF_T_SELFPERFINDEX', 100, 1, 0, null, null, 'pmkpi', null,'2016','87');


delete from p#busfw_t_uicolumn t where t.key in('/pmkpi/evaluation/gd/gdindex');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, isvisiable, isedit, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,YEAR,PROVINCE)
values (sys_guid(), '/pmkpi/evaluation/gd/gdindex', 'GUID', '主键ID', 1, 0, 0, 0, '0', 0, 6, null, null, null, 0, 100, 0, 's', '{}', null,'2016','87');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,YEAR,PROVINCE)
values (sys_guid(), '/pmkpi/evaluation/gd/gdindex', 'NAME', '指标名称', 4, 1, 0, 0, '0', 0, 6, null, null, null, 0, 180, 0, 's', '{}', null,'2016','87');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,YEAR,PROVINCE)
values (sys_guid(), '/pmkpi/evaluation/gd/gdindex', 'COMPUTESIGN', '计算符号', 5, 1, 0, 0, '0', 0, 6, null, '#name', null, 0, 100, 1, 'tree', '{}', null,'2016','87');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,YEAR,PROVINCE)
values (sys_guid(), '/pmkpi/evaluation/gd/gdindex', 'INDEXVAL', '指标值', 6, 1, 0, 0, '0', 0, 6, null, null, null, 0, 150, 0, 's', '{}', null,'2016','87');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,YEAR,PROVINCE)
values (sys_guid(), '/pmkpi/evaluation/gd/gdindex', 'ACTUALVALUE', '实际完成值', 7, 0, 1, 0, '0', 1, 6, null, null, null, 0, 150, 0, 's', '{}', null,'2016','87');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,YEAR,PROVINCE)
values (sys_guid(), '/pmkpi/evaluation/gd/gdindex', 'METERUNIT', '计量单位', 8, 1, 0, 0, '0', 0, 6, null, null, null, 0, 100, 0, 's', '{}', null,'2016','87');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,YEAR,PROVINCE)
values (sys_guid(), '/pmkpi/evaluation/gd/gdindex', 'WEIGHT', '权重', 9, 1, 1, 1, '0', 1, 1, null, '{unit: 1, dotname: 2, qfw: true}', null, 0, 100, 0, 'i', '{}', null,'2016','87');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,YEAR,PROVINCE)
values (sys_guid(), '/pmkpi/evaluation/gd/gdindex', 'ACTUALWEIGHT', '权重', 10, 0, 0, 1, '0', 1, 1, null, '{unit: 1, dotname: 2, qfw: true}', null, 0, 100, 0, 'i', '{}', null,'2016','87');


insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,YEAR,PROVINCE)
values (sys_guid(), '/pmkpi/evaluation/gd/gdindex', 'EVAL_VALUE', '绩效评分', 12, 1, 1, 1, '0', 1, 1, null, '{unit: 1, dotname: 2, qfw: true}', null, 0, 100, 0, 'i', '{}', null,'2016','87');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,YEAR,PROVINCE)
values (sys_guid(), '/pmkpi/evaluation/gd/gdindex', 'devi_analy', '目标偏差分析及整改措施', 14, 1, 1, 0, '0', 1, 6, null, null, null, 0, 200, 0, 's', '{}', null,'2016','87');

delete from p#busfw_t_uitable t where t.key in('/pmkpi/setting/gd/gdindex');
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG,YEAR,PROVINCE)
values (sys_guid(), '/pmkpi/setting/gd/gdindex', 'V_GD_PERF_INDICATOR', 100, 1, 0, null, null, 'pmkpi', null,'2016','87');

delete from p#busfw_t_uicolumn t where t.key in ('/pmkpi/setting/gd/gdindex');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, isvisiable, isedit, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,YEAR,PROVINCE)
values (sys_guid(), '/pmkpi/setting/gd/gdindex', 'GUID', '主键ID', 1, 0, 0, 0, '0', 0, 6, null, null, null, 0, 100, 0, 's', '{}', null,'2016','87');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/setting/gd/gdindex', 'IS_DELETED', '状态', 2, 1, 0, null, null, null, null, null, '#name', null, null, null, 1, 'tree', '{}', null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/setting/gd/gdindex', 'FINDEX', '一级指标', 3, 1, 0, null, null, 1, null, null, '#name', null, null, null, 1, 'tree', '{}', null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/setting/gd/gdindex', 'SINDEX', '二级指标', 4, 1, 0, null, null, null, null, null, '#name', null, null, null, 1, 'tree', '{}', null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/setting/gd/gdindex', 'PERF_IND_NAME', '名称', 5, 1, 0, 0, null, 1, null, '[''三级指标'']', null, null, null, 220, 0, 's', '{}', null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/setting/gd/gdindex', 'COMPUTESIGN', '符号', 6, 1, 0, null, null, null, null, '[''三级指标'']', '#name', null, null, null, 1, 'tree', '{}', null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/setting/gd/gdindex', 'FULL_VALUE', '指标值', 6, 1, 0, null, null, null, null, '[''三级指标'']', null, null, null, null, 0, 's', '{}', null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/setting/gd/gdindex', 'UNIT', '单位', 7, 1, 0, null, null, null, null, '[''三级指标'']', null, null, null, null, 0, 's', '{}', null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/setting/gd/gdindex', 'VALUE_DESC', '指标解释', 8, 1, 0, null, null, null, null, null, null, null, null, null, 0, 's', '{}', null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/setting/gd/gdindex', 'PERF_IND_CODE', '指标编码', 9, 0, 0, null, null, null, null, null, null, null, null, null, 0, 's', '{}', null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/setting/gd/gdindex', 'AGENCY_CODE', '预算单位', 10, 0, 0, null, null, null, null, null, '#name', null, null, null, 1, 'tree', '{iscommon:"0"}', null, '87', '2016');



delete from p#busfw_t_uifunction t where t.key in ('/pmkpi/setting/gd/gdindex');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/setting/gd/gdindex', '删除', 1, 3, 'searchicon', 'gdindex.del', null, '删除', 'pmkpi', 'del', null, '{}', '87', '2016');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/setting/gd/gdindex', '修改', 1, 2, 'searchicon', 'gdindex.mod', null, '修改', 'pmkpi', 'mod', null, '{}', '87', '2016');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/setting/gd/gdindex', '新增', 1, 1, 'searchicon', 'gdindex.add', null, '新增', 'pmkpi', 'add', null, '{}', '87', '2016');


delete from p#busfw_t_uiqueryform t where t.key in('/pmkpi/setting/gd/gdindex');

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, REQUIREMENT,YEAR,PROVINCE)
values (sys_guid(), '/pmkpi/setting/gd/gdindex', 'PERF_IND_NAME', '三级指标名称', 4, 1, 's', null, null, null, 'pmkpi', 'V_GD_PERF_INDICATOR', null, null, null,'2016','87');


delete from P#busfw_t_uifunction t where t.key in ('/pmkpi/gdindex/edit');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/gdindex/edit', '取消', 1, 2, 'searchicon', 'Ext.lt.ui.closeModalWindow', null, '取消', 'pmkpi', 'cancle', null, '{}', '87', '2016');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/gdindex/edit', '保存', 1, 1, 'searchicon', 'gdindexedit.save', null, '保存', 'pmkpi', 'save', null, '{}', '87', '2016');

delete from p#busfw_t_uieditform t where t.key in ('/pmkpi/gdindex/edit');

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/gdindex/edit', 'V_GD_PERF_INDICATOR', 's', '单位id', 'AGENCYGUID', 0, null, 0, null, 1, null, null, 'pmkpi', 1, null, '{}', null, null, null, '87', '2016');

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/gdindex/edit', 'V_GD_PERF_INDICATOR', 's', '单位id', 'AGENCY_CODE', 0, null, 0, null, 2, null, null, 'pmkpi', 1, null, '{}', null, null, null, '87', '2016');

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/gdindex/edit', 'V_GD_PERF_INDICATOR', 's', '编码', 'PERF_IND_CODE', 0, null, 0, null, 3, null, null, 'pmkpi', 1, null, '{}', null, null, null, '87', '2016');

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/gdindex/edit', 'V_GD_PERF_INDICATOR', 'tree', '一级指标', 'FINDEX', 0, null, 0, null, 4, null, null, 'pmkpi', 1, 0, '{format:''#name''}', 0, 1, null, '87', '2016');

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/gdindex/edit', 'V_GD_PERF_INDICATOR', 's', 'guid', 'GUID', 0, null, 0, null, 5, null, null, 'pmkpi', 1, null, '{}', null, null, null, '87', '2016');

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/gdindex/edit', 'V_GD_PERF_INDICATOR', 's', '指标名称', 'PERF_IND_NAME', 1, null, 1, null, 6, null, null, 'pmkpi', 1, null, '{}', null, null, null, '87', '2016');

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/gdindex/edit', 'V_GD_PERF_INDICATOR', 'tree', '层次分类', 'SINDEX', 1, null, 1, null, 7, null, null, 'pmkpi', 1, null, '{format:''#name''}', null, null, null, '87', '2016');

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/gdindex/edit', 'V_GD_PERF_INDICATOR', 'tree', '计算符号', 'COMPUTESIGN', 1, null, 1, null, 8, null, null, 'pmkpi', 1, null, '{format:''#name''}', null, null, null, '87', '2016');

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/gdindex/edit', 'V_GD_PERF_INDICATOR', 's', '指标值', 'FULL_VALUE', 1, null, 0, null, 9, null, null, 'pmkpi', 1, null, '{}', null, null, null, '87', '2016');

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/gdindex/edit', 'V_GD_PERF_INDICATOR', 's', '计量单位', 'UNIT', 1, null, 0, null, 10, null, null, 'pmkpi', 1, null, '{}', null, null, null, '87', '2016');

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/gdindex/edit', 'V_GD_PERF_INDICATOR', 'textarea', '指标值说明', 'VALUE_DESC', 1, null, 1, null, 11, 3, '3', 'pmkpi', 1, null, '{}', null, null, null, '87', '2016');


