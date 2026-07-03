begin

--绩效工作管理考核填报
delete from p#busfw_t_uifunction t where t.key in('/pmkpi/workevaluate/report/list');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/workevaluate/report/list', '填报/修改', 1, 2, 'searchicon', 'workevalreport.addOredit', null, '填报/修改', 'pmkpi', 'save', null, '{deptworkeval2:''deptkeywork''}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/workevaluate/report/list', '送审', 1, 4, 'searchicon', 'workevalreport.wfAudit', null, '送审', 'pmkpi', 'sendaudit', null, '{remark:true,subprostatus:''008''}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/workevaluate/report/list', '取消送审', 1, 5, 'searchicon', 'workevalreport.wfAudit', null, '取消送审', 'pmkpi', 'cancelsendaudit', null, '{subprostatus:''00''}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/workevaluate/report/list', '审核情况', 1, 6, 'searchicon', 'Ext.lt.pmkpi.auditquery', null, '审核情况', 'pmkpi', 'queryaudit', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/workevaluate/report/list', '查看明细', 1, 7, 'searchicon', 'workevalreport.addOredit', null, '查看明细', 'pmkpi', 'querydetailed', null, '{deptworkeval2:''deptkeywork''}');

delete from p#busfw_t_uitabpage t where t.key in('/pmkpi/workevaluate/report/list');
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values (sys_guid(), 'pmkpi', '/pmkpi/workevaluate/report/list', '待送审', 'waitaudit', 1, 1, 'choosed', 'workevalreport.clickTabpage', null, '待送审', null, '取消送审', '{subprovincefilter:"wfstatus in(''00'')"}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values (sys_guid(), 'pmkpi', '/pmkpi/workevaluate/report/list', '已送审', 'alreadyaudit', 1, 2, 'nomal', 'workevalreport.clickTabpage', null, '已送审', null, '填报/修改,送审', '{subprovincefilter:"wfstatus in(''008'')"}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values (sys_guid(), 'pmkpi', '/pmkpi/workevaluate/report/list', '被退回', 'back', 1, 3, 'nomal', 'workevalreport.clickTabpage', null, '被退回', null, '取消送审', '{subprovincefilter:"wfstatus in(''00'')"}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values (sys_guid(), 'pmkpi', '/pmkpi/workevaluate/report/list', '曾经办', 'alldeals', 1, 4, 'nomal', 'workevalreport.clickTabpage', null, '曾经办', null, '填报/修改,送审,取消送审', '{subprovincefilter:"wfstatus in(''00'',''008'',''011'')"}', null, '0', null, null, null, null, null, null, null);

--审核
delete from p#busfw_t_uifunction t where t.key in('/pmkpi/workevaluate/audit/list');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/workevaluate/audit/list', '审核', 1, 1, 'searchicon', 'workevalaudit.auditOrDetailed', null, '审核', 'pmkpi', 'audit', null, '{"action":"audit",deptworkeval2:''deptkeywork'',subprostatus:''011''}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/workevaluate/audit/list', '退回', 1, 2, 'searchicon', 'Ext.lt.pmkpi.wfAudit', null, '退回', 'pmkpi', 'back', null, '{subprostatus:''00''}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/workevaluate/audit/list', '取消审核', 1, 3, 'searchicon', 'Ext.lt.pmkpi.wfAudit', null, '取消审核', 'pmkpi', 'cancelaudit', null, '{"action":"audit_cancel",subprostatus:''008''}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/workevaluate/audit/list', '审核情况', 1, 4, 'searchicon', 'Ext.lt.pmkpi.auditquery', null, '审核情况', 'pmkpi', 'showwfinfo', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/workevaluate/audit/list', '查看明细', 1, 5, 'searchicon', 'workevalaudit.auditOrDetailed', null, '查看明细', 'pmkpi', 'detailed', null, '{deptworkeval2:''deptkeywork'',subprostatus:''00''}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/workevaluate/audit/list', '批量审核', 0, 6, 'searchicon', 'Ext.lt.pmkpi.wfAudit', null, '批量审核', 'pmkpi', 'auditbatch', null, '{remark:false,subprostatus:''011''}');

delete from p#busfw_t_uitabpage t where t.key in('/pmkpi/workevaluate/audit/list');
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values (sys_guid(), 'pmkpi', '/pmkpi/workevaluate/audit/list', '待审核', 'waitaudit', 1, 1, 'choosed', 'workevalaudit.clickTabpage', 0, '待审核', null, '取消审核', '{subprovincefilter:"wfstatus in(''008'')"}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values (sys_guid(), 'pmkpi', '/pmkpi/workevaluate/audit/list', '已审核', 'alreadyaudit', 1, 2, 'nomal', 'workevalaudit.clickTabpage', 0, '已审核', null, '审核,退回,批量审核', '{subprovincefilter:"wfstatus in(''011'')"}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values (sys_guid(), 'pmkpi', '/pmkpi/workevaluate/audit/list', '被退回', 'back', 1, 3, 'nomal', 'workevalaudit.clickTabpage', 0, '被退回', null, '取消审核,批量退回', '{subprovincefilter:"wfstatus in(''008'')"}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values (sys_guid(), 'pmkpi', '/pmkpi/workevaluate/audit/list', '曾经办', 'alldeals', 1, 4, 'nomal', 'workevalaudit.clickTabpage', 0, '曾经办', null, '审核,取消审核,退回,批量审核', '{subprovincefilter:"wfstatus in(''008'',''011'')"}', null, '0', null, null, null, null, null, null, null);
