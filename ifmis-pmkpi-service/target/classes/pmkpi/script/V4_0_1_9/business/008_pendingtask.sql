begin
delete from perf_pendingtask t where guid in('123456900AF1DAE3B707805D73F88E08','123456789AF1DAE3B707805D73F88E08',
'111156789AF1DAE3B707805D73F88E08','222256789AF1DAE3B707805D73F88E08','223456789AF1DAE3B707805D73F88E08','333456789AF1DAE3B707805D73F88E08',
'443456789AF1DAE3B707805D73F88E08','553456789AF1DAE3B707805D73F88E08','663456789AF1DAE3B707805D73F88E08','113456789AF1DAE3B707805D73F88E08');

insert into perf_pendingtask (GUID, KEY, NAME, PARAM, STATUS, PROVINCE, YEAR)
values ('111156789AF1DAE3B707805D73F88E08', '/pmkpi/program/trace/report', '绩效运行监控填报（部门）', '{
"beanid": "pmkpi.perfprotrace.report.ProTraceTaskBOTX",
"isleaf": "0",
"menuid": "B5A085C812D00888E0535164A8C0487E",
"prolev": "3",
"saveAgency": "treeroot",
"tabcode": "waitaudit",
"tablecode": "PERF_V_PROMONITOR",
"tasktype": "depttrace",
"workflow": "BBC491112EDB3877E053B11FA8C041AA"
}', 1, '340000000', 2021);

insert into perf_pendingtask (GUID, KEY, NAME, PARAM, STATUS, PROVINCE, YEAR)
values ('113456789AF1DAE3B707805D73F88E08', '/pmkpi/program/trace/report', '绩效运行监控填报（项目）', '{
"beanid":"pmkpi.perfprotrace.report.ProTraceTaskBOTX",
"isleaf":"0",
"meunid":"B5A085C812D00888E0535164A8C0487E",
"prolev":"3",
"saveAgency": "treeroot",
"tabcode": "waitaudit",
"tablecode": "PERF_V_PROMONITOR",
"tasktype": "protrace",
"workflow": "B7279B405D487EB4E0530100007FD738"
}', 1, '340000000', 2021);

insert into perf_pendingtask (GUID, KEY, NAME, PARAM, STATUS, PROVINCE, YEAR)
values ('123456789AF1DAE3B707805D73F88E08', '/pmkpi/program/report/list', '项目绩效目标填报', '{
"agency":"treeroot",
"workflow":"3DC76BC9CDA14F510E6D1B92AA561BE0",
"isleaf":"0",
"menuid":"pmkpiprogram2020113",
"pagetype":"audit",
"tabcode":"waitaudit",
"tablecode":"V_PERF_PROJECT_INFO"
}', 1, '340000000', 2021);

insert into perf_pendingtask (GUID, KEY, NAME, PARAM, STATUS, PROVINCE, YEAR)
values ('123456900AF1DAE3B707805D73F88E08', '/pmkpi/program/report/audit', '项目绩效目标审核', '{
"agency":"treeroot",
"workflow":"3DC76BC9CDA14F510E6D1B92AA561BE0",
"isleaf":"0",
"menuid":"pmkpiprogram2020113",
"pagetype":"audit",
"tabcode":"waitaudit",
"tablecode":"V_PERF_PROJECT_INFO"
}', 1, '340000000', 2021);

insert into perf_pendingtask (GUID, KEY, NAME, PARAM, STATUS, PROVINCE, YEAR)
values ('222256789AF1DAE3B707805D73F88E08', '/pmkpi/program/trace/audit', '绩效运行监控审核(部门)', '{
"beanid": "pmkpi.perfprotrace.audit.ProTraceAuditBOTX",
"isleaf": "0",
"menuid": "B5A085C812D10888E0535164A8C0487E",
"prolev": "3",
"saveAgency": "treeroot",
"tabcode": "waitaudit",
"tablecode": "PERF_V_PROMONITOR",
"tasktype": "depttrace",
"workflow": "BBC491112EDB3877E053B11FA8C041AA"
}', 1, '340000000', 2021);

insert into perf_pendingtask (GUID, KEY, NAME, PARAM, STATUS, PROVINCE, YEAR)
values ('223456789AF1DAE3B707805D73F88E08', '/pmkpi/program/trace/audit', '绩效运行监控审核(项目)', '{
"beanid": "pmkpi.perfprotrace.audit.ProTraceAuditBOTX",
"isleaf": "0",
"menuid": "B5A085C812D10888E0535164A8C0487E",
"prolev": "3",
"saveAgency": "treeroot",
"tabcode": "waitaudit",
"tablecode": "PERF_V_PROMONITOR",
"tasktype": "protrace",
"workflow": "B7279B405D487EB4E0530100007FD738"
}', 1, '340000000', 2021);

insert into perf_pendingtask (GUID, KEY, NAME, PARAM, STATUS, PROVINCE, YEAR)
values ('333456789AF1DAE3B707805D73F88E08', '/pmkpi/perfself/apply', '绩效自评填报(项目)', '{
"agency": "treeroot",
"beanid": "pmkpi.perfSelf.PerfSelfApplyBO",
"bustype": "1",
"isleaf": "0",
"lefttabtype": "program",
"menuid": "1420355654D1411C8C89E90409490D03",
"pagetype": "report",
"tabcode": "waitaudit",
"tablecode": "V_PERF_V_SELFEVALTASK",
"workflow": "97453626C11A83A453494FB4E08F3C16"
}', 1, '340000000', 2021);

insert into perf_pendingtask (GUID, KEY, NAME, PARAM, STATUS, PROVINCE, YEAR)
values ('443456789AF1DAE3B707805D73F88E08', '/pmkpi/perfself/audit', '绩效自评审核(项目)', '{
"agency": "treeroot",
"beanid": "pmkpi.perfSelf.PerfSelfAuditBO",
"bustype": "1",
"isleaf": "0",
"lefttabtype": "program",
"menuid": "6A093E24C0724067A7841F036D0A8972",
"pagetype": "audit",
"tabcode": "waitaudit",
"tablecode": "V_PERF_T_SELFEVALTASK",
"viewtabcode": "V_PERF_V_SELFEVALTASK",
"workflow": "97453626C11A83A453494FB4E08F3C16"
}', 1, '340000000', 2021);

insert into perf_pendingtask (GUID, KEY, NAME, PARAM, STATUS, PROVINCE, YEAR)
values ('553456789AF1DAE3B707805D73F88E08', '/pmkpi/perfself/apply', '绩效自评填报(部门)', '{
"agency": "treeroot",
"beanid": "pmkpi.perfSelf.PerfSelfApplyBO",
"bustype": "3",
"isleaf": "0",
"lefttabtype": "dept",
"menuid": "1420355654D1411C8C89E90409490D03",
"pagetype": "report",
"tabcode": "waitaudit",
"tablecode": "V_PERF_DEPT_SELFEVALTASK",
"workflow": "AB1C3F88E5BA9F021C1D2B249ADBDA27"
}', 1, '340000000', 2021);

insert into perf_pendingtask (GUID, KEY, NAME, PARAM, STATUS, PROVINCE, YEAR)
values ('663456789AF1DAE3B707805D73F88E08', '/pmkpi/perfself/audit', '绩效自评审核(部门)', '{
"agency": "treeroot",
"beanid": "pmkpi.perfSelf.PerfSelfAuditBO",
"bustype": "3",
"isleaf": "0",
"lefttabtype": "dept",
"menuid": "6A093E24C0724067A7841F036D0A8972",
"pagetype": "audit",
"tabcode": "waitaudit",
"tablecode": "V_PERF_T_SELFEVALTASK",
"viewtabcode": "V_PERF_DEPT_SELFEVALTASK",
"workflow": "AB1C3F88E5BA9F021C1D2B249ADBDA27"
}', 1, '340000000', 2021);

