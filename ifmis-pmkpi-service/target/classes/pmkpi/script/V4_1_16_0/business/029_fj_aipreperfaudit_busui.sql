begin

--注册信息
delete from bus_t_diccolumn where tablecode ='PERF_T_AISUPPORTAUDITEXE' and columncode ='PRO_ID';

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'PRO_ID', '1', '2016', '87', sys_guid(), 'PRO_ID', 'PERF_T_AISUPPORTAUDITEXE', '项目ID', 'S', '40', null, 1, 1, null, sysdate);


--按钮
delete from p#Busfw_t_uifunction t where t.key='/pmkpi/common/aipreperfaudit' and province = '87' and year = '2016';

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/common/aipreperfaudit', '返回', 1, 3, 'keepicon', 'aipreperfaudit.closewin', null, '返回', 'pmkpi', 'closewin', null, null, '87', '2016');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/common/aipreperfaudit', '保存结果记录', 0, 2, 'keepicon', 'aipreperfaudit.saveresult', null, '保存结果记录', 'pmkpi', 'saveresult', null, null, '87', '2016');

insert into Busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/common/aipreperfaudit', '重新审核', 1, 2, 'keepicon', 'aipreperfaudit.reaudit', null, '重新审核', 'pmkpi', 'reaudit', null, null, '87', '2016');

--辅助审核页面
delete from p#busfw_t_uieditform where key ='/pmkpi/common/aipreperfaudit' and province = '87' and year = '2016';

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR, HEAD, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/common/aipreperfaudit', 'PERF_T_AIPREPERFAUDIT', 's', '评审结果', 'CONCLUSION', 1, null, 0, null, 1, null, null, 'pmkpi', 1, null, '{}', null, null, null, '87', '2016', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR, HEAD, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/common/aipreperfaudit', 'PERF_T_AIPREPERFAUDIT', 'textarea', '事前绩效评估报告内容缺失、不规范问题', 'REPORTPROBLEM', 1, null, 0, null, 2, 3, 3, 'pmkpi', 1, null, '{}', null, null, null, '87', '2016', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR, HEAD, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/common/aipreperfaudit', 'PERF_T_AIPREPERFAUDIT', 'textarea', '项目绩效指标与报告指标填报一致性问题', 'INDICATOR', 1, null, 0, null, 3, 3, 3, 'pmkpi', 1, null, '{}', null, null, null, '87', '2016', null, null, null);

--页面配置节点
delete from perf_t_pagemenu t where t.uikey='/pmkpi/common/aipreperfaudit';

insert into perf_t_pagemenu (GUID, CODE, NAME, UIKEY, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, STATUS, CREATETIME, UPDATETIME, CREATER, PROVINCE, YEAR)
values (sys_guid(), '999008', 'AI事前评估审核结果(ZJ)', '/pmkpi/common/aipreperfaudit', '0ACD6A561C9D3D3C9F888FE3B056E4AF', 6, 1, 9, 1, '20250919095615', '20250919095615', '2ABB1E119E395E6EEC48EFA9D6ABB0CD', '87', '2016');

--增加默认过滤条件
update p#busfw_t_uitable set config = '{"PMKPI_AIPREPERFAUDIT":"exists(select 1 from v_pm_perf_indicator a where a.yearflag = ''1'' and t.pro_code = a.pro_code)","PMKPI_AISUPPORTAUDITDETAIL":"exists(select 1 from v_pm_perf_indicator a where a.yearflag = ''0'' and t.pro_code = a.pro_code)"}'
where key ='/pmkpi/perfcommon/aiauditexe' and province = '87' and year = '2016';
