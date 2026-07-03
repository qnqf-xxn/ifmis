begin

--dic
delete from bus_t_diccolumn where tablecode in('PM_PERF_INDICATOR','PM_PERF_INDICATOR_TEMP') and columncode ='IS_INTOINDEXLIB';

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'VD00001', null, '1', 'IS_INTOINDEXLIB', '1', '2016', '87', sys_guid(), 'IS_INTOINDEXLIB', 'PM_PERF_INDICATOR', '是否已纳入指标库', 'N', '1', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'VD00001', null, '1', 'IS_INTOINDEXLIB', '1', '2016', '87', sys_guid(), 'IS_INTOINDEXLIB', 'PM_PERF_INDICATOR_TEMP', '是否已纳入指标库', 'N', '1', null, 1, 1, null, sysdate);


--ui
delete from p#busfw_t_uicolumn where key ='/pmkpi/program/report/treeindex' and columncode ='IS_INTOINDEXLIB' and province = '87' and year = '2016';

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/report/treeindex', 'IS_INTOINDEXLIB', '已纳入指标库', 53, 0, 0, 0, null, 0, 1, null, '#name', null, null, null, 1, 'tree', null, null,  '87', '2016', null, null);

delete from p#busfw_t_uifunction where key ='/pmkpi/intoindexlib/index' and province = '87' and year = '2016';

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/intoindexlib/index', '填报要素说明', 0, 1, 'Nofinishicon', 'intoindexlibcommon.reportelementexplan', null, '填报要素说明', 'pmkpi', 'reportelementexplan', null, '{}', '87', '2016');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/intoindexlib/index', '纳入指标库', 1, 2, 'Nofinishicon', 'intoindexlibcommon.initindex', null, '纳入指标库', 'pmkpi', 'initindex', null, '{}', '87', '2016');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/intoindexlib/index', '取消', 1, 3, 'Nofinishicon', 'Ext.lt.ui.closeModalWindow', null, '取消', 'pmkpi', 'close', null, '{}', '87', '2016');


--纳入指标填报要素说明 页面
delete from p#busfw_t_uifunction where key ='/pmkpi/intoindexlib/explan' and province = '87' and year = '2016';

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/intoindexlib/explan', '返回', 1, 1, 'keepicon', 'intoindexlibexplan.close', null, '返回', 'pmkpi', 'save', null, null, '87', '2016');

delete from p#busfw_t_uitable where key ='/pmkpi/intoindexlib/explan' and province = '87' and year = '2016';

insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/intoindexlib/explan', 'PERF_T_INTOINDEXLIBEXPLAN', 0, 0, 0, 'order by ordernum', null, 'pmkpi', '{}', '87', '2016');

delete from p#busfw_t_uicolumn t where key ='/pmkpi/intoindexlib/explan' and province = '87' and year = '2016';

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/intoindexlib/explan', 'EXPLAN_TYPE', '分类', 1, 1, 0, 0, null, 0, 0, null, null, null, null, 100, 0, 's', null, null, null, null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/intoindexlib/explan', 'EXPLAN_CODE', '字段名称', 2, 1, 0, 0, null, 1, 1, null, null, null, null, 100, 0, 's', null, null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/intoindexlib/explan', 'EXPLAN_DESC', '字段说明', 3, 1, 0, 0, null, 1, 1, null, null, null, null, 100, 0, 's', null, null, '87', '2016', null, null);


--纳入指标填报要素说明 固定数据
delete from perf_t_intoindexlibexplan;

insert into perf_t_intoindexlibexplan (EXPLAN_TYPE, EXPLAN_CODE, EXPLAN_DESC, ORDERNUM)
values ('支出分类', '行业领域', '对标2025年政府预算支出功能分类科目的“类”', 1);

insert into perf_t_intoindexlibexplan (EXPLAN_TYPE, EXPLAN_CODE, EXPLAN_DESC, ORDERNUM)
values ('支出分类', '行业类别', '对标2025年政府预算支出功能分类科目的“款”', 2);

insert into perf_t_intoindexlibexplan (EXPLAN_TYPE, EXPLAN_CODE, EXPLAN_DESC, ORDERNUM)
values ('支出分类', '资金用途', '对标预算项目支出方向', 3);

insert into perf_t_intoindexlibexplan (EXPLAN_TYPE, EXPLAN_CODE, EXPLAN_DESC, ORDERNUM)
values ('绩效指标', '一级指标', '统一分类，主要包括产出指标、效益指标、满意度指标等', 4);

insert into perf_t_intoindexlibexplan (EXPLAN_TYPE, EXPLAN_CODE, EXPLAN_DESC, ORDERNUM)
values ('绩效指标', '二级指标', '统一分类，主要包括数量指标、质量指标、时效指标、成本指标、经济效益指标、社会效益指标、生态效益指标、可持续影响指标、服务对象满意度指标等', 5);

insert into perf_t_intoindexlibexplan (EXPLAN_TYPE, EXPLAN_CODE, EXPLAN_DESC, ORDERNUM)
values ('绩效指标', '三级指标', '分行业分领域的个性指标，定量三级指标中设置指标性质、单位', 6);

insert into perf_t_intoindexlibexplan (EXPLAN_TYPE, EXPLAN_CODE, EXPLAN_DESC, ORDERNUM)
values ('绩效指标', '指标解释', '三级指标的定义或解释，明确定量指标的计算方法或统计口径、定性指标的衡量内容和衡量方法', 7);

insert into perf_t_intoindexlibexplan (EXPLAN_TYPE, EXPLAN_CODE, EXPLAN_DESC, ORDERNUM)
values ('绩效标准', '计划标准', '预先制定的中长期或年度规划、计划、目标等数据', 8);

insert into perf_t_intoindexlibexplan (EXPLAN_TYPE, EXPLAN_CODE, EXPLAN_DESC, ORDERNUM)
values ('绩效标准', '历史标准', '历史年度完成值或前三年平均值', 9);

insert into perf_t_intoindexlibexplan (EXPLAN_TYPE, EXPLAN_CODE, EXPLAN_DESC, ORDERNUM)
values ('绩效标准', '行业标准', '国家公布的行业标准明确的指标数据或统一的技术要求和规范', 10);

insert into perf_t_intoindexlibexplan (EXPLAN_TYPE, EXPLAN_CODE, EXPLAN_DESC, ORDERNUM)
values ('绩效标准', '预算支出标准', '用于成本指标的取值，不得超出规定的预算支出标准设置目标值。', 11);

insert into perf_t_intoindexlibexplan (EXPLAN_TYPE, EXPLAN_CODE, EXPLAN_DESC, ORDERNUM)
values ('绩效标准', '其他标准', '其他来源及数据口径的参考标准', 12);

insert into perf_t_intoindexlibexplan (EXPLAN_TYPE, EXPLAN_CODE, EXPLAN_DESC, ORDERNUM)
values ('其他', '关键词', '方便实现指标检索和自动匹配', 13);


--页面配置节点

delete from perf_t_pagemenu where guid in('9626E5AC206BBB6358851E24813D08D5','509FBF4DC78C037ECC952778A3ECC82D');

insert into perf_t_pagemenu (GUID, CODE, NAME, UIKEY, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, STATUS, CREATETIME, UPDATETIME, CREATER, PROVINCE, YEAR)
values ('9626E5AC206BBB6358851E24813D08D5', '8', '纳入指标库', '/pmkpi/intoindexlib/index', 'D574940480DC7ED4E0533315A8C059D3', 3, 1, 8, 1, '20260602134505', '20260602134505', '2ABB1E119E395E6EEC48EFA9D6ABB0CD', '87', '2016');

insert into perf_t_pagemenu (GUID, CODE, NAME, UIKEY, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, STATUS, CREATETIME, UPDATETIME, CREATER, PROVINCE, YEAR)
values ('509FBF4DC78C037ECC952778A3ECC82D', '1', '填报要素说明', '/pmkpi/intoindexlib/explan', '9626E5AC206BBB6358851E24813D08D5', 4, 1, 1, 1, '20260604102048', '20260604102048', '2ABB1E119E395E6EEC48EFA9D6ABB0CD', '87', '2016');



