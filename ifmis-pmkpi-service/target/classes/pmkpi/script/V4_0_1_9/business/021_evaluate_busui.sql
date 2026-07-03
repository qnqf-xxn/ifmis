begin

DELETE FROM p#busfw_t_Uitabpage t where t.key='/pmkpi/workevaluate/assign/agencylist';
insert into busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('C3251C3805DED98BE053B11FA8C01094', 'pmkpi', '/pmkpi/workevaluate/assign/agencylist', '待下达单位', 'wait', 1, 1, 'choosed', 'pmkpitaskassign.clickTabpage', null, '待下达单位', ' t.levelno = ''1'' and LENGTH(t.code) = 3', '取消下达', '{tablecode:''PMKPI_FASP_T_PUBAGENCY''}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('C3251C3805DDD98BE053B11FA8C01094', 'pmkpi', '/pmkpi/workevaluate/assign/agencylist', '已下达单位', 'already', 1, 2, 'nomal', 'pmkpitaskassign.clickTabpage', null, '已下达单位', null, '下达', '{tablecode:''V_PERF_T_WORKTASKASSIGN''}', null, '0', null, null, null, null, null, null, null);

delete from p#busfw_t_uifunction t where t.key in('/pmkpi/workevaluate/report/list');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('A03E6F987C1D404FBDF88F6468818F23', '/pmkpi/workevaluate/report/list', '填报/修改', 1, 2, 'searchicon', 'workevalreport.addOredit', null, '填报/修改', 'pmkpi', 'save', null, '{deptworkeval2:''deptkeywork''}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('3102DB9EBF8CB5D8A86B7FA3248B7F3F', '/pmkpi/workevaluate/report/list', '送审', 1, 4, 'searchicon', 'workevalreport.wfAudit', null, '送审', 'pmkpi', 'sendaudit', null, '{subprostatus:''008''}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('586816E91ECE7E14FF6D27F4CD1EFF46', '/pmkpi/workevaluate/report/list', '取消送审', 1, 5, 'searchicon', 'workevalreport.wfAudit', null, '取消送审', 'pmkpi', 'cancelsendaudit', null, '{subprostatus:''00''}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('25DACAAB9CB8692334C7DEDDEDE70A44', '/pmkpi/workevaluate/report/list', '审核情况', 1, 6, 'searchicon', 'Ext.lt.pmkpi.auditquery', null, '审核情况', 'pmkpi', 'queryaudit', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('856178FF1BF085B75087580B8401EA5C', '/pmkpi/workevaluate/report/list', '查看明细', 1, 7, 'searchicon', 'workevalreport.addOredit', null, '查看明细', 'pmkpi', 'querydetailed', null, '{deptworkeval2:''deptkeywork''}');
