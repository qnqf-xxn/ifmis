begin
delete FROM Busfw_t_Uifunction t where t.key in ('/pmkpi/program/prjindex/lastyear','/pmkpi/program/prjindex/budget');
delete FROM Busfw_t_Uitable t where t.key in ('/pmkpi/program/prjindex/lastyear','/pmkpi/program/prjindex/budget');
delete FROM Busfw_t_Uicolumn t where t.key in ('/pmkpi/program/prjindex/lastyear','/pmkpi/program/prjindex/budget');

insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values ('prjindex/lastyear9013', '/pmkpi/program/prjindex/lastyear', '确定', 1, 2, 'addicon', 'pmkpilastyear.addindex', null, '确定', 'pmkpi', 'addindex', null, null, '87', '2016');

insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values ('prjindex/budget9089', '/pmkpi/program/prjindex/budget', '取消', 1, 1, 'delicon', 'pmkpiprjbudget.closewin', null, '取消', 'pmkpi', 'closewin', null, null, '87', '2016');

insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values ('prjindex/lastyear9012', '/pmkpi/program/prjindex/lastyear', '取消', 1, 3, 'delicon', 'pmkpilastyear.closewin', null, '取消', 'pmkpi', 'closewin', null, null, '87', '2016');

insert into Busfw_t_Uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG, PROVINCE, YEAR)
values ('prjindex/lastyear090203', '/pmkpi/program/prjindex/lastyear', 'V_BAS_PERF_INDICATOR', 100, 0, 0, null, null, 'pmkpi', '{}', '87', '2016');

insert into Busfw_t_Uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG, PROVINCE, YEAR)
values ('prjindex/budget902203', '/pmkpi/program/prjindex/budget', 'V_PERF_PRJBUDGETPAY', 0, 0, 0, null, null, 'pmkpi', '{}', '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('prjindex/budget909827', '/pmkpi/program/prjindex/budget', 'ENDAMT', '调整后预算', 15, 1, 0, null, null, null, null, null, null, null, null, null, 0, 'amt', '{}', null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('prjindex/budget909826', '/pmkpi/program/prjindex/budget', 'BDGAMT', '年度预算调整', 14, 1, 0, null, null, null, null, null, null, null, null, null, 0, 'amt', '{}', null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('prjindex/budget909825', '/pmkpi/program/prjindex/budget', 'STARTAMT', '年初预算', 13, 1, 0, 0, null, 1, null, null, null, null, null, 220, 0, 'amt', '{}', null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('prjindex/budget909824', '/pmkpi/program/prjindex/budget', 'AMTSOURCE', '资金来源', 12, 1, 0, null, null, null, null, null, null, null, null, null, 0, 's', '{}', null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('prjindex/budget909823', '/pmkpi/program/prjindex/budget', 'BGTYEAR', '预算年度', 11, 1, 0, null, null, 1, null, null, null, null, null, null, 0, 's', '{}', null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('prjindex/budget909829', '/pmkpi/program/prjindex/budget', 'BGTRATE', '预算执行率', 17, 1, 0, null, null, null, null, null, null, null, null, null, 0, 'amt', '{}', null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('pmkpiprjindexrecomindex011', '/pmkpi/program/prjindex/lastyear', 'INDEXVALUE', '参考值', 15, 1, 0, null, null, null, null, '[''三级指标'']', null, null, null, null, 0, 's', '{}', null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('pmkpiprjindexrecomindex010', '/pmkpi/program/prjindex/lastyear', 'COMPUTESIGN', '性质', 14, 1, 0, null, null, null, null, '[''三级指标'']', '#name', null, null, null, 1, 'tree', '{}', null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('pmkpiprjindexrecomindex009', '/pmkpi/program/prjindex/lastyear', 'NAME', '内容', 13, 1, 0, 0, null, 1, null, '[''三级指标'']', null, null, null, 220, 0, 's', '{}', null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('pmkpiprjindexrecomindex008', '/pmkpi/program/prjindex/lastyear', 'SINDEX', '二级指标', 12, 1, 0, null, null, null, null, null, '#name', null, null, null, 1, 'tree', '{}', null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('pmkpiprjindexrecomindex007', '/pmkpi/program/prjindex/lastyear', 'FINDEX', '一级指标', 11, 1, 0, null, null, 1, null, null, '#name', null, null, null, 1, 'tree', '{}', null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('pmkpiprjindexrecomindex012', '/pmkpi/program/prjindex/lastyear', 'METERUNIT', '单位', 16, 1, 0, null, null, null, null, '[''三级指标'']', null, null, null, null, 0, 's', '{}', null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('pmkpiprjindexrecomindex013', '/pmkpi/program/prjindex/lastyear', 'EXPLAIN', '指标解释', 17, 1, 0, null, null, null, null, null, null, null, null, null, 0, 's', '{}', null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('pmkpiprjindexrecomindex014', '/pmkpi/program/prjindex/lastyear', 'INDEXSTANDARDS', '绩效标准', 35, 1, 0, null, null, null, null, null, '#name', null, null, null, 1, 'tree', '{}', null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('prjindex/budget909828', '/pmkpi/program/prjindex/budget', 'SUMPAYAMT', '累计支出', 16, 1, 0, null, null, null, null, null, null, null, null, null, 0, 'amt', '{}', null, '87', '2016');