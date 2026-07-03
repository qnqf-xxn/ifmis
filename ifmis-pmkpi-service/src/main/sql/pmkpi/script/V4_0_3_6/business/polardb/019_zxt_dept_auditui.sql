begin
  
delete FROM P#Busfw_t_Uifunction t where t.key = '/pmkpi/deptZJformanceadjust/audit/index';
delete FROM P#Busfw_t_Uiqueryform t where t.key = '/pmkpi/deptZJformanceadjust/audit/index';
delete FROM P#Busfw_t_Uitabpage t where t.key = '/pmkpi/deptZJformanceadjust/audit/index';
delete FROM P#Busfw_t_Uitable t where t.key = '/pmkpi/deptZJformanceadjust/audit/index';
delete FROM P#Busfw_t_Uicolumn t where t.key = '/pmkpi/deptZJformanceadjust/audit/index';

insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values ('6D3751Asfd479CB544107BE04C3238', '/pmkpi/deptZJformanceadjust/audit/index', '取消审核', 1, 2, null, 'pmkpideptperfauditzj.wfAudit', null, '取消审核', 'pmkpi', 'cancelaudit', null, null, '330000000', '2022');

insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values ('6D3d51AsfsdF479CB544107BE04C3238', '/pmkpi/deptZJformanceadjust/audit/index', '审核', 1, 1, null, 'pmkpideptperfauditzj.audit', null, '审核', 'pmkpi', 'audit', null, null, '330000000', '2022');

insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values ('6D3751sss5EF479CB544107BE04C3238', '/pmkpi/deptZJformanceadjust/audit/index', '审核情况', 1, 6, 'searchicon', 'pmkpideptperfauditzj.queryaudit', null, '审核情况', 'pmkpi', 'queryaudit', null, null, '330000000', '2022');

insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values ('6D3751gggF479CB544107BE04C3238', '/pmkpi/deptZJformanceadjust/audit/index', '导出列表', 1, 5, 'searchicon', 'pmkpideptperfauditzj.export', null, '导出列表', 'pmkpi', 'export', null, '{}', '330000000', '2022');

insert into Busfw_t_Uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('5E4A0AsfdB8C470fd248E9fhBAFF444', '/pmkpi/deptZJformanceadjust/audit/index', 'WFSTATUS', '审核状态', 2, 1, 'tree', null, null, null, 'pmkpi', 'V_PERF_T_DEPTPERFDECLARE', null, null, '330000000', '2022');

insert into Busfw_t_Uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('5E4A0ABE9sfsD8052248hgE9BAFF444', '/pmkpi/deptZJformanceadjust/audit/index', 'NAME', '名称', 1, 1, 's', null, null, null, 'pmkpi', 'V_PERF_T_DEPTPERFDECLARE', null, null, '330000000', '2022');

insert into Busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER, PROVINCE, YEAR)
values ('5C4F0hhhddDDAD75F39972ABC76C', 'pmkpi', '/pmkpi/deptZJformanceadjust/audit/index', '曾经办', 'alldeals', 1, 3, 'nomal', 'pmkpideptperfauditzj.clickTabpage', null, '曾经办', null, '审核,取消审核', '{}', null, '0', null, null, null, null, null, null, null, '330000000', '2022');

insert into Busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER, PROVINCE, YEAR)
values ('5C4F090sfdDADdg75F39972ABC76C', 'pmkpi', '/pmkpi/deptZJformanceadjust/audit/index', '待审核', 'waitaudit', 1, 1, 'choosed', 'pmkpideptperfauditzj.clickTabpage', null, '待审核', null, '取消审核,审核信息', '{}', null, '0', null, null, null, null, null, null, null, '330000000', '2022');

insert into Busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER, PROVINCE, YEAR)
values ('5C4F09sgC48DDAD75F39972ABC76C', 'pmkpi', '/pmkpi/deptZJformanceadjust/audit/index', '已审核', 'alreadyaudit', 1, 2, 'nomal', 'pmkpideptperfauditzj.clickTabpage', null, '已审核', null, '审核', '{}', null, '0', null, null, null, null, null, null, null, '330000000', '2022');

insert into Busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER, PROVINCE, YEAR)
values ('FFF161B8FC851B09463174CFBCD30A', 'pmkpi', '/pmkpi/deptZJformanceadjust/audit/index', '被退回', 'back', 1, 3, 'nomal', 'pmkpideptperfauditzj.clickTabpage', null, '被退回', null, '取消送审', '{}', null, '0', null, null, null, null, null, null, null, '330000000', '2022');

insert into Busfw_t_Uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG, PROVINCE, YEAR)
values ('ABB70FCD4B1F40EF84AC9EE42E33EE45', '/pmkpi/deptZJformanceadjust/audit/index', 'V_PERF_T_ADJUST', 0, 0, 0, null, null, 'pmkpi', null, '330000000', '2022');

-----------------------
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('D40E60ABE5555C298486AFD0F0AD2F1', '/pmkpi/deptZJformanceadjust/audit/index', 'GUID', 'guid', 1, 0, 0, 0, null, 0, 6, null, null, null, null, null, 0, 's', null, null, '330000000', '2022');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('D40E60A9983345C298486AFD0F0AD2F1', '/pmkpi/deptZJformanceadjust/audit/index', 'WFSTATUS', '工作流状态', 2, 1, 0, 0, null, 0, 6, null, '#name', null, null, 80, 1, 'tree', null, null, '330000000', '2022');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('D40E60ABE7745C298486AFD0F0AD2F1', '/pmkpi/deptZJformanceadjust/audit/index', 'AGENCYGUID', '单位编码', 3, 1, 0, 0, null, 0, 6, null, '#code', null, null, 100, 0, 'tree', null, null, '330000000', '2022');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('D40E60ABE6665C298486AFD0F0AD2F1', '/pmkpi/deptZJformanceadjust/audit/index', 'AGENCYGUID', '单位名称', 4, 1, 0, 0, null, 0, 6, null, '#name', null, null, 200, 0, 'tree', null, null, '330000000', '2022');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('D40E60AB88745C298486AFD0F0AD2F1', '/pmkpi/deptZJformanceadjust/audit/index', 'WFID', '流程ID', 5, 0, 0, 0, null, 0, 6, null, null, null, null, 150, 0, 's', null, null, '330000000', '2022');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('D40E60ABED444C298486AFD0F0AD2F1', '/pmkpi/deptZJformanceadjust/audit/index', 'PROGUID', '项目ID', 6, 0, 0, 0, null, 0, 6, null, null, null, null, 100, 0, 's', null, null, '330000000', '2022');
