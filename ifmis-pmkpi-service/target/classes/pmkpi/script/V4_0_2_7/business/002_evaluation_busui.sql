begin
  -- 事前绩效评估申报页面
delete from busfw_t_uitabpage where key ='/pmkpi/seeting/evaluation/report';
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values (sys_guid(), 'pmkpi', '/pmkpi/seeting/evaluation/report', '曾经办', 'alldeals', 1, 4, 'nomal', 'evaluation.clickTabpage', 1, '曾经办', null, '填报/修改,送审,取消送审,删除项目,选择项目', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values (sys_guid(), 'pmkpi', '/pmkpi/seeting/evaluation/report', '已送审', 'alreadyaudit', 1, 2, 'nomal', 'evaluation.clickTabpage', 1, '已送审', null, '填报/修改,送审,删除项目,选择项目', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values (sys_guid(), 'pmkpi', '/pmkpi/seeting/evaluation/report', '未送审', 'waitaudit', 1, 1, 'choosed', 'evaluation.clickTabpage', 1, '未送审', null, '取消送审', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values (sys_guid(), 'pmkpi', '/pmkpi/seeting/evaluation/report', '被退回', 'back', 1, 3, 'nomal', 'evaluation.clickTabpage', 1, '被退回', null, '取消送审,选择项目', '{}', null, '0', null, null, null, null, null, null, null);

delete from busfw_t_uifunction where key ='/pmkpi/seeting/evaluation/report';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/seeting/evaluation/report', '选择项目', 1, 1, 'searchicon', 'evaluation.checkprogram', null, '选择项目', 'pmkpi', 'checkprogram', null, '{}');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/seeting/evaluation/report', '填报/修改', 1, 2, 'searchicon', 'evaluation.edit', null, '填报/修改', 'pmkpi', 'toEdit', null, '{}');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/seeting/evaluation/report', '送审', 1, 3, 'searchicon', 'evaluation.wfAudit', null, '送审', 'pmkpi', 'sendaudit', null, '{"action":"audit"}');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/seeting/evaluation/report', '取消送审', 1, 4, 'searchicon', 'evaluation.wfAudit', null, '取消送审', 'pmkpi', 'cancelsendaudit', null, '{"action":"audit_cancel"}');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/seeting/evaluation/report', '审核情况', 1, 5, 'searchicon', 'evaluation.queryaudit', null, '审核情况', 'pmkpi', 'showwfinfo', null, '{}');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/seeting/evaluation/report', '查看明细', 1, 6, 'searchicon', 'evaluation.detailed', null, '查看明细', 'pmkpi', 'detailed', null, '{}');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/seeting/evaluation/report', '删除项目', 1, 7, 'searchicon', 'evaluation.delete', null, '删除项目', 'pmkpi', 'delete', null, '{}');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/seeting/evaluation/report', '查看项目', 1, 7, 'searchicon', 'evaluation.showProjView', null, '查看项目', 'pmkpi', 'showProjViewn', null, '{}');

delete from busfw_t_uicolumn where key ='/pmkpi/seeting/evaluation/report';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/seeting/evaluation/report', 'PRO_TOTAL_AMT', '项目总金额', 7, 1, 0, 0, null, null, 1, null, null, null, null, null, 1, 's', null, null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/seeting/evaluation/report', 'PRO_NAME', '项目名称', 3, 1, 0, 0, null, null, 1, null, null, null, null, 200, 0, 's', '{type:''program''}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/seeting/evaluation/report', 'AGENCYGUID', '预算单位', 4, 1, 0, 0, null, null, 1, null, '#code-#name', null, null, 200, 1, 'tree', '{type:''program''}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/seeting/evaluation/report', 'YEAR', '设立年度', 6, 1, 0, 0, null, null, 1, null, null, null, null, 100, 0, 's', null, null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/seeting/evaluation/report', 'FININTORGGUID', '业务处室', 5, 1, 0, 0, null, null, 1, null, '#name', null, null, 100, 1, 'tree', null, null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/seeting/evaluation/report', 'GUID', '主键', 0, 0, 0, 0, null, null, null, null, null, null, null, null, 1, 's', null, null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/seeting/evaluation/report', 'WFSTATUS', '审核状态', 1, 1, 0, 0, null, null, 1, null, '#name', null, null, 100, 1, 'tree', null, null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/seeting/evaluation/report', 'PRO_CODE', '项目编码', 2, 1, 0, 0, null, null, 1, null, null, null, null, 150, 1, 's', '{type:''program''}', null);

delete from busfw_t_uitable where key ='/pmkpi/seeting/evaluation/report';
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values (sys_guid(), '/pmkpi/seeting/evaluation/report', 'V_PERF_T_EVALUATION', 100, 0, 0, null, null, 'pmkpi', null);

delete from busfw_t_uiqueryform where key ='/pmkpi/seeting/evaluation/report';
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, REQUIREMENT)
values (sys_guid(), '/pmkpi/seeting/evaluation/report', 'PRO_CODE', '项目编码', 1, 1, 's', null, null, null, 'pmkpi', 'V_PERF_T_EVALUATION', '{}', null, null);
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, REQUIREMENT)
values (sys_guid(), '/pmkpi/seeting/evaluation/report', 'PRO_NAME', '项目名称', 2, 1, 's', null, null, null, 'pmkpi', 'V_PERF_T_EVALUATION', '{}', null, null);


--事前绩效评估审核页面
delete from busfw_t_uitabpage where key ='/pmkpi/seeting/evaluation/audit';
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values (sys_guid(), 'pmkpi', '/pmkpi/seeting/evaluation/audit', '曾经办', 'alldeals', 1, 4, 'nomal', 'evaluationaudit.clickTabpage', 1, '曾经办', null, '修改,审核,取消审核,删除项目', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values (sys_guid(), 'pmkpi', '/pmkpi/seeting/evaluation/audit', '已审核', 'alreadyaudit', 1, 2, 'nomal', 'evaluationaudit.clickTabpage', 1, '已审核', null, '修改,审核,删除项目', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values (sys_guid(), 'pmkpi', '/pmkpi/seeting/evaluation/audit', '待审核', 'waitaudit', 1, 1, 'choosed', 'evaluationaudit.clickTabpage', 1, '待审核', null, '取消审核', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values (sys_guid(), 'pmkpi', '/pmkpi/seeting/evaluation/audit', '被退回', 'back', 1, 3, 'nomal', 'evaluationaudit.clickTabpage', 1, '被退回', null, '取消审核', '{}', null, '0', null, null, null, null, null, null, null);


delete from busfw_t_uifunction where key ='/pmkpi/seeting/evaluation/audit';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/seeting/evaluation/audit', '批量审核', 0, 5, 'searchicon', 'evaluationaudit.wfAudit', null, '批量审核', 'pmkpi', 'auditbatch', null, '{remark:true}');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/seeting/evaluation/audit', '批量退回', 0, 6, 'searchicon', 'evaluationaudit.wfAudit', null, '批量退回', 'pmkpi', 'back', null, '{}');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/seeting/evaluation/audit', '审核', 1, 1, 'searchicon', 'evaluationaudit.audit', null, '审核', 'pmkpi', 'audit', null, '{"action":"audit"}');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/seeting/evaluation/audit', '取消审核', 1, 2, 'searchicon', 'evaluationaudit.wfAudit', null, '取消审核', 'pmkpi', 'cancelaudit', null, '{"action":"audit_cancel"}');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/seeting/evaluation/audit', '审核情况', 1, 3, 'searchicon', 'evaluationaudit.queryaudit', null, '审核情况', 'pmkpi', 'showwfinfo', null, '{}');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/seeting/evaluation/audit', '查看明细', 1, 4, 'searchicon', 'evaluationaudit.detailed', null, '查看明细', 'pmkpi', 'detailed', null, '{}');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/seeting/evaluation/audit', '修改', 0, 7, 'searchicon', 'evaluationaudit.update', null, '修改', 'pmkpi', 'update', null, null);
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/seeting/evaluation/audit', '查看项目', 1, 8, 'searchicon', 'evaluationaudit.showProjView', null, '查看项目', 'pmkpi', 'showProjViewn', null, '{}');


--事前绩效评估查询页面
delete from busfw_t_uifunction where key ='/pmkpi/seeting/evaluation/query';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/seeting/evaluation/query', '审核情况', 0, 1, 'searchicon', 'evaluationquery.queryaudit', null, '审核情况', 'pmkpi', 'showwfinfo', null, '{}');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/seeting/evaluation/query', '查看明细', 0, 2, 'searchicon', 'evaluationquery.detailed', null, '查看明细', 'pmkpi', 'detailed', null, '{}');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/seeting/evaluation/query', '查看项目', 1, 3, 'searchicon', 'evaluationquery.showProjView', null, '查看项目', 'pmkpi', 'showProjViewn', null, '{}');


delete from busfw_t_uicolumn where key ='/pmkpi/seeting/evaluation/query';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/seeting/evaluation/query', 'PRO_TOTAL_AMT', '项目总金额', 7, 1, 0, 0, null, null, 1, null, null, null, null, null, 1, 's', null, null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/seeting/evaluation/query', 'PRO_NAME', '项目名称', 3, 1, 0, 0, null, null, 1, null, null, null, null, 200, 0, 's', '{type:''program''}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/seeting/evaluation/query', 'AGENCYGUID', '预算单位', 4, 1, 0, 0, null, null, 1, null, '#code-#name', null, null, 200, 1, 'tree', '{type:''program''}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/seeting/evaluation/query', 'YEAR', '设立年度', 6, 1, 0, 0, null, null, 1, null, null, null, null, 100, 0, 's', null, null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/seeting/evaluation/query', 'FININTORGGUID', '业务处室', 5, 1, 0, 0, null, null, 1, null, '#name', null, null, 100, 1, 'tree', null, null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/seeting/evaluation/query', 'GUID', '主键', 0, 0, 0, 0, null, null, null, null, null, null, null, null, 1, 's', null, null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/seeting/evaluation/query', 'PRO_CODE', '项目编码', 2, 1, 0, 0, null, null, 1, null, null, null, null, 150, 1, 's', '{type:''program''}', null);

delete from busfw_t_uitable where key ='/pmkpi/seeting/evaluation/query';
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values (sys_guid(), '/pmkpi/seeting/evaluation/query', 'V_PERF_PROJECT_INFO', 100, 0, 0, 'agencyguid asc，pro_total_amt desc', 't.PRO_LEV = ''2''', 'pmkpi', null);




--申报 选择项目页面
delete from busfw_t_uicolumn where key ='/pmkpi/evaluation/report/procheck';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/evaluation/report/procheck', 'PRO_CODE', '项目编码', 1, 1, 0, null, null, null, 1, null, null, null, null, null, 0, 's', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/evaluation/report/procheck', 'PRO_NAME', '项目名称', 2, 1, 0, null, null, null, 1, null, null, null, null, null, 0, 's', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/evaluation/report/procheck', 'AGENCYGUID', '预算单位', 3, 1, 0, null, null, null, null, null, '#code-#name', null, null, null, 1, 'tree', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/evaluation/report/procheck', 'YEAR', '设立年度', 4, 1, 0, null, null, null, 1, null, null, null, null, null, 0, 's', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/evaluation/report/procheck', 'CREATE_TIME', '填报时间', 7, 0, 0, null, null, null, 1, null, 'yyyy-MM-dd hh:mm:ss', null, null, null, 0, 'd', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/evaluation/report/procheck', 'FININTORGGUID', '业务处室', 5, 1, 0, null, null, null, null, null, '#name', null, null, null, 1, 'tree', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/evaluation/report/procheck', 'GUID', '主键', 8, 0, 0, null, null, null, null, null, null, null, null, null, 1, 's', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/evaluation/report/procheck', 'PRO_TOTAL_AMT', '项目总金额', 6, 1, 0, null, null, null, 1, null, null, null, null, null, 0, 'amt', '{}', null);

delete from busfw_t_uitable where key ='/pmkpi/evaluation/report/procheck';
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values (sys_guid(), '/pmkpi/evaluation/report/procheck', 'V_PERF_PROJECT_INFO', 100, 1, 0, 'PRO_CODE', ' t.PRO_TOTAL_AMT > 10000000 and t.pro_cat_code in(''22'',''3'')', 'pmkpi', null);


delete from busfw_t_uifunction where key ='/pmkpi/evaluation/report/procheck';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/evaluation/report/procheck', '确定', 1, 1, 'Keepicon', 'evaluationcheck.save', null, '确定', 'pmkpi', null, null, null);
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/evaluation/report/procheck', '取消', 1, 2, 'Nofinishicon', 'Ext.lt.ui.closeModalWindow', null, '取消', 'pmkpi', null, null, null);


--申报  填报修改

delete from busfw_t_uifunction where key ='/pmkpi/evaluation/report/proedit';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/evaluation/report/proedit', '保存', 1, 1, 'Keepicon', 'tabfreamedit.infosave', null, '保存', 'pmkpi', null, null, null);
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/evaluation/report/proedit', '取消', 1, 2, 'Nofinishicon', 'tabfreamedit.close', null, '取消', 'pmkpi', null, null, null);

delete from busfw_t_uitabpage where key ='/pmkpi/evaluation/report/proedit';
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values (sys_guid(), 'pmkpi', '/pmkpi/evaluation/report/proedit', '事前绩效评估信息', 'evaluationinfo', 1, 3, 'nomal', 'tabfreamedit.clickTabpage', null, '事前绩效评估信息', null, null, '{url:''/pmkpi/report/evaluationinfo.page'',action:''evaluationinfo.save''}', null, '0', 'iframeevaluationinfo', null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values (sys_guid(), 'pmkpi', '/pmkpi/evaluation/report/proedit', '附件管理', 'file', 1, 4, 'nomal', 'tabfreamedit.clickTabpage', null, '附件管理', null, '保存', '{filebustype:''evaluatereport'',url:''/pmkpi/upload/file/index.page''}', null, '0', 'iframemance', null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values (sys_guid(), 'pmkpi', '/pmkpi/evaluation/report/proedit', '基本信息', 'proinfo', 1, 1, 'choosed', 'tabfreamedit.clickTabpage', null, '基本信息', null, '保存', '{busguid:''B9B1886CA7A400A1E053B11FA8C0DBA4'',url:''/pmkpi/prorevision/report/proedit/info.page''}', null, '0', 'infoiframe', null, null, null, null, null, null);

--事前绩效评估基本信息
delete from busfw_t_uieditform where key ='/pmkpi/report/evaluationinfo';
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, HEAD)
values (sys_guid(), '/pmkpi/report/evaluationinfo', 'V_PERF_T_EVALUATION', 'textarea', '评估事项', 'ITEMS', 1, null, 1, null, 1, 3, '3', 'pmkpi', 1, null, '{}', null, null, null, null);
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, HEAD)
values (sys_guid(), '/pmkpi/report/evaluationinfo', 'V_PERF_T_EVALUATION', 'textarea', '评估结果', 'RESULT', 1, null, 1, null, 2, 3, '3', 'pmkpi', 1, null, '{}', null, null, null, null);


--事前绩效评估审核意见页面
delete from busfw_t_uieditform where key ='/pmkpi/audit/index/evaluation';
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, HEAD)
values (sys_guid(), '/pmkpi/audit/index/evaluation', 'PERF_T_AUDITMAIN', 'textarea', null, 'REMARK', 1, null, 0, null, 2, 1, '6', 'pmkpi', 1, null, '{}', 0, 0, 0, null);
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, HEAD)
values (sys_guid(), '/pmkpi/audit/index/evaluation', 'PERF_T_EVALUATION', 'tree', '审核方式', 'AUDITTYPE', 1, null, 1, null, 1, null, null, 'pmkpi', 1, null, '{format:''#name''}', 0, 0, 0, null);

delete from busfw_t_uifunction where key ='/pmkpi/audit/index/evaluation';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/audit/index/evaluation', '保存', 1, 1, 'searchicon', 'auditevaluation.save', null, '保存', 'pmkpi', 'save', null, null);
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/audit/index/evaluation', '审核', 1, 2, 'searchicon', 'auditevaluation.audit', null, '审核', 'pmkpi', 'audit', null, null);
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/audit/index/evaluation', '退回', 1, 3, 'searchicon', 'auditevaluation.back', null, '退回', 'pmkpi', 'back', null, '{remark:false}');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/audit/index/evaluation', '取消', 1, 4, 'searchicon', 'auditevaluation.close', null, '取消', 'pmkpi', 'close', null, null);
