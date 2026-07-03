begin
-- 按钮
delete from p#busfw_t_uifunction where key in('/pmkpi/rectification/audit/index','/pmkpi/rectification/feedback/audit/index','/pmkpi/rectification/index');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('95E751B0D548BFAF4D020E0708275B4A', '/pmkpi/rectification/audit/index', '下发', 1, 2, 'addaction', 'rectificationaudit.send', null, '下发', 'pmkpi', 'audit', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('40349437008AE6B5375F270FA5C63919', '/pmkpi/rectification/audit/index', '退回', 1, 3, 'addaction', 'rectificationaudit.back', null, '退回', 'pmkpi', '退回', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('DE24FB043565247602D4F8496CC3A094', '/pmkpi/rectification/audit/index', '审核情况', 1, 4, 'addaction', 'rectificationaudit.queryaudit', null, '审核情况', 'pmkpi', 'queryaudit', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('CEC03E0DDDE54EDEE0533315A8C0DD09', '/pmkpi/rectification/audit/index', '导出列表', 1, 8, 'addaction', 'Ext.lt.pmkpi.expdata', null, '导出列表', 'pmkpi', 'export', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('10F7DF1F9B604C88ABDBFC20277BEE00', '/pmkpi/rectification/audit/index', '查看项目', 1, 6, null, 'rectificationaudit.showProjView', null, '查看项目', 'pmkpi', 'showProjView', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('28163FECE45512A1E0533315A8C0AC00', '/pmkpi/rectification/audit/index', '查看明细', 1, 7, 'addaction', 'rectificationaudit.detailed', null, '查看明细', 'pmkpi', 'detailed', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('59CE85375EBA016896C69A79221E4170', '/pmkpi/rectification/audit/index', '查询', 0, 1, 'addaction', 'rectificationaudit.query', null, '查询', 'pmkpi', 'query', null, null);


insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('54314B2E452249C08234D60BB31729F0', '/pmkpi/rectification/feedback/audit/index', '导出列表', 1, 11, 'addaction', 'Ext.lt.pmkpi.expdata', null, '导出列表', 'pmkpi', 'export', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('64AFDD7C9DFD82DA5F418F0B68013751', '/pmkpi/rectification/feedback/audit/index', '查询', 0, 1, 'addaction', 'feedbackAudit.query', null, '查询', 'pmkpi', 'query', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('3B63783C84CA198D92FD6EBD458496FB', '/pmkpi/rectification/feedback/audit/index', '审核', 1, 5, 'addaction', 'feedbackAudit.send', null, '审核', 'pmkpi', 'send', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('0E47A168221C06E8E8C25C2A3A80EB6C', '/pmkpi/rectification/feedback/audit/index', '退回', 0, 6, 'addaction', 'feedbackAudit.back', null, '退回', 'pmkpi', 'back', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('4E3DC0A835A5B0683955F67349075DC2', '/pmkpi/rectification/feedback/audit/index', '批量审核', 0, 7, 'addaction', 'feedbackAudit.sendlist', null, '批量审核', 'pmkpi', 'sendlist', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('2E041D630C43BDE245F03751798259C3', '/pmkpi/rectification/feedback/audit/index', '取消审核', 1, 8, 'addaction', 'feedbackAudit.wfAudit', null, '取消审核', 'pmkpi', 'cancelaudit', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('AEDD3BDCB952726578D7D2838F16BA87', '/pmkpi/rectification/feedback/audit/index', '审核情况', 1, 9, 'addaction', 'feedbackAudit.showwflogs', null, '审核情况', 'pmkpi', 'showwflogs', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('54314B2E452249C08234D60BB31729FE', '/pmkpi/rectification/feedback/audit/index', '审核信息', 1, 10, 'addaction', 'feedbackAudit.auditinfo', null, '审核信息', 'pmkpi', 'auditinfo', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('10F7DF1F9B604C88ABDBFC20277BEE51', '/pmkpi/rectification/feedback/audit/index', '查看项目', 1, 4, 'addaction', 'feedbackAudit.showProjView', null, '查看项目', 'pmkpi', 'showProjView', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('28163FECE45512A1E0533315A8C0ACDB', '/pmkpi/rectification/feedback/audit/index', '查看明细', 1, 2, 'addaction', 'feedbackAudit.detailed', null, '查看明细', 'pmkpi', 'detailed', null, '{}');



insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('00F7DF1F9B604C88ABDBFC20277BEE51', '/pmkpi/rectification/index', '取消下达', 1, 10, 'addaction', 'rectification.wfAudit', null, '取消下达', 'pmkpi', 'cancelsendaudit', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('CEC03E0DDDE54EDEE0533315A8C0DD02', '/pmkpi/rectification/index', '导出列表', 1, 11, 'addaction', 'Ext.lt.pmkpi.expdata', null, '导出列表', 'pmkpi', 'export', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('700120DEBB6A19869F4F5070A1AB84A3', '/pmkpi/rectification/index', '查询', 0, 1, 'addaction', 'rectification.query', null, '查询', 'pmkpi', 'query', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('2D71A6F8F230CD0BCCCAD4F6DF6474D4', '/pmkpi/rectification/index', '选择项目', 1, 2, 'addaction', 'rectification.addproj', null, '选择项目', 'pmkpi', 'addproj', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('479F03EFCC39C1024D2C3342CFA2DD55', '/pmkpi/rectification/index', '起草/修改', 0, 3, 'addaction', 'rectification.edit', null, '起草/修改', 'pmkpi', 'edit', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('498EC1C7F15A05FF739AF997C5BD6466', '/pmkpi/rectification/index', '删除', 1, 4, 'addaction', 'rectification.del', null, '删除', 'pmkpi', 'del', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('6D43FAB5B8EAD7D4008D152B3B4C16F7', '/pmkpi/rectification/index', '下达', 1, 5, 'addaction', 'rectification.wfAudit', null, '下达', 'pmkpi', 'sendaudit', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('28163FECE45512A1E0533315A8C0ACD8', '/pmkpi/rectification/index', '查看明细', 1, 6, 'addaction', 'rectification.detailed', null, '查看明细', 'pmkpi', 'detailed', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('10F7DF1F9B604C88ABDBFC20277BEE59', '/pmkpi/rectification/index', '查看项目', 1, 7, null, 'rectification.showProjView', null, '查看项目', 'pmkpi', 'showProjView', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('FDDD969089A259056C6186B964B64BB0', '/pmkpi/rectification/index', '审核情况', 1, 8, 'addaction', 'rectification.showwflogs', null, '审核情况', 'pmkpi', 'showwflogs', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('6DDDFA005297265798DD72C6A3162900', '/pmkpi/rectification/index', '送审', 0, 9, 'addaction', 'rectification.send', null, '送审', 'pmkpi', 'send', null, null);
