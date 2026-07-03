begin

--评审模板配置02
--1.业务表注册
delete from p#busfw_t_uitable where key = '/pmkpi/setting/reviewset';
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('75B1592FB9F14A3889B6E71B2B3408E0', '/pmkpi/setting/reviewset', 'PERF_T_REVIEWTEMP', 0, 0, 0, ' order by ORDERNUM', null, 'pmkpi', null);


--2.展示列注册  
delete from p#Busfw_t_Uicolumn where key = '/pmkpi/setting/reviewset';
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('A8BF4C9344564D32B19F86A6FDA7E9AE', '/pmkpi/setting/reviewset', 'GUID', '主键', 1, 0, 0, 0, null, 1, null, null, null, null, null, 150, null, 's', null, null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('33A5BECBDF98427CB0FBA343CCB5FDEF', '/pmkpi/setting/reviewset', 'NAME', '名称', 2, 1, 1, 0, null, 1, null, null, null, null, null, 150, null, 's', null, null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('33A5BECBDF98427CB0FBA343CCB5FDEF', '/pmkpi/setting/reviewset', 'CONTEXT', '内容', 3, 1, 1, 0, null, 1, null, null, null, null, null, 150, null, 's', null, null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('33A5BECBDF98427CB0FBA343CCB5FDEF', '/pmkpi/setting/reviewset', 'ORDERNUM', '排序', 5, 1, 1, 0, null, 1, null, null, null, null, null, 150, null, 'n', null, null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D452E10846DA4B8EBD0FCFAC662B3767', '/pmkpi/setting/reviewset', 'CODE', '编码', 4, 1, 1, 0, null, 1, null, null, null, null, null, 150, null, 's', null, null);

--3.按钮注册--关联bus_t_pageconsolecomconfig表ID
delete from p#busfw_t_uifunction where key = '/pmkpi/setting/reviewset';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('1A218DF2483E4046829FC16243FF089B', '/pmkpi/setting/reviewset', '保存', 1, 1, 'searchicon', 'perfdataset.savemajorkey', null, '保存', 'pmkpi', 'savemajorkey', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('AD1FB9EC01A44DC1B79EFE76D2D285F1', '/pmkpi/setting/reviewset', '初始化', 1, 2, 'openstat', 'perfdataset.initset', null, '初始化', 'pmkpi', 'initset', '1', '{}');

--4.查询区注册
delete from p#busfw_t_uiqueryform where key = '/pmkpi/setting/reviewset';
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('EEA558EAD76E4722A395C07FC440CFEF', '/pmkpi/setting/reviewset', 'NAME', '名称', 1, 1, 's', null, 0, 0, 'pmkpi', 'PERF_T_REVIEWTEMP', '{}', null);
