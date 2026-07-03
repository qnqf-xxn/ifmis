begin
  
DELETE FROM P#busfw_t_Uifunction t where t.key='/pmkpi/perfselftaskmanage/index';
insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('4E3C9971C9700D552893A9588FD153AD', '/pmkpi/perfselftaskmanage/index', '导出', 0, 9, 'searchicon', 'perfselfmanage.exportProj', null, '导出', 'pmkpi', 'exportProj', null, '{}');

insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('P3C73369CCF04624B14367B8B1C3AE89', '/pmkpi/perfselftaskmanage/index', '查询', 0, 1, 'searchicon', 'perfselfmanage.query', null, '查询', 'pmkpi', 'query', null, null);

insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('PA3FE46E9F1F42FEA5609157CE1AE4EB', '/pmkpi/perfselftaskmanage/index', '任务下达', 1, 1, null, 'perfselfmanage.add', null, '任务下达', 'pmkpi', 'create', null, null);

insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('P641373EEFFA4A188E42D1B7621AC3CB', '/pmkpi/perfselftaskmanage/index', '取消下达', 1, 2, null, 'perfselfmanage.del', null, '取消下达', 'pmkpi', 'del', null, null);

insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('P741373EEFFA4A188E42D1B7621AC3CB', '/pmkpi/perfselftaskmanage/index', '查看项目明细', 1, 3, null, 'perfselfmanage.showProjView', null, '查看项目明细', 'pmkpi', 'showProjView', null, null);


DELETE FROM P#busfw_t_Uifunction t where t.key='/pmkpi/perfself/query/index';
insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('54D98F353F267D57C9E5A01CD5D39828', '/pmkpi/perfself/query/index', '导出', 0, 9, 'searchicon', 'perfselfquery.exportProj', null, '导出', 'pmkpi', 'exportProj', null, '{}');

insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('Q3C73369CCF04624B14367B8B1C3AE89', '/pmkpi/perfself/query/index', '查询', 0, 1, 'searchicon', 'perfselfquery.query', null, '查询', 'pmkpi', 'query', null, null);

insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('Q641373EEFFA4A188E42D1B7621AC5CB', '/pmkpi/perfself/query/index', '审核情况', 1, 5, 'searchicon', 'perfselfquery.queryaudit', null, '审核情况', 'pmkpi', 'queryaudit', null, null);


DELETE FROM P#busfw_t_Uifunction t where t.key='/pmkpi/perfself/audit/index';
insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('29C57E220BCB603FDD5FB908700CF20D', '/pmkpi/perfself/audit/index', '导出', 0, 9, 'searchicon', 'perfselfaudit.exportProj', null, '导出', 'pmkpi', 'exportProj', null, '{}');

insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('S4314B2E451149C08234D60BB31729FE', '/pmkpi/perfself/audit/index', '审核信息', 1, 7, 'searchicon', 'perfselfaudit.auditinfo', null, '审核信息', 'pmkpi', 'auditinfo', null, null);

insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('Sa21325a98ed6a0903d27fcdca051225', '/pmkpi/perfself/audit/index', '审核', 1, 1, 'searchicon', 'perfselfaudit.audit', null, '审核', 'pmkpi', 'audit', null, null);

insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('S23b7993be58e07c00008dd2194b6ab2', '/pmkpi/perfself/audit/index', '取消审核', 1, 2, 'searchicon', 'perfselfaudit.wfAudit', null, '取消审核', 'pmkpi', 'cancelaudit', null, null);

insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('S9bbc1539c1d2268c7b4e902850a321d', '/pmkpi/perfself/audit/index', '查询', 0, 3, 'searchicon', 'perfselfaudit.query', null, '查询', 'pmkpi', 'query', null, null);

insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('SBC3AF828F8C4DE5AE5FB0C363AE182F', '/pmkpi/perfself/audit/index', '审核情况', 1, 6, 'searchicon', 'perfselfaudit.queryaudit', null, '审核情况', 'pmkpi', 'queryaudit', null, null);


DELETE FROM P#busfw_t_Uifunction t where t.key='/pmkpi/perfself/apply/index';
insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('0B6DB0ECF46167746B070840E219C286', '/pmkpi/perfself/apply/index', '导出', 0, 9, 'searchicon', 'perfselfapply.exportProj', null, '导出', 'pmkpi', 'exportProj', null, '{}');

insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('P3C73369CCF04624B14367B8B1C3AE89', '/pmkpi/perfself/apply/index', '查询', 0, 1, 'searchicon', 'perfselfapply.query', null, '查询', 'pmkpi', 'query', null, null);

insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('PA3FE46E9F1F42FEA5609157CE1AE4EB', '/pmkpi/perfself/apply/index', '填报/修改', 1, 2, 'searchicon', 'perfselfapply.save', null, '填报/修改', 'pmkpi', 'create', null, null);

insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('P641373EEFFA4A188E42D1B7621AC3CB', '/pmkpi/perfself/apply/index', '送审', 1, 3, 'searchicon', 'perfselfapply.wfAudit', null, '送审', 'pmkpi', 'sendaudit', null, null);

insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('P641373EEFFA4A188E42D1B7621AC4CB', '/pmkpi/perfself/apply/index', '取消送审', 1, 4, 'searchicon', 'perfselfapply.wfAudit', null, '取消送审', 'pmkpi', 'cancelsendaudit', null, null);

insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('P641373EEFFA4A188E42D1B7621AC5CB', '/pmkpi/perfself/apply/index', '审核情况', 1, 5, 'searchicon', 'perfselfapply.queryaudit', null, '审核情况', 'pmkpi', 'queryaudit', null, null);


DELETE FROM P#busfw_t_Uifunction t where t.key='/pmkpi/perfselftaskmanage/index';
insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('4E3C9971C9700D552893A9588FD153AD', '/pmkpi/perfselftaskmanage/index', '导出', 0, 9, 'searchicon', 'perfselfmanage.exportProj', null, '导出', 'pmkpi', 'exportProj', null, '{}');

insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('P3C73369CCF04624B14367B8B1C3AE89', '/pmkpi/perfselftaskmanage/index', '查询', 0, 1, 'searchicon', 'perfselfmanage.query', null, '查询', 'pmkpi', 'query', null, null);

insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('PA3FE46E9F1F42FEA5609157CE1AE4EB', '/pmkpi/perfselftaskmanage/index', '任务下达', 1, 1, null, 'perfselfmanage.add', null, '任务下达', 'pmkpi', 'create', null, null);

insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('P641373EEFFA4A188E42D1B7621AC3CB', '/pmkpi/perfselftaskmanage/index', '取消下达', 1, 2, null, 'perfselfmanage.del', null, '取消下达', 'pmkpi', 'del', null, null);

insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('P741373EEFFA4A188E42D1B7621AC3CB', '/pmkpi/perfselftaskmanage/index', '查看项目明细', 0, 3, null, 'perfselfmanage.showProjView', null, '查看项目明细', 'pmkpi', 'showProjView', null, null);


delete from p#busfw_t_uifunction t where key in('/pmkpi/perfself/apply/edit');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('p16486c7792f5c2a84cc923256817aa9', '/pmkpi/perfself/apply/edit', '保存', 1, 1, 'Keepicon', 'tabfreamedit.infosave', null, '保存', 'pmkpi', null, null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('p00e52e9fa72be3a5ee9b4ca0864d373', '/pmkpi/perfself/apply/edit', '取消', 1, 2, 'Nofinishicon', 'tabfreamedit.close', null, '取消', 'pmkpi', null, null, null);
