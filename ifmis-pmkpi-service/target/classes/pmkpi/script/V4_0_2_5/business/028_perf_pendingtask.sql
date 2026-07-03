begin 
  
delete from perf_pendingtask where key in (
'/pmkpi/program/trace/audit',
'/pmkpi/perfself/audit',
'/pmkpi/evaluation/dept/audit',
'/pmkpi/evaluation/financial/proconfirm',
'/pmkpi/rectification/feedback/index',
'/pmkpi/evaluation/financial/audit',
'/pmkpi/evaluation/financial/resultupload',
'/pmkpi/rectification/audit/index',
'/pmkpi/program/report/list',
'/pmkpi/deptperformance/audit/index',
'/pmkpi/evaluation/dept/resultaudit',
'/pmkpi/evaluation/dept/result',
'/pmkpi/program/report/audit',
'/pmkpi/deptperformance/report/index',
'/pmkpi/perfself/apply',
'/pmkpi/rectification/index',
'/pmkpi/midprogram/report/list',
'/pmkpi/program/trace/report',
'/pmkpi/adjust/report',
'/pmkpi/evaluation/dept/report',
'/pmkpi/rectification/feedback/audit/index',
'/pmkpi/evaluation/financial/resultaudit',
'/pmkpi/adjust/audit',
'/pmkpi/prorevision/report',
'/pmkpi/prorevision/audit',
'/pmkpi/midprogram/report/audit');

insert into PERF_PENDINGTASK (GUID, KEY, NAME, PARAM, STATUS, PROVINCE, YEAR, TABCODE, LEFTTABNUM)
values ('BAD00B0A7C52AE5D03198BD921BB35D7', '/pmkpi/rectification/index', '部门整体整改通知编制--待下达', '{
beanid: "pmkpi.rectification.RectificationBOTX",
bustype: "3",
isleaf: "0",
leftmenuid: "deptrectificationhide",
lefttabtype: "dept",
menuid: "1D057E3C39B46759E053B11FA8C06041",
orderby: null,
queryConfig: undefined,
querySql: "",
saveAgency: "treeroot",
tabcode: "waitaudit",
tabfilter: null,
tablecode: "V_PERF_T_RECTIFY",
tablesql: null,
type: "TRACE",
workflow: "{rectifytrace:''D7F6D15AB0E37ECFE0533315A8C04610'',rectifyperfself:''D7F6D15AB0E17ECFE0533315A8C04610'',rectifyfinancialeval:''D7F6D15AB0E57ECFE0533315A8C04610'',rectifydepteval:''D7F6D15AB0E77ECFE0533315A8C04610''}"
}', 1, '87', 2016, null, '2');

insert into PERF_PENDINGTASK (GUID, KEY, NAME, PARAM, STATUS, PROVINCE, YEAR, TABCODE, LEFTTABNUM)
values ('2BB8524381215ED696302C6EEE0699DD', '/pmkpi/rectification/index', '部门整体整改通知编制--被退回', '{
beanid: "pmkpi.rectification.RectificationBOTX",
bustype: "3",
isleaf: "0",
leftmenuid: "deptrectificationhide",
lefttabtype: "dept",
menuid: "1D057E3C39B46759E053B11FA8C06041",
orderby: null,
queryConfig: undefined,
querySql: "",
saveAgency: "treeroot",
tabcode: "back",
tabfilter: null,
tablecode: "V_PERF_T_RECTIFY",
tablesql: null,
type: "TRACE",
workflow: "{rectifytrace:''D7F6D15AB0E37ECFE0533315A8C04610'',rectifyperfself:''D7F6D15AB0E17ECFE0533315A8C04610'',rectifyfinancialeval:''D7F6D15AB0E57ECFE0533315A8C04610'',rectifydepteval:''D7F6D15AB0E77ECFE0533315A8C04610''}"
}', 1, '87', 2016, 'back', '2');

insert into PERF_PENDINGTASK (GUID, KEY, NAME, PARAM, STATUS, PROVINCE, YEAR, TABCODE, LEFTTABNUM)
values ('31B9C318489EB9A36D101485CCE679F5', '/pmkpi/rectification/audit/index', '项目支出整改通知审核--待审核', '{
beanid: "pmkpi.rectification.RectificationAuditBO",
bustype: "1",
isleaf: "0",
leftmenuid: "programrectiaudithide",
lefttabtype: "program",
menuid: "2D057E3C39B56759E053B11FA8C06042",
orderby: null,
queryConfig: undefined,
querySql: "",
saveAgency: "treeroot",
tabcode: "waitaudit",
tabfilter: null,
tablecode: "V_PERF_T_RECTIFY",
tablesql: null,
type: "TRACE",
workflow: "{rectifytrace:''D7F6D15AB0E27ECFE0533315A8C04610'',rectifyperfself:''D7F6D15AB0E07ECFE0533315A8C04610'',rectifyfinancialeval:''D7F6D15AB0E47ECFE0533315A8C04610'',rectifydepteval:''D7F6D15AB0E67ECFE0533315A8C04610''}"
}', 1, '87', 2016, null, '1');

insert into PERF_PENDINGTASK (GUID, KEY, NAME, PARAM, STATUS, PROVINCE, YEAR, TABCODE, LEFTTABNUM)
values ('EEBAC8BA1376C5392EAB9E724E807C6E', '/pmkpi/rectification/audit/index', '项目支出整改通知审核--被退回', '{
beanid: "pmkpi.rectification.RectificationAuditBO",
bustype: "1",
isleaf: "0",
leftmenuid: "programrectiaudithide",
lefttabtype: "program",
menuid: "2D057E3C39B56759E053B11FA8C06042",
orderby: null,
queryConfig: undefined,
querySql: "",
saveAgency: "treeroot",
tabcode: "back",
tabfilter: null,
tablecode: "V_PERF_T_RECTIFY",
tablesql: null,
type: "TRACE",
workflow: "{rectifytrace:''D7F6D15AB0E27ECFE0533315A8C04610'',rectifyperfself:''D7F6D15AB0E07ECFE0533315A8C04610'',rectifyfinancialeval:''D7F6D15AB0E47ECFE0533315A8C04610'',rectifydepteval:''D7F6D15AB0E67ECFE0533315A8C04610''}"
}', 1, '87', 2016, 'back', '1');

insert into PERF_PENDINGTASK (GUID, KEY, NAME, PARAM, STATUS, PROVINCE, YEAR, TABCODE, LEFTTABNUM)
values ('20C67D63E85B0D8A56E89E46DC29AD13', '/pmkpi/rectification/audit/index', '部门整体整改通知审核--待审核', '{
beanid: "pmkpi.rectification.RectificationAuditBO",
bustype: "3",
isleaf: "0",
leftmenuid: "deptrectiaudithide",
lefttabtype: "dept",
menuid: "2D057E3C39B56759E053B11FA8C06042",
orderby: null,
queryConfig: undefined,
querySql: "",
saveAgency: "treeroot",
tabcode: "waitaudit",
tabfilter: null,
tablecode: "V_PERF_T_RECTIFY",
tablesql: null,
type: "TRACE",
workflow: "{rectifytrace:''D7F6D15AB0E37ECFE0533315A8C04610'',rectifyperfself:''D7F6D15AB0E17ECFE0533315A8C04610'',rectifyfinancialeval:''D7F6D15AB0E57ECFE0533315A8C04610'',rectifydepteval:''D7F6D15AB0E77ECFE0533315A8C04610''}"
}', 1, '87', 2016, null, '2');

insert into PERF_PENDINGTASK (GUID, KEY, NAME, PARAM, STATUS, PROVINCE, YEAR, TABCODE, LEFTTABNUM)
values ('6589770AC4C3746E20CD0318EA95DE98', '/pmkpi/rectification/feedback/index', '部门整体整改情况反馈--被退回', '{
beanid: "pmkpi.rectification.FeedbackIndexBO",
bustype: "3",
isleaf: "0",
leftmenuid: "deptfeedbackhide",
lefttabtype: "dept",
menuid: "3D057E3C39B66759E053B11FA8C06043",
orderby: null,
queryConfig: undefined,
querySql: "",
saveAgency: "treeroot",
tabcode: "back",
tabfilter: null,
tablecode: "V_PERF_T_RECTIFY",
tablesql: null,
type: "TRACE",
workflow: "{rectifytrace:''D7F6D15AB0E37ECFE0533315A8C04610'',rectifyperfself:''D7F6D15AB0E17ECFE0533315A8C04610'',rectifyfinancialeval:''D7F6D15AB0E57ECFE0533315A8C04610'',rectifydepteval:''D7F6D15AB0E77ECFE0533315A8C04610''}"
}', 1, '87', 2016, 'back', '2');

insert into PERF_PENDINGTASK (GUID, KEY, NAME, PARAM, STATUS, PROVINCE, YEAR, TABCODE, LEFTTABNUM)
values ('AE9CD6D881918F0CCAB4A3AD718F82FC', '/pmkpi/rectification/audit/index', '部门整体整改通知审核--被退回', '{
beanid: "pmkpi.rectification.RectificationAuditBO",
bustype: "3",
isleaf: "0",
leftmenuid: "deptrectiaudithide",
lefttabtype: "dept",
menuid: "2D057E3C39B56759E053B11FA8C06042",
orderby: null,
queryConfig: undefined,
querySql: "",
saveAgency: "treeroot",
tabcode: "back",
tabfilter: null,
tablecode: "V_PERF_T_RECTIFY",
tablesql: null,
type: "TRACE",
workflow: "{rectifytrace:''D7F6D15AB0E37ECFE0533315A8C04610'',rectifyperfself:''D7F6D15AB0E17ECFE0533315A8C04610'',rectifyfinancialeval:''D7F6D15AB0E57ECFE0533315A8C04610'',rectifydepteval:''D7F6D15AB0E77ECFE0533315A8C04610''}"
}', 1, '87', 2016, 'back', '2');

insert into PERF_PENDINGTASK (GUID, KEY, NAME, PARAM, STATUS, PROVINCE, YEAR, TABCODE, LEFTTABNUM)
values ('BE02F821F084AA5E7A83B6E2D0DCEE2C', '/pmkpi/rectification/feedback/index', '项目支出整改情况反馈--待送审', '{
beanid: "pmkpi.rectification.FeedbackIndexBO",
bustype: "1",
isleaf: "0",
leftmenuid: "programfeedbackhide",
lefttabtype: "program",
menuid: "3D057E3C39B66759E053B11FA8C06043",
orderby: null,
queryConfig: undefined,
querySql: "",
saveAgency: "treeroot",
tabcode: "waitaudit",
tabfilter: null,
tablecode: "V_PERF_T_RECTIFY",
tablesql: null,
type: "TRACE",
workflow: "{rectifytrace:''D7F6D15AB0E27ECFE0533315A8C04610'',rectifyperfself:''D7F6D15AB0E07ECFE0533315A8C04610'',rectifyfinancialeval:''D7F6D15AB0E47ECFE0533315A8C04610'',rectifydepteval:''D7F6D15AB0E67ECFE0533315A8C04610''}"
}', 1, '87', 2016, null, '1');

insert into PERF_PENDINGTASK (GUID, KEY, NAME, PARAM, STATUS, PROVINCE, YEAR, TABCODE, LEFTTABNUM)
values ('5E946FDB89D0C51A5C5D972284E1CF6F', '/pmkpi/rectification/feedback/index', '项目支出整改情况反馈--被退回', '{
beanid: "pmkpi.rectification.FeedbackIndexBO",
bustype: "1",
isleaf: "0",
leftmenuid: "programfeedbackhide",
lefttabtype: "program",
menuid: "3D057E3C39B66759E053B11FA8C06043",
orderby: null,
queryConfig: undefined,
querySql: "",
saveAgency: "treeroot",
tabcode: "back",
tabfilter: null,
tablecode: "V_PERF_T_RECTIFY",
tablesql: null,
type: "TRACE",
workflow: "{rectifytrace:''D7F6D15AB0E27ECFE0533315A8C04610'',rectifyperfself:''D7F6D15AB0E07ECFE0533315A8C04610'',rectifyfinancialeval:''D7F6D15AB0E47ECFE0533315A8C04610'',rectifydepteval:''D7F6D15AB0E67ECFE0533315A8C04610''}"
}', 1, '87', 2016, 'back', '1');

insert into PERF_PENDINGTASK (GUID, KEY, NAME, PARAM, STATUS, PROVINCE, YEAR, TABCODE, LEFTTABNUM)
values ('C9515EB0269682ADA848F5010A024876', '/pmkpi/rectification/feedback/index', '部门整体整改情况反馈--待送审', '{
beanid: "pmkpi.rectification.FeedbackIndexBO",
bustype: "3",
isleaf: "0",
leftmenuid: "deptfeedbackhide",
lefttabtype: "dept",
menuid: "3D057E3C39B66759E053B11FA8C06043",
orderby: null,
queryConfig: undefined,
querySql: "",
saveAgency: "treeroot",
tabcode: "waitaudit",
tabfilter: null,
tablecode: "V_PERF_T_RECTIFY",
tablesql: null,
type: "TRACE",
workflow: "{rectifytrace:''D7F6D15AB0E37ECFE0533315A8C04610'',rectifyperfself:''D7F6D15AB0E17ECFE0533315A8C04610'',rectifyfinancialeval:''D7F6D15AB0E57ECFE0533315A8C04610'',rectifydepteval:''D7F6D15AB0E77ECFE0533315A8C04610''}"
}', 1, '87', 2016, null, '2');

insert into PERF_PENDINGTASK (GUID, KEY, NAME, PARAM, STATUS, PROVINCE, YEAR, TABCODE, LEFTTABNUM)
values ('65BB5C9138FA7616FC861A8D54323AF7', '/pmkpi/evaluation/financial/proconfirm', '部门整体财政评价确定--被退回', '{
beanid: "pmkpi.financial.proconfirm.ProConfirmBOTX",
isleaf: "0",
leftmenuid: "deptfinconfirmhide",
lefttabtype: "dept",
menuid: "BD2785454409A0C1E053B11FA8C0DCF9",
prolev: undefined,
queryConfig: undefined,
querySql: "",
saveAgency: "treeroot",
tabcode: "back",
tabfilter: null,
workflow: "BD2785454442A0C1E053B11FA8C0DCF9"
}', 1, '87', 2016, 'back', '2');

insert into PERF_PENDINGTASK (GUID, KEY, NAME, PARAM, STATUS, PROVINCE, YEAR, TABCODE, LEFTTABNUM)
values ('AB162AEDCECFF42C4EA6912E0CE53C0D', '/pmkpi/rectification/feedback/audit/index', '项目支出整改情况审核--待审核', '{
beanid: "pmkpi.rectification.FeedbackAuditIndexBO",
bustype: "1",
isleaf: "0",
leftmenuid: "programfeedaudithide",
lefttabtype: "program",
menuid: "4D057E3C39B76759E053B11FA8C06044",
orderby: null,
queryConfig: undefined,
querySql: "",
saveAgency: "treeroot",
tabcode: "waitaudit",
tabfilter: null,
tablecode: "V_PERF_T_RECTIFY",
tablesql: null,
type: "TRACE",
workflow: "{rectifytrace:''D7F6D15AB0E27ECFE0533315A8C04610'',rectifyperfself:''D7F6D15AB0E07ECFE0533315A8C04610'',rectifyfinancialeval:''D7F6D15AB0E47ECFE0533315A8C04610'',rectifydepteval:''D7F6D15AB0E67ECFE0533315A8C04610''}"
}', 1, '87', 2016, null, '1');

insert into PERF_PENDINGTASK (GUID, KEY, NAME, PARAM, STATUS, PROVINCE, YEAR, TABCODE, LEFTTABNUM)
values ('A168FF830984881155E5AFCD0AC7DF33', '/pmkpi/evaluation/financial/proconfirm', '部门整体财政评价确定--待确认', '{
beanid: "pmkpi.financial.proconfirm.ProConfirmBOTX",
isleaf: "0",
leftmenuid: "deptfinconfirmhide",
lefttabtype: "dept",
menuid: "BD2785454409A0C1E053B11FA8C0DCF9",
prolev: undefined,
queryConfig: undefined,
querySql: "",
saveAgency: "treeroot",
tabcode: "waitaudit",
tabfilter: null,
workflow: "BD2785454442A0C1E053B11FA8C0DCF9"
}', 1, '87', 2016, null, '2');

insert into PERF_PENDINGTASK (GUID, KEY, NAME, PARAM, STATUS, PROVINCE, YEAR, TABCODE, LEFTTABNUM)
values ('11E8689D777C8A9AAA53AE18F54FDC79', '/pmkpi/evaluation/financial/audit', '项目支出财政评价审核--待审核', '{
beanid: "pmkpi.evaluation.financial.audit.FinancialAuditBOTX",
isleaf: "0",
leftmenuid: "programfinresultaudithide",
lefttabtype: "program",
menuid: "BD278545440BA0C1E053B11FA8C0DCF9",
prolev: undefined,
queryConfig: undefined,
querySql: "",
saveAgency: "treeroot",
tabcode: "waitaudit",
tabfilter: null,
workflow: "BD2785454440A0C1E053B11FA8C0DCF9"
}', 1, '87', 2016, null, '1');

insert into PERF_PENDINGTASK (GUID, KEY, NAME, PARAM, STATUS, PROVINCE, YEAR, TABCODE, LEFTTABNUM)
values ('B9A19EF6948EDE07364BFD561DBE8898', '/pmkpi/evaluation/financial/audit', '项目支出财政评价审核--被退回', '{
beanid: "pmkpi.evaluation.financial.audit.FinancialAuditBOTX",
isleaf: "0",
leftmenuid: "programfinresultaudithide",
lefttabtype: "program",
menuid: "BD278545440BA0C1E053B11FA8C0DCF9",
prolev: undefined,
queryConfig: undefined,
querySql: "",
saveAgency: "treeroot",
tabcode: "back",
tabfilter: null,
workflow: "BD2785454440A0C1E053B11FA8C0DCF9"
}', 1, '87', 2016, 'back', '1');

insert into PERF_PENDINGTASK (GUID, KEY, NAME, PARAM, STATUS, PROVINCE, YEAR, TABCODE, LEFTTABNUM)
values ('758A7888B39872560D3245F92E94A32C', '/pmkpi/evaluation/financial/audit', '部门整体财政评价审核--待审核', '{
beanid: "pmkpi.evaluation.financial.audit.FinancialAuditBOTX",
isleaf: "0",
leftmenuid: "deptfinresultaudithide",
lefttabtype: "dept",
menuid: "BD278545440BA0C1E053B11FA8C0DCF9",
prolev: undefined,
queryConfig: undefined,
querySql: "",
saveAgency: "treeroot",
tabcode: "waitaudit",
tabfilter: null,
workflow: "BD2785454442A0C1E053B11FA8C0DCF9"
}', 1, '87', 2016, null, '2');

insert into PERF_PENDINGTASK (GUID, KEY, NAME, PARAM, STATUS, PROVINCE, YEAR, TABCODE, LEFTTABNUM)
values ('F2AB6C3489C227891A1A7DDF1E9E8976', '/pmkpi/evaluation/financial/audit', '部门整体财政评价审核--被退回', '{
beanid: "pmkpi.evaluation.financial.audit.FinancialAuditBOTX",
isleaf: "0",
leftmenuid: "deptfinresultaudithide",
lefttabtype: "dept",
menuid: "BD278545440BA0C1E053B11FA8C0DCF9",
prolev: undefined,
queryConfig: undefined,
querySql: "",
saveAgency: "treeroot",
tabcode: "back",
tabfilter: null,
workflow: "BD2785454442A0C1E053B11FA8C0DCF9"
}', 1, '87', 2016, 'back', '2');

insert into PERF_PENDINGTASK (GUID, KEY, NAME, PARAM, STATUS, PROVINCE, YEAR, TABCODE, LEFTTABNUM)
values ('AEA58FE2F4F08BF72026D01E31002857', '/pmkpi/evaluation/financial/resultupload', '项目支出财政评价结果上传--待提交', '{
beanid: "pmkpi.evaluation.financial.ResultBOTX",
finhide: undefined,
isleaf: "0",
leftmenuid: "programfinresultuploadhide",
lefttabtype: "program",
menuid: "BD278545440CA0C1E053B11FA8C0DCF9",
prolev: undefined,
queryConfig: undefined,
querySql: "",
saveAgency: "treeroot",
tabcode: "waitaudit",
tabfilter: null,
wheresql: undefined,
workflow: "BD2785454440A0C1E053B11FA8C0DCF9"
}', 1, '87', 2016, null, '1');

insert into PERF_PENDINGTASK (GUID, KEY, NAME, PARAM, STATUS, PROVINCE, YEAR, TABCODE, LEFTTABNUM)
values ('D598388B22F42C11EB7C0FF0F24CDAC0', '/pmkpi/evaluation/financial/resultupload', '项目支出财政评价结果上传--被退回', '{
beanid: "pmkpi.evaluation.financial.ResultBOTX",
finhide: undefined,
isleaf: "0",
leftmenuid: "programfinresultuploadhide",
lefttabtype: "program",
menuid: "BD278545440CA0C1E053B11FA8C0DCF9",
prolev: undefined,
queryConfig: undefined,
querySql: "",
saveAgency: "treeroot",
tabcode: "back",
tabfilter: null,
wheresql: undefined,
workflow: "BD2785454440A0C1E053B11FA8C0DCF9"
}', 1, '87', 2016, 'back', '1');

insert into PERF_PENDINGTASK (GUID, KEY, NAME, PARAM, STATUS, PROVINCE, YEAR, TABCODE, LEFTTABNUM)
values ('C0803912EC6816E9B453BFD748C3C91C', '/pmkpi/evaluation/financial/resultupload', '部门整体财政评价结果上传--待提交', '{
beanid: "pmkpi.evaluation.financial.ResultBOTX",
finhide: undefined,
isleaf: "0",
leftmenuid: "deptfinresultaudithide",
lefttabtype: "dept",
menuid: "BD278545440CA0C1E053B11FA8C0DCF9",
prolev: undefined,
queryConfig: undefined,
querySql: "",
saveAgency: "treeroot",
tabcode: "waitaudit",
tabfilter: null,
wheresql: undefined,
workflow: "BD2785454442A0C1E053B11FA8C0DCF9"
}', 1, '87', 2016, null, '2');

insert into PERF_PENDINGTASK (GUID, KEY, NAME, PARAM, STATUS, PROVINCE, YEAR, TABCODE, LEFTTABNUM)
values ('8D543B91E629EFD9AEA9000F3E768E98', '/pmkpi/evaluation/financial/resultupload', '部门整体财政评价结果上传--被退回', '{
beanid: "pmkpi.evaluation.financial.ResultBOTX",
finhide: undefined,
isleaf: "0",
leftmenuid: "deptfinresultaudithide",
lefttabtype: "dept",
menuid: "BD278545440CA0C1E053B11FA8C0DCF9",
prolev: undefined,
queryConfig: undefined,
querySql: "",
saveAgency: "treeroot",
tabcode: "back",
tabfilter: null,
wheresql: undefined,
workflow: "BD2785454442A0C1E053B11FA8C0DCF9"
}', 1, '87', 2016, 'back', '2');

insert into PERF_PENDINGTASK (GUID, KEY, NAME, PARAM, STATUS, PROVINCE, YEAR, TABCODE, LEFTTABNUM)
values ('03F18B31E47D4CBA30208FE6FE88F4D7', '/pmkpi/evaluation/financial/resultaudit', '项目支出财政评价成果审核--待审核', '{
beanid: "pmkpi.evaluation.financial.ResultBOTX",
finhide: undefined,
isleaf: "0",
leftmenuid: "programfinresultaudithide",
lefttabtype: "program",
menuid: "BD278545440DA0C1E053B11FA8C0DCF9",
prolev: undefined,
queryConfig: undefined,
querySql: "",
saveAgency: "treeroot",
tabcode: "waitaudit",
tabfilter: null,
wheresql: undefined,
workflow: "BD2785454440A0C1E053B11FA8C0DCF9"
}', 1, '87', 2016, null, '1');

insert into PERF_PENDINGTASK (GUID, KEY, NAME, PARAM, STATUS, PROVINCE, YEAR, TABCODE, LEFTTABNUM)
values ('0925E70C9D075B94F1F8BB2254561B73', '/pmkpi/evaluation/financial/resultaudit', '项目支出财政评价成果审核--被退回', '{
beanid: "pmkpi.evaluation.financial.ResultBOTX",
finhide: undefined,
isleaf: "0",
leftmenuid: "programfinresultaudithide",
lefttabtype: "program",
menuid: "BD278545440DA0C1E053B11FA8C0DCF9",
prolev: undefined,
queryConfig: undefined,
querySql: "",
saveAgency: "treeroot",
tabcode: "back",
tabfilter: null,
wheresql: undefined,
workflow: "BD2785454440A0C1E053B11FA8C0DCF9"
}', 1, '87', 2016, 'back', '1');

insert into PERF_PENDINGTASK (GUID, KEY, NAME, PARAM, STATUS, PROVINCE, YEAR, TABCODE, LEFTTABNUM)
values ('98084B6FEBE548763A7DE8EB552DEAAF', '/pmkpi/evaluation/financial/resultaudit', '部门整体财政评价成果审核--待审核', '{
beanid: "pmkpi.evaluation.financial.ResultBOTX",
finhide: undefined,
isleaf: "0",
leftmenuid: "deptfinresultaudithide",
lefttabtype: "dept",
menuid: "BD278545440DA0C1E053B11FA8C0DCF9",
prolev: undefined,
queryConfig: undefined,
querySql: "",
saveAgency: "treeroot",
tabcode: "waitaudit",
tabfilter: null,
wheresql: undefined,
workflow: "BD2785454442A0C1E053B11FA8C0DCF9"
}', 1, '87', 2016, null, '2');

insert into PERF_PENDINGTASK (GUID, KEY, NAME, PARAM, STATUS, PROVINCE, YEAR, TABCODE, LEFTTABNUM)
values ('0712021CE62E5E200663D1152E3758B7', '/pmkpi/program/report/list', '项目绩效目标填报--被退回', '{
beanid: "pmkpi.perfprogram.TlpProgramBO",
isleaf: "0",
menuid: "pmkpiprogram2020111",
nodeguid: "treeroot",
orderby: "PRO_CODE",
prolev: "3",
queryConfig: undefined,
querySql: "",
tabcode: "back",
tabfilter: null,
tablecode: "V_PERF_PROJECT_INFO",
tablesql: null,
workflow: "3DC76BC9CDA14F510E6D1B92AA561BE0"
}', 1, '87', 2016, 'back', null);

insert into PERF_PENDINGTASK (GUID, KEY, NAME, PARAM, STATUS, PROVINCE, YEAR, TABCODE, LEFTTABNUM)
values ('87841C3E6A5CCF048D1DB8D12DF64CDF', '/pmkpi/rectification/feedback/audit/index', '项目支出整改情况审核-被退回', '{
beanid: "pmkpi.rectification.FeedbackAuditIndexBO",
bustype: "1",
isleaf: "0",
leftmenuid: "programfeedaudithide",
lefttabtype: "program",
menuid: "4D057E3C39B76759E053B11FA8C06044",
orderby: null,
queryConfig: undefined,
querySql: "",
saveAgency: "treeroot",
tabcode: "back",
tabfilter: null,
tablecode: "V_PERF_T_RECTIFY",
tablesql: null,
type: "TRACE",
workflow: "{rectifytrace:''D7F6D15AB0E27ECFE0533315A8C04610'',rectifyperfself:''D7F6D15AB0E07ECFE0533315A8C04610'',rectifyfinancialeval:''D7F6D15AB0E47ECFE0533315A8C04610'',rectifydepteval:''D7F6D15AB0E67ECFE0533315A8C04610''}"
}', 1, '87', 2016, 'back', '1');

insert into PERF_PENDINGTASK (GUID, KEY, NAME, PARAM, STATUS, PROVINCE, YEAR, TABCODE, LEFTTABNUM)
values ('109228A67A068FAB56DC773CDE4F9A38', '/pmkpi/rectification/feedback/audit/index', '部门整体整改情况审核-待审核', '{
beanid: "pmkpi.rectification.FeedbackAuditIndexBO",
bustype: "3",
isleaf: "0",
leftmenuid: "deptfeedaudithide",
lefttabtype: "dept",
menuid: "4D057E3C39B76759E053B11FA8C06044",
orderby: null,
queryConfig: undefined,
querySql: "",
saveAgency: "treeroot",
tabcode: "waitaudit",
tabfilter: null,
tablecode: "V_PERF_T_RECTIFY",
tablesql: null,
type: "TRACE",
workflow: "{rectifytrace:''D7F6D15AB0E37ECFE0533315A8C04610'',rectifyperfself:''D7F6D15AB0E17ECFE0533315A8C04610'',rectifyfinancialeval:''D7F6D15AB0E57ECFE0533315A8C04610'',rectifydepteval:''D7F6D15AB0E77ECFE0533315A8C04610''}"
}', 1, '87', 2016, null, '2');

insert into PERF_PENDINGTASK (GUID, KEY, NAME, PARAM, STATUS, PROVINCE, YEAR, TABCODE, LEFTTABNUM)
values ('93039CBDF7FC1459C6109BC67B1C8CDE', '/pmkpi/rectification/feedback/audit/index', '部门整体整改情况审核--被退回', '{
beanid: "pmkpi.rectification.FeedbackAuditIndexBO",
bustype: "3",
isleaf: "0",
leftmenuid: "deptfeedaudithide",
lefttabtype: "dept",
menuid: "4D057E3C39B76759E053B11FA8C06044",
orderby: null,
queryConfig: undefined,
querySql: "",
saveAgency: "treeroot",
tabcode: "back",
tabfilter: null,
tablecode: "V_PERF_T_RECTIFY",
tablesql: null,
type: "TRACE",
workflow: "{rectifytrace:''D7F6D15AB0E37ECFE0533315A8C04610'',rectifyperfself:''D7F6D15AB0E17ECFE0533315A8C04610'',rectifyfinancialeval:''D7F6D15AB0E57ECFE0533315A8C04610'',rectifydepteval:''D7F6D15AB0E77ECFE0533315A8C04610''}"
}', 1, '87', 2016, 'back', '2');

insert into PERF_PENDINGTASK (GUID, KEY, NAME, PARAM, STATUS, PROVINCE, YEAR, TABCODE, LEFTTABNUM)
values ('36A576F96AB244A06D86E3FE394687BF', '/pmkpi/program/report/list', '项目绩效目标填报--待送审', '{
beanid: "pmkpi.perfprogram.TlpProgramBO",
isleaf: "0",
menuid: "pmkpiprogram2020111",
nodeguid: "treeroot",
orderby: "PRO_CODE",
prolev: "3",
queryConfig: undefined,
querySql: "",
tabcode: "waitaudit",
tabfilter: null,
tablecode: "V_PERF_PROJECT_INFO",
tablesql: null,
workflow: "3DC76BC9CDA14F510E6D1B92AA561BE0"
}', 1, '87', 2016, null, null);

insert into PERF_PENDINGTASK (GUID, KEY, NAME, PARAM, STATUS, PROVINCE, YEAR, TABCODE, LEFTTABNUM)
values ('AD05F5B5A236402F7B661800EB9F2311', '/pmkpi/program/report/audit', '项目绩效目标审核--待审核', '{
agency: "treeroot",
beanid: "pmkpi.perfprogram.TlpProgramAuditBOTX",
isleaf: "0",
menuid: "pmkpiprogram2020113",
orderby: null,
pagetype: "audit",
queryConfig: undefined,
querySql: "",
tabcode: "waitaudit",
tabfilter: null,
tablecode: "V_PERF_PROJECT_INFO",
tablesql: null,
workflow: "3DC76BC9CDA14F510E6D1B92AA561BE0"
}', 1, '87', 2016, null, null);

insert into PERF_PENDINGTASK (GUID, KEY, NAME, PARAM, STATUS, PROVINCE, YEAR, TABCODE, LEFTTABNUM)
values ('F582E72118FEFA6C5D44D6FAA081F2BF', '/pmkpi/program/report/audit', '项目绩效目标审核--被退回', '{
agency: "treeroot",
beanid: "pmkpi.perfprogram.TlpProgramAuditBOTX",
isleaf: "0",
menuid: "pmkpiprogram2020113",
orderby: null,
pagetype: "audit",
queryConfig: undefined,
querySql: "",
tabcode: "back",
tabfilter: null,
tablecode: "V_PERF_PROJECT_INFO",
tablesql: null,
workflow: "3DC76BC9CDA14F510E6D1B92AA561BE0"
}', 1, '87', 2016, 'back', null);

insert into PERF_PENDINGTASK (GUID, KEY, NAME, PARAM, STATUS, PROVINCE, YEAR, TABCODE, LEFTTABNUM)
values ('BBAA9FC8B36E893A5AD778EF9466B73B', '/pmkpi/midprogram/report/list', '年中追加项目年度绩效目标填报--待送审', '{
beanid: "pmkpi.midperfprogram.MidProgramBOTX",
isleaf: "0",
menuid: "BEA7B41C9DC8228EE053B11FA8C08541",
nodeguid: "treeroot",
orderby: null,
prolev: "3",
queryConfig: undefined,
querySql: "",
tabcode: "waitaudit",
tabfilter: null,
tablecode: "V_PERF_T_DEPTPERFMIDDECLARE",
tablesql: null,
workflow: "AB1C3F88E5BA9F021C1D2B249ADBDAA"
}', 1, '87', 2016, null, null);

insert into PERF_PENDINGTASK (GUID, KEY, NAME, PARAM, STATUS, PROVINCE, YEAR, TABCODE, LEFTTABNUM)
values ('515D1866EAA6418D6A405FF0E89F8C5F', '/pmkpi/midprogram/report/list', '年中追加项目年度绩效目标填报--被退回', '{
beanid: "pmkpi.midperfprogram.MidProgramBOTX",
isleaf: "0",
menuid: "BEA7B41C9DC8228EE053B11FA8C08541",
nodeguid: "treeroot",
orderby: null,
prolev: "3",
queryConfig: undefined,
querySql: "",
tabcode: "back",
tabfilter: null,
tablecode: "V_PERF_T_DEPTPERFMIDDECLARE",
tablesql: null,
workflow: "AB1C3F88E5BA9F021C1D2B249ADBDAA"
}', 1, '87', 2016, 'back', null);

insert into PERF_PENDINGTASK (GUID, KEY, NAME, PARAM, STATUS, PROVINCE, YEAR, TABCODE, LEFTTABNUM)
values ('A7DFDEBF3610477431E63DA1D33F1CD2', '/pmkpi/program/trace/report', '项目支出绩效监控填报--待送审', '{
beanid: "pmkpi.perfprotrace.report.ProTraceTaskBOTX",
deptwfststus: "",
isleaf: "0",
jxwfststus: "",
leftmenuid: "protracereporthide",
menuid: "B5A085C812D00888E0535164A8C0487E",
prolev: "3",
queryConfig: undefined,
querySql: "",
saveAgency: "treeroot",
tabcode: "waitaudit",
tabfilter: undefined,
tablecode: "PERF_V_PROMONITOR",
tablesql: null,
tasktype: "protrace",
workflow: "B7279B405D487EB4E0530100007FD738"
}', 1, '87', 2016, null, '1');

insert into PERF_PENDINGTASK (GUID, KEY, NAME, PARAM, STATUS, PROVINCE, YEAR, TABCODE, LEFTTABNUM)
values ('5C1717255E551FA66B53DDBEDC8CFE7B', '/pmkpi/program/trace/report', '项目支出绩效监控填报--被退回', '{
beanid: "pmkpi.perfprotrace.report.ProTraceTaskBOTX",
deptwfststus: "",
isleaf: "0",
jxwfststus: "",
leftmenuid: "protracereporthide",
menuid: "B5A085C812D00888E0535164A8C0487E",
prolev: "3",
queryConfig: undefined,
querySql: "",
saveAgency: "treeroot",
tabcode: "back",
tabfilter: undefined,
tablecode: "PERF_V_PROMONITOR",
tablesql: null,
tasktype: "protrace",
workflow: "B7279B405D487EB4E0530100007FD738"
}', 1, '87', 2016, 'back', '1');

insert into PERF_PENDINGTASK (GUID, KEY, NAME, PARAM, STATUS, PROVINCE, YEAR, TABCODE, LEFTTABNUM)
values ('C29A4320F88D9EFB4E30B57B73EFB81A', '/pmkpi/program/trace/report', '部门整体绩效监控填报--待送审', '{
beanid: "pmkpi.perfprotrace.report.ProTraceTaskBOTX",
deptwfststus: "",
isleaf: "0",
jxwfststus: "",
leftmenuid: "depttracereporthide",
menuid: "B5A085C812D00888E0535164A8C0487E",
prolev: "3",
queryConfig: undefined,
querySql: "",
saveAgency: "treeroot",
tabcode: "waitaudit",
tabfilter: undefined,
tablecode: "PERF_V_PROMONITOR",
tablesql: null,
tasktype: "depttrace",
workflow: "BBC491112EDB3877E053B11FA8C041AA"
}', 1, '87', 2016, null, '2');

insert into PERF_PENDINGTASK (GUID, KEY, NAME, PARAM, STATUS, PROVINCE, YEAR, TABCODE, LEFTTABNUM)
values ('F5796F5880C27461CAD4BD2A292EEB9B', '/pmkpi/program/trace/report', '部门整体绩效监控填报--被退回', '{
beanid: "pmkpi.perfprotrace.report.ProTraceTaskBOTX",
deptwfststus: "",
isleaf: "0",
jxwfststus: "",
leftmenuid: "depttracereporthide",
menuid: "B5A085C812D00888E0535164A8C0487E",
prolev: "3",
queryConfig: undefined,
querySql: "",
saveAgency: "treeroot",
tabcode: "back",
tabfilter: undefined,
tablecode: "PERF_V_PROMONITOR",
tablesql: null,
tasktype: "depttrace",
workflow: "BBC491112EDB3877E053B11FA8C041AA"
}', 1, '87', 2016, 'back', '2');

insert into PERF_PENDINGTASK (GUID, KEY, NAME, PARAM, STATUS, PROVINCE, YEAR, TABCODE, LEFTTABNUM)
values ('4EA93E0FD5114ABE9A022611F0AC3B6B', '/pmkpi/program/trace/audit', '项目支出绩效监控审核--待审核', '{
beanid: "pmkpi.perfprotrace.audit.ProTraceAuditBOTX",
deptwfststus: "",
isleaf: "0",
jxwfststus: "",
leftmenuid: "protraceaudithide",
menuid: "B5A085C812D10888E0535164A8C0487E",
prolev: "3",
queryConfig: undefined,
querySql: "",
saveAgency: "treeroot",
tabcode: "waitaudit",
tabfilter: undefined,
tablecode: "PERF_V_PROMONITOR",
tablesql: null,
tasktype: "protrace",
workflow: "B7279B405D487EB4E0530100007FD738"
}', 1, '87', 2016, null, '1');

insert into PERF_PENDINGTASK (GUID, KEY, NAME, PARAM, STATUS, PROVINCE, YEAR, TABCODE, LEFTTABNUM)
values ('3900D6A673172BE79DE5ACC34F8FAEEA', '/pmkpi/program/trace/audit', '项目支出绩效监控审核--被退回', '{
beanid: "pmkpi.perfprotrace.audit.ProTraceAuditBOTX",
deptwfststus: "",
isleaf: "0",
jxwfststus: "",
leftmenuid: "protraceaudithide",
menuid: "B5A085C812D10888E0535164A8C0487E",
prolev: "3",
queryConfig: undefined,
querySql: "",
saveAgency: "treeroot",
tabcode: "back",
tabfilter: undefined,
tablecode: "PERF_V_PROMONITOR",
tablesql: null,
tasktype: "protrace",
workflow: "B7279B405D487EB4E0530100007FD738"
}', 1, '87', 2016, 'back', '1');

insert into PERF_PENDINGTASK (GUID, KEY, NAME, PARAM, STATUS, PROVINCE, YEAR, TABCODE, LEFTTABNUM)
values ('5C436EE7EF4A248E30C77E17F7A82985', '/pmkpi/program/trace/audit', '部门整体绩效监控审核--待审核', '{
beanid: "pmkpi.perfprotrace.audit.ProTraceAuditBOTX",
deptwfststus: "",
isleaf: "0",
jxwfststus: "",
leftmenuid: "depttraceaudithide",
menuid: "B5A085C812D10888E0535164A8C0487E",
prolev: "3",
queryConfig: undefined,
querySql: "",
saveAgency: "treeroot",
tabcode: "waitaudit",
tabfilter: undefined,
tablecode: "PERF_V_PROMONITOR",
tablesql: null,
tasktype: "depttrace",
workflow: "BBC491112EDB3877E053B11FA8C041AA"
}', 1, '87', 2016, null, '2');

insert into PERF_PENDINGTASK (GUID, KEY, NAME, PARAM, STATUS, PROVINCE, YEAR, TABCODE, LEFTTABNUM)
values ('24C14991A01D7A0E38E50276B878C20D', '/pmkpi/program/trace/audit', '部门整体绩效监控审核--被退回', '{
beanid: "pmkpi.perfprotrace.audit.ProTraceAuditBOTX",
deptwfststus: "",
isleaf: "0",
jxwfststus: "",
leftmenuid: "depttraceaudithide",
menuid: "B5A085C812D10888E0535164A8C0487E",
prolev: "3",
queryConfig: undefined,
querySql: "",
saveAgency: "treeroot",
tabcode: "back",
tabfilter: undefined,
tablecode: "PERF_V_PROMONITOR",
tablesql: null,
tasktype: "depttrace",
workflow: "BBC491112EDB3877E053B11FA8C041AA"
}', 1, '87', 2016, 'back', '2');

insert into PERF_PENDINGTASK (GUID, KEY, NAME, PARAM, STATUS, PROVINCE, YEAR, TABCODE, LEFTTABNUM)
values ('2AB9DEF44FA8AB34F1E1807DD9B3B6B8', '/pmkpi/adjust/report', '项目支出绩效目标调整填报--待送审', '{
beanid: "pmkpi.adjust.report.AdjustReportBOTX",
isleaf: "0",
leftmenuid: "programadjusthide",
lefttabtype: "program",
menuid: "B99067F619D5E2E2E053B11FA8C09FEF",
prolev: undefined,
queryConfig: undefined,
querySql: "",
saveAgency: "treeroot",
tabcode: "waitaudit",
tabfilter: undefined,
tablecode: "V_PERF_T_ADJUST",
tablesql: null,
workflow: "B9A12B5D94761164E053B11FA8C0460E"
}', 1, '87', 2016, null, '1');

insert into PERF_PENDINGTASK (GUID, KEY, NAME, PARAM, STATUS, PROVINCE, YEAR, TABCODE, LEFTTABNUM)
values ('FE53F0B0ECE87BB8697CE17814B62158', '/pmkpi/adjust/report', '项目支出绩效目标调整填报--被退回', '{
beanid: "pmkpi.adjust.report.AdjustReportBOTX",
isleaf: "0",
leftmenuid: "programadjusthide",
lefttabtype: "program",
menuid: "B99067F619D5E2E2E053B11FA8C09FEF",
prolev: undefined,
queryConfig: undefined,
querySql: "",
saveAgency: "treeroot",
tabcode: "back",
tabfilter: undefined,
tablecode: "V_PERF_T_ADJUST",
tablesql: null,
workflow: "B9A12B5D94761164E053B11FA8C0460E"
}', 1, '87', 2016, 'back', '1');

insert into PERF_PENDINGTASK (GUID, KEY, NAME, PARAM, STATUS, PROVINCE, YEAR, TABCODE, LEFTTABNUM)
values ('E63D2C193D8550CD33AB114851F7A4B1', '/pmkpi/adjust/report', '部门整体绩效目标调整填报--待送审', '{
beanid: "pmkpi.adjust.report.AdjustReportBOTX",
isleaf: "0",
leftmenuid: "deptadjusthide",
lefttabtype: "dept",
menuid: "B99067F619D5E2E2E053B11FA8C09FEF",
prolev: undefined,
queryConfig: undefined,
querySql: "",
saveAgency: "treeroot",
tabcode: "waitaudit",
tabfilter: undefined,
tablecode: "V_PERF_T_ADJUST",
tablesql: null,
workflow: "BBC128805C506A0AE053B11FA8C04258"
}', 1, '87', 2016, null, '2');

insert into PERF_PENDINGTASK (GUID, KEY, NAME, PARAM, STATUS, PROVINCE, YEAR, TABCODE, LEFTTABNUM)
values ('FFB5AD35C87754BAA3C0C368707F6F8F', '/pmkpi/adjust/report', '部门整体绩效目标调整填报--被退回', '{
beanid: "pmkpi.adjust.report.AdjustReportBOTX",
isleaf: "0",
leftmenuid: "deptadjusthide",
lefttabtype: "dept",
menuid: "B99067F619D5E2E2E053B11FA8C09FEF",
prolev: undefined,
queryConfig: undefined,
querySql: "",
saveAgency: "treeroot",
tabcode: "back",
tabfilter: undefined,
tablecode: "V_PERF_T_ADJUST",
tablesql: null,
workflow: "BBC128805C506A0AE053B11FA8C04258"
}', 1, '87', 2016, 'back', '2');

insert into PERF_PENDINGTASK (GUID, KEY, NAME, PARAM, STATUS, PROVINCE, YEAR, TABCODE, LEFTTABNUM)
values ('213CCD20ECC7334FC949BDB47AA7561B', '/pmkpi/adjust/audit', '项目支出绩效目标调整审核--待审核', '{
beanid: "pmkpi.adjust.audit.AdjustAuditBOTX",
isleaf: "0",
leftmenuid: "programauditadjusthide",
lefttabtype: "program",
menuid: "B99067F619D6E2E2E053B11FA8C09FEF",
prolev: undefined,
queryConfig: undefined,
querySql: "",
saveAgency: "treeroot",
tabcode: "waitaudit",
tabfilter: "(wfstatus <> ''000'' or wfstatus <> ''01'')",
tabfilter1: "wfstatus <> ''000''",
tablecode: "V_PERF_T_ADJUST",
tablesql: null,
workflow: "B9A12B5D94761164E053B11FA8C0460E"
}', 1, '87', 2016, null, '1');

insert into PERF_PENDINGTASK (GUID, KEY, NAME, PARAM, STATUS, PROVINCE, YEAR, TABCODE, LEFTTABNUM)
values ('72DC886C0E4A0D29C09F389F60007BBA', '/pmkpi/adjust/audit', '项目支出绩效目标调整审核--被退回', '{
beanid: "pmkpi.adjust.audit.AdjustAuditBOTX",
isleaf: "0",
leftmenuid: "programauditadjusthide",
lefttabtype: "program",
menuid: "B99067F619D6E2E2E053B11FA8C09FEF",
prolev: undefined,
queryConfig: undefined,
querySql: "",
saveAgency: "treeroot",
tabcode: "back",
tabfilter: undefined,
tabfilter1: null,
tablecode: "V_PERF_T_ADJUST",
tablesql: null,
workflow: "B9A12B5D94761164E053B11FA8C0460E"
}', 1, '87', 2016, 'back', '1');

insert into PERF_PENDINGTASK (GUID, KEY, NAME, PARAM, STATUS, PROVINCE, YEAR, TABCODE, LEFTTABNUM)
values ('BA01D41B7F369FDF81178D9804035D6B', '/pmkpi/adjust/audit', '部门整体绩效目标调整审核--待审核', '{
beanid: "pmkpi.adjust.audit.AdjustAuditBOTX",
isleaf: "0",
leftmenuid: "deptauditadjusthide",
lefttabtype: "dept",
menuid: "B99067F619D6E2E2E053B11FA8C09FEF",
prolev: undefined,
queryConfig: undefined,
querySql: "",
saveAgency: "treeroot",
tabcode: "waitaudit",
tabfilter: undefined,
tabfilter1: "wfstatus <> ''000''",
tablecode: "V_PERF_T_ADJUST",
tablesql: null,
workflow: "BBC128805C506A0AE053B11FA8C04258"
}', 1, '87', 2016, null, '2');

insert into PERF_PENDINGTASK (GUID, KEY, NAME, PARAM, STATUS, PROVINCE, YEAR, TABCODE, LEFTTABNUM)
values ('DEFFDFEA66AEC9A5B2E5A548B5590D9F', '/pmkpi/adjust/audit', '部门整体绩效目标调整审核--被退回', '{
beanid: "pmkpi.adjust.audit.AdjustAuditBOTX",
isleaf: "0",
leftmenuid: "deptauditadjusthide",
lefttabtype: "dept",
menuid: "B99067F619D6E2E2E053B11FA8C09FEF",
prolev: undefined,
queryConfig: undefined,
querySql: "",
saveAgency: "treeroot",
tabcode: "back",
tabfilter: undefined,
tabfilter1: null,
tablecode: "V_PERF_T_ADJUST",
tablesql: null,
workflow: "BBC128805C506A0AE053B11FA8C04258"
}', 1, '87', 2016, 'back', '2');

insert into PERF_PENDINGTASK (GUID, KEY, NAME, PARAM, STATUS, PROVINCE, YEAR, TABCODE, LEFTTABNUM)
values ('D230D8AF21AD66B43B5D8F971680F3CA', '/pmkpi/evaluation/financial/proconfirm', '项目支出财政评价项目确定--待确认', '{
beanid: "pmkpi.financial.proconfirm.ProConfirmBOTX",
isleaf: "0",
leftmenuid: "programfinconfirmhide",
lefttabtype: "program",
menuid: "BD2785454409A0C1E053B11FA8C0DCF9",
prolev: undefined,
queryConfig: undefined,
querySql: "",
saveAgency: "treeroot",
tabcode: "waitaudit",
tabfilter: null,
workflow: "BD2785454440A0C1E053B11FA8C0DCF9"
}', 1, '87', 2016, null, '1');

insert into PERF_PENDINGTASK (GUID, KEY, NAME, PARAM, STATUS, PROVINCE, YEAR, TABCODE, LEFTTABNUM)
values ('7D3B9B44E85C70F910D41D38664BA46D', '/pmkpi/evaluation/financial/proconfirm', '项目支出财政评价项目确定--被退回', '{
beanid: "pmkpi.financial.proconfirm.ProConfirmBOTX",
isleaf: "0",
leftmenuid: "programfinconfirmhide",
lefttabtype: "program",
menuid: "BD2785454409A0C1E053B11FA8C0DCF9",
prolev: undefined,
queryConfig: undefined,
querySql: "",
saveAgency: "treeroot",
tabcode: "back",
tabfilter: null,
workflow: "BD2785454440A0C1E053B11FA8C0DCF9"
}', 1, '87', 2016, 'back', '1');

insert into PERF_PENDINGTASK (GUID, KEY, NAME, PARAM, STATUS, PROVINCE, YEAR, TABCODE, LEFTTABNUM)
values ('0566B8B6548D7824011C3CD4FDC45607', '/pmkpi/deptperformance/report/index', '部门绩效申报填报--待送审', '{
"isleaf": "0",
"menuid": "E612AE4B4B6546F2BAAEB3E7CF8B9567",
"orderby": "",
"queryConfig": "",
"querySql": "",
"saveAgency": "treeroot",
"tabcode": "waitaudit",
"tabfilter": "",
"tablecode": "V_PERF_T_DEPTPERFDECLARE",
"tablesql": "",
"treesource": "PMKPIDEPT",
"workflow": "D00E439AFACC701EDEE1DBA1EADE225F"
}', 1, '87', 2016, null, null);

insert into PERF_PENDINGTASK (GUID, KEY, NAME, PARAM, STATUS, PROVINCE, YEAR, TABCODE, LEFTTABNUM)
values ('8FE3DC619032AD050C65601D38622CDD', '/pmkpi/deptperformance/report/index', '部门绩效申报填报--被退回', '{
"isleaf": "0",
"menuid": "E612AE4B4B6546F2BAAEB3E7CF8B9567",
"orderby": "",
"queryConfig": "",
"querySql": "",
"saveAgency": "treeroot",
"tabcode": "back",
"tabfilter": "",
"tablecode": "V_PERF_T_DEPTPERFDECLARE",
"tablesql": "",
"treesource": "PMKPIDEPT",
"workflow": "D00E439AFACC701EDEE1DBA1EADE225F"
}', 1, '87', 2016, 'back', null);

insert into PERF_PENDINGTASK (GUID, KEY, NAME, PARAM, STATUS, PROVINCE, YEAR, TABCODE, LEFTTABNUM)
values ('2810A6B90B7B9332FFB8639EC50A536C', '/pmkpi/deptperformance/audit/index', '部门绩效申报审核--待审核', '{
agency: "treeroot",
isleaf: "0",
menuid: "a6973002b22a4a96f373feccc3ce0d7f",
orderby: null,
pagetype: "audit",
queryConfig: undefined,
querySql: "",
tabcode: "waitaudit",
tabfilter: null,
tablecode: "V_PERF_T_DEPTPERFDECLARE",
tablesql: null,
workflow: "D00E439AFACC701EDEE1DBA1EADE225F"
}', 1, '87', 2016, null, null);

insert into PERF_PENDINGTASK (GUID, KEY, NAME, PARAM, STATUS, PROVINCE, YEAR, TABCODE, LEFTTABNUM)
values ('B3A603E3CD102A383B7B94E293AB48D1', '/pmkpi/deptperformance/audit/index', '部门绩效申报审核--被退回', '{
agency: "treeroot",
isleaf: "0",
menuid: "a6973002b22a4a96f373feccc3ce0d7f",
orderby: null,
pagetype: "audit",
queryConfig: undefined,
querySql: "",
tabcode: "back",
tabfilter: null,
tablecode: "V_PERF_T_DEPTPERFDECLARE",
tablesql: null,
workflow: "D00E439AFACC701EDEE1DBA1EADE225F"
}', 1, '87', 2016, 'back', null);

insert into PERF_PENDINGTASK (GUID, KEY, NAME, PARAM, STATUS, PROVINCE, YEAR, TABCODE, LEFTTABNUM)
values ('D5227B7BACB7A6068BEC860B4CE771EF', '/pmkpi/perfself/apply', '项目支出绩效自评填报--未送审', '{
agency: "treeroot",
beanid: "pmkpi.perfSelf.PerfSelfApplyBO",
bustype: "program",
isleaf: "0",
leftmenuid: "programselfapplyhide",
menuid: "1420355654D1411C8C89E90409490D03",
queryConfig: undefined,
querySql: "",
tabcode: "waitaudit",
tabfilter: undefined,
tablecode: "PERF_V_SELFEVALTASK",
tablesql: null,
workflow: "97453626C11A83A453494FB4E08F3C16"
}', 1, '87', 2016, null, '1');

insert into PERF_PENDINGTASK (GUID, KEY, NAME, PARAM, STATUS, PROVINCE, YEAR, TABCODE, LEFTTABNUM)
values ('EDBF5BAD5B365A85B507EB2F760E0ADB', '/pmkpi/perfself/apply', '项目支出绩效自评填报--被退回', '{
agency: "treeroot",
beanid: "pmkpi.perfSelf.PerfSelfApplyBO",
bustype: "program",
isleaf: "0",
leftmenuid: "programselfapplyhide",
menuid: "1420355654D1411C8C89E90409490D03",
queryConfig: undefined,
querySql: "",
tabcode: "back",
tabfilter: undefined,
tablecode: "PERF_V_SELFEVALTASK",
tablesql: null,
workflow: "97453626C11A83A453494FB4E08F3C16"
}', 1, '87', 2016, 'back', '1');

insert into PERF_PENDINGTASK (GUID, KEY, NAME, PARAM, STATUS, PROVINCE, YEAR, TABCODE, LEFTTABNUM)
values ('32E8FDD191BEFEEE31AF699646C6EC5C', '/pmkpi/perfself/apply', '部门整体绩效自评填报--未送审', '{
agency: "treeroot",
beanid: "pmkpi.perfSelf.PerfSelfApplyBO",
bustype: "dept",
isleaf: "0",
leftmenuid: "deptselfapplyhide",
menuid: "1420355654D1411C8C89E90409490D03",
queryConfig: undefined,
querySql: "",
tabcode: "waitaudit",
tabfilter: undefined,
tablecode: "PERF_V_SELFEVALTASK",
tablesql: null,
workflow: "AB1C3F88E5BA9F021C1D2B249ADBDA27"
}', 1, '87', 2016, null, '2');

insert into PERF_PENDINGTASK (GUID, KEY, NAME, PARAM, STATUS, PROVINCE, YEAR, TABCODE, LEFTTABNUM)
values ('4C808390488CA10E46DC515618A3654E', '/pmkpi/perfself/apply', '部门整体绩效自评填报--被退回', '{
agency: "treeroot",
beanid: "pmkpi.perfSelf.PerfSelfApplyBO",
bustype: "dept",
isleaf: "0",
leftmenuid: "deptselfapplyhide",
menuid: "1420355654D1411C8C89E90409490D03",
queryConfig: undefined,
querySql: "",
tabcode: "back",
tabfilter: undefined,
tablecode: "PERF_V_SELFEVALTASK",
tablesql: null,
workflow: "AB1C3F88E5BA9F021C1D2B249ADBDA27"
}', 1, '87', 2016, 'back', '2');

insert into PERF_PENDINGTASK (GUID, KEY, NAME, PARAM, STATUS, PROVINCE, YEAR, TABCODE, LEFTTABNUM)
values ('562B804B77C2897EC35E5136857CB7F5', '/pmkpi/perfself/audit', '项目支出绩效自评审核--待审核', '{
agency: "treeroot",
beanid: "pmkpi.perfSelf.PerfSelfAuditBO",
isleaf: "0",
leftmenuid: "programselfaudithide",
lefttabtype: "program",
menuid: "6A093E24C0724067A7841F036D0A8972",
queryConfig: undefined,
querySql: "",
tabcode: "waitaudit",
tabfilter: undefined,
tablecode: "PERF_V_SELFEVALTASK",
tablesql: null,
workflow: "97453626C11A83A453494FB4E08F3C16"
}', 1, '87', 2016, null, '1');

insert into PERF_PENDINGTASK (GUID, KEY, NAME, PARAM, STATUS, PROVINCE, YEAR, TABCODE, LEFTTABNUM)
values ('D72CBB686E3A7006D315D0990639B116', '/pmkpi/perfself/audit', '项目支出绩效自评审核--被退回', '{
agency: "treeroot",
beanid: "pmkpi.perfSelf.PerfSelfAuditBO",
isleaf: "0",
leftmenuid: "programselfaudithide",
lefttabtype: "program",
menuid: "6A093E24C0724067A7841F036D0A8972",
queryConfig: undefined,
querySql: "",
tabcode: "back",
tabfilter: undefined,
tablecode: "PERF_V_SELFEVALTASK",
tablesql: null,
workflow: "97453626C11A83A453494FB4E08F3C16"
}', 1, '87', 2016, 'back', '1');

insert into PERF_PENDINGTASK (GUID, KEY, NAME, PARAM, STATUS, PROVINCE, YEAR, TABCODE, LEFTTABNUM)
values ('190E0270103EAA2C85C5C32B2E8364F3', '/pmkpi/perfself/audit', '部门整体绩效自评审核--待审核', '{
agency: "treeroot",
beanid: "pmkpi.perfSelf.PerfSelfAuditBO",
isleaf: "0",
leftmenuid: "deptselfaudithide",
lefttabtype: "dept",
menuid: "6A093E24C0724067A7841F036D0A8972",
queryConfig: undefined,
querySql: "",
tabcode: "waitaudit",
tabfilter: undefined,
tablecode: "PERF_V_SELFEVALTASK",
tablesql: null,
workflow: "AB1C3F88E5BA9F021C1D2B249ADBDA27"
}', 1, '87', 2016, null, '2');

insert into PERF_PENDINGTASK (GUID, KEY, NAME, PARAM, STATUS, PROVINCE, YEAR, TABCODE, LEFTTABNUM)
values ('939EBA73487FAD5ACE8233D57632A117', '/pmkpi/perfself/audit', '部门整体绩效自评审核--被退回', '{
agency: "treeroot",
beanid: "pmkpi.perfSelf.PerfSelfAuditBO",
isleaf: "0",
leftmenuid: "deptselfaudithide",
lefttabtype: "dept",
menuid: "6A093E24C0724067A7841F036D0A8972",
queryConfig: undefined,
querySql: "",
tabcode: "back",
tabfilter: undefined,
tablecode: "PERF_V_SELFEVALTASK",
tablesql: null,
workflow: "AB1C3F88E5BA9F021C1D2B249ADBDA27"
}', 1, '87', 2016, 'back', '2');

insert into PERF_PENDINGTASK (GUID, KEY, NAME, PARAM, STATUS, PROVINCE, YEAR, TABCODE, LEFTTABNUM)
values ('E7D4045D8F402425CD647D54B7D26DC6', '/pmkpi/rectification/index', '项目支出整改通知编制--待下达', '{
beanid: "pmkpi.rectification.RectificationBOTX",
bustype: "1",
isleaf: "0",
leftmenuid: "programrectificationhide",
lefttabtype: "program",
menuid: "1D057E3C39B46759E053B11FA8C06041",
orderby: null,
queryConfig: undefined,
querySql: "",
saveAgency: "treeroot",
tabcode: "waitaudit",
tabfilter: null,
tablecode: "V_PERF_T_RECTIFY",
tablesql: null,
type: "TRACE",
workflow: "{rectifytrace:''D7F6D15AB0E27ECFE0533315A8C04610'',rectifyperfself:''D7F6D15AB0E07ECFE0533315A8C04610'',rectifyfinancialeval:''D7F6D15AB0E47ECFE0533315A8C04610'',rectifydepteval:''D7F6D15AB0E67ECFE0533315A8C04610''}"
}', 1, '87', 2016, null, '1');

insert into PERF_PENDINGTASK (GUID, KEY, NAME, PARAM, STATUS, PROVINCE, YEAR, TABCODE, LEFTTABNUM)
values ('EB58022160B2A1230130DA0D196E4FEA', '/pmkpi/rectification/index', '项目支出整改通知编制--被退回', '{
beanid: "pmkpi.rectification.RectificationBOTX",
bustype: "1",
isleaf: "0",
leftmenuid: "programrectificationhide",
lefttabtype: "program",
menuid: "1D057E3C39B46759E053B11FA8C06041",
orderby: null,
queryConfig: undefined,
querySql: "",
saveAgency: "treeroot",
tabcode: "back",
tabfilter: null,
tablecode: "V_PERF_T_RECTIFY",
tablesql: null,
type: "TRACE",
workflow: "{rectifytrace:''D7F6D15AB0E27ECFE0533315A8C04610'',rectifyperfself:''D7F6D15AB0E07ECFE0533315A8C04610'',rectifyfinancialeval:''D7F6D15AB0E47ECFE0533315A8C04610'',rectifydepteval:''D7F6D15AB0E67ECFE0533315A8C04610''}"
}', 1, '87', 2016, 'back', '1');

insert into PERF_PENDINGTASK (GUID, KEY, NAME, PARAM, STATUS, PROVINCE, YEAR, TABCODE, LEFTTABNUM)
values ('F15E8C33698F5B10EA9622E56943CFE2', '/pmkpi/evaluation/financial/resultaudit', '部门整体财政评价成果审核--被退回', '{
beanid: "pmkpi.evaluation.financial.ResultBOTX",
finhide: undefined,
isleaf: "0",
leftmenuid: "deptfinresultaudithide",
lefttabtype: "dept",
menuid: "BD278545440DA0C1E053B11FA8C0DCF9",
prolev: undefined,
queryConfig: undefined,
querySql: "",
saveAgency: "treeroot",
tabcode: "back",
tabfilter: null,
wheresql: undefined,
workflow: "BD2785454442A0C1E053B11FA8C0DCF9"
}', 1, '87', 2016, 'back', '2');

insert into PERF_PENDINGTASK (GUID, KEY, NAME, PARAM, STATUS, PROVINCE, YEAR, TABCODE, LEFTTABNUM)
values ('1535C3FDF4DDB957352893FAC93E4A14', '/pmkpi/evaluation/dept/report', '部门评价项目申报--待确认', '{
beanid: "pmkpi.evaluation.dept.report.DeptReportBOTX",
hidename: "deptevaluationreporthide",
isleaf: "0",
leftmenuid: "programdeptevaluationreporthide",
lefttabtype: "program",
menuid: "BE2FB8A81CED0A3DE053B11FA8C0BF96",
prolev: undefined,
queryConfig: undefined,
querySql: "",
saveAgency: "treeroot",
tabcode: "waitaudit",
tabfilter: null,
workflow: "BE2FB8A81CF30A3DE053B11FA8C0BF96"
}', 1, '87', 2016, null, null);

insert into PERF_PENDINGTASK (GUID, KEY, NAME, PARAM, STATUS, PROVINCE, YEAR, TABCODE, LEFTTABNUM)
values ('3C5F8BE2594E89DC5CB5FC01C60CAE09', '/pmkpi/evaluation/dept/report', '部门评价项目申报--被退回', '{
beanid: "pmkpi.evaluation.dept.report.DeptReportBOTX",
hidename: "deptevaluationreporthide",
isleaf: "0",
leftmenuid: "programdeptevaluationreporthide",
lefttabtype: "program",
menuid: "BE2FB8A81CED0A3DE053B11FA8C0BF96",
prolev: undefined,
queryConfig: undefined,
querySql: "",
saveAgency: "treeroot",
tabcode: "back",
tabfilter: null,
workflow: "BE2FB8A81CF30A3DE053B11FA8C0BF96"
}', 1, '87', 2016, 'back', null);

insert into PERF_PENDINGTASK (GUID, KEY, NAME, PARAM, STATUS, PROVINCE, YEAR, TABCODE, LEFTTABNUM)
values ('6943CFEC352C5EE90FEAE740C0A63BB3', '/pmkpi/evaluation/dept/audit', '部门评价项目审核--待审核', '{
beanid: "pmkpi.evaluation.dept.audit.DeptAuditBOTX",
hidename: "deptevaluationaudithide",
isleaf: "0",
leftmenuid: "programdeptevaluationaudithide",
lefttabtype: "program",
menuid: "BE2FB8A81CEE0A3DE053B11FA8C0BF96",
prolev: undefined,
queryConfig: undefined,
querySql: "",
saveAgency: "treeroot",
tabcode: "waitaudit",
tabfilter: null,
workflow: "BE2FB8A81CF30A3DE053B11FA8C0BF96"
}', 1, '87', 2016, null, null);

insert into PERF_PENDINGTASK (GUID, KEY, NAME, PARAM, STATUS, PROVINCE, YEAR, TABCODE, LEFTTABNUM)
values ('A598D64C6B75695A8FEFAE7B075A55CF', '/pmkpi/evaluation/dept/audit', '部门评价项目审核--被退回', '{
beanid: "pmkpi.evaluation.dept.audit.DeptAuditBOTX",
hidename: "deptevaluationaudithide",
isleaf: "0",
leftmenuid: "programdeptevaluationaudithide",
lefttabtype: "program",
menuid: "BE2FB8A81CEE0A3DE053B11FA8C0BF96",
prolev: undefined,
queryConfig: undefined,
querySql: "",
saveAgency: "treeroot",
tabcode: "back",
tabfilter: null,
workflow: "BE2FB8A81CF30A3DE053B11FA8C0BF96"
}', 1, '87', 2016, 'back', null);

insert into PERF_PENDINGTASK (GUID, KEY, NAME, PARAM, STATUS, PROVINCE, YEAR, TABCODE, LEFTTABNUM)
values ('2DF2B4903E8A9CCFADD85BACC28140FB', '/pmkpi/evaluation/dept/result', '部门评价成果申报--待提交', '{
beanid: "pmkpi.evaluation.dept.DeptResultBOTX",
finhide: "deptevaluationresulthide",
isleaf: "0",
leftmenuid: "programdeptevaluationresulthide",
lefttabtype: "program",
menuid: "BE2FB8A81CEF0A3DE053B11FA8C0BF96",
prolev: undefined,
queryConfig: undefined,
querySql: "",
saveAgency: "treeroot",
tabcode: "waitaudit",
tabfilter: null,
workflow: "BE2FB8A81CF30A3DE053B11FA8C0BF96"
}', 1, '87', 2016, null, null);

insert into PERF_PENDINGTASK (GUID, KEY, NAME, PARAM, STATUS, PROVINCE, YEAR, TABCODE, LEFTTABNUM)
values ('40033B101793822D8B5819DE2772985B', '/pmkpi/evaluation/dept/result', '部门评价成果申报--被退回', '{
beanid: "pmkpi.evaluation.dept.DeptResultBOTX",
finhide: "deptevaluationresulthide",
isleaf: "0",
leftmenuid: "programdeptevaluationresulthide",
lefttabtype: "program",
menuid: "BE2FB8A81CEF0A3DE053B11FA8C0BF96",
prolev: undefined,
queryConfig: undefined,
querySql: "",
saveAgency: "treeroot",
tabcode: "back",
tabfilter: null,
workflow: "BE2FB8A81CF30A3DE053B11FA8C0BF96"
}', 1, '87', 2016, 'back', null);

insert into PERF_PENDINGTASK (GUID, KEY, NAME, PARAM, STATUS, PROVINCE, YEAR, TABCODE, LEFTTABNUM)
values ('F62B96BAFB095BC30699DCD105461420', '/pmkpi/evaluation/dept/resultaudit', '部门评价成果审核--待审核', '{
beanid: "pmkpi.evaluation.dept.DeptResultBOTX",
finhide: "deptevaluaresultaudithide",
isleaf: "0",
leftmenuid: "programdeptevaluaresultaudithide",
lefttabtype: "program",
menuid: "BE2FB8A81CF00A3DE053B11FA8C0BF96",
prolev: undefined,
queryConfig: undefined,
querySql: "",
saveAgency: "treeroot",
tabcode: "waitaudit",
tabfilter: null,
workflow: "BE2FB8A81CF30A3DE053B11FA8C0BF96"
}', 1, '87', 2016, null, null);

insert into PERF_PENDINGTASK (GUID, KEY, NAME, PARAM, STATUS, PROVINCE, YEAR, TABCODE, LEFTTABNUM)
values ('8D39853D12766194C95244737E2A4AD3', '/pmkpi/evaluation/dept/resultaudit', '部门评价成果审核--被退回', '{
beanid: "pmkpi.evaluation.dept.DeptResultBOTX",
finhide: "deptevaluaresultaudithide",
isleaf: "0",
leftmenuid: "programdeptevaluaresultaudithide",
lefttabtype: "program",
menuid: "BE2FB8A81CF00A3DE053B11FA8C0BF96",
prolev: undefined,
queryConfig: undefined,
querySql: "",
saveAgency: "treeroot",
tabcode: "back",
tabfilter: null,
workflow: "BE2FB8A81CF30A3DE053B11FA8C0BF96"
}', 1, '87', 2016, 'back', null);

insert into PERF_PENDINGTASK (GUID, KEY, NAME, PARAM, STATUS, PROVINCE, YEAR, TABCODE, LEFTTABNUM)
values ('6548A4FFB3C05CE2BD8E664998897B25', '/pmkpi/midprogram/report/audit', '年中追加项目年度绩效目标审核--被退回', '{
agency: "treeroot",
isleaf: "0",
menuid: "BEA7B41O9DC8228EE053B11FA8C08541",
orderby: null,
pagetype: "audit",
queryConfig: undefined,
querySql: "",
tabcode: "back",
tabfilter: null,
tablecode: "V_PERF_T_DEPTPERFMIDDECLARE",
tablesql: null,
workflow: "AB1C3F88E5BA9F021C1D2B249ADBDAA"
}', 1, '87', 2016, 'back', null);

insert into PERF_PENDINGTASK (GUID, KEY, NAME, PARAM, STATUS, PROVINCE, YEAR, TABCODE, LEFTTABNUM)
values ('AFAF866A0431988C84D0F573703ECA25', '/pmkpi/midprogram/report/audit', '年中追加项目年度绩效目标审核--待审核', '{
agency: "treeroot",
isleaf: "0",
menuid: "BEA7B41O9DC8228EE053B11FA8C08541",
orderby: null,
pagetype: "audit",
queryConfig: undefined,
querySql: "",
tabcode: "waitaudit",
tabfilter: null,
tablecode: "V_PERF_T_DEPTPERFMIDDECLARE",
tablesql: null,
workflow: "AB1C3F88E5BA9F021C1D2B249ADBDAA"
}', 1, '87', 2016, null, null);

insert into PERF_PENDINGTASK (GUID, KEY, NAME, PARAM, STATUS, PROVINCE, YEAR, TABCODE, LEFTTABNUM)
values ('3EFBA57A9B2E74897FE818F2B3CE6DB6', '/pmkpi/prorevision/audit', '绩效目标修订审核--被退回', '{
beanid: "pmkpi.prorevision.RevisionAuditBOTX",
isleaf: "0",
leftmenuid: "programauditrevisionhide",
lefttabtype: "program",
menuid: "BEP7B41O9DC8228EE053B11FA8C08541",
prolev: undefined,
queryConfig: undefined,
querySql: "",
saveAgency: "treeroot",
tabcode: "back",
tabfilter: null,
tablecode: "V_PERF_T_PROVISIONDECLARE",
tablesql: null,
workflow: "PPA12B5D94761164E053B11FA8C0460E"
}', 1, '87', 2016, 'back', null);

insert into PERF_PENDINGTASK (GUID, KEY, NAME, PARAM, STATUS, PROVINCE, YEAR, TABCODE, LEFTTABNUM)
values ('3CB782C1DBC50F09F884D129DE178B4F', '/pmkpi/prorevision/audit', '绩效目标修订审核--待审核', '{
beanid: "pmkpi.prorevision.RevisionAuditBOTX",
isleaf: "0",
leftmenuid: "programauditrevisionhide",
lefttabtype: "program",
menuid: "BEP7B41O9DC8228EE053B11FA8C08541",
prolev: undefined,
queryConfig: undefined,
querySql: "",
saveAgency: "treeroot",
tabcode: "waitaudit",
tabfilter: null,
tablecode: "V_PERF_T_PROVISIONDECLARE",
tablesql: null,
workflow: "PPA12B5D94761164E053B11FA8C0460E"
}', 1, '87', 2016, null, null);

insert into PERF_PENDINGTASK (GUID, KEY, NAME, PARAM, STATUS, PROVINCE, YEAR, TABCODE, LEFTTABNUM)
values ('595020B3B6D13417338A5CE49D9BA7AC', '/pmkpi/prorevision/report', '绩效目标修订填报--被退回', '{
beanid: "pmkpi.prorevision.RevisionReportBOTX",
isleaf: "0",
leftmenuid: "programrevisionhide",
lefttabtype: "program",
menuid: "BEP7B41C9DC8228EE053B11FA8C08541",
prolev: undefined,
queryConfig: undefined,
querySql: "",
saveAgency: "treeroot",
tabcode: "back",
tabfilter: null,
tablecode: "V_PERF_T_PROVISIONDECLARE",
tablesql: null,
workflow: "PPA12B5D94761164E053B11FA8C0460E"
}', 1, '87', 2016, 'back', null);

insert into PERF_PENDINGTASK (GUID, KEY, NAME, PARAM, STATUS, PROVINCE, YEAR, TABCODE, LEFTTABNUM)
values ('A8962F6F8FB86B178F27EADBF2A5C1AD', '/pmkpi/prorevision/report', '绩效目标修订填报--未送审', '{
beanid: "pmkpi.prorevision.RevisionReportBOTX",
isleaf: "0",
leftmenuid: "programrevisionhide",
lefttabtype: "program",
menuid: "BEP7B41C9DC8228EE053B11FA8C08541",
prolev: undefined,
queryConfig: undefined,
querySql: "",
saveAgency: "treeroot",
tabcode: "waitaudit",
tabfilter: null,
tablecode: "V_PERF_T_PROVISIONDECLARE",
tablesql: null,
workflow: "PPA12B5D94761164E053B11FA8C0460E"
}', 1, '87', 2016, null, null);
