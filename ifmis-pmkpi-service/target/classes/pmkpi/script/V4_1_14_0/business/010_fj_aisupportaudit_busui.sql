begin

--按钮
delete from p#Busfw_t_uifunction t where t.key='/pmkpi/common/aisupportauditdetail';

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/common/aisupportauditdetail', '返回', 1, 3, 'keepicon', 'aisupportauditdetail.closewin', null, '返回', 'pmkpi', 'closewin', null, null, '87', '2016');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/common/aisupportauditdetail', '保存结果记录', 0, 2, 'keepicon', 'aisupportauditdetail.saveresult', null, '保存结果记录', 'pmkpi', 'saveresult', null, null, '87', '2016');

insert into Busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/common/aisupportauditdetail', '重新审核', 1, 2, 'keepicon', 'aisupportauditdetail.reaudit', null, '重新审核', 'pmkpi', 'reaudit', null, null, '87', '2016');



--辅助审核页面列表
delete from p#busfw_t_uitable where key in('/pmkpi/common/aisupportauditdetail');

insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/common/aisupportauditdetail', 'V_PERF_T_AISUPPORTAUDIDETAIL', null, 0, 0, null, null, 'pmkpi', null,'87', '2016');

delete from p#busfw_t_uicolumn t where key ='/pmkpi/common/aisupportauditdetail';

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/common/aisupportauditdetail', 'audit_point', '审核点', 1, 1, 0, 0, null, 0, 1, null, null, null, null, 100, 0, 's', null, null,'87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/common/aisupportauditdetail', 'audit_content', '审核内容', 2, 1, 0, 0, null, 0, 1, null, null, null, null, 400, 0, 's', null, null,'87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/common/aisupportauditdetail', 'ispass', '是否通过', 3, 1, 0, 0, null,0, 1, null, null, null, null, 100, 0, 's', null, null,'87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/common/aisupportauditdetail', 'nopass_indi', '不通过指标清单', 4, 1, 0, 0, null,0, 1, null, null, null, null, 300, 0, 's', null, null,'87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/common/aisupportauditdetail', 'warn_level', '预警级别', 5, 1, 0, 0, null,0, 1, null, null, null, null, 100, 0, 's', null, null,'87', '2016', null, null);



--自评审核- AI智能辅助审核 默认隐藏
delete from p#busfw_t_uifunction t where t.key='/pmkpi/yearprogram/query/list' and code in ('AIauditDetail','AIauditDetail2');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/yearprogram/query/list', '绩效目标智能审核', 0, 0, 'searchicon', 'Ext.lt.pmkpi.aisupportauditdetail', null, '绩效目标智能审核', 'pmkpi', 'AIauditDetail', null, '{isautosave:"1"}', '87', '2016', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/yearprogram/query/list', '查询绩效目标智能审核结果', 0, 0, 'searchicon', 'Ext.lt.pmkpi.aisupportauditdetail', null, '查询绩效目标智能审核结果', 'pmkpi', 'AIauditDetail2', null, '{isloadtaskdata:"1"}', '87', '2016', null, null);


--页面配置节点
delete from perf_t_pagemenu t where t.uikey='/pmkpi/common/aisupportauditdetail';

insert into perf_t_pagemenu (GUID, CODE, NAME, UIKEY, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, STATUS, CREATETIME, UPDATETIME, CREATER, PROVINCE, YEAR)
values (sys_guid(), '999008', '绩效目标智能审核(详细规则)', '/pmkpi/common/aisupportauditdetail', '0ACD6A561C9D3D3C9F888FE3B056E4AF', 6, 1, 9, 1, '20250919095615', '20250919095615', '2ABB1E119E395E6EEC48EFA9D6ABB0CD', '87', '2016');

