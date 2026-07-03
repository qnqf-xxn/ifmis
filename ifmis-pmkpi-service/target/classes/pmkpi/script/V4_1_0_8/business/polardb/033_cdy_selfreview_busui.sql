begin
  
--自评复核
--项目确定
delete from p#busfw_t_uitable t where t.key in('/pmkpi/selfreview/manage');
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/selfreview/manage', 'V_PERF_T_SELFREVIEWTASK', 100, 0, 0, 'AGENCYGUID', null, 'pmkpi', '{}', '2016','87');

delete from p#busfw_t_uicolumn t where t.key in('/pmkpi/selfreview/manage');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/selfreview/manage', 'PRO_CODE', '项目编码', 1, 1, 0, 0, null, 0, 1, null, null, null, null, 150, 0, 's', '{}', null, null, null, '2016','87');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/selfreview/manage', 'NAME', '项目名称', 2, 1, 0, 0, null, 0, 1, null, null, null, null, 180, 0, 's', '{}', null, null, null, '2016','87');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/selfreview/manage', 'DEPT_CODE', '预算部门', 4, 1, 0, 0, null, 0, 1, null, '#code-#name', null, null, 200, 1, 'tree', '{}', null, null, null, '2016','87');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/selfreview/manage', 'AGENCYGUID', '预算单位', 5, 1, 0, 0, null, 0, 1, null, '#code-#name', null, null, 200, 1, 'tree', '{}', null, null, null, '2016','87');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/selfreview/manage', 'MOF_DEP_CODE', '业务处室', 6, 1, 0, 0, null, 0, 1, null, '#code-#name', null, null, 100, 1, 'tree', '{}', null, null, null, '2016','87');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/selfreview/manage', 'BUDGETAMOUNT', '全年预算数', 7, 0, 0, 0, null, 0, 1, null, null, null, null, 100, 0, 's', '{}', null, null, null, '2016','87');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/selfreview/manage', 'YEAR', '预算年度', 12, 0, 0, 0, null, 0, 1, null, null, null, null, 100, 0, 's', '{}', null, null, null, '2016','87');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/selfreview/manage', 'PRO_TOTAL_AMT', '项目总金额', 13, 1, 0, 0, null, 0, 1, null, null, null, null, 100, 0, 's', '{}', null, null, null, '2016','87');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/selfreview/manage', 'PROJECTKIND', '支出项目类别', 14, 0, 0, 0, null, 0, 1, null, '#code-#name', null, null, 100, 1, 'tree', '{}', null, null, null, '2016','87');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/selfreview/manage', 'BGTAMT', '当年预算金额', 14, 1, 0, 0, null, 0, 1, null, null, null, null, 100, 0, 'amt', '{}', null, null, null, '2016','87');

delete from p#busfw_t_uifunction t where t.key in('/pmkpi/selfreview/manage');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, ISEDITCTRL, EDITCTRLMSG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/selfreview/manage', '任务下达', 1, 1, null, 'selfreviewmanage.add', null, '任务下达', 'pmkpi', 'create', null, null, null, null, '2016','87');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, ISEDITCTRL, EDITCTRLMSG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/selfreview/manage', '取消下达', 1, 2, null, 'selfreviewmanage.del', null, '取消下达', 'pmkpi', 'del', null, null, null, null, '2016','87');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, ISEDITCTRL, EDITCTRLMSG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/selfreview/manage', '查看项目', 1, 3, null, 'selfreviewmanage.showProjView', null, '查看项目', 'pmkpi', 'showProjView', null, null, null, null, '2016','87');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, ISEDITCTRL, EDITCTRLMSG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/selfreview/manage', '导出列表', 1, 9, 'searchicon', 'Ext.lt.pmkpi.expdata', null, '导出列表', 'pmkpi', 'exportProj', null, '{}', null, null, '2016','87');

delete from p#busfw_t_uiqueryform t where t.key in('/pmkpi/selfreview/manage');
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, REQUIREMENT, ISEDITCTRL, EDITCTRLMSG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/selfreview/manage', 'PRO_CODE', '项目编码', 1, 1, 's', null, null, null, 'pmkpi', 'V_PERF_T_SELFREVIEWTASK', null, null, null, null, null, '2016','87');

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, REQUIREMENT, ISEDITCTRL, EDITCTRLMSG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/selfreview/manage', 'NAME', '项目名称', 3, 1, 's', null, null, null, 'pmkpi', 'V_PERF_T_SELFREVIEWTASK', null, null, null, null, null, '2016','87');

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, REQUIREMENT, ISEDITCTRL, EDITCTRLMSG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/selfreview/manage', 'AGENCYGUID', '预算单位', 4, 1, 'tree', null, null, null, 'pmkpi', 'V_PERF_T_SELFREVIEWTASK', null, null, null, null, null, '2016','87');

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, REQUIREMENT, ISEDITCTRL, EDITCTRLMSG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/selfreview/manage', 'MOF_DEP_CODE', '业务处室', 5, 1, 'tree', null, null, null, 'pmkpi', 'V_PERF_T_SELFREVIEWTASK', null, null, null, null, null, '2016','87');

delete from p#busfw_t_uitabpage t where t.key in('/pmkpi/selfreview/manage');
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER, ISEDITCTRL, EDITCTRLMSG, YEAR, PROVINCE)
values (sys_guid(), 'pmkpi', '/pmkpi/selfreview/manage', '未下达', 'waitaudit', 1, 1, 'choosed', 'selfreviewmanage.clickTabpage', null, '未下达', null, '取消下达', '{}', null, '0', null, null, null, null, null, null, null, null, null, '2016','87');

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER, ISEDITCTRL, EDITCTRLMSG, YEAR, PROVINCE)
values (sys_guid(), 'pmkpi', '/pmkpi/selfreview/manage', '已下达', 'alreadyaudit', 1, 2, 'nomal', 'selfreviewmanage.clickTabpage', null, '已下达', null, '任务下达', '{}', null, '0', null, null, null, null, null, null, null, null, null, '2016','87');

--查询
delete from p#busfw_t_uitable t where t.key in('/pmkpi/selfreview/query');
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/selfreview/query', 'V_PERF_T_SELFREVIEWTASK', 100, 0, 0, 'updatetime', null, 'pmkpi', '{}', '2016','87');
  
delete from p#busfw_t_uicolumn t where t.key in('/pmkpi/selfreview/query');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/selfreview/query', 'GUID', 'guid', 0, 0, 0, 0, null, 0, 1, null, null, null, null, 200, 0, 's', '{}', null, null, null, '2016','87');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/selfreview/query', 'WFSTATUS', '状态', 1, 1, 0, 0, null, 0, 1, null, '#name', null, null, 100, 1, 'tree', '{}', null, null, null, '2016','87');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/selfreview/query', 'CODE', '编码', 2, 1, 0, 0, null, 0, 1, null, '#code', null, null, 100, 0, 's', '{}', null, null, null, '2016','87');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/selfreview/query', 'NAME', '名称', 3, 1, 0, 0, null, 0, 1, null, '#name', null, null, 200, 0, 's', '{}', null, null, null, '2016','87');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/selfreview/query', 'AGENCYGUID', '预算单位', 4, 1, 0, 0, null, 0, 1, null, '#code-#name', null, null, 200, 1, 'tree', '{}', null, null, null, '2016','87');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/selfreview/query', 'FININTORGGUID', '业务处室', 6, 1, 0, 0, null, 0, 1, null, '#code-#name', null, null, 100, 1, 'tree', '{}', null, null, null, '2016','87');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/selfreview/query', 'BUDGETAMOUNT', '年初预算数', 6, 1, 0, 0, null, 0, 1, null, null, null, null, 100, 0, 'amt', '{}', null, null, null, '2016','87');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/selfreview/query', 'MANAGE_MOF_DEP_CODE', '资金归口处室', 7, 0, 0, null, null, null, 1, null, '#code-#name', null, null, null, 1, 'tree', '{}', null, null, null, '2016','87');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/selfreview/query', 'BGTAMT', '当年预算数', 7, 1, 0, 0, null, 0, 1, null, null, null, null, 100, 0, 'amt', '{}', null, null, null, '2016','87');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/selfreview/query', 'EXECAMOUNT', '全年执行数', 8, 1, 0, 0, null, 0, 1, null, null, null, null, 100, 0, 'amt', '{}', null, null, null, '2016','87');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/selfreview/query', 'PRO_TOTAL_AMT', '项目总金额', 9, 1, 0, 0, null, 0, 1, null, null, null, null, 100, 0, 'amt', '{}', null, null, null, '2016','87');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/selfreview/query', 'BGTGET', '预算执行率', 10, 1, 0, 0, null, 0, 1, null, null, null, null, 100, 0, 's', '{}', null, null, null, '2016','87');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/selfreview/query', 'SCORE', '得分', 11, 1, 0, 0, null, 0, 1, null, null, null, null, 100, 0, 's', '{}', null, null, null, '2016','87');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/selfreview/query', 'SELFRESULT', '自评结论', 12, 1, 0, 0, null, 0, 1, null, null, null, null, 100, 0, 's', '{}', null, null, null, '2016','87');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/selfreview/query', 'WARN', '自评预警', 13, 0, 0, 0, null, 0, 1, null, null, null, null, 100, 0, 's', '{}', null, null, null, '2016','87');

delete from p#busfw_t_uifunction t where t.key in('/pmkpi/selfreview/query');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, ISEDITCTRL, EDITCTRLMSG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/selfreview/query', '审核情况', 1, 5, 'searchicon', 'selfreviewquery.queryaudit', null, '审核情况', 'pmkpi', 'queryaudit', null, null, null, null, '2016','87');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, ISEDITCTRL, EDITCTRLMSG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/selfreview/query', '查看复核成果', 1, 6, 'searchicon', 'selfreviewquery.detailed', null, '查看复核成果', 'pmkpi', 'detailed', null, '{}', null, null, '2016','87');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, ISEDITCTRL, EDITCTRLMSG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/selfreview/query', '查看自评信息', 1, 7, 'searchicon', 'selfreviewquery.selfproject', null, '查看自评信息', 'pmkpi', 'selfproject', null, null, null, null, '2016','87');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, ISEDITCTRL, EDITCTRLMSG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/selfreview/query', '查看项目', 1, 8, 'searchicon', 'selfreviewquery.showProjView', null, '查看项目', 'pmkpi', 'showProjView', null, null, null, null, '2016','87');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, ISEDITCTRL, EDITCTRLMSG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/selfreview/query', '导出列表', 1, 9, 'searchicon', 'Ext.lt.pmkpi.expdata', null, '导出列表', 'pmkpi', 'exportProj', null, '{}', null, null, '2016','87');

--成果上传
delete from p#busfw_t_uifunction t where t.key in('/pmkpi/selfreview/result');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, ISEDITCTRL, EDITCTRLMSG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/selfreview/result', '复核成果上传', 1, 2, 'searchicon', 'selfreviewresult.save', null, '复核成果上传', 'pmkpi', 'create', null, null, null, null, '2016','87');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, ISEDITCTRL, EDITCTRLMSG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/selfreview/result', '送审', 1, 3, 'searchicon', 'selfreviewresult.wfAudit', null, '送审', 'pmkpi', 'sendaudit', null, null, null, null, '2016','87');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, ISEDITCTRL, EDITCTRLMSG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/selfreview/result', '取消送审', 1, 4, 'searchicon', 'selfreviewresult.wfAudit', null, '取消送审', 'pmkpi', 'cancelsendaudit', null, null, null, null, '2016','87');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, ISEDITCTRL, EDITCTRLMSG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/selfreview/result', '审核情况', 1, 5, 'searchicon', 'selfreviewresult.queryaudit', null, '审核情况', 'pmkpi', 'queryaudit', null, null, null, null, '2016','87');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, ISEDITCTRL, EDITCTRLMSG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/selfreview/result', '查看复核成果', 1, 6, 'searchicon', 'selfreviewresult.detailed', null, '查看复核成果', 'pmkpi', 'detailed', null, '{}', null, null, '2016','87');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, ISEDITCTRL, EDITCTRLMSG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/selfreview/result', '查看自评信息', 1, 7, 'searchicon', 'selfreviewresult.selfproject', null, '查看自评信息', 'pmkpi', 'selfproject', null, null, null, null, '2016','87');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, ISEDITCTRL, EDITCTRLMSG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/selfreview/result', '查看项目', 1, 8, 'searchicon', 'selfreviewresult.showProjView', null, '查看项目', 'pmkpi', 'showProjView', null, null, null, null, '2016','87');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, ISEDITCTRL, EDITCTRLMSG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/selfreview/result', '导出列表', 1, 9, 'searchicon', 'Ext.lt.pmkpi.expdata', null, '导出列表', 'pmkpi', 'exportProj', null, '{}', null, null, '2016','87');

delete from p#busfw_t_uitabpage t where t.key in('/pmkpi/selfreview/result');
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER, ISEDITCTRL, EDITCTRLMSG, YEAR, PROVINCE)
values (sys_guid(), 'pmkpi', '/pmkpi/selfreview/result', '未送审', 'waitaudit', 1, 1, 'choosed', 'selfreviewresult.clickTabpage', null, '未送审', null, '取消送审', '{}', null, '0', null, null, null, null, null, null, null, null, null, '2016','87');

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER, ISEDITCTRL, EDITCTRLMSG, YEAR, PROVINCE)
values (sys_guid(), 'pmkpi', '/pmkpi/selfreview/result', '已送审', 'alreadyaudit', 1, 2, 'nomal', 'selfreviewresult.clickTabpage', null, '已送审', null, '复核成果上传,送审', '{}', null, '0', null, null, null, null, null, null, null, null, null, '2016','87');

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER, ISEDITCTRL, EDITCTRLMSG, YEAR, PROVINCE)
values (sys_guid(), 'pmkpi', '/pmkpi/selfreview/result', '被退回', 'back', 1, 3, 'nomal', 'selfreviewresult.clickTabpage', null, '被退回', null, '取消送审', '{}', null, '0', null, null, null, null, null, null, null, null, null, '2016','87');

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER, ISEDITCTRL, EDITCTRLMSG, YEAR, PROVINCE)
values (sys_guid(), 'pmkpi', '/pmkpi/selfreview/result', '曾经办', 'alldeals', 1, 4, 'nomal', 'selfreviewresult.clickTabpage', null, '曾经办', null, '复核成果上传,送审,取消送审', '{}', null, '0', null, null, null, null, null, null, null, null, null, '2016','87');

--成果审核
delete from p#busfw_t_uifunction t where t.key in('/pmkpi/selfreview/audit');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, ISEDITCTRL, EDITCTRLMSG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/selfreview/audit', '审核', 1, 1, 'searchicon', 'selfreviewaudit.audit', null, '审核', 'pmkpi', 'audit', null, null, null, null, '2016','87');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, ISEDITCTRL, EDITCTRLMSG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/selfreview/audit', '批量审核', 1, 2, 'searchicon', 'selfreviewaudit.wfAudit', null, '批量审核', 'pmkpi', 'auditbatch', null, '{remark:true}', null, null, '2016','87');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, ISEDITCTRL, EDITCTRLMSG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/selfreview/audit', '退回', 1, 3, 'searchicon', 'selfreviewaudit.wfAudit', null, '退回', 'pmkpi', 'back', null, null, null, null, '2016','87');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, ISEDITCTRL, EDITCTRLMSG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/selfreview/audit', '取消审核', 1, 4, 'searchicon', 'selfreviewaudit.wfAudit', null, '取消审核', 'pmkpi', 'cancelaudit', null, null, null, null, '2016','87');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, ISEDITCTRL, EDITCTRLMSG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/selfreview/audit', '审核情况', 1, 5, 'searchicon', 'selfreviewaudit.queryaudit', null, '审核情况', 'pmkpi', 'queryaudit', null, null, null, null, '2016','87');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, ISEDITCTRL, EDITCTRLMSG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/selfreview/audit', '查看复核成果', 1, 6, 'searchicon', 'selfreviewaudit.detailed', null, '查看复核成果', 'pmkpi', 'detailed', null, '{}', null, null, '2016','87');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, ISEDITCTRL, EDITCTRLMSG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/selfreview/audit', '查看自评信息', 1, 7, 'searchicon', 'selfreviewaudit.selfproject', null, '查看自评信息', 'pmkpi', 'selfproject', null, null, null, null, '2016','87');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, ISEDITCTRL, EDITCTRLMSG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/selfreview/audit', '查看项目', 1, 8, 'searchicon', 'selfreviewaudit.showProjView', null, '查看项目', 'pmkpi', 'showProjView', null, null, null, null, '2016','87');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, ISEDITCTRL, EDITCTRLMSG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/selfreview/audit', '导出列表', 1, 9, 'searchicon', 'Ext.lt.pmkpi.expdata', null, '导出列表', 'pmkpi', 'exportProj', null, '{}', null, null, '2016','87');

delete from p#busfw_t_uitabpage t where t.key in('/pmkpi/selfreview/audit');
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER, ISEDITCTRL, EDITCTRLMSG, YEAR, PROVINCE)
values (sys_guid(), 'pmkpi', '/pmkpi/selfreview/audit', '待审核', 'waitaudit', 1, 1, 'choosed', 'selfreviewaudit.clickTabpage', null, '待审核', null, '取消审核', '{}', null, '0', null, null, null, null, null, null, null, null, null, '2016','87');

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER, ISEDITCTRL, EDITCTRLMSG, YEAR, PROVINCE)
values (sys_guid(), 'pmkpi', '/pmkpi/selfreview/audit', '已审核', 'alreadyaudit', 1, 2, 'nomal', 'selfreviewaudit.clickTabpage', null, '已审核', null, '审核,批量审核,退回', '{}', null, '0', null, null, null, null, null, null, null, null, null, '2016','87');

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER, ISEDITCTRL, EDITCTRLMSG, YEAR, PROVINCE)
values (sys_guid(), 'pmkpi', '/pmkpi/selfreview/audit', '被退回', 'back', 1, 3, 'nomal', 'selfreviewaudit.clickTabpage', null, '被退回', null, '取消审核', '{}', null, '0', null, null, null, null, null, null, null, null, null, '2016','87');

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER, ISEDITCTRL, EDITCTRLMSG, YEAR, PROVINCE)
values (sys_guid(), 'pmkpi', '/pmkpi/selfreview/audit', '曾经办', 'alldeals', 1, 4, 'nomal', 'selfreviewaudit.clickTabpage', null, '曾经办', null, '审核,取消审核,批量审核,退回', '{}', null, '0', null, null, null, null, null, null, null, null, null, '2016','87');

--编辑区
delete from p#busfw_t_uifunction t where t.key in('/pmkpi/selfreview/result/edit');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, ISEDITCTRL, EDITCTRLMSG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/selfreview/result/edit', '取消', 1, 2, 'Nofinishicon', 'tabfreamedit.close', null, '取消', 'pmkpi', null, null, null, null, null, '2016','87');

delete from p#busfw_t_uitabpage t where t.key in('/pmkpi/selfreview/result/edit');
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER, ISEDITCTRL, EDITCTRLMSG, YEAR, PROVINCE)
values (sys_guid(), 'pmkpi', '/pmkpi/selfreview/result/edit', '项目基本信息', 'proinfo', 1, 1, 'choosed', 'tabfreamedit.clickTabpage', null, '项目基本信息', null, null, '{viewtype:''query''}', null, '0', 'proinfoeditform', null, null, null, null, null, null, null, null, '2016','87');

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER, ISEDITCTRL, EDITCTRLMSG, YEAR, PROVINCE)
values (sys_guid(), 'pmkpi', '/pmkpi/selfreview/result/edit', '复核成果', 'file', 1, 5, 'nomal', 'tabfreamedit.clickTabpage', null, '复核成果', null, '保存', '{filebustype:''selfreviewpro'',url:''/pmkpi/upload/file/index.page''}', null, '0', 'manceiframe', null, null, null, null, null, null, null, null, '2016','87');
