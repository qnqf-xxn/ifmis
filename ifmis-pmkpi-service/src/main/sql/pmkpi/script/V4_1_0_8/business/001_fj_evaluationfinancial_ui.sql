begin

--财政评价项目确定、预算部门自评、财政评价项目审核列表增加DEPT_CODE、MANAGE_DEPT_CODE、MANAGE_MOF_DEP_CODE、MOF_DEP_CODE ,默认隐藏。
delete from p#busfw_t_uicolumn where key ='/pmkpi/evaluation/financial/program' and COLUMNCODE in ('DEPT_CODE','MANAGE_DEPT_CODE','MANAGE_MOF_DEP_CODE','MOF_DEP_CODE');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/evaluation/financial/program', 'DEPT_CODE', '单位主管部门', 24, 0, 0, 0, null, null, 1, null, '#code-#name', null, null, null, 1, 'tree', null, null, null, null, '2016','87');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/evaluation/financial/program', 'MANAGE_DEPT_CODE', '资金主管部门', 25, 0, 0, 0, null, null, 1, null, '#code-#name', null, null, null, 1, 'tree', null, null, null, null, '2016','87');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/evaluation/financial/program', 'MANAGE_MOF_DEP_CODE', '资金主管处室', 26, 0, 0, 0, null, null, 1, null, '#code-#name', null, null, null, 1, 'tree', null, null, null, null, '2016','87');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/evaluation/financial/program', 'MOF_DEP_CODE', '单位归口处室', 27, 0, 0, 0, null, null, 1, null, '#code-#name', null, null, null, 1, 'tree', null, null, null, null, '2016','87');


delete from p#busfw_t_uicolumn where key ='/pmkpi/evaluation/financial/deptassessment' and COLUMNCODE in ('DEPT_CODE','MANAGE_DEPT_CODE','MANAGE_MOF_DEP_CODE','MOF_DEP_CODE');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/evaluation/financial/deptassessment', 'DEPT_CODE', '单位主管部门', 24, 0, 0, 0, null, null, 1, null, '#code-#name', null, null, null, 1, 'tree', null, null, null, null, '2016','87');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/evaluation/financial/deptassessment', 'MANAGE_DEPT_CODE', '资金主管部门', 25, 0, 0, 0, null, null, 1, null, '#code-#name', null, null, null, 1, 'tree', null, null, null, null, '2016','87');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/evaluation/financial/deptassessment', 'MANAGE_MOF_DEP_CODE', '资金主管处室', 26, 0, 0, 0, null, null, 1, null, '#code-#name', null, null, null, 1, 'tree', null, null, null, null, '2016','87');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/evaluation/financial/deptassessment', 'MOF_DEP_CODE', '单位归口处室', 27, 0, 0, 0, null, null, 1, null, '#code-#name', null, null, null, 1, 'tree', null, null, null, null, '2016','87');


delete from p#busfw_t_uicolumn where key ='/pmkpi/evaluation/financial/program/audit' and COLUMNCODE in ('DEPT_CODE','MANAGE_DEPT_CODE','MANAGE_MOF_DEP_CODE','MOF_DEP_CODE');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/evaluation/financial/program/audit', 'DEPT_CODE', '单位主管部门', 24, 0, 0, 0, null, null, 1, null, '#code-#name', null, null, null, 1, 'tree', null, null, null, null, '2016','87');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/evaluation/financial/program/audit', 'MANAGE_DEPT_CODE', '资金主管部门', 25, 0, 0, 0, null, null, 1, null, '#code-#name', null, null, null, 1, 'tree', null, null, null, null, '2016','87');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/evaluation/financial/program/audit', 'MANAGE_MOF_DEP_CODE', '资金主管处室', 26, 0, 0, 0, null, null, 1, null, '#code-#name', null, null, null, 1, 'tree', null, null, null, null, '2016','87');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/evaluation/financial/program/audit', 'MOF_DEP_CODE', '单位归口处室', 27, 0, 0, 0, null, null, 1, null, '#code-#name', null, null, null, 1, 'tree', null, null, null, null, '2016','87');

--更新对应字段注册信息数据源
update bus_t_diccolumn set csid = 'VD00010' where tablecode ='PERF_T_FINEVALUATION' and columncode ='DEPT_CODE';
update bus_t_diccolumn set csid = 'VD00010' where tablecode ='PERF_T_FINEVALUATION' and columncode ='MANAGE_DEPT_CODE';
update bus_t_diccolumn set csid = '099003' where tablecode ='PERF_T_FINEVALUATION' and columncode ='MANAGE_MOF_DEP_CODE';
update bus_t_diccolumn set csid = '099003' where tablecode ='PERF_T_FINEVALUATION' and columncode ='MOF_DEP_CODE';