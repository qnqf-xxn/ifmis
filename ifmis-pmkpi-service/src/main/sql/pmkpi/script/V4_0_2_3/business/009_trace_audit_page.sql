begin

--年中追加绩效目标申报

delete from p#BUSFW_T_UITABPAGE t where t.key='/pmkpi/midprogram/report/audit';

insert into BUSFW_T_UITABPAGE (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN,  DEFAULTFILTER)
values ('D4D3D3E37913274CE0533315A8C0ACDD', 'pmkpi', '/pmkpi/midprogram/report/audit', '被退回', 'back', 1, 3, 'nomal', 'midprogramaudit.clickTabpage', null, '被退回', null, '取消审核,审核信息', '{}', null, '0', null, null, null, null, null, null, null);

insert into BUSFW_T_UITABPAGE (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D4D3D3E37914274CE0533315A8C0ACDD', 'pmkpi', '/pmkpi/midprogram/report/audit', '待审核', 'waitaudit', 1, 1, 'choosed', 'midprogramaudit.clickTabpage', null, '待审核', null, '取消审核,审核信息', '{}', null, '0', null, null, null, null, null, null, null);

insert into BUSFW_T_UITABPAGE (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D4D3D3E3791A274CE0533315A8C0ACDD', 'pmkpi', '/pmkpi/midprogram/report/audit', '已审核', 'alreadyaudit', 1, 2, 'nomal', 'midprogramaudit.clickTabpage', null, '已审核', null, '审核,批量审核,,批量退回', '{}', null, '0', null, null, null, null, null, null, null);

insert into BUSFW_T_UITABPAGE (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D4D3D3E3791C274CE0533315A8C0ACDD', 'pmkpi', '/pmkpi/midprogram/report/audit', '曾经办', 'alldeals', 1, 4, 'nomal', 'midprogramaudit.clickTabpage', null, '曾经办', null, '审核,取消审核,批量审核,,批量退回', '{}', null, '0', null, null, null, null, null, null,null);

delete from P#BUSFW_T_UIFUNCTION t where t.key ='/pmkpi/midprogram/report/audit' and t.name in('批量审核','批量退回');

insert into BUSFW_T_UIFUNCTION (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('D4D3D3E36691274CE0533315A8C0ACDD', '/pmkpi/midprogram/report/audit', '批量审核', 0, 4, 'searchicon', 'midprogramaudit.wfAudit', null, '批量审核', 'pmkpi', 'auditbatch', null, '{remark:true}');

insert into BUSFW_T_UIFUNCTION (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('D4D5D3E36691274CE0112312A8C0ACDD', '/pmkpi/midprogram/report/audit', '批量退回', 0, 5, 'searchicon', 'midprogramaudit.wfAudit', null, '批量退回', 'pmkpi', 'back', null, '{}');

--绩效监控审核


delete from p#BUSFW_T_UITABPAGE  t where t.key='/pmkpi/program/trace/audit';

insert into BUSFW_T_UITABPAGE (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D4D3D3E379D1274CE0533315A8C0ACDD', 'pmkpi', '/pmkpi/program/trace/audit', '待审核', 'waitaudit', 1, 1, 'choosed', 'protraceaudit.clickTabpage', null, '待审核', null, '取消审核', '{}', null, '0', null, null, null, null, null, null, null);

insert into BUSFW_T_UITABPAGE (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D4D3D3E379D2274CE0533315A8C0ACDD', 'pmkpi', '/pmkpi/program/trace/audit', '已审核', 'alreadyaudit', 1, 2, 'nomal', 'protraceaudit.clickTabpage', null, '已审核', null, '审核,批量审核,批量退回', '{}', null, '0', null, null, null, null, null, null, null);

insert into BUSFW_T_UITABPAGE (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D4D3D3E379D3274CE0533315A8C0ACDD', 'pmkpi', '/pmkpi/program/trace/audit', '曾经办', 'alldeals', 1, 4, 'nomal', 'protraceaudit.clickTabpage', null, '曾经办', null, '审核,取消审核,批量审核,批量退回', '{}', null, '0', null, null, null, null, null, null, null);

insert into BUSFW_T_UITABPAGE (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D4D3D3E379D4274CE0533315A8C0ACDD', 'pmkpi', '/pmkpi/program/trace/audit', '被退回', 'back', 1, 3, 'nomal', 'protraceaudit.clickTabpage', null, '被退回', null, '取消审核', '{}', null, '0', null, null, null, null, null, null, null);


delete from P#BUSFW_T_UIFUNCTION  t where t.key='/pmkpi/program/trace/audit' and t.name in('批量审核','批量退回');

insert into BUSFW_T_UIFUNCTION (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('D4D3D3E3669B274CE0533315A8C0ACDD', '/pmkpi/program/trace/audit', '批量审核', 0, 4, 'searchicon', 'protraceaudit.wfAudit', null, '批量审核', 'pmkpi', 'auditbatch', null, '{remark:true}');

insert into BUSFW_T_UIFUNCTION (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('D4D3D3E9985B274CE0533345A8C0ACDD', '/pmkpi/program/trace/audit', '批量退回', 0, 5, 'searchicon', 'protraceaudit.wfAudit', null, '批量退回', 'pmkpi', 'back', null, '{}');




--项目绩效目标审核 

delete from P#BUSFW_T_UITABPAGE  t where t.key = '/pmkpi/program/report/audit';

insert into BUSFW_T_UITABPAGE (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D4D3D3E379D5274CE0533315A8C0ACDD', 'pmkpi', '/pmkpi/program/report/audit', '被退回', 'back', 1, 3, 'nomal', 'tlprogramaudit.clickTabpage', null, '被退回', null, '取消审核,审核信息', '{}', null, '0', null, null, null, null, null, null, null);

insert into BUSFW_T_UITABPAGE (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D4D3D3E379D6274CE0533315A8C0ACDD', 'pmkpi', '/pmkpi/program/report/audit', '待审核', 'waitaudit', 1, 1, 'choosed', 'tlprogramaudit.clickTabpage', null, '待审核', null, '取消审核,审核信息', '{}', null, '0', null, null, null, null, null, null, null);

insert into BUSFW_T_UITABPAGE (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D4D3D3E379D7274CE0533315A8C0ACDD', 'pmkpi', '/pmkpi/program/report/audit', '已审核', 'alreadyaudit', 1, 2, 'nomal', 'tlprogramaudit.clickTabpage', null, '已审核', null, '审核,批量审核,批量退回', '{}', null, '0', null, null, null, null, null, null, null);

insert into BUSFW_T_UITABPAGE (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D4D3D3E379D8274CE0533315A8C0ACDD', 'pmkpi', '/pmkpi/program/report/audit', '曾经办', 'alldeals', 1, 4, 'nomal', 'tlprogramaudit.clickTabpage', null, '曾经办', null, '审核,取消审核,批量审核,批量退回', '{}', null, '0', null, null, null, null, null, null, null);


delete from P#BUSFW_T_UIFUNCTION t where t.key ='/pmkpi/program/report/audit' and t.name in('批量审核','批量退回');

insert into BUSFW_T_UIFUNCTION (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('D4D3D3E3669C274CE0533315A8C0ACDD', '/pmkpi/program/report/audit', '批量审核', 0, 4, 'searchicon', 'tlprogramaudit.wfAudit', null, '批量审核', 'pmkpi', 'auditbatch', null, '{remark:true}');

insert into BUSFW_T_UIFUNCTION (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('D8D3D3E368F8974CE0533315A5C0ACDD', '/pmkpi/program/report/audit', '批量退回', 0, 5, 'searchicon', 'tlprogramaudit.wfAudit', null, '批量退回', 'pmkpi', 'back', null, null);



--整改通知审核

delete from p#BUSFW_T_UITABPAGE  t where t.key='/pmkpi/rectification/audit/index';

insert into BUSFW_T_UITABPAGE (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D4D3D3E37A19274CE0533315A8C0ACDD', 'pmkpi', '/pmkpi/rectification/audit/index', '待审核', 'waitaudit', 1, 1, 'choosed', 'rectificationaudit.clickTabpage', null, '待审核', null, null, '{}', null, '0', null, null, null, null, null, null, null);

insert into BUSFW_T_UITABPAGE (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D4D3D3E37A1A274CE0533315A8C0ACDD', 'pmkpi', '/pmkpi/rectification/audit/index', '已审核', 'alreadyaudit', 1, 2, 'nomal', 'rectificationaudit.clickTabpage', null, '已审核', 'WFSTATUS <>''011''', '下发,退回,批量退回,批量审核', '{}', null, '0', null, null, null, null, null, null, null);

insert into BUSFW_T_UITABPAGE (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D4D3D3E37A1B274CE0533315A8C0ACDD', 'pmkpi', '/pmkpi/rectification/audit/index', '被退回', 'back', 1, 3, 'nomal', 'rectificationaudit.clickTabpage', null, '被退回', null, '退回,批量审核', '{}', null, '0', null, null, null, null, null, null, null);

insert into BUSFW_T_UITABPAGE (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D4D3D3E37A4D274CE0533315A8C0ACDD', 'pmkpi', '/pmkpi/rectification/audit/index', '曾经办', 'alldeals', 1, 4, 'nomal', 'rectificationaudit.clickTabpage', null, '曾经办', null, '下发,退回,批量退回', '{}', null, '0', null, null, null, null, null, null, null);


delete from P#BUSFW_T_UIFUNCTION  t where t.key='/pmkpi/rectification/audit/index' and t.name in('批量退回','批量审核');

insert into P#BUSFW_T_UIFUNCTION (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('D2D1D3E3882E274CE0533315A8C0ACDD', '/pmkpi/rectification/audit/index', '批量退回', 0, 9, 'addaction', 'rectificationaudit.wfAudit', null, '批量退回', 'pmkpi', 'back', null, null);

insert into BUSFW_T_UIFUNCTION (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('D5D3D3E3882E274CE0433315A5C0ACDD', '/pmkpi/rectification/audit/index', '批量审核', 0, 10, 'addaction', 'rectificationaudit.wfAudit', null, '批量审核', 'pmkpi', 'auditbatch', null, '{remark:true}');


--整改情况审核

delete from p#BUSFW_T_UITABPAGE t where t.key='/pmkpi/rectification/feedback/audit/index';

insert into BUSFW_T_UITABPAGE (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D4D3D3E3795E274CE0533315A8C0ACDD', 'pmkpi', '/pmkpi/rectification/feedback/audit/index', '已审核', 'alreadyaudit', 1, 2, 'nomal', 'feedbackAudit.clickTabpage', null, '已审核', null, '审核,审核信息,批量审核,批量退回', '{}', null, '0', null, null, null, null, null, null, null);

insert into BUSFW_T_UITABPAGE (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D4D3D3E3795F274CE0533315A8C0ACDD', 'pmkpi', '/pmkpi/rectification/feedback/audit/index', '被退回', 'back', 1, 3, 'nomal', 'feedbackAudit.clickTabpage', null, '被退回', null, '取消审核,审核信息', '{}', null, '0', null, null, null, null, null, null, null);

insert into BUSFW_T_UITABPAGE (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D4D3D3E37960274CE0533315A8C0ACDD', 'pmkpi', '/pmkpi/rectification/feedback/audit/index', '曾经办', 'alldeals', 1, 4, 'nomal', 'feedbackAudit.clickTabpage', null, '曾经办', null, '审核,取消审核,审核信息,批量审核,批量退回', '{}', null, '0', null, null, null, null, null, null, null);

insert into BUSFW_T_UITABPAGE (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D4D3D3E37961274CE0533315A8C0ACDD', 'pmkpi', '/pmkpi/rectification/feedback/audit/index', '待审核', 'waitaudit', 1, 1, 'choosed', 'feedbackAudit.clickTabpage', null, '待审核', null, '取消审核,审核信息', '{}', null, '0', null, null, null, null, null, null, null);

delete from P#BUSFW_T_UIFUNCTION t where t.key='/pmkpi/rectification/feedback/audit/index' and t.name in('批量审核','批量退回');

insert into BUSFW_T_UIFUNCTION (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('D4D3D3E36692274CE0533315A8C0ACDD', '/pmkpi/rectification/feedback/audit/index', '批量审核', 0, 7, 'addaction', 'feedbackAudit.wfAudit', null, '批量审核', 'pmkpi', 'auditbatch', null, '{remark:true}');

insert into BUSFW_T_UIFUNCTION (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('D2D3D3E36639274CE0573355A8C0ACDD', '/pmkpi/rectification/feedback/audit/index', '批量退回', 0, 8, 'addaction', 'feedbackAudit.wfAudit', null, '批量退回', 'pmkpi', 'back', null, '{}');



--部门评价项目审核

delete from p#BUSFW_T_UITABPAGE t where t.key='/pmkpi/evaluation/dept/audit';

insert into BUSFW_T_UITABPAGE (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D4D3D3E37920274CE0533315A8C0ACDD', 'pmkpi', '/pmkpi/evaluation/dept/audit', '待审核', 'waitaudit', 1, 1, 'choosed', 'deptaudit.clickTabpage', 0, '待审核', null, '取消审核', '{}', null, '0', null, null, null, null, null, null, null);

insert into BUSFW_T_UITABPAGE (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D4D3D3E37921274CE0533315A8C0ACDD', 'pmkpi', '/pmkpi/evaluation/dept/audit', '已审核', 'alreadyaudit', 1, 2, 'nomal', 'deptaudit.clickTabpage', 0, '已审核', null, '审核,退回,批量审核,批量退回', '{}', null, '0', null, null, null, null, null, null, null);

insert into BUSFW_T_UITABPAGE (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D4D3D3E37922274CE0533315A8C0ACDD', 'pmkpi', '/pmkpi/evaluation/dept/audit', '曾经办', 'allconfirm', 1, 4, 'nomal', 'deptaudit.clickTabpage', 0, '曾经办', null, '审核,取消审核,退回,批量审核,批量退回', '{}', null, '0', null, null, null, null, null, null, null);

insert into BUSFW_T_UITABPAGE (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN,  DEFAULTFILTER)
values ('D4D3D3E37924274CE0533315A8C0ACDD', 'pmkpi', '/pmkpi/evaluation/dept/audit', '被退回', 'back', 1, 3, 'nomal', 'deptaudit.clickTabpage', 0, '被退回', null, '取消审核', '{}', null, '0', null, null, null, null, null, null, null);


delete from P#BUSFW_T_UIFUNCTION  t where t.key='/pmkpi/evaluation/dept/audit' and t.name in('批量审核','批量退回');

insert into BUSFW_T_UIFUNCTION (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('D4D3D3E3668A274CE0533315A8C0ACDD', '/pmkpi/evaluation/dept/audit', '批量审核', 0, 1, 'searchicon', 'deptaudit.wfAudit', null, '批量审核', 'pmkpi', 'auditbatch', null, '{remark:true}');

insert into BUSFW_T_UIFUNCTION (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('D8D3D4E36743274CE0530315A8C0ACDD', '/pmkpi/evaluation/dept/audit', '批量退回', 0, 2, 'searchicon', 'deptaudit.wfAudit', null, '批量退回', 'pmkpi', 'back', null, '{}');




--部门评价成果审核

delete from p#BUSFW_T_UITABPAGE  t where t.key='/pmkpi/evaluation/dept/resultaudit';

insert into BUSFW_T_UITABPAGE (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D4D3D3E378D8274CE0533315A8C0ACDD', 'pmkpi', '/pmkpi/evaluation/dept/resultaudit', '待审核', 'waitaudit', 1, 1, 'choosed', 'deptevaluationresult.clickTabpage', 0, '待审核', null, '取消审核', '{}', null, '0', null, null, null, null, null, null, null);

insert into p#BUSFW_T_UITABPAGE (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW,COMPONENTSERVICEID,COMPONENTCALLBACKFN,
DEFAULTFILTER)
values ('D4D3D3E3791D274CE0533315A8C0ACDD', 'pmkpi', '/pmkpi/evaluation/dept/resultaudit', '已审核', 'alreadyaudit', 1, 2, 'nomal', 'deptevaluationresult.clickTabpage', 0, '已审核', null, '审核,退回,批量审核,批量退回', '{}', null, '0', null, null, null, null, null, null, null);

insert into BUSFW_T_UITABPAGE (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D4D3D3E3791E274CE0533315A8C0ACDD', 'pmkpi', '/pmkpi/evaluation/dept/resultaudit', '曾经办', 'allconfirm', 1, 4, 'nomal', 'deptevaluationresult.clickTabpage', 0, '曾经办', null, '审核,取消审核,退回,批量审核,批量退回', '{}', null, '0', null, null, null, null, null, null, null);

insert into BUSFW_T_UITABPAGE (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D4D3D3E3791F274CE0533315A8C0ACDD', 'pmkpi', '/pmkpi/evaluation/dept/resultaudit', '被退回', 'back', 1, 3, 'nomal', 'deptevaluationresult.clickTabpage', 0, '被退回', null, '取消审核', '{}', null, '0', null, null, null, null, null, null, null);


delete from P#BUSFW_T_UIFUNCTION  t where t.key='/pmkpi/evaluation/dept/resultaudit' and t.name in('批量审核','批量退回');

insert into P#BUSFW_T_UIFUNCTION (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('D4D3D3E36687274CE0533315A8C0ACDD', '/pmkpi/evaluation/dept/resultaudit', '批量审核', 0, 3, 'searchicon', 'deptevaluationresult.wfAudit', null, '批量审核', 'pmkpi', 'auditbatch', null, '{remark:true}');

insert into P#BUSFW_T_UIFUNCTION (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('D2D1D3E36573274CE0513315A8C0ACDD', '/pmkpi/evaluation/dept/resultaudit', '批量退回', 0, 4, 'searchicon', 'deptevaluationresult.wfAudit', null, '批量退回', 'pmkpi', 'back', null, '{}');



--财政评价项目审核


delete from p#BUSFW_T_UITABPAGE t where t.key='/pmkpi/evaluation/financial/audit';

insert into BUSFW_T_UITABPAGE (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D4D3D3E3792B274CE0533315A8C0ACDD', 'pmkpi', '/pmkpi/evaluation/financial/audit', '被退回', 'back', 1, 3, 'nomal', 'finevalaudit.clickTabpage', 0, '被退回', null, '取消审核', '{}', null, '0', null, null, null, null, null, null, null);

insert into BUSFW_T_UITABPAGE (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D4D3D3E3792C274CE0533315A8C0ACDD', 'pmkpi', '/pmkpi/evaluation/financial/audit', '待审核', 'waitaudit', 1, 1, 'choosed', 'finevalaudit.clickTabpage', 0, '待审核', null, '取消审核', '{}', null, '0', null, null, null, null, null, null, null);

insert into BUSFW_T_UITABPAGE (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D4D3D3E3792D274CE0533315A8C0ACDD', 'pmkpi', '/pmkpi/evaluation/financial/audit', '已审核', 'alreadyaudit', 1, 2, 'nomal', 'finevalaudit.clickTabpage', 0, '已审核', null, '审核,指派中介,指派专家,批量审核,批量退回', '{}', null, '0', null, null, null, null, null, null, null);

insert into BUSFW_T_UITABPAGE (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D4D3D3E3792E274CE0533315A8C0ACDD', 'pmkpi', '/pmkpi/evaluation/financial/audit', '曾经办', 'allconfirm', 1, 4, 'nomal', 'finevalaudit.clickTabpage', 0, '曾经办', null, '审核,取消审核,指派中介,指派专家,批量审核,批量退回', '{}', null, '0', null, null, null, null, null, null, null);



delete from P#BUSFW_T_UIFUNCTION t where t.key='/pmkpi/evaluation/financial/audit' and t.name in('批量审核','批量退回');


insert into BUSFW_T_UIFUNCTION (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('D4D3D3E3668C274CE0533315A8C0ACDD', '/pmkpi/evaluation/financial/audit', '批量审核', 0, 11, 'searchicon', 'finevalaudit.wfAudit', null, '批量审核', 'pmkpi', 'auditbatch', null, '{remark:true}');

insert into BUSFW_T_UIFUNCTION (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('D3D2D1E4321C274CE4453345A8C0ACDD', '/pmkpi/evaluation/financial/audit', '批量退回', 0, 12, 'searchicon', 'finevalaudit.wfAudit', null, '批量退回', 'pmkpi', 'back', null, '{}');



--财政评价成果审核

delete from p#BUSFW_T_UITABPAGE t where t.key='/pmkpi/evaluation/financial/resultaudit';

insert into BUSFW_T_UITABPAGE (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D4D3D3E37926274CE0533315A8C0ACDD', 'pmkpi', '/pmkpi/evaluation/financial/resultaudit', '被退回', 'back', 1, 3, 'nomal', 'finevaluationresult.clickTabpage', 0, '被退回', null, '取消审核,下达整改通知', '{}', null, '0', null, null, null, null, null, null, null);

insert into BUSFW_T_UITABPAGE (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D4D3D3E37927274CE0533315A8C0ACDD', 'pmkpi', '/pmkpi/evaluation/financial/resultaudit', '待审核', 'waitaudit', 1, 1, 'choosed', 'finevaluationresult.clickTabpage', 0, '待审核', null, '取消审核,下达整改通知', '{}', null, '0', null, null, null, null, null, null, null);

insert into BUSFW_T_UITABPAGE (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW,COMPONENTSERVICEID,COMPONENTCALLBACKFN,
DEFAULTFILTER)
values ('D4D3D3E37928274CE0533315A8C0ACDD', 'pmkpi', '/pmkpi/evaluation/financial/resultaudit', '已审核', 'alreadyaudit', 1, 2, 'nomal', 'finevaluationresult.clickTabpage', 0, '已审核', null, '审核,评价成果修改,批量审核,批量退回', '{}', null, '0', null, null, null, null, null, null, null);

insert into BUSFW_T_UITABPAGE (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D4D3D3E3792A274CE0533315A8C0ACDD', 'pmkpi', '/pmkpi/evaluation/financial/resultaudit', '曾经办', 'allconfirm', 1, 4, 'nomal', 'finevaluationresult.clickTabpage', 0, '曾经办', null, '审核,取消审核,评价成果修改,下达整改通知,批量审核,批量退回', '{}', null, '0', null, null, null, null, null, null, null);


delete from P#BUSFW_T_UIFUNCTION  t where t.key='/pmkpi/evaluation/financial/resultaudit' and t.name in('批量审核','批量退回');

insert into P#BUSFW_T_UIFUNCTION (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('D4D3D3E3668B274CE0533315A8C0ACDD', '/pmkpi/evaluation/financial/resultaudit', '批量审核', 0, 8, 'searchicon', 'finevaluationresult.wfAudit', null, '批量审核', 'pmkpi', 'auditbatch', null, '{remark:true}');

insert into P#BUSFW_T_UIFUNCTION (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('D2D3D3E36918274CE0533314A1C0ACDD', '/pmkpi/evaluation/financial/resultaudit', '批量退回', 0, 9, 'searchicon', 'finevaluationresult.wfAudit', null, '批量退回', 'pmkpi', 'back', null, '{}');



--省级绩效管理工作考核审核

delete from p#BUSFW_T_UITABPAGE t where t.key='/pmkpi/workevaluate/audit/list';

insert into BUSFW_T_UITABPAGE (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D4D3D3E37946274CE0533315A8C0ACDD', 'pmkpi', '/pmkpi/workevaluate/audit/list', '待审核', 'waitaudit', 1, 1, 'choosed', 'workevalaudit.clickTabpage', 0, '已审核', null, '取消审核', '{}', null, '0', null, null, null, null, null, null, null);

insert into BUSFW_T_UITABPAGE (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D4D3D3E37947274CE0533315A8C0ACDD', 'pmkpi', '/pmkpi/workevaluate/audit/list', '已审核', 'alreadyaudit', 1, 2, 'nomal', 'workevalaudit.clickTabpage', 0, '已审核', null, '审核,批量审核,批量退回', '{}', null, '0', null, null, null, null, null, null, null);

insert into BUSFW_T_UITABPAGE (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D4D3D3E37948274CE0533315A8C0ACDD', 'pmkpi', '/pmkpi/workevaluate/audit/list', '曾经办', 'alldeals', 1, 4, 'nomal', 'workevalaudit.clickTabpage', 0, '曾经办', null, '审核,取消审核,批量审核,批量退回', '{}', null, '0', null, null, null, null, null, null, null);

insert into BUSFW_T_UITABPAGE (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D4D3D3E37949274CE0533315A8C0ACDD', 'pmkpi', '/pmkpi/workevaluate/audit/list', '被退回', 'back', 1, 3, 'nomal', 'workevalaudit.clickTabpage', 0, '被退回', null, '取消审核', '{}', null, '0', null, null, null, null, null, null, null);


delete from P#BUSFW_T_UIFUNCTION t where t.key='/pmkpi/workevaluate/audit/list' and t.name in('批量审核','批量退回');

insert into BUSFW_T_UIFUNCTION (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('D1D2D3E44624274CE0533315A8C0ACDD', '/pmkpi/workevaluate/audit/list', '批量审核', 0, 5, 'searchicon', 'Ext.lt.pmkpi.wfAudit', null, '批量审核', 'pmkpi', 'auditbatch', null, '{remark:true}');

insert into BUSFW_T_UIFUNCTION (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('D2D3D1E56634574CE0533315A8C0ACDD', '/pmkpi/workevaluate/audit/list', '批量退回', 0, 6, 'searchicon', 'Ext.lt.pmkpi.wfAudit', null, '批量退回', 'pmkpi', 'back', null, '{}');


--绩效目标调整审核

delete from p#BUSFW_T_UITABPAGE t where t.key='/pmkpi/adjust/audit';

insert into BUSFW_T_UITABPAGE (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW,COMPONENTSERVICEID,COMPONENTCALLBACKFN,
DEFAULTFILTER)
values ('D4D3D3E379CD274CE0533315A8C0ACDD', 'pmkpi', '/pmkpi/adjust/audit', '被退回', 'back', 1, 3, 'nomal', 'adjustaudit.clickTabpage', 0, '被退回', null, '取消审核', '{}', null, '0', null, null, null, null, null, null, null);

insert into BUSFW_T_UITABPAGE (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D4D3D3E379CE274CE0533315A8C0ACDD', 'pmkpi', '/pmkpi/adjust/audit', '曾经办', 'alldeals', 1, 4, 'nomal', 'adjustaudit.clickTabpage', 0, '曾经办', null, '审核,取消审核,批量审核,批量退回', '{}', null, '0', null, null, null, null, null, null, null);

insert into BUSFW_T_UITABPAGE (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN,  DEFAULTFILTER)
values ('D4D3D3E379CF274CE0533315A8C0ACDD', 'pmkpi', '/pmkpi/adjust/audit', '已审核', 'alreadyaudit', 1, 2, 'nomal', 'adjustaudit.clickTabpage', 0, '已审核', null, '审核,批量审核,批量退回', '{}', null, '0', null, null, null, null, null, null, null);

insert into BUSFW_T_UITABPAGE (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D4D3D3E379D0274CE0533315A8C0ACDD', 'pmkpi', '/pmkpi/adjust/audit', '待审核', 'waitaudit', 1, 1, 'choosed', 'adjustaudit.clickTabpage', 0, '待审核', null, '取消审核', '{}', null, '0', null, null, null, null, null, null, null);


delete from P#BUSFW_T_UIFUNCTION t where t.key='/pmkpi/adjust/audit' and t.name in('批量退回','批量审核');

insert into BUSFW_T_UIFUNCTION (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('D4D3D3E3669A274CE0533315A8C0ACDD', '/pmkpi/adjust/audit', '批量审核', 0, 6, 'searchicon', 'adjustaudit.wfAudit', null, '批量审核', 'pmkpi', 'auditbatch', null, '{remark:true}');

insert into BUSFW_T_UIFUNCTION (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('D7D1D3E26B83274CE0533315A8C0ACDD', '/pmkpi/adjust/audit', '批量退回', 0, 7, 'searchicon', 'adjustaudit.wfAudit', null, '批量退回', 'pmkpi', 'back', null, '{}');



--绩效目标修灯审核

delete  from p#BUSFW_T_UITABPAGE t where t.key='/pmkpi/prorevision/audit';

insert into BUSFW_T_UITABPAGE (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D4D3D3E37979274CE0533315A8C0ACDD', 'pmkpi', '/pmkpi/prorevision/audit', '曾经办', 'alldeals', 1, 4, 'nomal', 'prorevisionaudit.clickTabpage', 0, '曾经办', 'wfstatus in(''011'')', '审核,取消审核,批量审核,批量退回', '{}', null, '0', null, null, null, null, null, null, null);

insert into BUSFW_T_UITABPAGE (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D4D3D3E379CA274CE0533315A8C0ACDD', 'pmkpi', '/pmkpi/prorevision/audit', '已审核', 'alreadyaudit', 1, 2, 'nomal', 'prorevisionaudit.clickTabpage', 0, '已审核', 'wfstatus in(''011'')', '审核,批量审核,批量退回', '{}', null, '0', null, null, null, null, null, null,null);

insert into BUSFW_T_UITABPAGE (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN,  DEFAULTFILTER)
values ('D4D3D3E379CB274CE0533315A8C0ACDD', 'pmkpi', '/pmkpi/prorevision/audit', '待审核', 'waitaudit', 1, 1, 'choosed', 'prorevisionaudit.clickTabpage', 0, '待审核', 'wfstatus in(''008'')', '取消审核', '{}', null, '0', null, null, null, null, null, null, null);

insert into BUSFW_T_UITABPAGE (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D4D3D3E379CC274CE0533315A8C0ACDD', 'pmkpi', '/pmkpi/prorevision/audit', '被退回', 'back', 1, 3, 'nomal', 'prorevisionaudit.clickTabpage', 0, '被退回', null, '取消审核', '{}', null, '0', null, null, null, null, null, null, null);


delete from P#BUSFW_T_UIFUNCTION t where t.key='/pmkpi/prorevision/audit' and t.name in('批量审核','批量退回');

insert into BUSFW_T_UIFUNCTION (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('D4D3D3E36699274CE0533315A8C0ACDD', '/pmkpi/prorevision/audit', '批量审核', 0, 5, 'searchicon', 'prorevisionaudit.wfAudit', null, '批量审核', 'pmkpi', 'auditbatch', null, '{remark:true}');

insert into BUSFW_T_UIFUNCTION (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('D1D3D3E36E07554CE0533315A8C0ACDD', '/pmkpi/prorevision/audit', '批量退回', 0, 6, 'searchicon', 'prorevisionaudit.wfAudit', null, '批量退回', 'pmkpi', 'back', null, '{}');


--部门绩效申报审核


delete from p#BUSFW_T_UITABPAGE t where t.key='/pmkpi/deptperformance/audit/index';

insert into BUSFW_T_UITABPAGE (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D4D3D3E37963274CE0533315A8C0ACDD', 'pmkpi', '/pmkpi/deptperformance/audit/index', '被退回', 'back', 1, 3, 'nomal', 'deptperformanceaudit.clickTabpage', null, '被退回', null, '取消审核,审核信息', '{}', null, '0', null, null, null, null, null, null, null);

insert into BUSFW_T_UITABPAGE (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D4D3D3E37964274CE0533315A8C0ACDD', 'pmkpi', '/pmkpi/deptperformance/audit/index', '曾经办', 'alldeals', 1, 4, 'nomal', 'deptperformanceaudit.clickTabpage', null, '曾经办', null, '审核,取消审核,修改,批量审核,批量退回', '{}', null, '0', null, null, null, null, null, null, null);

insert into BUSFW_T_UITABPAGE (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D4D3D3E37965274CE0533315A8C0ACDD', 'pmkpi', '/pmkpi/deptperformance/audit/index', '已审核', 'alreadyaudit', 1, 2, 'nomal', 'deptperformanceaudit.clickTabpage', null, '已审核', null, '审核,修改,批量审核,批量退回', '{}', null, '0', null, null, null, null, null, null, null);

insert into BUSFW_T_UITABPAGE (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D4D3D3E37978274CE0533315A8C0ACDD', 'pmkpi', '/pmkpi/deptperformance/audit/index', '待审核', 'waitaudit', 1, 1, 'choosed', 'deptperformanceaudit.clickTabpage', null, '待审核', null, '取消审核,审核信息', '{}', null, '0', null, null, null, null, null, null, null);


delete from P#BUSFW_T_UIFUNCTION t where t.key='/pmkpi/deptperformance/audit/index' and t.name in('批量审核','批量退回');

insert into BUSFW_T_UIFUNCTION (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('D4D3D3E36693274CE0533315A8C0ACDD', '/pmkpi/deptperformance/audit/index', '批量审核', 0, 4, 'searchicon', 'deptperformanceaudit.wfAudit', null, '批量审核', 'pmkpi', 'auditbatch', null, '{remark:true}');

insert into BUSFW_T_UIFUNCTION (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('D6D3D3E30093274CE0537315A8C0ACDD', '/pmkpi/deptperformance/audit/index', '批量退回', 0, 5, 'searchicon', 'deptperformanceaudit.wfAudit', null, '批量退回', 'pmkpi', 'back', null, '{}');


--绩效自评审核


delete from P#BUSFW_T_UIFUNCTION t where t.key='/pmkpi/perfself/audit/index' and t.name in('批量审核','批量退回');


insert into BUSFW_T_UIFUNCTION (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('D4D3D3E3668F274CE0533315A8C0ACDD', '/pmkpi/perfself/audit/index', '批量审核', 0, 10, 'searchicon', 'perfselfaudit.wfAudit', null, '批量审核', 'pmkpi', 'auditbatch', null, '{remark:true}');

insert into BUSFW_T_UIFUNCTION (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('D4D3D3E57622825CE0288541A8C0ACDD', '/pmkpi/perfself/audit/index', '批量退回', 0, 11, 'searchicon', 'perfselfaudit.wfAudit', null, '批量退回', 'pmkpi', 'back', null, null);

delete from p#BUSFW_T_UITABPAGE t where t.key='/pmkpi/perfself/audit';

insert into BUSFW_T_UITABPAGE (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D4D3D3E3792F274CE0533315A8C0ACDD', 'pmkpi', '/pmkpi/perfself/audit', '被退回', 'back', 1, 3, 'nomal', 'perfselfaudit.clickTabpage', null, '被退回', null, '取消审核,审核信息', '{}', null, '0', null, null, null, null, null, null, null);

insert into BUSFW_T_UITABPAGE (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D4D3D3E37930274CE0533315A8C0ACDD', 'pmkpi', '/pmkpi/perfself/audit', '已审核', 'alreadyaudit', 1, 2, 'nomal', 'perfselfaudit.clickTabpage', null, '已审核', null, '审核,批量审核,批量退回', '{}', null, '0', null, null, null, null, null, null, null);

insert into BUSFW_T_UITABPAGE (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN,  DEFAULTFILTER)
values ('D4D3D3E37932274CE0533315A8C0ACDD', 'pmkpi', '/pmkpi/perfself/audit', '曾经办', 'alldeals', 1, 4, 'nomal', 'perfselfaudit.clickTabpage', null, '曾经办', null, '审核,取消审核,批量审核,批量退回', '{}', null, '0', null, null, null, null, null, null, null);

insert into BUSFW_T_UITABPAGE (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D4D3D3E37933274CE0533315A8C0ACDD', 'pmkpi', '/pmkpi/perfself/audit', '待审核', 'waitaudit', 1, 1, 'choosed', 'perfselfaudit.clickTabpage', null, '待审核', null, '取消审核,审核信息', '{}', null, '0', null, null, null, null, null, null, null);

