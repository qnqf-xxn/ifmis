begin

--01 问题下达页面
delete from p#busfw_t_uifunction where key ='/pmkpi/problemtask/issue';

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/problemtask/issue', '新增', 1, 1, 'searchicon', 'problemtasklist.add', null, '新增', 'pmkpi', 'add', null, '{}','87', '2016', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/problemtask/issue', '修改', 1, 2, 'searchicon', 'problemtasklist.update', null, '修改', 'pmkpi', 'update', null, '{}', '87', '2016', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/problemtask/issue', '删除', 1, 3, 'searchicon', 'problemtasklist.del', null, '删除', 'pmkpi', 'del', null, '{}','87', '2016', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/problemtask/issue', '下达', 1, 4, 'searchicon', 'problemtasklist.issue', null, '下达', 'pmkpi', 'issue', null, '{}', '87', '2016', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/problemtask/issue', '撤回', 1, 5, 'searchicon', 'problemtasklist.issue', null, '撤回', 'pmkpi', 'cancelissue', null, '{}','87', '2016', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/problemtask/issue', '导出列表', 1, 6, 'searchicon', 'Ext.lt.pmkpi.expdata', null, '导出列表', 'pmkpi', 'expdata', null, '{}', '87', '2016', null, null);

delete from p#busfw_t_uiqueryform t where key ='/pmkpi/problemtask/issue';

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, REQUIREMENT, ISEDITCTRL, EDITCTRLMSG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/problemtask/issue', 'NAME', '评价项目名称', 1, 1, 's', null, null, null, 'pmkpi', 'V_PERF_T_PROBLEMTASK', '{}', null, null, null, null, '87', '2016');

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, REQUIREMENT, ISEDITCTRL, EDITCTRLMSG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/problemtask/issue', 'PROBLEMTYPE', '整改类型', 2, 1, 'tree', null, null, null, 'pmkpi', 'V_PERF_T_PROBLEMTASK', '{}', null, null, null, null, '87', '2016');

delete from p#busfw_t_uitabpage where key ='/pmkpi/problemtask/issue';

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, PROVINCE, YEAR, DEFAULTFILTER, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), 'pmkpi', '/pmkpi/problemtask/issue', '待下达', 'tobeissue', 1, 1, 'choosed', 'problemtasklist.clickTabpage', 0, '待下达', null, '撤回', '{}', null, '0', null, null, null, null, null, null, '87', '2016', null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, PROVINCE, YEAR, DEFAULTFILTER, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), 'pmkpi', '/pmkpi/problemtask/issue', '已下达', 'issued', 1, 2, 'nomal', 'problemtasklist.clickTabpage', 0, '已下达', null, '新增,修改,删除,下达', '{}', null, '0', null, null, null, null, null, null, '87', '2016', null, null, null);

delete from p#busfw_t_uitable where key ='/pmkpi/problemtask/issue';

insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/problemtask/issue', 'V_PERF_T_PROBLEMTASK', 100, 0, 0, 'order by create_time,name', null, 'pmkpi', '{}', '87', '2016');

delete from p#busfw_t_uicolumn t where key ='/pmkpi/problemtask/issue';

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/problemtask/issue', 'GUID', '主键', 0, 0, 0, 0, null, 0, 1, null, null, null, null, 200, 0, 's', null, null, null, null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/problemtask/issue', 'NAME', '评价项目名称', 1, 1, 0, 0, null, 0, 1, null, null, null, null, 200, 0, 's', null, null, null, null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/problemtask/issue', 'LV1_TITLE', '一级标题', 2, 1, 0, 0, null, 0, 1, '[''问题类别'']', null, null, null, 150, 0, 's', null, null, null, null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/problemtask/issue', 'LV2_TITLE', '二级标题', 3, 1, 0, 0, null, 0, 1, '[''问题类别'']', null, null, null, 180, 0, 's', null, null, null, null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/problemtask/issue', 'DETAILCONTENT', '问题涉及具体事项', 4, 1, 0, 0, null, 0, 1, null, null, null, null, 200, 0, 's', null, null, null, null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/problemtask/issue', 'PROBLEMTYPE', '整改类型', 5, 1, 0, 0, null, 0, 1, null, '#code-#name', null, null, 100, 1, 'tree', null, null, null, null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/problemtask/issue', 'START_TIME', '评价结果反馈时间', 6, 1, 0, 0, null, 0, 1, null, null, null, null, 100, 0, 'd', '{}', null, null, null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/problemtask/issue', 'LEAD_AGENCY', '整改牵头部门', 7, 1, 0, 0, null, 0, 6, null, '#code-#name', null, null, 100, 1, 'tree', null, null, null, null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/problemtask/issue', 'LEAD_DEPARTMENT', '牵头处室', 8, 1, 0, 0, null, 0, 1, '[''财政部门'']', '#code-#name', null, null, 100, 1, 'tree', null, null, null, null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/problemtask/issue', 'LINKMAN', '联系人', 9, 1, 0, 0, null, 0, 1, '[''财政部门'']', null, null, null, 100, 0, 's', null, null, null, null, '87', '2016');


--02 整改反馈页面
delete from p#busfw_t_uifunction where key ='/pmkpi/problemtask/feedback';

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/problemtask/feedback', '填报', 1, 1, 'searchicon', 'problemtasklist.report', null, '填报', 'pmkpi', 'report', null, '{}','87', '2016', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/problemtask/feedback', '送审', 1, 2, 'searchicon', 'problemtasklist.wfAudit', null, '送审', 'pmkpi', 'sendaudit', null, '{}', '87', '2016', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/problemtask/feedback', '申请延期', 1, 3, 'searchicon', 'problemtasklist.senddelay', null, '申请延期', 'pmkpi', 'senddelay', null, '{}','87', '2016', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/problemtask/feedback', '撤回', 1, 4, 'searchicon', 'problemtasklist.wfAudit', null, '撤回', 'pmkpi', 'cancelsendaudit', null, '{}', '87', '2016', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/problemtask/feedback', '撤回申请延期', 1, 5, 'searchicon', 'problemtasklist.delay', null, '撤回申请延期', 'pmkpi', 'cancelsenddelay', null, '{}', '87', '2016', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/problemtask/feedback', '整改到期提醒', 0, 6, 'searchicon', 'problemtasklist.expirationreminder', null, '整改到期提醒', 'pmkpi', 'expirationreminder', null, '{}','87', '2016', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/problemtask/feedback', '导出列表', 0, 7, 'searchicon', 'Ext.lt.pmkpi.expdata', null, '导出列表', 'pmkpi', 'expdata', null, '{}', '87', '2016', null, null);

delete from p#busfw_t_uitabpage where key ='/pmkpi/problemtask/feedback';

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, PROVINCE, YEAR, DEFAULTFILTER, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), 'pmkpi', '/pmkpi/problemtask/feedback', '待送审', 'waitaudit', 1, 1, 'choosed', 'problemtasklist.clickTabpage', 0, '待送审', null, '撤回,撤回申请延期', '{}', null, '0', null, null, null, null, null, null, '87', '2016', null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, PROVINCE, YEAR, DEFAULTFILTER, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), 'pmkpi', '/pmkpi/problemtask/feedback', '已送审', 'alreadyaudit', 1, 2, 'nomal', 'problemtasklist.clickTabpage', 0, '已送审', null, '填报,送审,申请延期,整改到期提醒,撤回申请延期', '{}', null, '0', null, null, null, null, null, null, '87', '2016', null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, PROVINCE, YEAR, DEFAULTFILTER, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), 'pmkpi', '/pmkpi/problemtask/feedback', '被退回', 'back', 1, 3, 'nomal', 'problemtasklist.clickTabpage', 0, '被退回', null, '撤回,撤回申请延期', '{}', null, '0', null, null, null, null, null, null, '87', '2016', null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, PROVINCE, YEAR, DEFAULTFILTER, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), 'pmkpi', '/pmkpi/problemtask/feedback', '曾经办', 'alldeals', 1, 4, 'nomal', 'problemtasklist.clickTabpage', 0, '曾经办', null, '填报,送审,申请延期,整改到期提醒,撤回,撤回申请延期', '{}', null, '0', null, null, null, null, null, null, '87', '2016', null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, PROVINCE, YEAR, DEFAULTFILTER, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), 'pmkpi', '/pmkpi/problemtask/feedback', '审批中的延期申请', 'senddelay', 1, 5, 'nomal', 'problemtasklist.clickTabpage', 0, '审批中的延期申请', null, '填报,送审,申请延期,整改到期提醒,撤回', '{}', null, '0', null, null, null, null, null, null, '87', '2016', null, null, null);

delete from p#busfw_t_uitable where key ='/pmkpi/problemtask/feedback';

insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/problemtask/feedback', 'V_PERF_T_PROBLEMTASKQUERY', 100, 0, 0, 'order by create_time,name,lead_agency', null, 'pmkpi', '{}', '87', '2016');

delete from p#busfw_t_uicolumn t where key ='/pmkpi/problemtask/feedback';

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/problemtask/feedback', 'GUID', '主键', 0, 0, 0, 0, null, 0, 1, null, null, null, null, 200, 0, 's', null, null, null, null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/problemtask/feedback', 'NAME', '评价项目名称', 1, 1, 0, 0, null, 0, 1, '[''问题清单'']', null, null, null, 200, 0, 's', null, null, null, null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/problemtask/feedback', 'LV1_TITLE', '一级标题', 2, 1, 0, 0, null, 0, 1, '[''问题类别'',''问题清单'']', null, null, null, 150, 0, 's', null, null, null, null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/problemtask/feedback', 'LV2_TITLE', '二级标题', 3, 1, 0, 0, null, 0, 1, '[''问题类别'',''问题清单'']', null, null, null, 180, 0, 's', null, null, null, null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/problemtask/feedback', 'DETAILCONTENT', '问题涉及具体事项', 4, 1, 0, 0, null, 0, 1, '[''问题清单'']', null, null, null, 200, 0, 's', null, null, null, null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/problemtask/feedback', 'PROBLEMTYPE', '整改类型', 5, 1, 0, 0, null, 0, 1, '[''问题清单'']', '#code-#name', null, null, 100, 1, 'tree', null, null, null, null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/problemtask/feedback', 'START_TIME', '评价结果反馈时间', 6, 1, 0, 0, null, 0, 1, '[''问题清单'']', null, null, null, 100, 0, 'd', '{}', null, null, null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/problemtask/feedback', 'EXTENSION_REASON', '延期原因', 8, 0, 0, 0, null, 0, 1, null, null, null, null, 100, 0, 's', '{pagetype:''senddelay''}', null, null, null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/problemtask/feedback', 'EXTENSION_TIME', '申请时间', 9, 0, 0, 0, null, 0, 1, null, null, null, null, 100, 0, 'd', '{pagetype:''senddelay''}', null, null, null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/problemtask/feedback', 'LEAD_AGENCY', '整改牵头部门', 7, 1, 0, 0, null, 0, 1, '[''问题清单'']', '#code-#name', null, null, 100, 1, 'tree', null, null, null, null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/problemtask/feedback', 'RECTIFY_MEASURES', '整改举措', 8, 1, 0, 0, null, 0, 1, '[''整改方案'',''整改清单'']', null, null, null, 100, 0, 's', null, null, null, null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/problemtask/feedback', 'RECTIFY_TIME', '整改时限', 9, 1, 0, 0, null, 0, 1, '[''整改方案'',''整改清单'']', null, null, null, 100, 0, 'd', null, null, null, null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/problemtask/feedback', 'RECTIFY_RESULT', '整改结果', 10, 1, 0, 0, null, 0, 1, '[''整改完成情况'',''整改清单'']', null, null, null, 100, 0, 's', null, null, null, null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/problemtask/feedback', 'RECTIFY_CONDITION', '整改情况', 11, 1, 0, 0, null, 0, 1, '[''整改完成情况'',''整改清单'']', null, null, null, 100, 0, 's', null, null, null, null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/problemtask/feedback', 'RECTIFY_REASON', '整改未到位原因及下步措施', 12, 1, 0, 0, null, 0, 1, '[''整改完成情况'',''整改清单'']', null, null, null, 100, 0, 's', null, null, null, null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/problemtask/feedback', 'COMPLETE_TIME', '整改实际完成时间', 13, 1, 0, 0, null, 0, 1, '[''整改完成情况'',''整改清单'']', null, null, null, 100, 0, 'd', null, null, null, null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/problemtask/feedback', 'BUDGET_APPLICATION', '预算应用（具体调整金额）', 14, 1, 0, 0, null, 0, 1, '[''整改成果'',''整改清单'']', null, null, null, 100, 0, 's', null, null, null, null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/problemtask/feedback', 'INTRODUCE_SYSTEM', '出台或更新制度', 15, 1, 0, 0, null, 0, 1, '[''整改成果'',''整改清单'']', null, null, null, 100, 0, 's', null, null, null, null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/problemtask/feedback', 'PERFECT_MECHANISM', '完善机制', 16, 1, 0, 0, null, 0, 1, '[''整改成果'',''整改清单'']', null, null, null, 100, 0, 's', null, null, null, null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/problemtask/feedback', 'OTHER_ACHIEVEMENT', '其他成果', 17, 1, 0, 0, null, 0, 1, '[''整改成果'',''整改清单'']', null, null, null, 100, 0, 's', null, null, null, null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/problemtask/feedback', 'EVALUATED_DEPARTMENT', '责任处室', 18, 1, 0, 0, null, 0, 1, '[''被评价单位'',''联系人'']', null, null, null, 100, 0, 's', null, null, null, null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/problemtask/feedback', 'EVALUATED_LINKMAN', '联系人', 19, 1, 0, 0, null, 0, 6, '[''被评价单位'',''联系人'']', null, null, null, 100, 0, 's', null, null, null, null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/problemtask/feedback', 'EVALUATED_CONTACT', '联系方式', 20, 1, 0, 0, null, 0, 1, '[''被评价单位'',''联系人'']', null, null, null, 100, 0, 's', null, null, null, null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/problemtask/feedback', 'LEAD_DEPARTMENT', '牵头处室', 21, 1, 0, 0, null, 0, 1, '[''财政部门'',''联系人'']', '#code-#name', null, null, 100, 1, 'tree', null, null, null, null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/problemtask/feedback', 'LINKMAN', '联系人', 22, 1, 0, 0, null, 0, 6, '[''财政部门'',''联系人'']', null, null, null, 100, 0, 's', null, null, null, null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/problemtask/feedback', 'PLAN_FILE', '整改方案（盖章扫描件）', 23, 1, 0, 0, null, 0, 6, '[''材料清单'']', '#name', null, null, 100, 1, 'tree', '{filetype:''problemtaskfeedback''}', null, null, null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/problemtask/feedback', 'SUPPORT_FILE', '整改佐证材料', 24, 1, 0, 0, null, 0, 6, '[''材料清单'']', '#name', null, null, 100, 1, 'tree', '{filetype:''problemtaskfeedback''}', null, null, null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/problemtask/feedback', 'IS_END', '整改销号认定', 25, 1, 0, 0, null, 0, 1, null, '#name', null, null, 100, 1, 'tree', '{pagetype:''audit''}', null, null, null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/problemtask/feedback', 'REPORT_TIME', '上报时间', 26, 1, 0, 0, null, 0, 1, null, null, null, null, 100, 0, 'd', '{pagetype:''audit''}', null, null, null, '87', '2016');


--03 整改审核页面
delete from p#busfw_t_uifunction where key ='/pmkpi/problemtask/audit';

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/problemtask/audit', '销号认定', 1, 1, 'searchicon', 'problemtasklist.wfAudit', null, '销号认定', 'pmkpi', 'audit', null, '{}','87', '2016', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/problemtask/audit', '退回', 1, 2, 'searchicon', 'problemtasklist.wfAudit', null, '退回', 'pmkpi', 'back', null, '{}', '87', '2016', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/problemtask/audit', '撤回', 1, 3, 'searchicon', 'problemtasklist.wfAudit', null, '撤回', 'pmkpi', 'cancelaudit', null, '{}','87', '2016', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/problemtask/audit', '导出列表', 1, 4, 'searchicon', 'Ext.lt.pmkpi.expdata', null, '导出列表', 'pmkpi', 'expdata', null, '{}', '87', '2016', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/problemtask/audit', '导出附件', 0, 5, 'searchicon', 'problemtasklist.expfile', null, '导出附件', 'pmkpi', 'expfile', null, '{zipname:''''}', '87', '2016', null, null);

delete from p#busfw_t_uitabpage where key ='/pmkpi/problemtask/audit';

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, PROVINCE, YEAR, DEFAULTFILTER, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), 'pmkpi', '/pmkpi/problemtask/audit', '待处理', 'waitaudit', 1, 1, 'choosed', 'problemtasklist.clickTabpage', 0, '待处理', null, '撤回,导出附件', '{}', null, '0', null, null, null, null, null, null, '87', '2016', null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, PROVINCE, YEAR, DEFAULTFILTER, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), 'pmkpi', '/pmkpi/problemtask/audit', '已销号', 'alreadyaudit', 1, 2, 'nomal', 'problemtasklist.clickTabpage', 0, '已销号', null, '销号认定,退回,导出附件', '{}', null, '0', null, null, null, null, null, null, '87', '2016', null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, PROVINCE, YEAR, DEFAULTFILTER, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), 'pmkpi', '/pmkpi/problemtask/audit', '全部', 'all', 1, 3, 'nomal', 'problemtasklist.clickTabpage', 0, '全部', null, '销号认定,退回,撤回', '{}', null, '0', null, null, null, null, null, null, '87', '2016', null, null, null);


--04 延期申请审核页面
delete from p#busfw_t_uifunction where key ='/pmkpi/problemtask/delayaudit';

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/problemtask/delayaudit', '批准', 1, 1, 'searchicon', 'problemtasklist.delay', null, '批准', 'pmkpi', 'pass', null, '{}','87', '2016', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/problemtask/delayaudit', '退回', 1, 2, 'searchicon', 'problemtasklist.delay', null, '退回', 'pmkpi', 'back', null, '{}', '87', '2016', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/problemtask/delayaudit', '导出列表', 0, 4, 'searchicon', 'Ext.lt.pmkpi.expdata', null, '导出列表', 'pmkpi', 'expdata', null, '{}', '87', '2016', null, null);

delete from p#busfw_t_uitabpage where key ='/pmkpi/problemtask/delayaudit';

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, PROVINCE, YEAR, DEFAULTFILTER, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), 'pmkpi', '/pmkpi/problemtask/delayaudit', '待审批', 'senddelay', 1, 1, 'choosed', 'problemtasklist.clickTabpage', 0, '待审批', null, null, '{}', null, '0', null, null, null, null, null, null, '87', '2016', null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, PROVINCE, YEAR, DEFAULTFILTER, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), 'pmkpi', '/pmkpi/problemtask/delayaudit', '已审批', 'auditdelay', 1, 2, 'nomal', 'problemtasklist.clickTabpage', 0, '已审批', null, '批准,退回', '{}', null, '0', null, null, null, null, null, null, '87', '2016', null, null, null);

delete from p#busfw_t_uitable where key ='/pmkpi/problemtask/delayaudit';

insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/problemtask/delayaudit', 'V_PERF_T_PROBLEMTASKQUERY', 100, 0, 0, 'order by create_time,name,lead_agency', null, 'pmkpi', '{}', '87', '2016');

delete from p#busfw_t_uicolumn t where key ='/pmkpi/problemtask/delayaudit';

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/problemtask/delayaudit', 'GUID', '主键', 0, 0, 0, 0, null, 0, 1, null, null, null, null, 200, 0, 's', null, null, null, null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/problemtask/delayaudit', 'NAME', '评价项目名称', 1, 1, 0, 0, null, 0, 1, null, null, null, null, 200, 0, 's', null, null, null, null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/problemtask/delayaudit', 'LV1_TITLE', '一级标题', 2, 1, 0, 0, null, 0, 1, '[''问题类别'']', null, null, null, 150, 0, 's', null, null, null, null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/problemtask/delayaudit', 'LV2_TITLE', '二级标题', 3, 1, 0, 0, null, 0, 1, '[''问题类别'']', null, null, null, 180, 0, 's', null, null, null, null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/problemtask/delayaudit', 'DETAILCONTENT', '问题涉及具体事项', 4, 1, 0, 0, null, 0, 1, null, null, null, null, 200, 0, 's', null, null, null, null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/problemtask/delayaudit', 'PROBLEMTYPE', '整改类型', 5, 1, 0, 0, null, 0, 1, null, '#code-#name', null, null, 100, 1, 'tree', null, null, null, null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/problemtask/delayaudit', 'START_TIME', '评价结果反馈时间', 6, 1, 0, 0, null, 0, 1, null, null, null, null, 100, 0, 'd', '{}', null, null, null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/problemtask/delayaudit', 'EXTENSION_REASON', '延期原因', 7, 1, 0, 0, null, 0, 1, null, null, null, null, 100, 0, 's', '{}', null, null, null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/problemtask/delayaudit', 'EXTENSION_TIME', '申请时间', 8, 1, 0, 0, null, 0, 1, null, null, null, null, 100, 0, 'd', '{}', null, null, null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/problemtask/delayaudit', 'LEAD_AGENCY', '整改牵头部门', 9, 1, 0, 0, null, 0, 1, null, '#code-#name', null, null, 100, 1, 'tree', null, null, null, null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/problemtask/delayaudit', 'LEAD_DEPARTMENT', '牵头处室', 10, 1, 0, 0, null, 0, 1, '[''财政部门'']', '#code-#name', null, null, 100, 1, 'tree', null, null, null, null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/problemtask/delayaudit', 'LINKMAN', '联系人', 11, 1, 0, 0, null, 0, 1, '[''财政部门'']', null, null, null, 100, 0, 's', null, null, null, null, '87', '2016');


--05 整改反馈信息页面
delete from p#busfw_t_uitabpage where key ='/pmkpi/problemtask/editissue';

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, PROVINCE, YEAR, DEFAULTFILTER, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), 'pmkpi', '/pmkpi/problemtask/editissue', '问题基本信息', 'info', 1, 1, 'choosed', 'tabfreamedit.clickTabpage', null, '问题基本信息', null, null, '{url:''/pmkpi/problemtask/issueinfo.page?pagetype=issue'',action:''problemtaskinfo.save'',busguid:''8DB78FE7219440ADA2DD4D8B9A384D2A''}', null, '0', 'iframeissueinfo', null, null, null, null, null, '87', '2016', null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, PROVINCE, YEAR, DEFAULTFILTER, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), 'pmkpi', '/pmkpi/problemtask/editissue', '附件材料', 'file', 0, 2, 'nomal', 'tabfreamedit.clickTabpage', null, '附件材料', null, '保存', '{filebustype:''problemtaskissue'',url:''/pmkpi/upload/file/index.page''}', null, '0', 'iframemance', null, null, null, null, null, '87', '2016', null, null, null);


delete from p#busfw_t_uitabpage where key ='/pmkpi/problemtask/edit';

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, PROVINCE, YEAR, DEFAULTFILTER, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), 'pmkpi', '/pmkpi/problemtask/edit', '问题基本信息', 'info', 1, 1, 'choosed', 'tabfreamedit.clickTabpage', null, '问题基本信息', null, null,  '{url:''/pmkpi/problemtask/issueinfo.page?pagetype=issue'||chr(38)||'viewtype=query'',action:''problemtaskinfo.save'',busguid:''8DB78FE7219440ADA2DD4D8B9A384D2A'',viewtype:''query''}', null, '0', 'iframeissueinfo', null, null, null, null, null, '87', '2016', null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, PROVINCE, YEAR, DEFAULTFILTER, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), 'pmkpi', '/pmkpi/problemtask/edit', '整改信息', 'feedback', 1, 2, 'nomal', 'tabfreamedit.clickTabpage', null, '整改信息', null, null, '{url:''/pmkpi/problemtask/editfeedback.page?pagetype=feedback'',action:''problemtaskinfo.save'',busguid:''8DB78FE7219440ADA2DD4D8B9A484D2A''}', null, '0', 'iframefeedbackinfo', null, null, null, null, null, '87', '2016', null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, PROVINCE, YEAR, DEFAULTFILTER, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), 'pmkpi', '/pmkpi/problemtask/edit', '附件材料', 'file', 1, 3, 'nomal', 'tabfreamedit.clickTabpage', null, '附件材料', null, '保存', '{filebustype:''problemtaskfeedback'',url:''/pmkpi/upload/file/index.page''}', null, '0', 'iframemance', null, null, null, null, null, '87', '2016', null, null, null);


delete from p#busfw_t_uifunction where key ='/pmkpi/problemtask/edit';

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/problemtask/edit', '保存', 1, 1, 'Keepicon', 'tabfreamedit.infosave', null, '保存', 'pmkpi', null, null, null, '87', '2016', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/problemtask/edit', '取消', 1, 2, 'Nofinishicon', 'tabfreamedit.close', null, '取消', 'pmkpi', null, null, null, '87', '2016', null, null);

delete from p#busfw_t_uieditform where key ='/pmkpi/problemtask/edit';

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR, HEAD, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/problemtask/edit', 'V_PERF_T_PROBLEMTASK', 's', '主键', 'GUID', 0, null, 1, null, 1, null, null, 'pmkpi', 1, null, '{}', null, null, null, '87', '2016', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR, HEAD, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/problemtask/edit', 'V_PERF_T_PROBLEMTASK', 's', '评价项目名称', 'NAME', 1, null, 1, null, 1, null, null, 'pmkpi', 1, null, '{}', null, null, null, '87', '2016', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR, HEAD, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/problemtask/edit', 'V_PERF_T_PROBLEMTASK', 's', '一级标题', 'LV1_TITLE', 1, null, 1, null, 2, null, null, 'pmkpi', 1, null, '{}', null, null, null, '87', '2016', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR, HEAD, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/problemtask/edit', 'V_PERF_T_PROBLEMTASK', 's', '二级标题', 'LV2_TITLE', 1, null, 1, null, 3, null, null, 'pmkpi', 1, null, '{}', null, null, null, '87', '2016', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR, HEAD, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/problemtask/edit', 'V_PERF_T_PROBLEMTASK', 'textarea', '问题涉及具体事项', 'DETAILCONTENT', 1, null, 1, null, 4, 3, 3, 'pmkpi', 1, null, '{}', null, null, null, '87', '2016', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR, HEAD, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/problemtask/edit', 'V_PERF_T_PROBLEMTASK', 'tree', '整改类型', 'PROBLEMTYPE', 1, null, 1, null, 5, null, null, 'pmkpi', 1, null, '{}', null, null, null, '87', '2016', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR, HEAD, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/problemtask/edit', 'V_PERF_T_PROBLEMTASK', 'd', '评价结果反馈时间', 'START_TIME', 1, null, 1, null, 6, null, null, 'pmkpi', 1, null, '{}', null, null, null, '87', '2016', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR, HEAD, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/problemtask/edit', 'V_PERF_T_PROBLEMTASK', 'tree', '整改牵头部门', 'LEAD_AGENCY', 1, null, 1, null, 7, null, null, 'pmkpi', 1, null, '{"format":"#code-#name","isMulti":true,"jsfilter":true}', null, 1, null, '87', '2016', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR, HEAD, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/problemtask/edit', 'V_PERF_T_PROBLEMTASK', 'tree', '牵头处室', 'LEAD_DEPARTMENT', 1, null, 1, null, 8, null, null, 'pmkpi', 0, null, '{}', null, null, null, '87', '2016', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR, HEAD, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/problemtask/edit', 'V_PERF_T_PROBLEMTASK', 's', '联系人', 'LINKMAN', 1, null, 1, null, 9, null, null, 'pmkpi', 1, null, '{}', null, null, null, '87', '2016', null, null, null);


delete from p#busfw_t_uieditform where key ='/pmkpi/problemtask/edit/feedback';

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR, HEAD, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/problemtask/edit/feedback', 'V_PERF_T_PROBLEMTASK', 's', '主键', 'GUID', 0, null, 1, null, 1, null, null, 'pmkpi', 1, null, '{}', null, null, null, '87', '2016', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR, HEAD, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/problemtask/edit/feedback', 'V_PERF_T_PROBLEMTASK', 's', '被评价单位责任处室', 'EVALUATED_DEPARTMENT', 1, null, 1, null, 1, null, null, 'pmkpi', 1, null, '{}', null, null, null, '87', '2016', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR, HEAD, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/problemtask/edit/feedback', 'V_PERF_T_PROBLEMTASK', 's', '被评价单位联系人', 'EVALUATED_LINKMAN', 1, null, 1, null, 2, null, null, 'pmkpi', 1, null, '{}', null, null, null, '87', '2016', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR, HEAD, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/problemtask/edit/feedback', 'V_PERF_T_PROBLEMTASK', 's', '被评价单位联系方式', 'EVALUATED_CONTACT', 1, null, 1, null, 3, null, null, 'pmkpi', 1, null, '{}', null, null, null, '87', '2016', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR, HEAD, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/problemtask/edit/feedback', 'V_PERF_T_PROBLEMTASK', 'textarea', '整改举措', 'RECTIFY_MEASURES', 1, null, 1, null, 4, 3, 3, 'pmkpi', 1, null, '{}', null, null, null, '87', '2016', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR, HEAD, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/problemtask/edit/feedback', 'V_PERF_T_PROBLEMTASK', 'd', '整改时限', 'RECTIFY_TIME', 1, null, 1, null, 5, null, null, 'pmkpi', 0, null, '{}', null, null, null, '87', '2016', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR, HEAD, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/problemtask/edit/feedback', 'V_PERF_T_PROBLEMTASK', 'textarea', '整改结果', 'RECTIFY_RESULT', 1, null, 1, null, 6, 3, 3, 'pmkpi', 1, null, '{}', null, null, null, '87', '2016', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR, HEAD, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/problemtask/edit/feedback', 'V_PERF_T_PROBLEMTASK', 'textarea', '整改情况', 'RECTIFY_CONDITION', 1, null, 1, null, 7, 3, 3, 'pmkpi', 1, null, '{}', null, null, null, '87', '2016', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR, HEAD, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/problemtask/edit/feedback', 'V_PERF_T_PROBLEMTASK', 'textarea', '整改未到位原因及下步措施', 'RECTIFY_REASON', 1, null, 0, null, 8, 3, 3, 'pmkpi', 1, null, '{}', null, null, null, '87', '2016', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR, HEAD, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/problemtask/edit/feedback', 'V_PERF_T_PROBLEMTASK', 'd', '整改实际完成时间', 'COMPLETE_TIME', 1, null, 1, null, 9, null, null, 'pmkpi', 1, null, '{}', null, null, null, '87', '2016', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR, HEAD, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/problemtask/edit/feedback', 'V_PERF_T_PROBLEMTASK', 'textarea', '预算应用（具体调整金额）', 'BUDGET_APPLICATION', 1, null, 1, null, 10, 3, 3, 'pmkpi', 1, null, '{}', null, null, null, '87', '2016', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR, HEAD, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/problemtask/edit/feedback', 'V_PERF_T_PROBLEMTASK', 'textarea', '出台或更新制度', 'INTRODUCE_SYSTEM', 1, null, 1, null, 11, 3, 3, 'pmkpi', 1, null, '{}', null, null, null, '87', '2016', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR, HEAD, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/problemtask/edit/feedback', 'V_PERF_T_PROBLEMTASK', 'textarea', '完善机制', 'PERFECT_MECHANISM', 1, null, 1, null, 12, 3, 3, 'pmkpi', 1, null, '{}', null, null, null, '87', '2016', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR, HEAD, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/problemtask/edit/feedback', 'V_PERF_T_PROBLEMTASK', 'textarea', '其他成果', 'OTHER_ACHIEVEMENT', 1, null, 1, null, 13, 3, 3, 'pmkpi', 1, null, '{}', null, null, null, '87', '2016', null, null, null);


delete from p#busfw_t_uieditform where key ='/pmkpi/problemtask/issue';

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR, HEAD, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/problemtask/issue', 'V_PERF_T_PROBLEMTASK', 'd', '原整改时限', 'RECTIFY_TIME', 1, null, 1, null, 0, null, null, 'pmkpi', 0, null, '{}', null, null, null,'87', '2016', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR, HEAD, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/problemtask/issue', 'V_PERF_T_PROBLEMTASK', 'd', '申请时间', 'EXTENSION_TIME', 1, null, 1, null, 1, null, null, 'pmkpi', 1, null, '{}', null, null, null, '87', '2016', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR, HEAD, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/problemtask/issue', 'V_PERF_T_PROBLEMTASK', 'textarea', '延期原因', 'EXTENSION_REASON', 1, null, 1, null, 2, 3, 3, 'pmkpi', 1, null, '{}', null, null, null, '87', '2016', null, null, null);
