begin
  
delete FROM p#Busfw_t_Uifunction t where t.key = '/pmkpi/deptZJformanceadjust/report/index';
delete FROM P#Busfw_t_Uiqueryform t where t.key = '/pmkpi/deptZJformanceadjust/report/index';
delete FROM P#Busfw_t_Uitabpage t where t.key = '/pmkpi/deptZJformanceadjust/report/index';
delete FROM P#Busfw_t_Uitable t where t.key = '/pmkpi/deptZJformanceadjust/report/index';
delete FROM P#Busfw_t_Uicolumn t where t.key = '/pmkpi/deptZJformanceadjust/report/index';

insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values ('531A032SSSSA00934E1341C6137E9A', '/pmkpi/deptZJformanceadjust/report/index', '调整', 1, 1, 'searchicon', 'deptZJlist.add', null, '调整', 'pmkpi', 'add', null, '{}', '330000000', '2022');

insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values ('531A032SSD64A00934E1341C6137E9A', '/pmkpi/deptZJformanceadjust/report/index', '修改', 1, 2, 'searchicon', 'deptZJlist.save', null, '修改', 'pmkpi', 'save', null, '{}', '330000000', '2022');

insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values ('531A03DDD2B64A009341341C6137E9A', '/pmkpi/deptZJformanceadjust/report/index', '删除', 1, 3, 'searchicon', 'deptZJlist.del', null, '删除', 'pmkpi', 'del', null, '{}', '330000000', '2022');

insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values ('531A032DSB64A00934E1341C6137E9A', '/pmkpi/deptZJformanceadjust/report/index', '送审', 1, 4, 'searchicon', 'deptZJlist.wfAudit', null, '送审', 'pmkpi', 'sendaudit', null, '{}', '330000000', '2022');

insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values ('531A03SD2B64A00934E1341C6137E9A', '/pmkpi/deptZJformanceadjust/report/index', '取消送审', 1, 5, 'searchicon', 'deptZJlist.wfAudit', null, '取消送审', 'pmkpi', 'cancelsendaudit', null, '{}', '330000000', '2022');

insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values ('531A0FDS2B64A00934E1341C6137E9A', '/pmkpi/deptZJformanceadjust/report/index', '审核情况', 1, 6, 'searchicon', 'deptZJlist.queryaudit', null, '审核情况', 'pmkpi', 'queryaudit', null, '{}', '330000000', '2022');

insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values ('531AWED02B64A00934E1341C6137E9A', '/pmkpi/deptZJformanceadjust/report/index', '查询', 0, 7, 'searchicon', 'deptZJlist.query', null, '查询', 'pmkpi', 'query', null, '{}', '330000000', '2022');

insert into Busfw_t_Uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('ABEB4A3ddC4E50BC977BDF936FA662', '/pmkpi/deptZJformanceadjust/report/index', 'NAME', '名称', 1, 1, 's', null, null, null, 'pmkpi', 'V_PERF_T_DEPTPERFDECLARE', null, null, '330000000', '2022');

insert into Busfw_t_Uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('ABEB4A3C49ss50BC977BDF936FA662', '/pmkpi/deptZJformanceadjust/report/index', 'WFSTATUS', '审核状态', 2, 1, 'tree', null, null, null, 'pmkpi', 'V_PERF_T_DEPTPERFDECLARE', null, null, '330000000', '2022');

insert into Busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER, PROVINCE, YEAR)
values ('A7D51Bddsddewrwerwrerwrdsf921EB', 'pmkpi', '/pmkpi/deptZJformanceadjust/report/index', '待送审', 'waitaudit', 1, 1, 'choosed', 'deptZJlist.clickTabpage', null, '待送审', null, '取消送审', '{}', null, '0', null, null, null, null, null, null, null, '330000000', '2022');

insert into Busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER, PROVINCE, YEAR)
values ('A7D51B3BEB324368971E825751A921EB', 'pmkpi', '/pmkpi/deptZJformanceadjust/report/index', '已送审', 'alreadyaudit', 1, 2, 'nomal', 'deptZJlist.clickTabpage', null, '已送审', null, '选择项目,调整,删除,送审', '{}', null, '0', null, null, null, null, null, null, null, '330000000', '2022');

insert into Busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER, PROVINCE, YEAR)
values ('A7D51B3Bsds368971E825751A921EB', 'pmkpi', '/pmkpi/deptZJformanceadjust/report/index', '曾经办', 'alldeals', 1, 3, 'nomal', 'deptZJlist.clickTabpage', null, '曾经办', null, '选择项目,调整,删除,送审,取消送审', '{}', null, '0', null, null, null, null, null, null, null, '330000000', '2022');

insert into Busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER, PROVINCE, YEAR)
values ('FFF161B8FC851B09463174CFBCD308', 'pmkpi', '/pmkpi/deptZJformanceadjust/report/index', '被退回', 'back', 1, 3, 'nomal', 'deptZJlist.clickTabpage', null, '被退回', null, '取消送审', '{}', null, '0', null, null, null, null, null, null, null, '330000000', '2022');

insert into Busfw_t_Uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG, PROVINCE, YEAR)
values ('4E390CE018FESDSB961767496C3B519A', '/pmkpi/deptZJformanceadjust/report/index', 'V_PERF_T_ADJUST', 0, 0, 0, null, null, 'pmkpi', null, '330000000', '2022');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('D40E60ABE5555C298486AFD0F0AD2F8', '/pmkpi/deptZJformanceadjust/report/index', 'GUID', 'guid', 1, 0, 0, 0, null, 0, 6, null, null, null, null, null, 0, 's', null, null, '330000000', '2022');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('D40E60A9983345C298486AFD0F0AD2F8', '/pmkpi/deptZJformanceadjust/report/index', 'WFSTATUS', '工作流状态', 2, 1, 0, 0, null, 0, 6, null, '#name', null, null, 80, 1, 'tree', null, null, '330000000', '2022');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('D40E60ABE7745C298486AFD0F0AD2F8', '/pmkpi/deptZJformanceadjust/report/index', 'AGENCYGUID', '单位编码', 3, 1, 0, 0, null, 0, 6, null, '#code', null, null, 100, 0, 'tree', null, null, '330000000', '2022');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('D40E60ABE6665C298486AFD0F0AD2F8', '/pmkpi/deptZJformanceadjust/report/index', 'AGENCYGUID', '单位名称', 4, 1, 0, 0, null, 0, 6, null, '#name', null, null, 200, 0, 'tree', null, null, '330000000', '2022');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('D40E60AB88745C298486AFD0F0AD2F8', '/pmkpi/deptZJformanceadjust/report/index', 'WFID', '流程ID', 5, 0, 0, 0, null, 0, 6, null, null, null, null, 150, 0, 's', null, null, '330000000', '2022');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('D40E60ABED444C298486AFD0F0AD2F8', '/pmkpi/deptZJformanceadjust/report/index', 'PROGUID', '项目ID', 6, 0, 0, 0, null, 0, 6, null, null, null, null, 100, 0, 's', null, null, '330000000', '2022');
