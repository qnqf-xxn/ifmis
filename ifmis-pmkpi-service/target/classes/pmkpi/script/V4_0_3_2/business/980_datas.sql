begin

--指标库左侧树页签
delete from perf_t_treetab t where t.key in('/pmkpi/indexlib/list','/pmkpi/indexlib/deptlist','/pmkpi/index/audit','/pmkpi/index/query','/pmkpi/index/query/dept');
insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID, CONFIG)
values ('ED15452045E40B42E0533315A8C0D3C2', '/pmkpi/indexlib/list', 'IDEXCOMCLS', '共性指标', 1, '个性绩效指标导入,转移支付绩效指标导入', 1, '2016', '87', null, null, null);

insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID, CONFIG)
values ('ED15452045E50B42E0533315A8C0D3C2', '/pmkpi/indexlib/list', 'INDEXCOMFUNC', '个性指标', 1, '共性绩效指标导入,转移支付绩效指标导入', 2, '2016', '87', null, null, null);

insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID, CONFIG)
values ('ED15452045E60B42E0533315A8C0D3C2', '/pmkpi/indexlib/list', 'INDEXTRANPAY', '转移支付指标', 0, '共性绩效指标导入,个性绩效指标导入', 3, '2016', '87', null, null, null);

insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID, CONFIG)
values ('ED15452045E70B42E0533315A8C0D3C2', '/pmkpi/indexlib/deptlist', 'INDEXCOMFUNC', '项目支出', 1, null, 1, '2016', '87', null, null, null);

insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID, CONFIG)
values ('ED15452045E80B42E0533315A8C0D3C2', '/pmkpi/indexlib/deptlist', 'PMKPIDEPT', '部门整体', 1, null, 2, '2016', '87', null, null, null);

insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID, CONFIG)
values ('ED15452045EB0B42E0533315A8C0D3C2', '/pmkpi/index/query', 'IDEXCOMCLS', '共性指标', 1, '审核情况', 1, '2016', '87', null, null, null);

insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID, CONFIG)
values ('ED15452045EC0B42E0533315A8C0D3C2', '/pmkpi/index/query', 'INDEXCOMFUNC', '个性指标', 1, '审核情况', 2, '2016', '87', null, null, null);

insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID, CONFIG)
values ('ED15452045ED0B42E0533315A8C0D3C2', '/pmkpi/index/query', 'INDEXTRANPAY', '转移支付指标', 0, '审核情况', 3, '2016', '87', null, null, null);

insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID, CONFIG)
values ('ED15452045EE0B42E0533315A8C0D3C2', '/pmkpi/index/query/dept', 'INDEXCOMFUNC', '项目支出', 1, null, 1, '2016', '87', null, null, null);

insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID, CONFIG)
values ('ED15452045EF0B42E0533315A8C0D3C2', '/pmkpi/index/query/dept', 'PMKPIDEPT', '部门整体', 1, '省级指标,市级指标,县级指标', 2, '2016', '87', null, null, null);

insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID, CONFIG)
values ('ED15452045F10B42E0533315A8C0D3C2', '/pmkpi/index/audit', 'INDEXCOMFUNC', '项目支出', 1, null, 1, '2016', '87', null, null, null);

insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID, CONFIG)
values ('ED15452045F20B42E0533315A8C0D3C2', '/pmkpi/index/audit', 'PMKPIDEPT', '部门整体', 1, null, 2, '2016', '87', null, null, null);

--转移支付指标导入模板
delete from p#fw_t_importtemplate t where t.tempcode in('120011004') and t.appid='C43D8AA7015B7F8B25CA18C3277CA4BE';
insert into fw_t_importtemplate (GUID, TEMPCODE, TEMPNAME, COLSPLIT, TABLECODE, CALLBACKBEANID, DEFAULTVALUE, CALLBACKMETHOD, APPID, VCHTYPEID)
values ('ED15452047170B42E0533315A8C0D3C2', '120011004', '转移支付绩效指标导入模板', ',', 'V_BAS_PERF_INDICATOR', 'pmkpi.setting.indexlib.report.IndexRpBOTx', null, 'importIndexlibData', 'C43D8AA7015B7F8B25CA18C3277CA4BE', 'ED154520471A0B42E0533315A8C0D3C2');

delete from p#fw_t_importtempdetail t where t.tempid in('ED15452047170B42E0533315A8C0D3C2');
insert into fw_t_importtempdetail (GUID, COLUMNID, TEMPID, ORDERNUM, IMPORTDS, IMPORTDSCFG, SHOWNAME)
values ('C08B41D0DB3E082BF974DD1D58E59A78', 'VD15452046AB0B42E0533315A8C0D3C2', 'ED15452047170B42E0533315A8C0D3C2', 0, 'checked', null, '专项资金名称');

insert into fw_t_importtempdetail (GUID, COLUMNID, TEMPID, ORDERNUM, IMPORTDS, IMPORTDSCFG, SHOWNAME)
values ('A52B524FCBAB30310D11E631388275DF', 'V412538AA08B62E3E0535164A8C0C98B', 'ED15452047170B42E0533315A8C0D3C2', 1, 'checked', 't.levelno=1 and t.frametype=''PM001''', null);

insert into fw_t_importtempdetail (GUID, COLUMNID, TEMPID, ORDERNUM, IMPORTDS, IMPORTDSCFG, SHOWNAME)
values ('45A415F9990BB0CE5586FA857061926E', 'V412538AA08C62E3E0535164A8C0C98B', 'ED15452047170B42E0533315A8C0D3C2', 2, 'checked', 't.frametype=''PM001'' and exists(select 1 from v_perf_t_frame a where a.guid=t.superguid and a.levelno=1 and a.frametype=''PM001'') order by code', null);

insert into fw_t_importtempdetail (GUID, COLUMNID, TEMPID, ORDERNUM, IMPORTDS, IMPORTDSCFG, SHOWNAME)
values ('27131493D3F18017E6BBAB896DCA9948', 'V412538AA09062E3E0535164A8C0C98B', 'ED15452047170B42E0533315A8C0D3C2', 3, null, null, null);

insert into fw_t_importtempdetail (GUID, COLUMNID, TEMPID, ORDERNUM, IMPORTDS, IMPORTDSCFG, SHOWNAME)
values ('68043C8B409E0952559818D131C1F7F9', 'V7625FA0D4E347EAACD5F0253ABC5975', 'ED15452047170B42E0533315A8C0D3C2', 4, 'checked', null, null);

insert into fw_t_importtempdetail (GUID, COLUMNID, TEMPID, ORDERNUM, IMPORTDS, IMPORTDSCFG, SHOWNAME)
values ('9C24FA99193E0A9EF4C5A76F7870A0DB', 'V6D147E4A9D442D6942EB34B6A0C4113', 'ED15452047170B42E0533315A8C0D3C2', 5, null, null, '参考值');

insert into fw_t_importtempdetail (GUID, COLUMNID, TEMPID, ORDERNUM, IMPORTDS, IMPORTDSCFG, SHOWNAME)
values ('2F78C59E8A4F430D0CBB370981A99F23', 'V355CD7C6150449AB1F16C4511697744', 'ED15452047170B42E0533315A8C0D3C2', 6, null, null, null);

insert into fw_t_importtempdetail (GUID, COLUMNID, TEMPID, ORDERNUM, IMPORTDS, IMPORTDSCFG, SHOWNAME)
values ('9954844AF9596C6A0840F0E76E9DC075', 'V0DE94A00F7F44A9B5786A173314D717', 'ED15452047170B42E0533315A8C0D3C2', 7, null, null, null);

insert into fw_t_importtempdetail (GUID, COLUMNID, TEMPID, ORDERNUM, IMPORTDS, IMPORTDSCFG, SHOWNAME)
values ('8158BCB541FEDA231CD6C8F7C2B24FF8', 'V7A738A2A10A42538A319BBC13E839DA', 'ED15452047170B42E0533315A8C0D3C2', 8, 'checked', null, null);

--指标库、事前绩效评估、部门评价待办功能配置
update perf_pendingtask t set t.lefttabnum=1 where key in('/pmkpi/prorevision/report','/pmkpi/prorevision/audit','/pmkpi/evaluation/dept/result','/pmkpi/evaluation/dept/resultaudit');

delete from perf_pendingtask t where key in('/pmkpi/seeting/evaluation/report','/pmkpi/seeting/evaluation/audit','/pmkpi/indexlib/deptlist','/pmkpi/index/audit','/pmkpi/evaluation/financial/deptassessment/list');
insert into perf_pendingtask (GUID, KEY, NAME, STATUS, PROVINCE, YEAR, PARAM, TABCODE, LEFTTABNUM, BEANID, MOTHOD)
values ('ED8DD6D907AD48E2E0533315A8C05CF6', '/pmkpi/seeting/evaluation/report', '项目支出事前绩效评估申报-未送审', 1, '87', 2022, '{isleaf: "0",
leftmenuid: "programevaluationhide",
lefttabtype: "program",
menuid: "DE678F7165211ED8E0533315A8C0875C",
prolev: undefined,
queryConfig: undefined,
querySql: "",
tablecode:"V_PERF_T_EVALUATION",
saveAgency: "treeroot",
tabcode: "waitaudit",
tabfilter: null,
workflow: "DEA8A8BEF3143C0AE0533315A8C0D7DA"
}', null, '1', 'pmkpi.setting.evaluation.report.EvaluationReportBOTX', 'getVodSql');

insert into perf_pendingtask (GUID, KEY, NAME, STATUS, PROVINCE, YEAR, PARAM, TABCODE, LEFTTABNUM, BEANID, MOTHOD)
values ('ED8DD6D907AE48E2E0533315A8C05CF6', '/pmkpi/seeting/evaluation/report', '项目支出事前绩效评估申报-被退回', 1, '87', 2022, '{isleaf: "0",
leftmenuid: "programevaluationhide",
lefttabtype: "program",
menuid: "DE678F7165211ED8E0533315A8C0875C",
prolev: undefined,
queryConfig: undefined,
querySql: "",
tablecode:"V_PERF_T_EVALUATION",
saveAgency: "treeroot",
tabcode: "back",
tabfilter: null,
workflow: "DEA8A8BEF3143C0AE0533315A8C0D7DA"
}', 'back', '1', 'pmkpi.setting.evaluation.report.EvaluationReportBOTX', 'getVodSql');

insert into perf_pendingtask (GUID, KEY, NAME, STATUS, PROVINCE, YEAR, PARAM, TABCODE, LEFTTABNUM, BEANID, MOTHOD)
values ('ED8DD6D907B048E2E0533315A8C05CF6', '/pmkpi/seeting/evaluation/audit', '项目支出事前绩效评估审核-未送审', 1, '87', 2022, '{isleaf: "0",
leftmenuid: "programevaluationaudithide",
lefttabtype: "program",
menuid: "DE678F7165211ED8E0533315A8C0875C",
prolev: undefined,
queryConfig: undefined,
querySql: "",
tablecode:"V_PERF_T_EVALUATION",
saveAgency: "treeroot",
tabcode: "back",
tabfilter: null,
workflow: "DEA8A8BEF3143C0AE0533315A8C0D7DA"
}', null, '1', 'pmkpi.setting.evaluation.audit.EvaluationAuditBOTX', 'getVodSql');

insert into perf_pendingtask (GUID, KEY, NAME, STATUS, PROVINCE, YEAR, PARAM, TABCODE, LEFTTABNUM, BEANID, MOTHOD)
values ('ED8DD6D907B148E2E0533315A8C05CF6', '/pmkpi/seeting/evaluation/audit', '项目支出事前绩效评估审核-被退回', 1, '87', 2022, '{isleaf: "0",
leftmenuid: "programevaluationaudithide",
lefttabtype: "program",
menuid: "DE678F7165211ED8E0533315A8C0875C",
prolev: undefined,
queryConfig: undefined,
querySql: "",
tablecode:"V_PERF_T_EVALUATION",
saveAgency: "treeroot",
tabcode: "back",
tabfilter: null,
workflow: "DEA8A8BEF3143C0AE0533315A8C0D7DA"
}', 'back', '1', 'pmkpi.setting.evaluation.audit.EvaluationAuditBOTX', 'getVodSql');

insert into perf_pendingtask (GUID, KEY, NAME, STATUS, PROVINCE, YEAR, PARAM, TABCODE, LEFTTABNUM, BEANID, MOTHOD)
values ('ED8DD6D907B348E2E0533315A8C05CF6', '/pmkpi/indexlib/deptlist', '个性指标-部门整体指标-待送审', 1, '87', 2022, '{isleaf: "0",
tabtype: "INDEXCOMFUNC",
menuid: "B8C8933B0D03196EE0530100007FF847",
indextype:"dept",
queryConfig: undefined,
querySql: "",
saveAgency: "treeroot",
tabcode: "waitaudit",
tabfilter: null,
workflow: "2F62B0E1A972408B8330D3653F836522"
}', null, '1', 'pmkpi.setting.indexlib.report.IndexRpBOTx', 'getVodSql');

insert into perf_pendingtask (GUID, KEY, NAME, STATUS, PROVINCE, YEAR, PARAM, TABCODE, LEFTTABNUM, BEANID, MOTHOD)
values ('ED8DD6D907B448E2E0533315A8C05CF6', '/pmkpi/indexlib/deptlist', '个性指标-部门整体指标-被退回', 1, '87', 2022, '{isleaf: "0",
tabtype: "INDEXCOMFUNC",
menuid: "B8C8933B0D03196EE0530100007FF847",
indextype:"dept",
queryConfig: undefined,
querySql: "",
saveAgency: "treeroot",
tabcode: "back",
tabfilter: null,
workflow: "2F62B0E1A972408B8330D3653F836522"
}', 'back', '1', 'pmkpi.setting.indexlib.report.IndexRpBOTx', 'getVodSql');

insert into perf_pendingtask (GUID, KEY, NAME, STATUS, PROVINCE, YEAR, PARAM, TABCODE, LEFTTABNUM, BEANID, MOTHOD)
values ('ED8DD6D907B648E2E0533315A8C05CF6', '/pmkpi/indexlib/deptlist', '部门整体-部门整体指标-待送审', 1, '87', 2022, '{isleaf: "0",
tabtype: "PMKPIDEPT",
menuid: "B8C8933B0D03196EE0530100007FF847",
indextype:"dept",
queryConfig: undefined,
querySql: "",
saveAgency: "treeroot",
tabcode: "waitaudit",
tabfilter: null,
workflow: "2F62B0E1A972408B8330D3653F836522"
}', null, '2', 'pmkpi.setting.indexlib.report.IndexRpBOTx', 'getVodSql');

insert into perf_pendingtask (GUID, KEY, NAME, STATUS, PROVINCE, YEAR, PARAM, TABCODE, LEFTTABNUM, BEANID, MOTHOD)
values ('ED8DD6D907B748E2E0533315A8C05CF6', '/pmkpi/indexlib/deptlist', '部门整体-部门整体指标-被退回', 1, '87', 2022, '{isleaf: "0",
tabtype: "PMKPIDEPT",
menuid: "B8C8933B0D03196EE0530100007FF847",
indextype:"dept",
queryConfig: undefined,
querySql: "",
saveAgency: "treeroot",
tabcode: "back",
tabfilter: null,
workflow: "2F62B0E1A972408B8330D3653F836522"
}', 'back', '2', 'pmkpi.setting.indexlib.report.IndexRpBOTx', 'getVodSql');

insert into perf_pendingtask (GUID, KEY, NAME, STATUS, PROVINCE, YEAR, PARAM, TABCODE, LEFTTABNUM, BEANID, MOTHOD)
values ('ED8DD6D9081048E2E0533315A8C05CF6', '/pmkpi/index/audit', '个性指标-部门整体指标确认-待送审', 1, '87', 2022, '{isleaf: "0",
tabtype: "INDEXCOMFUNC",
menuid: "B8C8933B0D04196EE0530100007FF847",
indextype:"dept",
queryConfig: undefined,
querySql: "",
saveAgency: "treeroot",
tabcode: "waitaudit",
tabfilter: null,
workflow: "2F62B0E1A972408B8330D3653F836522"
}', null, '1', 'pmkpi.setting.indexlib.audit.IndexAuditBOTx', 'getVodSql');

insert into perf_pendingtask (GUID, KEY, NAME, STATUS, PROVINCE, YEAR, PARAM, TABCODE, LEFTTABNUM, BEANID, MOTHOD)
values ('ED8DD6D9081148E2E0533315A8C05CF6', '/pmkpi/index/audit', '个性指标-部门整体指标确认-被退回', 1, '87', 2022, '{isleaf: "0",
tabtype: "INDEXCOMFUNC",
menuid: "B8C8933B0D04196EE0530100007FF847",
indextype:"dept",
queryConfig: undefined,
querySql: "",
saveAgency: "treeroot",
tabcode: "back",
tabfilter: null,
workflow: "2F62B0E1A972408B8330D3653F836522"
}', 'back', '1', 'pmkpi.setting.indexlib.audit.IndexAuditBOTx', 'getVodSql');

insert into perf_pendingtask (GUID, KEY, NAME, STATUS, PROVINCE, YEAR, PARAM, TABCODE, LEFTTABNUM, BEANID, MOTHOD)
values ('ED8DD6D9081248E2E0533315A8C05CF6', '/pmkpi/index/audit', '部门整体-部门整体指标确认-待送审', 1, '87', 2022, '{isleaf: "0",
tabtype: "PMKPIDEPT",
menuid: "B8C8933B0D04196EE0530100007FF847",
indextype:"dept",
queryConfig: undefined,
querySql: "",
saveAgency: "treeroot",
tabcode: "waitaudit",
tabfilter: null,
workflow: "2F62B0E1A972408B8330D3653F836522"
}', null, '2', 'pmkpi.setting.indexlib.audit.IndexAuditBOTx', 'getVodSql');

insert into perf_pendingtask (GUID, KEY, NAME, STATUS, PROVINCE, YEAR, PARAM, TABCODE, LEFTTABNUM, BEANID, MOTHOD)
values ('ED8DD6D9081348E2E0533315A8C05CF6', '/pmkpi/index/audit', '部门整体-部门整体指标确认-被退回', 1, '87', 2022, '{isleaf: "0",
tabtype: "PMKPIDEPT",
menuid: "B8C8933B0D04196EE0530100007FF847",
indextype:"dept",
queryConfig: undefined,
querySql: "",
saveAgency: "treeroot",
tabcode: "back",
tabfilter: null,
workflow: "2F62B0E1A972408B8330D3653F836522"
}', 'back', '2', 'pmkpi.setting.indexlib.audit.IndexAuditBOTx', 'getVodSql');

insert into perf_pendingtask (GUID, KEY, NAME, STATUS, PROVINCE, YEAR, PARAM, TABCODE, LEFTTABNUM, BEANID, MOTHOD)
values ('EE33BB3917CE390BE0533315A8C0A093', '/pmkpi/evaluation/financial/deptassessment/list', '项目支出财政评价部门自评价-待审核', 1, '87', 2016, '{isleaf: "0",
leftmenuid: "programfindeptfillhide",
lefttabtype: "program",
prolev: undefined,
queryConfig: undefined,
querySql: "",
saveAgency: "treeroot",
tabcode: "waitaudit",
tabfilter: null,
wheresql: undefined,
workflow: "BD2785454440A0C1E053B11FA8C0DCF9"
}', null, '1', 'pmkpi.evaluation.financial.deptfill.DeptfillBOTX', 'getVodSql');

insert into perf_pendingtask (GUID, KEY, NAME, STATUS, PROVINCE, YEAR, PARAM, TABCODE, LEFTTABNUM, BEANID, MOTHOD)
values ('EE33BB3917CF390BE0533315A8C0A093', '/pmkpi/evaluation/financial/deptassessment/list', '项目支出财政评价部门自评价-被退回', 1, '87', 2016, '{isleaf: "0",
leftmenuid: "programfindeptfillhide",
lefttabtype: "program",
prolev: undefined,
queryConfig: undefined,
querySql: "",
saveAgency: "treeroot",
tabcode: "back",
tabfilter: null,
wheresql: undefined,
workflow: "BD2785454440A0C1E053B11FA8C0DCF9"
}', 'back', '1', 'pmkpi.evaluation.financial.deptfill.DeptfillBOTX', 'getVodSql');

insert into perf_pendingtask (GUID, KEY, NAME, STATUS, PROVINCE, YEAR, PARAM, TABCODE, LEFTTABNUM, BEANID, MOTHOD)
values ('EE33BB3917D0390BE0533315A8C0A093', '/pmkpi/evaluation/financial/deptassessment/list', '部门整体财政评价部门自评价-待审核', 1, '87', 2016, '{isleaf: "0",
leftmenuid: "deptfindeptfillhide",
lefttabtype: "dept",
queryConfig: undefined,
querySql: "",
saveAgency: "treeroot",
tabcode: "waitaudit",
tabfilter: null,
wheresql: undefined,
workflow: "BD2785454442A0C1E053B11FA8C0DCF9"
}', null, '2', 'pmkpi.evaluation.financial.deptfill.DeptfillBOTX', 'getVodSql');

insert into perf_pendingtask (GUID, KEY, NAME, STATUS, PROVINCE, YEAR, PARAM, TABCODE, LEFTTABNUM, BEANID, MOTHOD)
values ('EE33BB3917D1390BE0533315A8C0A093', '/pmkpi/evaluation/financial/deptassessment/list', '部门整体财政评价部门自评价-被退回', 1, '87', 2016, '{isleaf: "0",
leftmenuid: "deptfindeptfillhide",
lefttabtype: "dept",
queryConfig: undefined,
querySql: "",
saveAgency: "treeroot",
tabcode: "back",
tabfilter: null,
wheresql: undefined,
workflow: "BD2785454442A0C1E053B11FA8C0DCF9"
}', 'back', '2', 'pmkpi.evaluation.financial.deptfill.DeptfillBOTX', 'getVodSql');