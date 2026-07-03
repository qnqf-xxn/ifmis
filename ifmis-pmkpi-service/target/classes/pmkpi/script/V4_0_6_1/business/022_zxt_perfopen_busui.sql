begin

--绩效公开填报
delete FROM p#Busfw_t_Dcworkflowplan t where t.GUID = '9CA7347F12AAA0A8AE02ABEA139D3A99';

insert into Busfw_t_Dcworkflowplan (GUID, CODE, TABLECODE, NAME, STATUS, YEAR, PROVINCE, VERSION, DBVERSION, REMARK, CREATER, CREATETIME, TYPE)
values ('9CA7347F12AAA0A8AE02ABEA139D3A99', 'V_PERF_T_MANCEOPEN', 'V_PERF_T_MANCEOPEN', '绩效公开填报', '1','2016','87', null, null, null, null, '20200829172956946', 'B876713347C31372A297A0234F30FFB8');

--填报
delete from p#busfw_t_uitabpage t where t.key in('/pmkpi/performanceopen/report');
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER, YEAR, PROVINCE)
values (sys_guid(), 'pmkpi', '/pmkpi/performanceopen/report', '未送审', 'waitaudit', 1, 1, 'choosed', 'perfopenreport.clickTabpage', 1, '未送审', null, '取消送审', '{}', null, '0', null, null, null, null, null, null, null,'2016','87');
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER, YEAR, PROVINCE)
values (sys_guid(), 'pmkpi', '/pmkpi/performanceopen/report', '已送审', 'alreadyaudit', 1, 2, 'nomal', 'perfopenreport.clickTabpage', 1, '已送审', null, '保存,送审,导入', '{}', null, '0', null, null, null, null, null, null, null,'2016','87');
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER, YEAR, PROVINCE)
values (sys_guid(), 'pmkpi', '/pmkpi/performanceopen/report', '曾经办', 'alldeals', 1, 4, 'nomal', 'perfopenreport.clickTabpage', 1, '曾经办', null, '保存,送审,取消送审,导入', '{}', null, '0', null, null, null, null, null, null, null,'2016','87');
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER, YEAR, PROVINCE)
values (sys_guid(), 'pmkpi', '/pmkpi/performanceopen/report', '被退回', 'back', 1, 3, 'nomal', 'perfopenreport.clickTabpage', 1, '被退回', null, '取消送审,导入', '{}', null, '0', null, null, null, null, null, null, null,'2016','87');

delete from p#busfw_t_uifunction t where key in('/pmkpi/performanceopen/report');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/performanceopen/report', '保存', 1, 1, 'searchicon', 'perfopenreport.save', null, '保存', 'pmkpi', 'toEdit', null, null,'2016','87');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/performanceopen/report', '送审', 1, 2, 'searchicon', 'perfopenreport.wfAudit', null, '送审', 'pmkpi', 'sendaudit', null, '{"action":"audit"}','2016','87');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/performanceopen/report', '取消送审', 1, 3, 'searchicon', 'perfopenreport.wfAudit', null, '取消送审', 'pmkpi', 'cancelsendaudit', null, '{"action":"audit_cancel"}','2016','87');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/performanceopen/report', '审核情况', 1, 4, 'searchicon', 'perfopenreport.queryaudit', null, '审核情况', 'pmkpi', 'queryaudit', null, '{}','2016','87');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/performanceopen/report', '查看明细', 1, 5, 'searchicon', 'perfopenreport.showwfinfo', null, '查看明细', 'pmkpi', 'showwfinfo', null, '{}','2016','87');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/performanceopen/report', '导出列表', 1, 6, 'export', 'Ext.lt.pmkpi.expdata', null, '导出列表', 'pmkpi', 'expdoc', null, '{}','2016','87');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/performanceopen/report', '导入', 1, 7, 'searchicon', 'perfopenreport.import', null, '导入', 'pmkpi', 'import', null, '{}','2016','87');

--项目列表
delete from p#busfw_t_uitable t where key in('/pmkpi/performanceopen/report/list');
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/performanceopen/report/list', 'V_PERF_MANCEOPEN', 100, 0, 0, null, null, 'pmkpi', null,'2016','87');

delete from p#busfw_t_uicolumn t where key in('/pmkpi/performanceopen/report/list');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/performanceopen/report/list', 'GUID', '主键', 1, 0, 0, 0, null, null, null, null, null, null, null, null, 1, 's', null, null,'2016','87');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/performanceopen/report/list', 'PROJGUID', '项目主键', 2, 0, 0, 0, null, null, null, null, null, null, null, null, 1, 's', null, null,'2016','87');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/performanceopen/report/list', 'WFID', '工作流id', 3, 0, 0, 0, null, null, null, null, null, null, null, null, 0, 's', null, null,'2016','87');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/performanceopen/report/list', 'WFSTATUS', '状态', 4, 1, 0, 0, null, null, null, null, '#name', null, null, 100, 1, 'tree', null, null,'2016','87');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/performanceopen/report/list', 'MANAGE_MOF_DEP_CODE', '处室', 5, 1, 0, 0, null, null, null, null, '#name', null, null, 150, 1, 'tree', null, null,'2016','87');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/performanceopen/report/list', 'DEPT_CODE', '部门', 6, 1, 0, 0, null, null, null, null, '#name', null, null, 150, 1, 'tree', null, null,'2016','87');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/performanceopen/report/list', 'AGENCY_CODE', '单位', 7, 1, 0, 0, null, null, null, null, '#name', null, null, 150, 1, 'tree', null, null,'2016','87');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/performanceopen/report/list', 'PRO_KIND_CODE', '项目类型', 8, 1, 0, 0, null, null, null, null, '#name', null, null, 150, 1, 'tree', null, null,'2016','87');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/performanceopen/report/list', 'PRO_CODE', '项目编码', 9, 1, 0, 0, null, null, 1, null, null, null, null, 150, 1, 's', null, null,'2016','87');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/performanceopen/report/list', 'PRO_NAME', '项目名称', 10, 1, 0, 0, null, null, 1, null, null, null, null, 150, 0, 's', null, null,'2016','87');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/performanceopen/report/list', 'MONEY', '预算金额', 11, 1, 0, 0, null, null, null, null, null, null, null, 150, 1, 's', null, null,'2016','87');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/performanceopen/report/list', 'XMLY', '项目来源', 12, 1, 0, 0, null, null, null, null, null, null, null, 150, 1, 's', null, null,'2016','87');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/performanceopen/report/list', 'ISTBJX', '是否填报绩效', 13, 1, 0, 0, null, null, null, null, null, null, null, 150, 1, 's', null, null,'2016','87');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/performanceopen/report/list', 'PERFOPEN', '公开类型', 14, 1, 0, 0, null, null, null, null, '#name', null, null, 150, 1, 'tree', null, null,'2016','87');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/performanceopen/report/list', 'ISOPEN', '是否公开', 15, 1, 1, 0, null, null, null, null, '#name', null, null, 150, 1, 'tree', null, null,'2016','87');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/performanceopen/report/list', 'OPENAMT', '公开金额', 16, 1, 1, 0, null, null, null, null, null, null, null, 150, 0, 's', null, null,'2016','87');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/performanceopen/report/list', 'OPENURL', '公开网址', 17, 1, 1, 0, null, null, null, null, null, null, null, 150, 0, 's', null, null,'2016','87');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/performanceopen/report/list', 'OPENREASON', '不公开原因', 18, 1, 1, 0, null, null, null, null, null, null, null, 150, 0, 's', null, null,'2016','87');


delete from p#busfw_t_uiqueryform t where t.key in('/pmkpi/performanceopen/report');
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, YEAR, PROVINCE)
values ('B9ED1F7009C32EC2E053B11FA8C00E35', '/pmkpi/performanceopen/report', 'PRO_CODE', '项目编码', 1, 1, 's', null, null, null, 'pmkpi', 'V_PERF_MANCEOPEN', '{}', null,'2016','87');

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, YEAR, PROVINCE)
values ('B98F59846620B918E053B11FA8C0831D', '/pmkpi/performanceopen/report', 'PRO_NAME', '项目名称', 2, 1, 's', null, null, null, 'pmkpi', 'V_PERF_MANCEOPEN', '{}', null,'2016','87');


--审核
delete from p#busfw_t_uitabpage t where t.key in('/pmkpi/performanceopen/audit');
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER, YEAR, PROVINCE)
values (sys_guid(), 'pmkpi', '/pmkpi/performanceopen/audit', '待审核', 'waitaudit', 1, 1, 'choosed', 'perfopenaudit.clickTabpage', 1, '待审核', null, '取消审核', '{}', null, '0', null, null, null, null, null, null, null,'2016','87');
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER, YEAR, PROVINCE)
values (sys_guid(), 'pmkpi', '/pmkpi/performanceopen/audit', '已审核', 'alreadyaudit', 1, 2, 'nomal', 'perfopenaudit.clickTabpage', 1, '已审核', null, '审核', '{}', null, '0', null, null, null, null, null, null, null,'2016','87');
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER, YEAR, PROVINCE)
values (sys_guid(), 'pmkpi', '/pmkpi/performanceopen/audit', '曾经办', 'alldeals', 1, 4, 'nomal', 'perfopenaudit.clickTabpage', 1, '曾经办', null, '审核,取消审核', '{}', null, '0', null, null, null, null, null, null, null,'2016','87');
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER, YEAR, PROVINCE)
values (sys_guid(), 'pmkpi', '/pmkpi/performanceopen/audit', '被退回', 'back', 1, 3, 'nomal', 'perfopenaudit.clickTabpage', 1, '被退回', null, '取消审核', '{}', null, '0', null, null, null, null, null, null, null,'2016','87');

delete from p#busfw_t_uifunction t where key in('/pmkpi/performanceopen/audit');


insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/performanceopen/audit', '审核', 1, 2, 'searchicon', 'perfopenaudit.wfAudit', null, '审核', 'pmkpi', 'sendaudit', null, '{"action":"audit"}','2016','87');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/performanceopen/audit', '取消审核', 1, 3, 'searchicon', 'perfopenaudit.wfclenAudit', null, '取消审核', 'pmkpi', 'cancelsendaudit', null, '{"action":"audit_cancel"}','2016','87');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/performanceopen/audit', '审核情况', 1, 4, 'searchicon', 'perfopenaudit.queryaudit', null, '审核情况', 'pmkpi', 'queryaudit', null, '{}','2016','87');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/performanceopen/audit', '查看明细', 1, 5, 'searchicon', 'perfopenaudit.showwfinfo', null, '查看明细', 'pmkpi', 'showwfinfo', null, '{}','2016','87');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/performanceopen/audit', '导出列表', 1, 6, 'export', 'Ext.lt.pmkpi.expdata', null, '导出列表', 'pmkpi', 'expdoc', null, '{}','2016','87');


delete from p#busfw_t_uiqueryform t where t.key in('/pmkpi/performanceopen/audit');
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, YEAR, PROVINCE)
values ('B9ED1F7009C32EC2E053B11FA8C00E35', '/pmkpi/performanceopen/audit', 'PRO_CODE', '项目编码', 1, 1, 's', null, null, null, 'pmkpi', 'V_PERF_MANCEOPEN', '{}', null,'2016','87');

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, YEAR, PROVINCE)
values ('B98F59846620B918E053B11FA8C0831D', '/pmkpi/performanceopen/audit', 'PRO_NAME', '项目名称', 2, 1, 's', null, null, null, 'pmkpi', 'V_PERF_MANCEOPEN', '{}', null,'2016','87');

delete from p#busfw_t_uitable t where key in('/pmkpi/performanceopen/report/listaudit');
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/performanceopen/report/listaudit', 'V_PERF_MANCEOPEN', 100, 0, 0, null, null, 'pmkpi', null,'2016','87');

delete from p#busfw_t_uicolumn t where key in('/pmkpi/performanceopen/report/listaudit');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/performanceopen/report/listaudit', 'GUID', '主键', 1, 0, 0, 0, null, null, null, null, null, null, null, null, 1, 's', null, null,'2016','87');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/performanceopen/report/listaudit', 'PROJGUID', '项目主键', 2, 0, 0, 0, null, null, null, null, null, null, null, null, 1, 's', null, null,'2016','87');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/performanceopen/report/listaudit', 'WFID', '工作流id', 3, 0, 0, 0, null, null, null, null, null, null, null, null, 0, 's', null, null,'2016','87');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/performanceopen/report/listaudit', 'WFSTATUS', '状态', 4, 1, 0, 0, null, null, null, null, '#name', null, null, 100, 1, 'tree', null, null,'2016','87');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/performanceopen/report/listaudit', 'MANAGE_MOF_DEP_CODE', '处室', 5, 1, 0, 0, null, null, null, null, '#name', null, null, 150, 1, 'tree', null, null,'2016','87');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/performanceopen/report/listaudit', 'DEPT_CODE', '部门', 6, 1, 0, 0, null, null, null, null, '#name', null, null, 150, 1, 'tree', null, null,'2016','87');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/performanceopen/report/listaudit', 'AGENCY_CODE', '单位', 7, 1, 0, 0, null, null, null, null, '#name', null, null, 150, 1, 'tree', null, null,'2016','87');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/performanceopen/report/listaudit', 'PRO_KIND_CODE', '项目类型', 8, 1, 0, 0, null, null, null, null, '#name', null, null, 150, 1, 'tree', null, null,'2016','87');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/performanceopen/report/listaudit', 'PRO_CODE', '项目编码', 9, 1, 0, 0, null, null, 1, null, null, null, null, 150, 1, 's', null, null,'2016','87');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/performanceopen/report/listaudit', 'PRO_NAME', '项目名称', 10, 1, 0, 0, null, null, 1, null, null, null, null, 150, 0, 's', null, null,'2016','87');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/performanceopen/report/listaudit', 'MONEY', '预算金额', 11, 1, 0, 0, null, null, null, null, null, null, null, 150, 1, 's', null, null,'2016','87');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/performanceopen/report/listaudit', 'XMLY', '项目来源', 12, 1, 0, 0, null, null, null, null, null, null, null, 150, 1, 's', null, null,'2016','87');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/performanceopen/report/listaudit', 'ISTBJX', '是否填报绩效', 13, 1, 0, 0, null, null, null, null, null, null, null, 150, 1, 's', null, null,'2016','87');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/performanceopen/report/listaudit', 'PERFOPEN', '公开类型', 14, 1, 0, 0, null, null, null, null, '#name', null, null, 150, 1, 'tree', null, null,'2016','87');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/performanceopen/report/listaudit', 'ISOPEN', '是否公开', 15, 1, 0, 0, null, null, null, null, '#name', null, null, 150, 1, 'tree', null, null,'2016','87');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/performanceopen/report/listaudit', 'OPENAMT', '公开金额', 16, 1, 0, 0, null, null, null, null, null, null, null, 150, 0, 's', null, null,'2016','87');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/performanceopen/report/listaudit', 'OPENURL', '公开网址', 17, 1, 0, 0, null, null, null, null, null, null, null, 150, 0, 's', null, null,'2016','87');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/performanceopen/report/listaudit', 'OPENREASON', '不公开原因', 18, 1, 0, 0, null, null, null, null, null, null, null, 150, 0, 's', null, null,'2016','87');


--查询

delete from p#busfw_t_uifunction t where key in('/pmkpi/performanceopen/query');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/performanceopen/query', '审核情况', 1, 4, 'searchicon', 'perfopenquery.queryaudit', null, '审核情况', 'pmkpi', 'queryaudit', null, '{}','2016','87');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/performanceopen/query', '查看明细', 1, 5, 'searchicon', 'perfopenquery.showwfinfo', null, '查看明细', 'pmkpi', 'showwfinfo', null, '{}','2016','87');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/performanceopen/query', '导出列表', 1, 6, 'export', 'Ext.lt.pmkpi.expdata', null, '导出列表', 'pmkpi', 'expdoc', null, '{}','2016','87');


delete from p#busfw_t_uiqueryform t where t.key in('/pmkpi/performanceopen/query');
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, YEAR, PROVINCE)
values ('B9ED1F7009C32EC2E053B11FA8C00E35', '/pmkpi/performanceopen/query', 'PRO_CODE', '项目编码', 1, 1, 's', null, null, null, 'pmkpi', 'V_PERF_MANCEOPEN', '{}', null,'2016','87');

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, YEAR, PROVINCE)
values ('B98F59846620B918E053B11FA8C0831D', '/pmkpi/performanceopen/query', 'PRO_NAME', '项目名称', 2, 1, 's', null, null, null, 'pmkpi', 'V_PERF_MANCEOPEN', '{}', null,'2016','87');

delete from p#busfw_t_uitable t where key in('/pmkpi/performanceopen/report/listquery');
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/performanceopen/report/listquery', 'V_PERF_MANCEOPEN', 100, 0, 0, null, null, 'pmkpi', null,'2016','87');

delete from p#busfw_t_uicolumn t where key in('/pmkpi/performanceopen/report/listquery');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/performanceopen/report/listquery', 'GUID', '主键', 1, 0, 0, 0, null, null, null, null, null, null, null, null, 1, 's', null, null,'2016','87');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/performanceopen/report/listquery', 'PROJGUID', '项目主键', 2, 0, 0, 0, null, null, null, null, null, null, null, null, 1, 's', null, null,'2016','87');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/performanceopen/report/listquery', 'WFID', '工作流id', 3, 0, 0, 0, null, null, null, null, null, null, null, null, 0, 's', null, null,'2016','87');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/performanceopen/report/listquery', 'WFSTATUS', '状态', 4, 1, 0, 0, null, null, null, null, '#name', null, null, 100, 1, 'tree', null, null,'2016','87');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/performanceopen/report/listquery', 'MANAGE_MOF_DEP_CODE', '处室', 5, 1, 0, 0, null, null, null, null, '#name', null, null, 150, 1, 'tree', null, null,'2016','87');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/performanceopen/report/listquery', 'DEPT_CODE', '部门', 6, 1, 0, 0, null, null, null, null, '#name', null, null, 150, 1, 'tree', null, null,'2016','87');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/performanceopen/report/listquery', 'AGENCY_CODE', '单位', 7, 1, 0, 0, null, null, null, null, '#name', null, null, 150, 1, 'tree', null, null,'2016','87');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/performanceopen/report/listquery', 'PRO_KIND_CODE', '项目类型', 8, 1, 0, 0, null, null, null, null, '#name', null, null, 150, 1, 'tree', null, null,'2016','87');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/performanceopen/report/listquery', 'PRO_CODE', '项目编码', 9, 1, 0, 0, null, null, 1, null, null, null, null, 150, 1, 's', null, null,'2016','87');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/performanceopen/report/listquery', 'PRO_NAME', '项目名称', 10, 1, 0, 0, null, null, 1, null, null, null, null, 150, 0, 's', null, null,'2016','87');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/performanceopen/report/listquery', 'MONEY', '预算金额', 11, 1, 0, 0, null, null, null, null, null, null, null, 150, 1, 's', null, null,'2016','87');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/performanceopen/report/listquery', 'XMLY', '项目来源', 12, 1, 0, 0, null, null, null, null, null, null, null, 150, 1, 's', null, null,'2016','87');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/performanceopen/report/listquery', 'ISTBJX', '是否填报绩效', 13, 1, 0, 0, null, null, null, null, null, null, null, 150, 1, 's', null, null,'2016','87');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/performanceopen/report/listquery', 'PERFOPEN', '公开类型', 14, 1, 0, 0, null, null, null, null, '#name', null, null, 150, 1, 'tree', null, null,'2016','87');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/performanceopen/report/listquery', 'ISOPEN', '是否公开', 15, 1, 0, 0, null, null, null, null, '#name', null, null, 150, 1, 'tree', null, null,'2016','87');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/performanceopen/report/listquery', 'OPENAMT', '公开金额', 16, 1, 0, 0, null, null, null, null, null, null, null, 150, 0, 's', null, null,'2016','87');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/performanceopen/report/listquery', 'OPENURL', '公开网址', 17, 1, 0, 0, null, null, null, null, null, null, null, 150, 0, 's', null, null,'2016','87');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/performanceopen/report/listquery', 'OPENREASON', '不公开原因', 18, 1, 0, 0, null, null, null, null, null, null, null, 150, 0, 's', null, null,'2016','87');
