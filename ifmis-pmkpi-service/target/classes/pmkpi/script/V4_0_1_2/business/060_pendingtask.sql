begin
delete from v_perf_pendingtask where guid in ('ED0AE6B017296D750223CBA13E4E8C98','891527900AF1DAE3B707805D73F88E08','051679E30D8A0BBC4E0281B2FB7CFE30','A6D64F8EC4684D589B576F93D180DD78','63CBB88D5143DAD51354166C2E9E04A8','20E023B7ED99E1B91C9EC7FE58004AEE','275B4BD6CB254F7998FC0FB1A2DD4B5A');
insert into v_perf_pendingtask (GUID, KEY, NAME, PARAM, STATUS, PROVINCE, YEAR)
values ('ED0AE6B017296D750223CBA13E4E8C98', '/pmkpi/program/trace/report', '绩效目标监控填报', '{}', 1, '340000000', 2021);

insert into v_perf_pendingtask (GUID, KEY, NAME, PARAM, STATUS, PROVINCE, YEAR)
values ('891527900AF1DAE3B707805D73F88E08', '/pmkpi/program/trace/audit', '绩效目标监控审核', '{}', 1, '340000000', 2021);

insert into v_perf_pendingtask (GUID, KEY, NAME, PARAM, STATUS, PROVINCE, YEAR)
values ('051679E30D8A0BBC4E0281B2FB7CFE30', '/pmkpi/program/reportdp/jxaudit', '项目绩效目标审核（绩效处）', '{
"pagetype":"audit",
"agency":"treeroot",
"workflow":"B9C7D80EC0188933E053B11FA8C0A5D6",
"menuid":"pmkpiprogram2020517",
"tablecode":"V_PERF_PROJECT_REVIEW",
"isleaf":"0",
"tabcode":"waitaudit"
}', 1, '340000000', 2021);

insert into v_perf_pendingtask (GUID, KEY, NAME, PARAM, STATUS, PROVINCE, YEAR)
values ('A6D64F8EC4684D589B576F93D180DD78', '/pmkpi/deptperformance/report/index', '部门绩效申报填报', '{
"saveAgency":"treeroot",
"workflow":"D00E439AFACC701EDEE1DBA1EADE225F",
"treesource":"PMKPIDEPT",
"menuid":"E612AE4B4B6546F2BAAEB3E7CF8B9567",
"tablecode":"V_PERF_T_DEPTPERFDECLARE",
"isleaf":"0",
"tabcode":"waitaudit"
}', 1, '340000000', 2021);

insert into v_perf_pendingtask (GUID, KEY, NAME, PARAM, STATUS, PROVINCE, YEAR)
values ('63CBB88D5143DAD51354166C2E9E04A8', '/pmkpi/indexlib/list', '绩效指标维护(财政)', '{
"indextype":"finance",
"isleaf":"0",
"menuid":"838B1FDBFEE7E614316B0A2631CF8555",
"tabtype":"INDEXCOMFUNC",
"treeid":"treeroot"
}', 1, '340000000', 2021);

insert into v_perf_pendingtask (GUID, KEY, NAME, PARAM, STATUS, PROVINCE, YEAR)
values ('20E023B7ED99E1B91C9EC7FE58004AEE', '/pmkpi/indexlib/deptlist', '绩效指标维护(部门)', '{
"indextype":"dept",
"treeid":"treeroot",
"workflow":"2F62B0E1A972408B8330D3653F836522",
"menuid":"B8C8933B0D03196EE0530100007FF847",
"tabtype":"IDEXCOMCLS",
"tabcode":"waitaudit",
"key":"/pmkpi/indexlib/deptlist"
}', 1, '340000000', 2021);

insert into v_perf_pendingtask (GUID, KEY, NAME, PARAM, STATUS, PROVINCE, YEAR)
values ('275B4BD6CB254F7998FC0FB1A2DD4B5A', '/pmkpi/index/audit', '绩效指标审核', '{
beanid: "pmkpi.setting.indexlib.audit.IndexAuditBOTx",
isleaf: 0,
menuid: "B8C8933B0D04196EE0530100007FF847",
tabcode: "waitaudit",
tabtype: "INDEXCOMFUNC",
treeid: "treeroot",
workflow: "2F62B0E1A972408B8330D3653F836522"
}', 1, '340000000', 2021);


