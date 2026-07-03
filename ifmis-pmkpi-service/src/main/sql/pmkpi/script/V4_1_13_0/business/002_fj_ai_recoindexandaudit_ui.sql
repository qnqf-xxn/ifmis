begin

--1.AI指标推荐
--注册信息
delete from bus_t_diccolumn where tablecode in('PM_PERF_INDICATOR','PM_PERF_INDICATOR_TEMP','PERF_T_ADJUSTINDEX') and columncode ='AI_RECOINDEXMARK';

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'AI_RECOINDEXMARK', '1', '2016', '87', sys_guid(), 'AI_RECOINDEXMARK', 'PM_PERF_INDICATOR', 'AI指标推荐标识', 'S', '40', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'AI_RECOINDEXMARK', '1', '2016', '87', sys_guid(), 'AI_RECOINDEXMARK', 'PM_PERF_INDICATOR_TEMP', 'AI指标推荐标识', 'S', '40', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'AI_RECOINDEXMARK', '1', '2016', '87', sys_guid(), 'AI_RECOINDEXMARK', 'PERF_T_ADJUSTINDEX', 'AI指标推荐标识', 'S', '40', null, 1, 1, null, sysdate);

--列表配置
delete from p#busfw_t_uicolumn t where key ='/pmkpi/program/airecoindex' and columncode in('KPI_TARGET','AI_RECOINDEXMARK');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/airecoindex', 'KPI_TARGET', '绩效目标', 0, 0, 0, 0, null, 0, 1, null, null, null, null, 50, 0, 's', null, null,'87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/airecoindex', 'AI_RECOINDEXMARK', '智能指标推荐标识', 7, 0, 0, 0, null, 0, 1, null, null, null, null, 50, 0, 's', null, null,'87', '2016', null, null);

delete from p#busfw_t_uicolumn where key in ('/pmkpi/program/report/treeindex','/pmkpi/adjust/report/proedit/index') and columncode ='AI_RECOINDEXMARK';

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/report/treeindex', 'AI_RECOINDEXMARK', '智能指标推荐标识', 51, 0, 0, 0, null, 0, 0, null, null, null, null, null, 0, 's', null, null,  '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/adjust/report/proedit/index', 'AI_RECOINDEXMARK', '智能指标推荐标识', 51, 0, 0, 0, null, 0, 0, null, null, null, null, null, 0, 's', null, null,  '87', '2016', null, null);

--项目申报湖北目标指标页签- AI指标推荐按钮 默认隐藏
delete from p#Busfw_t_uifunction t where t.key='/pmkpi/program/report/goalandindex' and code ='AIrecoindex';

insert into p#busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/report/goalandindex', '智能推荐', 0, 0, 'keepicon', 'goalandindex.AIrecoindex', null, '智能推荐', 'pmkpi', 'AIrecoindex', null, '{}', '87', '2016', null, null);

--湖北 引用指标按钮
delete from p#Busfw_t_uifunction t where t.key='/pmkpi/program/airecoindex' and code ='addindexhb' and action = 'airecoindex.addindexhb';

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/program/airecoindex', '引用(湖北)', 0, 1, 'keepicon', 'airecoindex.addindexhb', null, '引用', 'pmkpi', 'addindexhb', null, null,'87', '2016');

--修复之前错误的code
update p#Busfw_t_uifunction set code = 'addindex' where key='/pmkpi/program/airecoindex' and action = 'airecoindex.addindex';

update p#Busfw_t_uifunction set code = 'closewin' where key='/pmkpi/program/airecoindex' and action = 'airecoindex.closewin';

update p#Busfw_t_uifunction set code = 'query' where key='/pmkpi/program/airecoindex' and action = 'airecoindex.query';


--2.AI智能审核
--项目年度绩效查询菜单- 绩效目标智能审核 默认隐藏
delete from p#busfw_t_uifunction t where t.key='/pmkpi/yearprogram/query/list' and code in ('AIaudit','AIaudit2');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/yearprogram/query/list', '绩效目标智能审核', 0, 0, 'searchicon', 'Ext.lt.pmkpi.aisupportaudit', null, '绩效目标智能审核', 'pmkpi', 'AIaudit', null, '{}', '87', '2016', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/yearprogram/query/list', '绩效目标智能审核(记录查询)', 0, 0, 'searchicon', 'Ext.lt.pmkpi.aisupportaudit', null, '绩效目标智能审核(记录查询)', 'pmkpi', 'AIaudit2', null, '{isloadtaskdata:"1"}', '87', '2016', null, null);

--智能审核列表配置 新增扩展备用审核项
delete from p#busfw_t_uicolumn t where key ='/pmkpi/common/aisupportaudit' and columncode in ('AUDITPOINT4','AUDITPOINT5');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/common/aisupportaudit', 'AUDITPOINT4', '备用审核项4', 8, 0, 0, 0, null, 0, 1, null, null, null, null, 200, 0, 's', null, null,'87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/common/aisupportaudit', 'AUDITPOINT5', '备用审核项5', 9, 0, 0, 0, null,0, 1, null, null, null, null, 200, 0, 's', null, null,'87', '2016', null, null);
