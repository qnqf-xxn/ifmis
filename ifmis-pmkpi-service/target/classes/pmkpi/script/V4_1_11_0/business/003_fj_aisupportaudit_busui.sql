begin

--按钮
delete from p#Busfw_t_uifunction t where t.key='/pmkpi/common/aisupportaudit';

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/common/aisupportaudit', '导出', 1, 1, 'keepicon', 'aisupportaudit.expxls', null, '导出', 'pmkpi', 'expxls', null, '{key:"/pmkpi/common/aisupportaudit"}', '87', '2016');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/common/aisupportaudit', '返回', 1, 3, 'keepicon', 'aisupportaudit.closewin', null, '返回', 'pmkpi', 'closewin', null, null, '87', '2016');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/common/aisupportaudit', '保存结果记录', 1, 2, 'keepicon', 'aisupportaudit.saveresult', null, '保存结果记录', 'pmkpi', 'saveresult', null, null, '87', '2016');


--随便给一个配置占位用来渲染思考过程，实际没用
delete from p#busfw_t_uieditform where key ='/pmkpi/common/aisupportaudit';

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR, HEAD, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/common/aisupportaudit', 'V_PM_PERF_GOAL_INFO', 's', '...', 'KPI_TARGET', 1, null, 0, null, 0, null, null, 'pmkpi', 1, null, '{}', null, null, null,'87', '2016', null, null, null);

--推荐指标列表
delete from p#busfw_t_uitable where key in('/pmkpi/common/aisupportaudit');

insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/common/aisupportaudit', 'V_PERF_T_AISUPPORTAUDIRESULT', 100, 0, 0, null, null, 'pmkpi', null,'87', '2016');

delete from p#busfw_t_uicolumn t where key ='/pmkpi/common/aisupportaudit';

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/common/aisupportaudit', 'AGENCY_CODE', '单位编码', 1, 1, 0, 0, null, 0, 1, null, null, null, null, 80, 0, 's', null, null,'87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/common/aisupportaudit', 'AGENCY_NAME', '单位名称', 2, 1, 0, 0, null, 0, 1, null, null, null, null, 100, 0, 's', null, null,'87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/common/aisupportaudit', 'PRO_CODE', '项目编码', 3, 1, 0, 0, null, 0, 1, null, null, null, null, 100, 0, 's', null, null,'87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/common/aisupportaudit', 'PRO_NAME', '项目名称', 4, 1, 0, 0, null, 0, 1, null, null, null, null, 150, 0, 's', null, null,'87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/common/aisupportaudit', 'AUDITPOINT1', '指标值合理性', 5, 1, 0, 0, null, 0, 1, null, null, null, null, 200, 0, 's', null, null,'87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/common/aisupportaudit', 'AUDITPOINT2', '核心指标缺失', 6, 1, 0, 0, null, 0, 1, null, null, null, null, 200, 0, 's', null, null,'87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/common/aisupportaudit', 'AUDITPOINT3', '指标可衡量', 7, 1, 0, 0, null,0, 1, null, null, null, null, 200, 0, 's', null, null,'87', '2016', null, null);

--查询区
delete from p#busfw_t_uiqueryform t where key ='/pmkpi/common/aisupportaudit';

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, REQUIREMENT, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/common/aisupportaudit', 'AGENCY_CODE', '单位编码', 1, 1, 's', null, null, null, 'pmkpi', 'V_PERF_T_AISUPPORTAUDIRESULT', '{}', null, '87', '2016', null, null, null);

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, REQUIREMENT, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/common/aisupportaudit', 'AGENCY_NAME', '单位名称', 2, 1, 's', null, null, null, 'pmkpi', 'V_PERF_T_AISUPPORTAUDIRESULT', '{}', null, '87', '2016', null, null, null);

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, REQUIREMENT, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/common/aisupportaudit', 'PRO_CODE', '项目编码', 3, 1, 's', null, null, null, 'pmkpi', 'V_PERF_T_AISUPPORTAUDIRESULT', '{}', null, '87', '2016', null, null, null);

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, REQUIREMENT, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/common/aisupportaudit', 'PRO_NAME', '项目名称', 4, 1, 's', null, null, null, 'pmkpi', 'V_PERF_T_AISUPPORTAUDIRESULT', '{}', null, '87', '2016', null, null, null);


--自评审核- AI智能辅助审核 默认隐藏
delete from p#busfw_t_uifunction t where t.key='/pmkpi/perfself/audit/index' and code in ('AIaudit','AIaudit2');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/perfself/audit/index', 'AI智能辅助审核', 0, 0, 'searchicon', 'Ext.lt.pmkpi.aisupportaudit', null, 'AI智能辅助审核', 'pmkpi', 'AIaudit', null, '{}', '87', '2016', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/perfself/audit/index', 'AI智能辅助审核(记录查询)', 0, 0, 'searchicon', 'Ext.lt.pmkpi.aisupportaudit', null, 'AI智能辅助审核(记录查询)', 'pmkpi', 'AIaudit2', null, '{isloadtaskdata:"1"}', '87', '2016', null, null);


--页面配置节点
delete from perf_t_pagemenu t where t.uikey='/pmkpi/common/aisupportaudit';

insert into perf_t_pagemenu (GUID, CODE, NAME, UIKEY, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, STATUS, CREATETIME, UPDATETIME, CREATER, PROVINCE, YEAR)
values (sys_guid(), '999009', 'AI智能辅助审核', '/pmkpi/common/aisupportaudit', '0ACD6A561C9D3D3C9F888FE3B056E4AF', 6, 1, 9, 1, '20250919095615', '20250919095615', '2ABB1E119E395E6EEC48EFA9D6ABB0CD', '87', '2016');

