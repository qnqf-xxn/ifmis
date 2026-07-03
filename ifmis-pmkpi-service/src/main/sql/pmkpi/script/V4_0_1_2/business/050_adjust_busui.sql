begin

--1.绩效运行监控-绩效监控审核（发起监控整改、发起目标调整）
delete from p#busfw_t_uifunction where  key = '/pmkpi/program/trace/audit';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('1A461A8F8E4A41D6899C5931418C8FB7', '/pmkpi/program/trace/audit', '发起监控整改', 1, 11, 'searchicon', 'protraceaudit.monRect', null, '发起监控整改', 'pmkpi', 'monRect', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('55E44D005992444EBB5E238AA23C99A2', '/pmkpi/program/trace/audit', '发起目标调整', 1, 10, 'searchicon', 'protraceaudit.adjustTarget', null, '发起目标调整', 'pmkpi', 'adjustTarget', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B7A11C351F9449CBE0530100007F4B66', '/pmkpi/program/trace/audit', '审核', 1, 4, 'searchicon', 'protraceaudit.audit', null, '审核', 'pmkpi', 'sendaudit', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B7A11C351F9549CBE0530100007F4B66', '/pmkpi/program/trace/audit', '取消审核', 1, 5, 'searchicon', 'protraceaudit.wfAudit', null, '取消审核', 'pmkpi', 'cancelsendaudit', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B7A11C351F9649CBE0530100007F4B66', '/pmkpi/program/trace/audit', '审核情况', 1, 6, 'searchicon', 'protraceaudit.queryaudit', null, '审核情况', 'pmkpi', 'queryaudit', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('4D4011F3455B444FB0C58CF7D5C5EFC8', '/pmkpi/program/trace/audit', '导出列表', 1, 9, 'searchicon', 'protraceaudit.export', null, '导出列表', 'pmkpi', 'export', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('C14F231C6BB34F83D254806FDDE5478A', '/pmkpi/program/trace/audit', '导出报告', 1, 8, 'searchicon', 'Ext.lt.pmkpi.expdoc', null, '导出报告', 'pmkpi', 'expdoc', null, '{tempatecode:''tracereportindex''}');
