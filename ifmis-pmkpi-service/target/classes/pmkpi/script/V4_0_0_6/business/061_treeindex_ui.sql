begin
delete FROM Busfw_t_Uitable t where t.key = '/pmkpi/program/report/treeindex';
delete FROM Busfw_t_Uicolumn t where t.key = '/pmkpi/program/report/treeindex';
delete FROM Busfw_t_Uitabpage t where t.key = '/pmkpi/program/report/treeindex';
delete FROM Busfw_t_Uifunction t where t.key = '/pmkpi/program/report/treeindex';

insert into Busfw_t_Uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG, PROVINCE, YEAR)
values ('programtreeindextablecode01', '/pmkpi/program/report/treeindex', 'V_PM_PERF_INDICATOR', 0, 1, 0, null, null, 'pmkpi', '{}', '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('program/report/treeindexcolum008', '/pmkpi/program/report/treeindex', 'WEIGHT', '权重', 16, 0, 0, 0, null, 0, 6, null, null, null, null, 100, 0, 'amt', null, null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('program/report/treeindexcolum007', '/pmkpi/program/report/treeindex', 'LEVELNO', '级次', 12, 0, 0, 0, null, 0, 6, null, null, null, null, 150, 0, 's', null, null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('program/report/treeindexcolum006', '/pmkpi/program/report/treeindex', 'METERUNIT', '计量单位', 11, 1, 1, 0, null, 0, 6, null, null, null, null, 100, 0, 's', null, null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('program/report/treeindexcolum005', '/pmkpi/program/report/treeindex', 'INDEXVAL', '指标值', 10, 1, 1, 0, null, 1, 6, null, null, null, null, 150, 0, 's', null, null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('program/report/treeindexcolum004', '/pmkpi/program/report/treeindex', 'COMPUTESIGN', '计算符号', 9, 1, 1, 0, null, 1, 6, null, '#name', null, null, 100, 1, 'tree', null, null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('program/report/treeindexcolum003', '/pmkpi/program/report/treeindex', 'EXPLAIN', '公式或说明', 4, 0, 1, 0, null, 0, 6, null, null, null, null, 200, 0, 's', null, null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('program/report/treeindexcolum002', '/pmkpi/program/report/treeindex', 'NAME', '指标名称', 3, 1, 1, 0, null, 1, 6, null, null, null, null, 150, 0, 's', null, null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('program/report/treeindexcolum001', '/pmkpi/program/report/treeindex', 'OBLIGATE1', '操作', 1, 1, 0, 0, null, 0, 6, null, null, null, null, 80, 0, 's', null, null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('program/report/treeindexcolum012', '/pmkpi/program/report/treeindex', 'FINDEX', '一级指标', 22, 0, 0, 0, null, 0, 6, null, null, null, null, 150, 0, 's', null, null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('program/report/treeindexcolum013', '/pmkpi/program/report/treeindex', 'SINDEX', '二级指标', 23, 0, 0, 0, null, 0, 6, null, null, null, null, 150, 0, 's', null, null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('program/report/treeindexcolum014', '/pmkpi/program/report/treeindex', 'GUID', 'GUID', 25, 0, 0, 0, null, 0, 6, null, null, null, null, 150, 0, 's', null, null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('program/report/treeindexcolum015', '/pmkpi/program/report/treeindex', 'SUPERID', 'SUPERID', 26, 0, 0, 0, null, 0, 6, null, null, null, null, 150, 0, 's', null, null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('program/report/treeindexcolum016', '/pmkpi/program/report/treeindex', 'KPI_CONTENT', '指标内容', 27, 0, 1, 0, null, 1, 6, null, null, null, null, 150, 0, 's', null, null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('program/report/treeindexcolum017', '/pmkpi/program/report/treeindex', 'KPI_EVALSTD', '扣分标准', 28, 0, 1, 0, null, 1, 6, null, null, null, null, 150, 0, 's', null, null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('program/report/treeindexcolum099', '/pmkpi/program/report/treeindex', 'KPI_REMARK', '备注', 29, 1, 1, 0, null, 0, 6, null, null, null, null, null, 0, 's', null, null, '87', '2016');

insert into Busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER, PROVINCE, YEAR)
values ('program/report/treeindex002', 'pmkpi', '/pmkpi/program/report/treeindex', '年度绩效指标', 'year', 1, 2, 'nomal', 'prjtreeindex.clickTabpage', 0, '年度绩效指标', null, null, '{}', null, '0', null, null, null, null, null, null, null, '87', '2016');

insert into Busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER, PROVINCE, YEAR)
values ('program/report/treeindex001', 'pmkpi', '/pmkpi/program/report/treeindex', '总体绩效指标', 'total', 1, 1, 'choosed', 'prjtreeindex.clickTabpage', 0, '总体绩效指标', null, null, '{}', null, '0', null, null, null, null, null, null, null, '87', '2016');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B9C5A23C0BFA2C8BE053B11FA8C03A18', '/pmkpi/program/report/treeindex', '删除指标', 1, 4, 'keepicon', 'prjtreeindex.del', null, '删除指标', 'pmkpi', 'del', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B9C5A23C0BFB2C8BE053B11FA8C03A18', '/pmkpi/program/report/treeindex', '修改指标', 1, 3, 'keepicon', 'prjtreeindex.mod', null, '修改指标', 'pmkpi', 'mod', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B9C5A23C0BFC2C8BE053B11FA8C03A18', '/pmkpi/program/report/treeindex', '新增指标', 1, 2, 'keepicon', 'prjtreeindex.add', null, '新增指标', 'pmkpi', 'add', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B9C5A23C0BFD2C8BE053B11FA8C03A18', '/pmkpi/program/report/treeindex', '精准推荐', 1, 1, 'keepicon', 'prjtreeindex.recom', null, '精准推荐', 'pmkpi', 'recom', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B9C5A23C0BF92C8BE053B11FA8C03A18', '/pmkpi/program/report/treeindex', '挑选指标', 1, 5, 'keepicon', 'prjtreeindex.pick', null, '挑选指标', 'pmkpi', 'pick', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BA5C77F29C1223DBE053B11FA8C01563', '/pmkpi/program/report/treeindex', '往年预算执行情况', 1, 7, 'keepicon', 'prjtreeindex.budget', null, '往年预算执行情况', 'pmkpi', 'budget', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BA5C77F29C1323DBE053B11FA8C01563', '/pmkpi/program/report/treeindex', '复制上年指标', 1, 6, 'keepicon', 'prjtreeindex.lastyear', null, '复制上年指标', 'pmkpi', 'lastyear', null, null);
