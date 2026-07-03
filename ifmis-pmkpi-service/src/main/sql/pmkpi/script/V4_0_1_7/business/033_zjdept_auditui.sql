begin
  
delete FROM P#Busfw_t_Uifunction t where t.key = '/pmkpi/deptZJformance/audit/index';
delete FROM P#Busfw_t_Uiqueryform t where t.key = '/pmkpi/deptZJformance/audit/index';
delete FROM P#Busfw_t_Uitabpage t where t.key = '/pmkpi/deptZJformance/audit/index';
delete FROM P#Busfw_t_Uitable t where t.key = '/pmkpi/deptZJformance/audit/index';
delete FROM P#Busfw_t_Uicolumn t where t.key = '/pmkpi/deptZJformance/audit/index';

insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values ('6D3751Asfd479CB544107BE04C3238', '/pmkpi/deptZJformance/audit/index', '取消审核', 1, 2, null, 'deptperformanceaudit.wfAudit', null, '取消审核', 'pmkpi', 'cancelaudit', null, null, '87', '2016');

insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values ('6D3d51AsfsdF479CB544107BE04C3238', '/pmkpi/deptZJformance/audit/index', '审核', 1, 1, null, 'deptperformanceaudit.audit', null, '审核', 'pmkpi', 'audit', null, null, '87', '2016');

insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values ('6D3751sss5EF479CB544107BE04C3238', '/pmkpi/deptZJformance/audit/index', '审核情况', 1, 6, 'searchicon', 'deptperformanceaudit.queryaudit', null, '审核情况', 'pmkpi', 'queryaudit', null, null, '87', '2016');

insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values ('6D3751gggF479CB544107BE04C3238', '/pmkpi/deptZJformance/audit/index', '导出列表', 1, 5, 'searchicon', 'deptperformanceaudit.export', null, '导出列表', 'pmkpi', 'export', null, '{}', '87', '2016');

insert into Busfw_t_Uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('5E4A0AsfdB8C470fd248E9fhBAFF444', '/pmkpi/deptZJformance/audit/index', 'WFSTATUS', '审核状态', 2, 1, 'tree', null, null, null, 'pmkpi', 'V_PERF_T_DEPTPERFDECLARE', null, null, '87', '2016');

insert into Busfw_t_Uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('5E4A0ABE9sfsD8052248hgE9BAFF444', '/pmkpi/deptZJformance/audit/index', 'NAME', '名称', 1, 1, 's', null, null, null, 'pmkpi', 'V_PERF_T_DEPTPERFDECLARE', null, null, '87', '2016');

insert into Busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER, PROVINCE, YEAR)
values ('5C4F0hhhddDDAD75F39972ABC76C', 'pmkpi', '/pmkpi/deptZJformance/audit/index', '曾经办', 'alldeals', 1, 3, 'nomal', 'pmkpideptperfauditzj.clickTabpage', null, '曾经办', null, '审核,取消审核', '{}', null, '0', null, null, null, null, null, null, null, '87', '2016');

insert into Busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER, PROVINCE, YEAR)
values ('5C4F090sfdDADdg75F39972ABC76C', 'pmkpi', '/pmkpi/deptZJformance/audit/index', '待审核', 'waitaudit', 1, 1, 'choosed', 'pmkpideptperfauditzj.clickTabpage', null, '待审核', null, '取消审核,审核信息', '{}', null, '0', null, null, null, null, null, null, null, '87', '2016');

insert into Busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER, PROVINCE, YEAR)
values ('5C4F09sgC48DDAD75F39972ABC76C', 'pmkpi', '/pmkpi/deptZJformance/audit/index', '已审核', 'alreadyaudit', 1, 2, 'nomal', 'pmkpideptperfauditzj.clickTabpage', null, '已审核', null, '审核', '{}', null, '0', null, null, null, null, null, null, null, '87', '2016');

insert into Busfw_t_Uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG, PROVINCE, YEAR)
values ('ABB70FCD4B1F40EF84AC9EE42E33EE45', '/pmkpi/deptZJformance/audit/index', 'V_PERF_T_DEPTPERFDECLARE', 0, 0, 0, null, null, 'pmkpi', null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('500Adgdf29439C9E2521CA9688BA39', '/pmkpi/deptZJformance/audit/index', 'TELEPHONE', '联系电话', 5, 1, 0, 0, null, 0, 6, null, null, null, null, 150, 0, 's', null, null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('500A685gsd29439C9E2521CA9688BA39', '/pmkpi/deptZJformance/audit/index', 'NAME', '名称', 3, 1, 0, 0, null, 0, 6, null, null, null, null, 200, 0, 's', null, null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('500A685Asg9439C9E2521CA9688BA39', '/pmkpi/deptZJformance/audit/index', 'LINKMAN', '联系人', 4, 1, 0, 0, null, 0, 6, null, null, null, null, 100, 0, 's', null, null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('500A685Asf29439C9E2521CA9688BA39', '/pmkpi/deptZJformance/audit/index', 'GUID', 'guid', 1, 0, 0, 0, null, 0, 6, null, null, null, null, null, 0, 's', null, null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('500A685Asfd9439C9E2521CA9688BA39', '/pmkpi/deptZJformance/audit/index', 'CREATETIME', '创建人', 6, 0, 0, 0, null, 0, 6, null, null, null, null, 100, 0, 's', null, null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('500ttt5ADt9439C9E2521CA9688BA39', '/pmkpi/deptZJformance/audit/index', 'WFSTATUS', '工作流状态', 2, 1, 0, 0, null, 0, 6, null, '#name', null, null, 100, 1, 's', null, null, '87', '2016');
