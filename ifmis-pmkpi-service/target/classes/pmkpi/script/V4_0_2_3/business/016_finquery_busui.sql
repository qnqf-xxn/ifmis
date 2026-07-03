begin

--财政评价项目查询-busui
--UI表注册
delete from p#busfw_t_uitable where key = '/pmkpi/evaluation/financial/query';
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('D42C217B4BEA2931E0533315A8C044CA', '/pmkpi/evaluation/financial/query', 'V_PERF_T_FINEVALUATION', 100, 0, null, null, '', 'pmkpi', '{}');

--展示列注册
delete from p#Busfw_t_Uicolumn where key = '/pmkpi/evaluation/financial/query';
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('CCF16B4354D66519E0530B4B050A695B', '/pmkpi/evaluation/financial/query', 'NAME', '项目名称', 1, 1, 0, null, null, null, 1, null, null, null, null, 150, 0, 's', '{ispro:1}', null);
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D42DB4B01D6064FAE0533315A8C01883', '/pmkpi/evaluation/financial/query', 'CODE', '项目编码', 2, 1, 0, null, null, null, 6, null, null, null, null, 80, 0, 's', '{ispro:1}', null);
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D42DB4B01D6164FAE0533315A8C01883', '/pmkpi/evaluation/financial/query', 'AGENCYGUID', '预算单位', 3, 1, 0, null, null, null, null, null, '#code-#name', null, null, 150, 1, 'tree', '{ispro:1}', null);
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D42DB4B01D6264FAE0533315A8C01883', '/pmkpi/evaluation/financial/query', 'PRO_TOTAL_AMT', '项目总金额', 4, 1, 0, 0, null, 0, 6, null, null, null, null, 100, 0, 's', '{ispro:1}', null);
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D42DB4B01D6364FAE0533315A8C01883', '/pmkpi/evaluation/financial/query', 'WFSTATUS', '状态', 5, 1, 0, null, null, null, null, null, '#name', null, null, 80, 1, 'tree', '{ispro:1}', null);
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D42DB4B01D6464FAE0533315A8C01883', '/pmkpi/evaluation/financial/query', 'CATEGORY', '财政评价类型', 6, 0, 0, 0, null, 0, 6, null, '#name', null, null, 200, 1, 'tree', '{ispro:1}', null);
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D42DB4B01D6564FAE0533315A8C01883', '/pmkpi/evaluation/financial/query', 'FININTORGGUID', '牵头处室', 7, 1, 0, null, null, null, null, null, '#name', null, null, 90, 1, 'tree', '{ispro:1}', null);
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D42DB4B01D6764FAE0533315A8C01883', '/pmkpi/evaluation/financial/query', 'AGENCYGUID', '部门名称', 8, 1, 0, null, null, null, null, null, '#code-#name', null, null, 150, 1, 'tree', '{isdept:1}', null);
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D42DB4B01D6864FAE0533315A8C01883', '/pmkpi/evaluation/financial/query', 'FININTORGGUID', '主管处室', 9, 1, 0, null, null, null, null, null, '#name', null, null, 90, 1, 'tree', '{isdept:1}', null);
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BD672DCCF3358602E053B11FA8C0BE47', '/pmkpi/evaluation/financial/query', 'SELFSCORE', '自评得分', 10, 0, 0, null, null, null, 6, null, null, null, null, 150, 0, 's', '{}', null);
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BD672DCCF32C8602E053B11FA8C0BE47', '/pmkpi/evaluation/financial/query', 'YEAR', '预算年份', 11, 1, 0, null, null, null, 1, null, null, null, null, 80, 0, 's', '{}', null);

--按钮
delete from p#busfw_t_uifunction where key = '/pmkpi/evaluation/financial/query';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('D42C217B4BEC2931E0533315A8C044CA', '/pmkpi/evaluation/financial/query', '查看项目明细', 1, 1, 'searchicon', 'finevalquery.detailed', null, '查看项目明细', 'pmkpi', 'detailed', null, '{}');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('D42C217B4BED2931E0533315A8C044CA', '/pmkpi/evaluation/financial/query', '审核情况', 1, 2, 'searchicon', 'finevalquery.queryaudit', null, '审核情况', 'pmkpi', 'queryaudit', null, '{}');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('D42C217B4BEB2931E0533315A8C044CA', '/pmkpi/evaluation/financial/query', '查看自评信息', 0, 3, 'searchicon', 'finevalquery.queryassessment', null, '查看自评信息', 'pmkpi', 'queryassessment', null, '{}');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('CCF16B4354D56519E0530B4B050A695B', '/pmkpi/evaluation/financial/query', '导出指标附件', 1, 5, 'searchicon', 'finevalquery.batchExp', null, '导出指标附件', 'pmkpi', 'batchExp', null, '{"zipname":""}');

--查询区
delete from p#busfw_t_uiqueryform where key = '/pmkpi/evaluation/financial/query';
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('D42C217B4BEE2931E0533315A8C044CA', '/pmkpi/evaluation/financial/query', 'NAME', '名称', 1, 1, 's', null, null, null, 'pmkpi', 'V_PERF_T_FINEVALUATION', '{}', null);
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('D42C217B4BEF2931E0533315A8C044CA', '/pmkpi/evaluation/financial/query', 'FININTORGGUID', '业务处室', 1, 1, 'tree', null, null, null, 'pmkpi', 'V_PERF_T_FINEVALUATION', '{format:''#name''}', null);
