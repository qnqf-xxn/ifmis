begin

--项目支出

--1、绩效目标修订填报、绩效目标修订审核；
delete from p#busfw_t_uicolumn where key = '/pmkpi/prorevision/report/list' and columncode = 'MANAGE_MOF_DEP_CODE';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/prorevision/report/list', 'MANAGE_MOF_DEP_CODE', '资金归口处室', 14, 0, 0, null, null, null, 1, null, '#name', null, null, null, 1, 'tree', '{type:''program''}', null, null, null);

--2、绩效监控填报、绩效监控审核、成果上传、成果上传审核；
--dic
delete from bus_t_diccolumn where tablecode = 'PERF_V_PROMONITOR' and columncode = 'MANAGE_MOF_DEP_CODE';
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, '099003', null, '1', 'MANAGE_MOF_DEP_CODE', '1', '2016', '87', 'EED47FE19AC60202E0533315A8C02FDB', 'MANAGE_MOF_DEP_CODE', 'PERF_V_PROMONITOR', '资金主管处室', 'S', '200', null, null, 1, null, sysdate);
--busui
delete from p#busfw_t_uicolumn where key = '/pmkpi/program/trace/report' and columncode = 'MANAGE_MOF_DEP_CODE';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/trace/report', 'MANAGE_MOF_DEP_CODE', '资金归口处室', 12, 0, 0, null, null, null, 1, null, '#name', null, null, null, 1, 'tree', '{type:''protrace''}', null, null, null);
--绩效监控查询；
delete from p#busfw_t_uicolumn where key = '/pmkpi/program/trace/query' and columncode = 'MANAGE_MOF_DEP_CODE';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/trace/query', 'MANAGE_MOF_DEP_CODE', '资金归口处室', 12, 0, 0, null, null, null, 1, null, '#name', null, null, null, 1, 'tree', '{type:''protrace''}', null, null, null);

--3、绩效自评填报、绩效自评审核、绩效自评查询；
--dic
update bus_t_diccolumn set csid = '099003' where tablecode = 'PERF_T_SELFEVALTASK' and columncode = 'MANAGE_MOF_DEP_CODE';
delete from bus_t_diccolumn where tablecode = 'PERF_V_SELFEVALTASK' and columncode = 'MANAGE_MOF_DEP_CODE';
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, '099003', null, '1', 'MANAGE_MOF_DEP_CODE', '1', '2016', '87', 'EED47FE19AC50202E0533315A8C02FDB', 'MANAGE_MOF_DEP_CODE', 'PERF_V_SELFEVALTASK', '资金主管处室', 'S', '200', null, null, 1, null, sysdate);
--busui
delete from p#busfw_t_uicolumn where key = '/pmkpi/perfself/query' and columncode = 'MANAGE_MOF_DEP_CODE';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/perfself/query', 'MANAGE_MOF_DEP_CODE', '资金归口处室', 7, 0, 0, null, null, null, 1, null, '#code-#name', null, null, null, 1, 'tree', '{type:''program''}', null, null, null);

--4、部门评价项目申报、部门评价成果申报、部门评价成果审核、部门评价结果查询
--dic
update bus_t_diccolumn set csid = '099003' where tablecode = 'PERF_T_DEPTEVALUATION' and columncode = 'MANAGE_MOF_DEP_CODE';
--busui
delete from p#busfw_t_uicolumn where key = '/pmkpi/evaluation/dept/program' and columncode = 'MANAGE_MOF_DEP_CODE';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/evaluation/dept/program', 'MANAGE_MOF_DEP_CODE', '资金归口处室', 13, 0, 0, null, null, null, 1, null, '#name', null, null, null, 1, 'tree', '{ispro:1}', null, null, null);
--部门评价项目审核
delete from p#busfw_t_uicolumn where key = '/pmkpi/evaluation/dept/program/audit' and columncode = 'MANAGE_MOF_DEP_CODE';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/evaluation/dept/program/audit', 'MANAGE_MOF_DEP_CODE', '资金归口处室', 8, 0, 0, null, null, null, 1, null, '#name', null, null, null, 1, 'tree', '{ispro:1}', null, null, null);


