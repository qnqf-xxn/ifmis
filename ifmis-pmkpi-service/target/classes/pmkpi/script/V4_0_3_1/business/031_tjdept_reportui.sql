begin
 
--report 
delete FROM p#Busfw_t_Uifunction t where t.key = '/pmkpi/deptTJformance/report/index';
delete FROM P#Busfw_t_Uiqueryform t where t.key = '/pmkpi/deptTJformance/report/index';
delete FROM P#Busfw_t_Uitabpage t where t.key = '/pmkpi/deptTJformance/report/index';
delete FROM P#Busfw_t_Uitable t where t.key = '/pmkpi/deptTJformance/report/index';
delete FROM P#Busfw_t_Uicolumn t where t.key = '/pmkpi/deptTJformance/report/index';

insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/deptTJformance/report/index', '新增', 1, 1, 'searchicon', 'deptTJlist.add', null, '新增', 'pmkpi', 'add', null, '{}');

insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/deptTJformance/report/index', '修改', 1, 2, 'searchicon', 'deptTJlist.save', null, '修改', 'pmkpi', 'save', null, '{}');

insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/deptTJformance/report/index', '删除', 1, 3, 'searchicon', 'deptTJlist.del', null, '删除', 'pmkpi', 'del', null, '{}');

insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/deptTJformance/report/index', '送审', 1, 4, 'searchicon', 'deptTJlist.wfAudit', null, '送审', 'pmkpi', 'sendaudit', null, '{}');

insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/deptTJformance/report/index', '取消送审', 1, 5, 'searchicon', 'deptTJlist.wfAudit', null, '取消送审', 'pmkpi', 'cancelsendaudit', null, '{}');

insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/deptTJformance/report/index', '审核情况', 1, 6, 'searchicon', 'deptTJlist.queryaudit', null, '审核情况', 'pmkpi', 'queryaudit', null, '{}');

insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/deptTJformance/report/index', '查询', 0, 7, 'searchicon', 'deptTJlist.query', null, '查询', 'pmkpi', 'query', null, '{}');

insert into Busfw_t_Uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/deptTJformance/report/index', 'NAME', '名称', 1, 1, 's', null, null, null, 'pmkpi', 'V_PERF_T_DEPTPERFDECLARE', null, null);

insert into Busfw_t_Uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/deptTJformance/report/index', 'WFSTATUS', '审核状态', 2, 1, 'tree', null, null, null, 'pmkpi', 'V_PERF_T_DEPTPERFDECLARE', null, null);

insert into Busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values (sys_guid(), 'pmkpi', '/pmkpi/deptTJformance/report/index', '待送审', 'waitaudit', 1, 1, 'choosed', 'deptTJlist.clickTabpage', null, '待送审', null, '取消送审', '{}', null, '0', null, null, null, null, null, null, null);

insert into Busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values (sys_guid(), 'pmkpi', '/pmkpi/deptTJformance/report/index', '已送审', 'alreadyaudit', 1, 2, 'nomal', 'deptTJlist.clickTabpage', null, '已送审', null, '新增,修改,删除,送审', '{}', null, '0', null, null, null, null, null, null, null);

insert into Busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values (sys_guid(), 'pmkpi', '/pmkpi/deptTJformance/report/index', '曾经办', 'alldeals', 1, 3, 'nomal', 'deptTJlist.clickTabpage', null, '曾经办', null, '新增,修改,删除,送审,取消送审', '{}', null, '0', null, null, null, null, null, null, null);

insert into Busfw_t_Uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values (sys_guid(), '/pmkpi/deptTJformance/report/index', 'V_PERF_T_DEPTPERFDECLARE', 0, 0, 0, null, null, 'pmkpi', null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/deptTJformance/report/index', 'GUID', 'guid', 1, 0, 0, 0, null, 0, 6, null, null, null, null, null, 0, 's', null, null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/deptTJformance/report/index', 'WFSTATUS', '工作流状态', 2, 1, 0, 0, null, 0, 6, null, '#name', null, null, 80, 1, 'tree', null, null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/deptTJformance/report/index', 'NAME', '名称', 3, 1, 0, 0, null, 0, 1, null, null, null, null, 200, 0, 's', null, null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/deptTJformance/report/index', 'LINKMAN', '联系人', 4, 1, 0, 0, null, 0, 1, null, null, null, null, 100, 0, 's', null, null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/deptTJformance/report/index', 'TELEPHONE', '联系电话', 5, 1, 0, 0, null, 0, 6, null, null, null, null, 150, 0, 's', null, null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/deptTJformance/report/index', 'CREATETIME', '创建人', 6, 0, 0, 0, null, 0, 6, null, null, null, null, 100, 0, 's', null, null);


--audit
delete FROM p#Busfw_t_Uifunction t where t.key = '/pmkpi/deptTJformance/audit/index';
delete FROM P#Busfw_t_Uitabpage t where t.key = '/pmkpi/deptTJformance/audit/index';

insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/deptTJformance/audit/index', '审核', 1, 1, null, 'deptTJauditlist.audit', null, '审核', 'pmkpi', 'audit', null, null);

insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/deptTJformance/audit/index', '修改', 0, 2, 'searchicon', 'deptTJauditlist.addOredit', null, '修改', 'pmkpi', 'save', null, '{}');

insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/deptTJformance/audit/index', '取消审核', 1, 2, null, 'deptTJauditlist.wfAudit', null, '取消审核', 'pmkpi', 'cancelaudit', null, null);

insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/deptTJformance/audit/index', '查询', 0, 3, 'searchicon', 'deptTJauditlist.query', null, '查询', 'pmkpi', 'query', null, null);

insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/deptTJformance/audit/index', '批量审核', 0, 4, 'searchicon', 'deptTJauditlist.wfAudit', null, '批量审核', 'pmkpi', 'auditbatch', null, '{remark:true}');

insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/deptTJformance/audit/index', '审核情况', 1, 6, 'searchicon', 'deptTJauditlist.queryaudit', null, '审核情况', 'pmkpi', 'queryaudit', null, null);

insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/deptTJformance/audit/index', '审核信息', 1, 7, 'searchicon', 'deptTJauditlist.auditinfo', null, '审核信息', 'pmkpi', 'auditinfo', null, null);

insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/deptTJformance/audit/index', '批量退回', 0, 9, 'searchicon', 'deptTJauditlist.wfAudit', null, '批量退回', 'pmkpi', 'back', null, '{}');

insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/deptTJformance/audit/index', '分发处室', 1, 10, 'searchicon', 'deptTJauditlist.tofinintorg', null, '分发处室', 'pmkpi', 'tofinintorg', null, '{}');


insert into Busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values (sys_guid(), 'pmkpi', '/pmkpi/deptTJformance/audit/index', '被退回', 'back', 1, 3, 'nomal', 'deptTJauditlist.clickTabpage', null, '被退回', null, '取消审核,审核信息', '{}', null, '0', null, null, null, null, null, null, null);

insert into Busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values (sys_guid(), 'pmkpi', '/pmkpi/deptTJformance/audit/index', '曾经办', 'alldeals', 1, 4, 'nomal', 'deptTJauditlist.clickTabpage', null, '曾经办', null, '审核,取消审核,修改,批量审核,批量退回,分发处室', '{}', null, '0', null, null, null, null, null, null, null);

insert into Busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values (sys_guid(), 'pmkpi', '/pmkpi/deptTJformance/audit/index', '已审核', 'alreadyaudit', 1, 2, 'nomal', 'deptTJauditlist.clickTabpage', null, '已审核', null, '审核,修改,批量审核,批量退回,分发处室', '{}', null, '0', null, null, null, null, null, null, null);

insert into Busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values (sys_guid(), 'pmkpi', '/pmkpi/deptTJformance/audit/index', '待审核', 'waitaudit', 1, 1, 'choosed', 'deptTJauditlist.clickTabpage', null, '待审核', null, '取消审核,审核信息', '{}', null, '0', null, null, null, null, null, null, null);


--query
delete FROM p#Busfw_t_Uifunction t where t.key = '/pmkpi/deptTJformance/query/index';

insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/deptTJformance/query/index', '查询', 0, 1, 'searchicon', 'deptTJquerylist.query', null, '查询', 'pmkpi', 'query', null, null);

insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/deptTJformance/query/index', '审核情况', 1, 2, 'searchicon', 'deptTJquerylist.queryaudit', null, '审核情况', 'pmkpi', 'queryaudit', null, null);

insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/deptTJformance/query/index', '导出报告', 1, 3, 'searchicon', 'Ext.lt.pmkpi.expdoc', null, '导出报告', 'pmkpi', 'expxls', null, '{tempatecode:''tjdeptyeargoalindexxls''}');


--tofinintorg
delete FROM p#Busfw_t_Uifunction t where t.key = '/pmkpi/deptTJformance/audit/tofinintorg';
delete FROM P#Busfw_t_Uitabpage t where t.key = '/pmkpi/deptTJformance/audit/tofinintorg';
delete FROM P#Busfw_t_Uitable t where t.key = '/pmkpi/deptTJformance/audit/tofinintorg';
delete FROM P#Busfw_t_Uicolumn t where t.key = '/pmkpi/deptTJformance/audit/tofinintorg';

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/deptTJformance/audit/tofinintorg', '确认分发', 1, 1, 'Keepicon', 'deptTJtofinintorg.tofinintorg', null, '确认分发', 'pmkpi', 'add', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/deptTJformance/audit/tofinintorg', '取消分发', 1, 1, 'Keepicon', 'deptTJtofinintorg.tofinintorg', null, '取消分发', 'pmkpi', 'del', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/deptTJformance/audit/tofinintorg', '取消', 1, 2, 'Nofinishicon', 'Ext.lt.ui.closeModalWindow', null, '取消', 'pmkpi', null, null, null);


insert into Busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values (sys_guid(), 'pmkpi', '/pmkpi/deptTJformance/audit/tofinintorg', '待分发', 'waitaudit', 1, 1, 'choosed', 'deptTJtofinintorg.clickTabpage', null, '待分发', null, '取消分发', '{}', null, '0', null, null, null, null, null, null, null);

insert into Busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values (sys_guid(), 'pmkpi', '/pmkpi/deptTJformance/audit/tofinintorg', '已分发', 'alreadyaudit', 1, 2, 'nomal', 'deptTJtofinintorg.clickTabpage', null, '已分发', null, '确认分发', '{}', null, '0', null, null, null, null, null, null, null);


insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values (sys_guid(), '/pmkpi/deptTJformance/audit/tofinintorg', 'PERF_T_DEPTTOFININTORG', 0, 1, 0, null, null, 'pmkpi', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/deptTJformance/audit/tofinintorg', 'GUID', 'guid', 1, 0, 0, null, null, 0, null, null, null, null, null, null, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/deptTJformance/audit/tofinintorg', 'MAINGUID', '主数据id', 2, 0, 1, 0, null, 0, null, null, null, null, null, 200, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/deptTJformance/audit/tofinintorg', 'FINITORG', '处室编码', 3, 1, 1, 0, null, 0, null, null, null, null, null, 200, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/deptTJformance/audit/tofinintorg', 'FINITORGNAME', '处室名称', 4, 1, 1, 0, null, 0, null, null, null, null, null, 200, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/deptTJformance/audit/tofinintorg', 'YEAR', '年度', 5, 0, 1, 0, null, 0, null, null, null, null, null, 200, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/deptTJformance/audit/tofinintorg', 'PROVINCE', '区划', 6, 0, 1, 0, null, 0, null, null, null, null, null, 200, 0, 's', '{}', null);


--finreview
delete FROM p#Busfw_t_Uifunction t where t.key = '/pmkpi/deptTJformance/finreview/index';
delete FROM P#Busfw_t_Uitabpage t where t.key = '/pmkpi/deptTJformance/finreview/index';
delete FROM P#Busfw_t_Uiqueryform t where t.key = '/pmkpi/deptTJformance/finreview/index';
delete FROM P#Busfw_t_Uitable t where t.key = '/pmkpi/deptTJformance/finreview/index';
delete FROM P#Busfw_t_Uicolumn t where t.key = '/pmkpi/deptTJformance/finreview/index';


insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/deptTJformance/finreview/index', '审阅', 1, 1, 'Keepicon', 'deptTJfinreview.review', null, '审阅', 'pmkpi', 'add', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/deptTJformance/finreview/index', '取消审阅', 1, 1, 'Keepicon', 'deptTJfinreview.review', null, '取消审阅', 'pmkpi', 'del', null, null);


insert into Busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values (sys_guid(), 'pmkpi', '/pmkpi/deptTJformance/finreview/index', '未审阅', 'waitaudit', 1, 1, 'choosed', 'deptTJfinreview.clickTabpage', null, '未审阅', null, '取消审阅', '{}', null, '0', null, null, null, null, null, null, null);

insert into Busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values (sys_guid(), 'pmkpi', '/pmkpi/deptTJformance/finreview/index', '已审阅', 'alreadyaudit', 1, 2, 'nomal', 'deptTJfinreview.clickTabpage', null, '已审阅', null, '审阅', '{}', null, '0', null, null, null, null, null, null, null);


insert into Busfw_t_Uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/deptTJformance/finreview/index', 'CODE', '部门编码', 2, 1, 'tree', null, null, null, 'pmkpi', 'V_PERF_T_DEPTPERFDECLARE', null, null);

insert into Busfw_t_Uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/deptTJformance/finreview/index', 'NAME', '部门名称', 1, 1, 's', null, null, null, 'pmkpi', 'V_PERF_T_DEPTPERFDECLARE', null, null);


insert into Busfw_t_Uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values (sys_guid(), '/pmkpi/deptTJformance/finreview/index', 'V_PERF_T_DEPTPERFDECLARE', 0, 0, 0, null, null, 'pmkpi', null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/deptTJformance/finreview/index', 'GUID', 'guid', 1, 0, 0, 0, null, 0, 6, null, null, null, null, null, 0, 's', null, null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/deptTJformance/finreview/index', 'CODE', '部门编码', 2, 1, 0, 0, null, 0, 1, null, null, null, null, 100, 0, 's', null, null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/deptTJformance/finreview/index', 'NAME', '部门名称', 3, 1, 0, 0, null, 0, 1, null, null, null, null, 200, 0, 's', null, null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/deptTJformance/finreview/index', 'LINKMAN', '联系人', 4, 1, 0, 0, null, 0, 6, null, null, null, null, 100, 0, 's', null, null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/deptTJformance/finreview/index', 'TELEPHONE', '联系电话', 5, 1, 0, 0, null, 0, 6, null, null, null, null, 150, 0, 's', null, null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/deptTJformance/finreview/index', 'REVIEWGUID', '审阅id', 6, 0, 0, 0, null, 0, 6, null, null, null, null, 150, 0, 's', null, null);

