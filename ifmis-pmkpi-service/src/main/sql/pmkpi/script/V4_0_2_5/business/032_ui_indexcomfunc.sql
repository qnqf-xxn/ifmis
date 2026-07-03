begin
  
delete FROM p#Busfw_t_Uitable t where t.key = '/pmkpi/setting/zjindexenum';
delete FROM p#Busfw_t_Uicolumn t where t.key = '/pmkpi/setting/zjindexenum';
delete FROM p#Busfw_t_Uifunction t where t.key = '/pmkpi/setting/zjindexenum';
delete FROM p#Busfw_t_Uiqueryform t where t.KEY = '/pmkpi/setting/zjindexenum';

insert into Busfw_t_Uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG, PROVINCE, YEAR)
values ('DC9AA0D6C7406794E0533315A8C0E291', '/pmkpi/setting/zjindexenum', 'V_PERF_T_INDEXCOMFUNC', 0, 0, 0, null, null, 'pmkpi', null, '87', '2016');

insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values ('DC9AA0D6C74F6794E0533315A8C0E291', '/pmkpi/setting/zjindexenum', '保存', 1, 1, 'Keepicon', 'zjtempdata.savemajorkey', null, '保存', 'pmkpi', null, null, null, '87', '2016');

insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values ('DC9AA0D6C74E6794E0533315A8C0E291', '/pmkpi/setting/zjindexenum', '导入码表项目', 1, 2, 'Keepicon', 'zjtempdata.importProj', null, '导入码表项目', 'pmkpi', 'power', null, null, '87', '2016');

insert into Busfw_t_Uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, REQUIREMENT)
values ('DC9AA0D6C7506794E0533315A8C0E291', '/pmkpi/setting/zjindexenum', 'CODE', '编码', 1, 1, 's', null, null, null, 'pmkpi', 'PERF_T_INDEXCOMFUNC', '{}', null, '87', '2016', null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('DC9AA0D6C7416794E0533315A8C0E291', '/pmkpi/setting/zjindexenum', 'STATUS', '状态', 7, 0, 0, 0, null, 0, null, null, null, null, null, 100, 0, 's', null, null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('DC9AA0D6C7426794E0533315A8C0E291', '/pmkpi/setting/zjindexenum', 'DEPT', '部门', 5, 0, 0, 0, null, 0, null, null, null, null, null, 100, 0, 's', null, null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('DC9AA0D6C7436794E0533315A8C0E291', '/pmkpi/setting/zjindexenum', 'AGENCYGUID', '预算单位', 4, 1, 0, 0, null, 0, null, null, '#name', null, null, 250, 1, 'tree', null, null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('DC9AA0D6C7446794E0533315A8C0E291', '/pmkpi/setting/zjindexenum', 'CODE', '编码', 2, 1, 0, 0, null, 1, null, null, null, null, null, 200, 0, 's', null, null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('DC9AA0D6C7456794E0533315A8C0E291', '/pmkpi/setting/zjindexenum', 'GUID', '主键', 0, 0, 0, 0, null, 1, null, null, null, null, null, 0, 0, 's', null, null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('DC9AA0D6C7466794E0533315A8C0E291', '/pmkpi/setting/zjindexenum', 'LEVELNO', '层级', 10, 0, 0, 0, null, 0, null, null, null, null, null, 100, 0, 's', null, null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('DC9AA0D6C7476794E0533315A8C0E291', '/pmkpi/setting/zjindexenum', 'ORDERNUM', '排序', 8, 0, 0, 0, null, 0, null, null, null, null, null, 100, 0, 's', null, null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('DC9AA0D6C7486794E0533315A8C0E291', '/pmkpi/setting/zjindexenum', 'REMARK', '备注', 6, 1, 1, 0, null, 0, null, null, null, null, null, 300, 0, 's', null, null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('DC9AA0D6C7496794E0533315A8C0E291', '/pmkpi/setting/zjindexenum', 'SUPERID', '父级', 12, 0, 0, 0, null, 0, null, null, null, null, null, 100, 0, 's', null, null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('DC9AA0D6C74A6794E0533315A8C0E291', '/pmkpi/setting/zjindexenum', 'ISADD', '操作', 1, 1, 0, 0, null, 0, null, null, null, null, null, 100, 0, 's', null, null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('DC9AA0D6C74B6794E0533315A8C0E291', '/pmkpi/setting/zjindexenum', 'VERSION', '版本', 5, 0, 0, 0, null, 0, null, null, null, null, null, 100, 0, 's', null, null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('DC9AA0D6C74C6794E0533315A8C0E291', '/pmkpi/setting/zjindexenum', 'NAME', '名称', 3, 1, 1, 0, null, 1, null, null, null, null, null, 200, 0, 's', null, null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('DC9AA0D6C74D6794E0533315A8C0E291', '/pmkpi/setting/zjindexenum', 'ISLEAF', '是否末节点', 9, 0, 0, 0, null, 0, null, null, null, null, null, 100, 0, 's', null, null, '87', '2016');

