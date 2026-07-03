begin

--监控指标保存草稿
--项目支出-按钮
delete from p#busfw_t_uifunction where key = '/pmkpi/program/trace/report/edit/indextarget';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/program/trace/report/edit/indextarget', '保存草稿', 0, 1, 'Keepicon', 'proindextrace.saveDrafts', null, '保存草稿', 'pmkpi', null, null, null);
--部门整体-按钮
delete from p#busfw_t_uifunction where key = '/pmkpi/trace/report/deptedit/indextarget';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/trace/report/deptedit/indextarget', '保存草稿', 0, 1, 'Keepicon', 'proindextrace.saveDrafts', null, '保存草稿', 'pmkpi', null, null, null);

--自评指标保存草稿
--项目支出-按钮
delete from p#busfw_t_uifunction where key = '/pmkpi/perfself/apply/edit/selfindex';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/perfself/apply/edit/selfindex', '保存草稿', 0, 1, 'Keepicon', 'selfindex.saveDrafts', null, '保存草稿', 'pmkpi', null, null, null);
--部门整体-按钮
delete from p#busfw_t_uifunction where key = '/pmkpi/perfself/apply/editdept/selfindex';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/perfself/apply/editdept/selfindex', '保存草稿', 0, 1, 'Keepicon', 'selfindex.saveDrafts', null, '保存草稿', 'pmkpi', null, null, null);
