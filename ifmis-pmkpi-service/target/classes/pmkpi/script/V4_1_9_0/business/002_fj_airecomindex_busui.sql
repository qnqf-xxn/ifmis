begin

--按钮
delete from p#Busfw_t_uifunction t where t.key='/pmkpi/program/airecoindex';

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/program/airecoindex', '引用', 1, 1, 'keepicon', 'airecoindex.addindex', null, '引用', 'pmkpi', 'save', null, null,'87', '2016');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/program/airecoindex', '返回', 1, 1, 'keepicon', 'airecoindex.closewin', null, '返回', 'pmkpi', 'save', null, null,'87', '2016');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/program/airecoindex', '重新推荐', 1, 1, 'keepicon', 'airecoindex.query', null, '重新推荐', 'pmkpi', 'save', null, null,'87', '2016');

--随便给一个配置占位，实际没用
delete from p#busfw_t_uieditform where key ='/pmkpi/program/airecoindex';

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR, HEAD, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/airecoindex', 'V_PM_PERF_GOAL_INFO', 'tree', '空', 'KPI_TARGET', 1, null, 0, null, 0, null, null, 'pmkpi', 1, null, '{}', null, null, null,'87', '2016', null, null, null);

--推荐指标列表
delete from p#busfw_t_uitable where key in('/pmkpi/program/airecoindex');

insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/program/airecoindex', 'V_PM_PERF_INDICATOR', 0, 0, 0, null, null, 'pmkpi', null,'87', '2016');

delete from p#busfw_t_uicolumn t where key ='/pmkpi/program/airecoindex';

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/airecoindex', 'FINDEXNAME', '一级指标', 1, 1, 0, 0, null, 0, 1, null, null, null, null, 100, 0, 's', null, null,'87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/airecoindex', 'SINDEXNAME', '二级指标', 2, 1, 0, 0, null, 0, 1, null, null, null, null, 100, 0, 's', null, null,'87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/airecoindex', 'FINDEX', '一级指标', 1, 0, 0, 0, null, 0, 1, null, null, null, null, 100, 0, 's', null, null,'87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/airecoindex', 'SINDEX', '二级指标', 2, 0, 0, 0, null, 0, 1, null, null, null, null, 100, 0, 's', null, null,'87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/airecoindex', 'NAME', '指标名称', 3, 1, 0, 0, null, 0, 1, null, null, null, null, 150, 0, 's', null, null,'87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/airecoindex', 'COMPUTESIGN', '计算符号', 4, 1, 0, 0, null, 0, 1, null, '#name', null, null, 50, 1, 'tree', null, null,'87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/airecoindex', 'INDEXVAL', '指标值', 5, 1, 0, 0, null,0, 1, null, null, null, null, 100, 0, 's', null, null,'87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/airecoindex', 'METERUNIT', '计量单位', 6, 1, 0, 0, null, 0, 1, null, null, null, null, 50, 0, 's', null, null,'87', '2016', null, null);

--项目申报指标页签- AI指标推荐按钮 默认隐藏
delete from p#Busfw_t_uifunction t where t.key='/pmkpi/program/report/treeindex' and code ='AIrecoindex';

insert into p#busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/report/treeindex', 'AI指标推荐', 0, 15, 'keepicon', 'prjtreeindex.AIrecoindex', null, 'AI指标推荐', 'pmkpi', 'AIrecoindex', null, '{api_key:"app-SbKqXvBUyHhC5EQqpGzDn4qw"}', '87', '2016', null, null);
