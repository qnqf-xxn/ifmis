begin

--1.事前绩效评估-业务表注册
delete from p#busfw_t_uitable where key = '/pmkpi/assess/query';
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('19FE30B446E949C3B77BCCADB3472255', '/pmkpi/assess/query', 'V_PERF_PROJECT_INFO', 100, 0, 0, null, null, 'pmkpi', null);

--2.事前绩效评估-展示列注册
delete from p#Busfw_t_Uicolumn where key = '/pmkpi/assess/query';
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('396C62B658D341AFA5765F316FCFB9AA', '/pmkpi/assess/query', 'PRO_NAME', '项目名称', 2, 1, 0, null, null, null, 1, null, null, null, null, 200, 0, 's', '{}', null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('FC522B2698FE492DBDF1665DE767A6B6', '/pmkpi/assess/query', 'AGENCY_CODE', '预算单位', 3, 1, 0, null, null, null, null, null, '#code-#name', null, null, 200, 1, 'tree', '{}', null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('7490FDFAA8AA421284E35A3F62911B32', '/pmkpi/assess/query', 'YEAR', '预算年份', 4, 1, 0, null, null, null, 1, null, null, null, null, 100, 0, 's', '{}', null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BFB839C07A4C405BA3973D58344B684D', '/pmkpi/assess/query', 'CREATE_TIME', '填报时间', 9, 1, 0, null, null, null, 1, null, 'yyyy-MM-dd hh:mm:ss', null, null, 100, 0, 'd', '{}', null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('A361B5F008E4416C8645A3340EBB17A1', '/pmkpi/assess/query', 'FININTORGGUID', '业务科室', 13, 1, 0, null, null, null, null, null, '#name', null, null, 100, 1, 'tree', '{}', null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('CAEF9E37E02844808C11068CEFBA83CC', '/pmkpi/assess/query', 'CREATER', '创建人', 14, 0, 0, null, null, null, null, null, '#name', null, null, 100, 1, 'tree', '{}', null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('5A63338C5A324E48AAF109C889E6F77C', '/pmkpi/assess/query', 'WFSTATUS', '审核状态', 15, 1, 0, null, null, null, null, null, '#name', null, null, 100, 1, 'tree', '{}', null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B572ACF591074427BDF6325B3B27A036', '/pmkpi/assess/query', 'PRO_NAME', '名称', 0, 0, 0, 0, null, 0, 0, null, null, null, null, 200, 1, 's', null, null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('3E844726DFCD4245B99426F48C9DF157', '/pmkpi/assess/query', 'PRO_CODE', '项CODE', 1, 0, 0, null, null, null, 1, null, null, null, null, 200, 0, 's', '{}', null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B47ECC5377464A6386371B5028B60FCE', '/pmkpi/assess/query', 'PRO_ID', '项目ID', 1, 0, 0, null, null, null, 1, null, null, null, null, 200, 0, 's', '{}', null);

--3.事前绩效评估-按钮注册
delete from p#busfw_t_uifunction where key = '/pmkpi/assess/query';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('CD1BAC7AD32E4BCBBA83099D2AD93118', '/pmkpi/assess/query', '审核情况', 1, 2, 'searchicon', 'assessquery.queryaudit', null, '审核情况', 'pmkpi', 'queryaudit', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('7A7BD4E0C35542709BC5E89967938F63', '/pmkpi/assess/query', '查询', 0, 1, 'searchicon', 'assessquery.query', null, '查询', 'pmkpi', 'query', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('88E10C86801849F2A064546619321455', '/pmkpi/assess/query', '查看项目明细', 1, 4, 'searchicon', 'assessquery.showProjView', null, '查看项目明细', 'pmkpi', 'showProjView', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('F708BC1D610540C5B57163460817D36F', '/pmkpi/assess/query', '导出列表', 1, 3, 'searchicon', 'assessquery.export', null, '导出列表', 'pmkpi', 'export', null, null);


--4.事前绩效评估-查询区注册
delete from p#busfw_t_uiqueryform where key = '/pmkpi/assess/query';
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('392FC26FB55147F2986A2C35366D1509', '/pmkpi/assess/query', 'WFSTATUS', '审核状态', 2, 1, 'tree', null, null, null, 'pmkpi', 'V_PERF_PROJECT_INFO', null, null);

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('DAA499BFABE346D6AA86CBDEF97167C3', '/pmkpi/assess/query', 'PRO_NAME', '名称', 1, 1, 's', null, null, null, 'pmkpi', 'V_PERF_PROJECT_INFO', null, null);

