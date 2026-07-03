begin

--目标日志ui配置
delete from p#busfw_t_uitable where key ='/pmkpi/program/report/protabgoal/loglist';

insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/program/report/protabgoal/loglist', 'V_PM_PERF_GOAL_INFO', 100, 0, 0, null, null, 'pmkpi', null, '87', '2016');
  
delete from p#busfw_t_uicolumn where key = '/pmkpi/program/report/protabgoal/loglist';

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/report/protabgoal/loglist', 'GUID', 'GUID', 1, 0, 1, 0, null, 1, 1, null, null, null, null, null, 0, 's', null, null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/report/protabgoal/loglist', 'KPI_TARGET', '绩效目标', 2, 1, 1, 0, null, 1, 1, null, null, null, null, null, 0, 's', null, null, '87', '2016', null, null);


--指标日志ui配置
delete from p#busfw_t_uitable where key ='/pmkpi/program/report/treeindex/loglist';

insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/program/report/treeindex/loglist', 'V_PM_PERF_INDICATOR', 100, 0, 0, null, null, 'pmkpi', null, '87', '2016');
   
delete from p#busfw_t_uicolumn where key = '/pmkpi/program/report/treeindex/loglist';

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/report/treeindex/loglist', 'NAME', '指标名称', 3, 1, 1, 0, null, 1, 1, null, null, null, null, 150, 0, 's', null, null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/report/treeindex/loglist', 'COMPUTESIGN', '计算符号', 9, 1, 1, 0, null, 1, 1, null, '#name', null, null, 100, 1, 'tree', null, null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/report/treeindex/loglist', 'INDEXVAL', '指标值', 10, 1, 1, 0, null, 1, 1, null, null, null, null, 150, 0, 's', null, null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/report/treeindex/loglist', 'METERUNIT', '计量单位', 11, 1, 1, 0, null, 0, 1, null, null, null, null, 100, 0, 's', null, null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/report/treeindex/loglist', 'LEVELNO', '级次', 12, 0, 0, 0, null, 0, 1, null, null, null, null, 150, 0, 's', null, null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/report/treeindex/loglist', 'FINDEX', '一级指标', 22, 0, 0, 0, null, 0, 1, null, null, null, null, 150, 0, 's', null, null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/report/treeindex/loglist', 'SINDEX', '二级指标', 23, 0, 0, 0, null, 0, 1, null, null, null, null, 150, 0, 's', null, null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/report/treeindex/loglist', 'GUID', 'GUID', 25, 0, 0, 0, null, 0, 1, null, null, null, null, 150, 0, 's', null, null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/report/treeindex/loglist', 'SUPERID', 'SUPERID', 26, 0, 0, 0, null, 0, 1, null, null, null, null, 150, 0, 's', null, null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/report/treeindex/loglist', 'KPI_CONTENT', '指标内容', 27, 0, 1, 0, null, 1, 1, null, null, null, null, 150, 0, 's', null, null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/report/treeindex/loglist', 'KPI_EVALSTD', '扣分标准', 28, 0, 1, 0, null, 1, 1, null, null, null, null, 150, 0, 's', null, null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/report/treeindex/loglist', 'EXPLAIN', '（参考值SX）指标解释', 29, 0, 0, 0, null, 0, 1, null, null, null, null, 150, 0, 's', null, null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/report/treeindex/loglist', 'KPI_REMARK', '备注', 29, 1, 1, 0, null, 0, 1, null, null, null, null, null, 0, 's', null, null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/report/treeindex/loglist', 'QNINDEXVAL', '历史值', 30, 0, 1, 0, null, 0, 1, null, null, null, null, 100, 0, 's', null, null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/report/treeindex/loglist', 'SNINDEXVAL', '上年自评值', 31, 0, 1, 0, null, 0, 1, null, null, null, null, 100, 0, 's', null, null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/report/treeindex/loglist', 'INDEXSTANDARDS', '绩效标准', 34, 0, 1, 0, null, 0, 1, null, '#name', null, null, 150, 1, 'tree', null, null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/report/treeindex/loglist', 'COMPUTETYPE', '计算公式', 35, 0, 1, 0, null, 0, 1, null, null, null, null, 150, 0, 's', null, null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/report/treeindex/loglist', 'ENDVALTYPE', '取值方式', 36, 0, 1, 0, null, 0, 1, null, '#name', null, null, 100, 1, 'tree', null, null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/report/treeindex/loglist', 'ENDVALSOURCE', '指标完成值数据来源', 37, 0, 1, 0, null, 0, 1, null, '#name', null, null, 100, 1, 'tree', null, null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/report/treeindex/loglist', 'WEIGHT', '指标分值权重', 38, 0, 1, 0, null, 0, 1, null, '2', null, null, 100, 0, 'i', null, null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/report/treeindex/loglist', 'VALRULE', '赋分规则', 39, 0, 1, 0, null, 0, 1, null, null, null, null, 100, 0, 's', null, null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/report/treeindex/loglist', 'EVIDENCEFILE', '佐证资料要求', 40, 0, 1, 0, null, 0, 1, null, '#name', null, null, 100, 1, 'tree', null, null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/report/treeindex/loglist', 'VALUE_REMARK', '指标值说明', 47, 0, 1, 0, null, 0, 1, null, null, null, null, null, 0, 's', null, null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/report/treeindex/loglist', 'ISAPPLY', '是否适用', 50, 1, 1, 0, null, 1, 1, null, '#name', null, null, null, 1, 'tree', null, null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/report/treeindex/loglist', 'ISSTANDPUSH', '绩效指标来源', 51, 0, 1, 0, null, 0, 1, null, '#name', null, null, 150, 1, 'tree', null, null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/report/treeindex/loglist', 'REFERENCESTANDARDS', '参考值确定依据', 51, 0, 1, 0, null, 0, 1, null, null, null, null, 150, 0, 's', null, null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/report/treeindex/loglist', 'ISALLOWEDIT', '是否允许编辑', 51, 0, 1, 0, null, 1, 1, null, '#name', null, null, null, 1, 'tree', '{"prolev":"1"}', null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/report/treeindex/loglist', 'OPINION_REMARK', '审核意见', 51, 0, 0, 0, null, 0, 1, null, null, null, null, 200, 0, 's', '{"datalength":4000}', null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/report/treeindex/loglist', 'REFERENCEVAL', '参考值', 51, 0, 1, 0, null, 0, 1, null, null, null, null, 150, 0, 's', null, null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/report/treeindex/loglist', 'SUMTYPE', '汇总方式', 52, 0, 1, 0, null, 1, 1, null, '#name', null, null, null, 1, 'tree', '{"prolev":"1"}', null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/report/treeindex/loglist', 'ONLYSELF', '仅本级适用', 52, 0, 1, 0, null, 1, 1, null, '#name', null, null, null, 1, 'tree', '{"prolev":"1"}', null, '87', '2016', null, null);


--事前评估日志ui配置
delete from p#busfw_t_uitable where key ='/pmkpi/program/assessment/list/loglist';

insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/program/assessment/list/loglist', 'V_PERF_T_ASSESSMENT', 100, 0, 0, null, null, 'pmkpi', null, '87', '2016');
  
delete from p#busfw_t_uicolumn where key = '/pmkpi/program/assessment/list/loglist';

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/assessment/list/loglist', 'GUID', 'GUID', 1, 0, 0, 0, null, 0, 1, null, null, null, null, 150, 0, 's', null, null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/assessment/list/loglist', 'NAME', '指标名称', 2, 1, 0, 0, null, 0, 1, null, null, null, null, 280, 0, 's', null, null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/assessment/list/loglist', 'WEIGHT', '权重', 3, 1, 0, 0, null, 0, 1, null, null, null, null, 100, 0, 'amt', null, null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/assessment/list/loglist', 'POINTS', '评估要点', 4, 1, 0, 0, null, 0, 1, null, null, null, null, 500, 0, 's', null, null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/assessment/list/loglist', 'SCORENUM', '评估得分', 6, 1, 1, 0, null, 1, 1, null, null, null, null, 100, 0, 's', null, null, '87', '2016', null, null);


--日志页面组件注册，用于页面配置维护
delete from bus_t_pageconsole t where t.url in('/pmkpi/program/assessment/list/loglist');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/program/assessment/list/loglist', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfprogram.assessment.PerfAssessmentPage', 'index', '{main:[datatable]}', null, null, 0);

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/program/assessment/list/loglist');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION) values ('/pmkpi/program/assessment/list/loglist', 'pmkpi_perfassessment', '{}', 'perfassessment', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION) values ('/pmkpi/program/assessment/list/loglist', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION) values ('/pmkpi/program/assessment/list/loglist', 'busuidatatable', '{headsort:false,addrow:false,nogroupbox:false,name:''事前绩效评估日志'',edit:true,checkbox:false,title:''事前绩效评估日志'', groupcols:[''guid'',''superid'',''name'',''levelno''],treedata:true,treemapping:null,initlevel:6,isuphide:false,editgroupdata:true,nextSibling:false}', 'datatable', 'pmkpi', null);


delete from bus_t_pageconsole t where t.url in('/pmkpi/program/report/protabgoal/loglist');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/program/report/protabgoal/loglist', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', '', '', 'pmkpi', 'gov.mof.fasp2.pmkpi.tabfream.TabfreamPage', 'index', '{main:[toolbutton,tabpage,datatable]}', '', '', 0);

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/program/report/protabgoal/loglist');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION) values ('/pmkpi/program/report/protabgoal/loglist', 'pmkpi_tabfreamlist', '{}', 'tabfreamlist', 'pmkpi', '');
insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION) values ('/pmkpi/program/report/protabgoal/loglist', 'busuidatatable', '{headsort:false,addrow:false,nogroupbox:true,edit:true,checkbox:true,groupcols:[''guid'',''superid'',''name'',''levelno''],treedata:true,treemapping:null,initlevel:6,isuphide:false,editgroupdata:true,nextSibling:false}', 'datatable', 'pmkpi', null);
insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION) values ('/pmkpi/program/report/protabgoal/loglist', 'bustabpage', '{key:''/pmkpi/program/report/protabgoal''}', 'tabpage', 'pmkpi', null);
insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION) values ('/pmkpi/program/report/protabgoal/loglist', 'bustoolbutton', '{key:''/pmkpi/program/report/protabgoal''}', 'toolbutton', 'pmkpi', null);


delete from bus_t_pageconsole t where t.url in('/pmkpi/program/report/treeindex/loglist');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/program/report/treeindex/loglist', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfprogram.prjindex.PrjIndexPage', 'index', '{main:[toolbutton,tabpage,datatable]}', null, null, null);

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/program/report/treeindex/loglist');
insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION) values ('/pmkpi/program/report/treeindex/loglist', 'pmkpi_prjtreeindex', '{}', 'prjtreeindex', 'pmkpi', null);
insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION) values ('/pmkpi/program/report/treeindex/loglist', 'busuidatatable', '{headsort:false,addrow:false,nogroupbox:true,edit:true,checkbox:true,groupcols:[''guid'',''superid'',''name'',''levelno''],treedata:true,treemapping:null,initlevel:6,isuphide:false,editgroupdata:true,nextSibling:false}', 'datatable', 'pmkpi', null);
insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION) values ('/pmkpi/program/report/treeindex/loglist', 'bustabpage', '{key:''/pmkpi/program/report/treeindex''}', 'tabpage', 'pmkpi', null);
insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION) values ('/pmkpi/program/report/treeindex/loglist', 'bustoolbutton', '{key:''/pmkpi/program/report/treeindex''}', 'toolbutton', 'pmkpi', null);


--页面配置菜单节点
delete from perf_t_pagemenu where superguid = 'D574940480DC7ED4E0533315A8C059D3' and uikey in ('/pmkpi/program/report/protabgoal/loglist','/pmkpi/program/report/treeindex/loglist','/pmkpi/program/assessment/list/loglist');

insert into perf_t_pagemenu (GUID, CODE, NAME, UIKEY, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, STATUS, CREATETIME, UPDATETIME, CREATER, PROVINCE, YEAR)
values ('2E5120EE57160C3DE065CAE22F328D41', '11', '项目库绩效目标日志', '/pmkpi/program/report/protabgoal/loglist', 'D574940480DC7ED4E0533315A8C059D3', 3, 1, 1, 1, '20250217144944', '20250217144944', '2ABB1E119E395E6EEC48EFA9D6ABB0CD', '87', '2016');

insert into perf_t_pagemenu (GUID, CODE, NAME, UIKEY, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, STATUS, CREATETIME, UPDATETIME, CREATER, PROVINCE, YEAR)
values ('2E5120EE57170C3DE065CAE22F328D41', '12', '项目库绩效指标日志', '/pmkpi/program/report/treeindex/loglist', 'D574940480DC7ED4E0533315A8C059D3', 3, 1, 1, 1, '20250217144944', '20250217144944', '2ABB1E119E395E6EEC48EFA9D6ABB0CD', '87', '2016');

insert into perf_t_pagemenu (GUID, CODE, NAME, UIKEY, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, STATUS, CREATETIME, UPDATETIME, CREATER, PROVINCE, YEAR)
values ('2E5120EE57180C3DE065CAE22F328D41', '13', '项目库绩效事前评估日志', '/pmkpi/program/assessment/list/loglist', 'D574940480DC7ED4E0533315A8C059D3', 3, 1, 1, 1, '20250217144944', '20250217144944', '2ABB1E119E395E6EEC48EFA9D6ABB0CD', '87', '2016');
