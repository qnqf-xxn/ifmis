begin
  
DELETE FROM P#busfw_t_Uieditform t where t.key='/pmkpi/audit/index/traceopinion';
insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('411B78CE93BB4FF8B80EBA7790D3D1D2', '/pmkpi/audit/index/traceopinion', 'PERF_T_AUDITMAIN', 'textarea', '审核意见', 'REMARK', 1, null, 0, null, 2, 2, '6', 'pmkpi', 1, null, '{}', 0, 0, 0);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('C22E111415EB146FE053B11FA8C0EB32', '/pmkpi/audit/index/traceopinion', 'PERF_T_PROMONITOR', 'tree', '审核方式', 'AUDITTYPE', 1, null, 1, null, 1, null, null, 'pmkpi', 1, null, '{format:''#name''}', 0, 0, 0);


DELETE FROM P#busfw_t_Uifunction t where t.key='/pmkpi/audit/index/traceopinion';
insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('C22EB17C9ADF2914E053B11FA8C0FA19', '/pmkpi/audit/index/traceopinion', '审核', 1, 2, 'searchicon', 'audittraceopinion.audit', null, '审核', 'pmkpi', 'audit', null, null);

insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('C22EB17C9AE02914E053B11FA8C0FA19', '/pmkpi/audit/index/traceopinion', '退回', 1, 3, 'searchicon', 'audittraceopinion.back', null, '退回', 'pmkpi', 'back', null, '{remark:false}');

insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('C22EB17C9AE12914E053B11FA8C0FA19', '/pmkpi/audit/index/traceopinion', '取消', 1, 4, 'searchicon', 'audittraceopinion.close', null, '取消', 'pmkpi', 'close', null, null);

insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('C2357FD83C6856C9E053B11FA8C0CAB0', '/pmkpi/audit/index/traceopinion', '保存', 1, 1, 'searchicon', 'audittraceopinion.save', null, '保存', 'pmkpi', 'save', null, null);



DELETE FROM P#busfw_t_Uitabpage t where t.key='/pmkpi/program/trace/thirdaudit';
insert into busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('C247137BB10C7E9FE053B11FA8C0130A', 'pmkpi', '/pmkpi/program/trace/thirdaudit', '待审核', 'waitaudit', 1, 1, 'choosed', 'protracethirdaudit.clickTabpage', null, '待审核', null, '取消送审,审核信息', '{}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('C247137BB10D7E9FE053B11FA8C0130A', 'pmkpi', '/pmkpi/program/trace/thirdaudit', '已审核', 'alreadyaudit', 1, 2, 'nomal', 'protracethirdaudit.clickTabpage', null, '已审核', null, '成果上传,送审', '{}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('C247137BB10E7E9FE053B11FA8C0130A', 'pmkpi', '/pmkpi/program/trace/thirdaudit', '曾经办', 'alldeals', 1, 3, 'nomal', 'protracethirdaudit.clickTabpage', null, '曾经办', null, '成果上传,送审,取消送审', '{}', null, '0', null, null, null, null, null, null, null);


DELETE FROM P#busfw_t_Uifunction t where t.key='/pmkpi/program/trace/thirdaudit';
insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('C2A75BE2E668D765E053B11FA8C0E2C8', '/pmkpi/program/trace/thirdaudit', '成果上传', 1, 4, 'searchicon', 'protracethirdaudit.uploadresults', null, '成果上传', 'pmkpi', 'uploadresults', null, '{}');

insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('C247137BB10F7E9FE053B11FA8C0130A', '/pmkpi/program/trace/thirdaudit', '送审', 1, 4, 'searchicon', 'protracethirdaudit.wfAudit', null, '送审', 'pmkpi', 'sendaudit', null, '{}');

insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('C247137BB1107E9FE053B11FA8C0130A', '/pmkpi/program/trace/thirdaudit', '取消送审', 1, 5, 'searchicon', 'protracethirdaudit.wfAudit', null, '取消送审', 'pmkpi', 'cancelsendaudit', null, '{}');

insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('C247137BB1117E9FE053B11FA8C0130A', '/pmkpi/program/trace/thirdaudit', '审核情况', 1, 6, 'searchicon', 'protracethirdaudit.queryaudit', null, '审核情况', 'pmkpi', 'queryaudit', null, '{}');



DELETE FROM P#busfw_t_Uitabpage t where t.key='/pmkpi/protrace/thirdaudit/opinion';
insert into busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('C24AB5F1E74C31F4E053B11FA8C059E7', 'pmkpi', '/pmkpi/protrace/thirdaudit/opinion', '审核意见', 'opinioninfo', 1, 1, 'choosed', 'thirdauditopinion.clickTabpage', null, '审核意见', null, null, '{busguid:''8DB78FE7219440ADA2DD4D8B93384D2A'',action:''thirdauditopinion.save''}', null, '0', 'editform', null, null, null, null, null, null);

insert into busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('C24AB5F1E74B31F4E053B11FA8C059E7', 'pmkpi', '/pmkpi/protrace/thirdaudit/opinion', '附件管理', 'file', 1, 2, 'nomal', 'thirdauditopinion.clickTabpage', null, '附件管理', null, '保存', '{url:''/pmkpi/file/index.page''}', null, '0', 'iframemance', null, null, null, null, null, null);

DELETE FROM P#busfw_t_Uieditform t where t.key='/pmkpi/protrace/thirdaudit/opinion';
insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('C24B38D3ED674389E053B11FA8C05DF4', '/pmkpi/protrace/thirdaudit/opinion', 'V_PERF_T_TRACETHIRDAUDIT', 'textarea', '存在问题', 'PROBLEM', 1, null, 0, null, 3, 3, '2', 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('C24B38D3ED684389E053B11FA8C05DF4', '/pmkpi/protrace/thirdaudit/opinion', 'V_PERF_T_TRACETHIRDAUDIT', 's', '业务主键', 'GUID', 0, null, 0, null, 1, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('C24B38D3ED694389E053B11FA8C05DF4', '/pmkpi/protrace/thirdaudit/opinion', 'V_PERF_T_TRACETHIRDAUDIT', 'textarea', '整改措施和建议', 'RECTIFY', 1, null, 0, null, 5, 3, '2', 'pmkpi', 1, null, '{}', null, null, null);


DELETE FROM P#busfw_t_Uifunction t where t.key='/pmkpi/protrace/thirdaudit/opinion';

insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('C256DA8D1D65837BE053B11FA8C0728A', '/pmkpi/protrace/thirdaudit/opinion', '取消', 1, 4, 'searchicon', 'thirdauditopinion.close', null, '取消', 'pmkpi', 'close', null, null);

insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('C256DA8D1D66837BE053B11FA8C0728A', '/pmkpi/protrace/thirdaudit/opinion', '保存', 1, 1, 'searchicon', 'thirdauditopinion.save', null, '保存', 'pmkpi', 'save', null, null);



DELETE FROM P#busfw_t_Uitabpage t where t.key='/pmkpi/program/trace/auditresults';
insert into busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('C2A75BE2E669D765E053B11FA8C0E2C8', 'pmkpi', '/pmkpi/program/trace/auditresults', '待审核', 'waitaudit', 1, 1, 'choosed', 'traceauditresults.clickTabpage', null, '待审核', null, '取消审核', '{}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('C2A75BE2E66AD765E053B11FA8C0E2C8', 'pmkpi', '/pmkpi/program/trace/auditresults', '已审核', 'alreadyaudit', 1, 2, 'nomal', 'traceauditresults.clickTabpage', null, '已审核', null, '审核', '{}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('C2A75BE2E66BD765E053B11FA8C0E2C8', 'pmkpi', '/pmkpi/program/trace/auditresults', '曾经办', 'alldeals', 1, 3, 'nomal', 'traceauditresults.clickTabpage', null, '曾经办', null, '审核,取消审核', '{}', null, '0', null, null, null, null, null, null, null);


DELETE FROM P#busfw_t_Uifunction t where t.key='/pmkpi/program/trace/auditresults';
insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('C2A75BE2E66CD765E053B11FA8C0E2C8', '/pmkpi/program/trace/auditresults', '审核', 1, 4, 'searchicon', 'traceauditresults.audit', null, '审核', 'pmkpi', 'sendaudit', null, '{}');

insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('C2A75BE2E66DD765E053B11FA8C0E2C8', '/pmkpi/program/trace/auditresults', '取消审核', 1, 5, 'searchicon', 'traceauditresults.wfAudit', null, '取消审核', 'pmkpi', 'cancelsendaudit', null, '{}');

insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('C2A75BE2E66ED765E053B11FA8C0E2C8', '/pmkpi/program/trace/auditresults', '审核情况', 1, 6, 'searchicon', 'traceauditresults.queryaudit', null, '审核情况', 'pmkpi', 'queryaudit', null, '{}');

insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('C2A75BE2E671D765E053B11FA8C0E2C8', '/pmkpi/program/trace/auditresults', '成果查看', 1, 6, 'searchicon', 'traceauditresults.viewresults', null, '成果查看', 'pmkpi', 'viewresults', null, '{}');
