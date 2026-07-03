begin

delete from bus_t_pagecomponent t where t.id='pmkpi_evaluateaudit';
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_evaluateaudit', '事前绩效评估审核', null, '事前绩效评估审核', '/pmkpi/evaluate/audit/evaluateaudit.js,/pmkpi/common/filemanage/filemanage.js', 'Ext.lt.pmkpi.evaluate.auditservice', 'pmkpi', 'pmkpi.evaluate.EvaluateAuditService');