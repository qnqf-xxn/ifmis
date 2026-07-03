begin

delete from p#busfw_t_uifunction where key ='/pmkpi/setting/perfcarryover';

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/setting/perfcarryover', '结转上年绩效', 1, 1, 'searchicon', 'perfcarryover.carryover', null, '结转上年绩效', 'pmkpi', 'carryover', null, '{}','87', '2016', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/setting/perfcarryover', '取消结转', 1, 2, 'searchicon', 'perfcarryover.carryover', null, '取消结转', 'pmkpi', 'cancelcarryover', null, '{}', '87', '2016', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/setting/perfcarryover', '查看本年度项目绩效', 1, 3, 'searchicon', 'perfcarryover.queryView', null, '查看本年度项目绩效', 'pmkpi', 'queryView', null, '{}', '87', '2016', null, null);

delete from p#busfw_t_uitabpage where key ='/pmkpi/setting/perfcarryover';

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, PROVINCE, YEAR, DEFAULTFILTER, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), 'pmkpi', '/pmkpi/setting/perfcarryover', '未结转', 'uncarryover', 1, 1, 'choosed', 'perfcarryover.clickTabpage', 0, '待送审', null, '取消结转,查看项目绩效', '{}', null, '0', null, null, null, null, null, null, '87', '2016', null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, PROVINCE, YEAR, DEFAULTFILTER, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), 'pmkpi', '/pmkpi/setting/perfcarryover', '已结转', 'caarryovered', 1, 2, 'nomal', 'perfcarryover.clickTabpage', 0, '已送审', null, '结转上年绩效', '{}', null, '0', null, null, null, null, null, null, '87', '2016', null, null, null);

delete from p#busfw_t_uiqueryform t where key ='/pmkpi/setting/perfcarryover';

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, REQUIREMENT, ISEDITCTRL, EDITCTRLMSG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/setting/perfcarryover', 'PRO_CODE', '项目编码', 1, 1, 's', null, null, null, 'pmkpi', 'V_PERF_PROJECT_CARRYOVER', '{}', null, null, null, null, '87', '2016');

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, REQUIREMENT, ISEDITCTRL, EDITCTRLMSG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/setting/perfcarryover', 'PRO_NAME', '项目名称', 2, 1, 's', null, null, null, 'pmkpi', 'V_PERF_PROJECT_CARRYOVER', '{}', null, null, null, null, '87', '2016');

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, REQUIREMENT, ISEDITCTRL, EDITCTRLMSG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/setting/perfcarryover', 'ISREPORT_LASTYEAR', '上年填报绩效', 3, 1, 'tree', null, null, null, 'pmkpi', 'V_PERF_PROJECT_CARRYOVER', '{}', null, null, null, null, '87', '2016');

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, REQUIREMENT, ISEDITCTRL, EDITCTRLMSG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/setting/perfcarryover', 'ISREPORT_NOWYEAR', '本年填报绩效', 4, 1, 'tree', null, null, null, 'pmkpi', 'V_PERF_PROJECT_CARRYOVER', '{}', null, null, null, null, '87', '2016');

delete from p#busfw_t_uitable where key ='/pmkpi/setting/perfcarryover';

insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/setting/perfcarryover', 'V_PERF_PROJECT_CARRYOVER', 100, 0, 0, 'order by pro_code', null, 'pmkpi', '{}', '87', '2016');

delete from p#busfw_t_uicolumn t where key ='/pmkpi/setting/perfcarryover';

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/setting/perfcarryover', 'GUID', '主键', 0, 0, 0, 0, null, 0, 1, null, null, null, null, 200, 0, 's', null, null, null, null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/setting/perfcarryover', 'ISREPORT_LASTYEAR', '上年填报绩效', 1, 1, 0, 0, null, 0, 6, null, '#name', null, null, 50, 1, 'tree', null, null, null, null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/setting/perfcarryover', 'ISREPORT_NOWYEAR', '本年填报绩效', 2, 1, 0, 0, null, 0, 6, null, '#name', null, null, 50, 1, 'tree', null, null, null, null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/setting/perfcarryover', 'PRO_CODE', '项目编码', 3, 1, 0, 0, null, 0, 1, null, null, null, null, 100, 0, 's', null, null, null, null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/setting/perfcarryover', 'PRO_NAME', '项目名称', 4, 1, 0, 0, null, 0, 1, null, null, null, null, 200, 0, 's', null, null, null, null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/setting/perfcarryover', 'AGENCY_CODE', '预算单位', 5, 1, 0, 0, null, 0, 6, null, '#code-#name', null, null, 100, 1, 'tree', null, null, null, null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/setting/perfcarryover', 'FININTORGGUID', '业务科室', 6, 1, 0, 0, null, 0, 6, null, '#code-#name', null, null, 100, 1, 'tree', null, null, null, null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/setting/perfcarryover', 'PRO_TOTAL_AMT', '项目金额', 7, 1, 0, 0, null, 0, 6, null, null, null, null, 100, 0, 's', null, null, null, null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/setting/perfcarryover', 'BGT_AMT', '当年预算金额', 8, 1, 0, 0, null, 0, 6, null, null, null, null, 100, 0, 's', null, null, null, null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/setting/perfcarryover', 'PROJECTKIND', '支出项目类别', 9, 1, 0, 0, null, 0, 6, null, '#code-#name', null, null, 100, 1, 'tree', null, null, null, null, '87', '2016');


delete from perf_t_treetab t where t.key in('/pmkpi/setting/perfcarryover');

insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values (sys_guid(), '/pmkpi/setting/perfcarryover', 'program', '项目支出', 1, null, 1, '2016', '87', null, 'programperfcarryoverhide');

insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values (sys_guid(), '/pmkpi/setting/perfcarryover', 'dept', '部门整体', 0, null, 2, '2016', '87', null, 'deptperfcarryoverhide');


