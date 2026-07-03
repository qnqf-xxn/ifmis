begin
  --新增上传附件按钮
delete from p#busfw_t_uifunction where key in('/pmkpi/program/trace/query','/pmkpi/program/trace/audit','/pmkpi/program/trace/report') and code ='uploadFile';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/program/trace/query', '附件查看', 0, 10, 'searchicon', 'protracequery.uploadFile', null, '附件查看', 'pmkpi', 'uploadFile', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/program/trace/audit', '附件上传', 0, 10, 'searchicon', 'protraceaudit.uploadFile', null, '附件上传', 'pmkpi', 'uploadFile', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/program/trace/report', '附件查看', 0, 8, 'searchicon', 'protaskreport.uploadFile', null, '附件查看', 'pmkpi', 'uploadFile', null, null);
