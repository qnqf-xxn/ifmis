begin

--1、年中追加绩效目标-项目支出
update bus_t_diccolumn set csid = '099003' where tablecode = 'PERF_T_DEPTPERFMIDDECLARE' and columncode = 'MANAGE_MOF_DEP_CODE';
--填报
delete from p#busfw_t_uicolumn where key = '/pmkpi/midprogram/report/list' and columncode = 'MANAGE_MOF_DEP_CODE';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/midprogram/report/list', 'MANAGE_MOF_DEP_CODE', '资金归口处室', 13, 1, 0, null, null, null, 1, null, '#name', null, null, null, 1, 'tree', '{}', null, null, null);
--审核--uicolumn
delete from p#busfw_t_uicolumn where key = '/pmkpi/midprogram/report/audit' and columncode = 'MANAGE_MOF_DEP_CODE';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/midprogram/report/audit', 'MANAGE_MOF_DEP_CODE', '资金归口处室', 13, 1, 0, null, null, null, 1, null, '#name', null, null, null, 1, 'tree', '{}', null, null, null);
--审核--uiqueryform
delete from p#busfw_t_uiqueryform where  key = '/pmkpi/midprogram/report/audit' and columncode in( 'FININTORGGUID','PRO_CODE' )  ;
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, REQUIREMENT, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/midprogram/report/audit', 'PRO_CODE', '项目编码', 3, 1, 's', null, null, null, 'pmkpi', 'V_PERF_T_DEPTPERFMIDDECLARE', '{}', null, null, null, null);
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, REQUIREMENT, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/midprogram/report/audit', 'FININTORGGUID', '业务处室', 4, 1, 'tree', null, 0, 0, 'pmkpi', 'V_PERF_T_DEPTPERFMIDDECLARE', '{}', null, null, null, null);
--查询--uicolumn
delete from p#busfw_t_uicolumn where key = '/pmkpi/midprogram/query/list' and columncode = 'MANAGE_MOF_DEP_CODE';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/midprogram/query/list', 'MANAGE_MOF_DEP_CODE', '资金归口处室', 13, 1, 0, null, null, null, 1, null, '#name', null, null, null, 1, 'tree', '{}', null, null, null);
--查询--uiqueryform
delete from p#busfw_t_uiqueryform where  key = '/pmkpi/midprogram/query/list' and columncode in( 'FININTORGGUID','PRO_CODE' )  ;
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, REQUIREMENT, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/midprogram/query/list', 'PRO_CODE', '项目编码', 3, 1, 's', null, null, null, 'pmkpi', 'V_PERF_T_DEPTPERFMIDDECLARE', '{}', null, null, null, null);
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, REQUIREMENT, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/midprogram/query/list', 'FININTORGGUID', '业务处室', 4, 1, 'tree', null, 0, 0, 'pmkpi', 'V_PERF_T_DEPTPERFMIDDECLARE', '{}', null, null, null, null);

--2、绩效目标调整-项目支出 --VD10001
update bus_t_diccolumn set csid = '099003' where tablecode = 'PERF_T_ADJUST' and columncode = 'FININTORGGUID';
--列：填报、审核、查询
delete from p#busfw_t_uicolumn where key = '/pmkpi/adjust/report/list' and columncode = 'MANAGE_MOF_DEP_CODE';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/adjust/report/list', 'MANAGE_MOF_DEP_CODE', '资金归口处室', 13, 1, 0, 0, null, null, 1, null, '#name', null, null, 100, 1, 'tree', '{type:''program''}', null, null, null);
--查询区：审核、查询(代码有改动，需要打补丁)
delete from p#busfw_t_uiqueryform where  key = '/pmkpi/adjust/report/program' and columncode = 'FININTORGGUID'   ;
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, REQUIREMENT, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/adjust/report/program', 'FININTORGGUID', '业务处室', 3, 1, 'tree', null, 0, 0, 'pmkpi', 'V_PERF_PROJECT_INFO', '{}', null, null, null, null);
