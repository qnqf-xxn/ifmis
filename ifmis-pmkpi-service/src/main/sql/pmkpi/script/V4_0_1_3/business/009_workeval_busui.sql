begin

delete from p#busfw_t_uifunction t where key in('/pmkpi/workevaluate/audit/list');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('C37063D848195B21E053B11FA8C06DFA', '/pmkpi/workevaluate/audit/list', '审核', 1, 1, 'searchicon', 'workevalaudit.auditOrDetailed', null, '审核', 'pmkpi', 'audit', null, '{"action":"audit",deptworkeval2:''deptkeywork''}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('C43A16A37C0A18EFE053B11FA8C0DE0F', '/pmkpi/workevaluate/audit/list', '退回', 1, 2, 'searchicon', 'Ext.lt.pmkpi.wfAudit', null, '退回', 'pmkpi', 'back', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('C37063D8481A5B21E053B11FA8C06DFA', '/pmkpi/workevaluate/audit/list', '取消审核', 1, 3, 'searchicon', 'Ext.lt.pmkpi.wfAudit', null, '取消审核', 'pmkpi', 'cancelaudit', null, '{"action":"audit_cancel"}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('C37063D8481B5B21E053B11FA8C06DFA', '/pmkpi/workevaluate/audit/list', '审核情况', 1, 4, 'searchicon', 'Ext.lt.pmkpi.auditquery', null, '审核情况', 'pmkpi', 'showwfinfo', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('C37063D8481C5B21E053B11FA8C06DFA', '/pmkpi/workevaluate/audit/list', '查看明细', 1, 5, 'searchicon', 'workevalaudit.auditOrDetailed', null, '查看明细', 'pmkpi', 'detailed', null, '{deptworkeval2:''deptkeywork''}');

delete from p#busfw_t_uitabpage t where key in('/pmkpi/workevaluate/audit/list');
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('C37063D848185B21E053B11FA8C06DFA', 'pmkpi', '/pmkpi/workevaluate/audit/list', '审核', 'waitaudit', 1, 1, 'choosed', 'workevalaudit.clickTabpage', 0, '审核', null, '取消审核', '{}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('C37063D848175B21E053B11FA8C06DFA', 'pmkpi', '/pmkpi/workevaluate/audit/list', '已审核', 'alreadyaudit', 1, 2, 'nomal', 'workevalaudit.clickTabpage', 0, '已审核', null, '审核,退回', '{}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('C37063D848165B21E053B11FA8C06DFA', 'pmkpi', '/pmkpi/workevaluate/audit/list', '曾经办', 'alldeals', 1, 3, 'nomal', 'workevalaudit.clickTabpage', 0, '曾经办', null, '审核,取消审核,退回', '{}', null, '0', null, null, null, null, null, null, null);
