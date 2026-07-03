begin
  --监控成功上传、成果审核页面添加查看明细按钮
delete from p#busfw_t_uifunction where key ='/pmkpi/program/trace/auditresults' and code ='detailed';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/program/trace/auditresults', '查看明细', 1, 8, 'searchicon', 'traceauditresults.detailed', null, '查看明细', 'pmkpi', 'detailed', null, '{}');

delete from p#busfw_t_uifunction where key ='/pmkpi/program/trace/thirdaudit' and code ='detailed';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/program/trace/thirdaudit', '查看明细', 1, 8, 'searchicon', 'protracethirdaudit.detailed', null, '查看明细', 'pmkpi', 'detailed', null, '{}');

