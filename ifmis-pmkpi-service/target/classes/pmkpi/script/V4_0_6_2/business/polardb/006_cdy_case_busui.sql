begin

delete from p#busfw_t_uifunction t where t.key in('/pmkpi/setting/case/list') and t.code='impindex';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, ISEDITCTRL, EDITCTRLMSG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/setting/case/list', '导入案例指标', 1, 14, 'searchicon', 'caseservice.impindex', null, '导入案例指标', 'pmkpi', 'impindex', null, '{}', null, null,'2016','87');

update p#busfw_t_uitabpage t set t.hidebtns='新增,修改,删除,送审,选择案例,导入案例指标' where t.key in('/pmkpi/setting/case/list') and t.code='alreadyaudit';
update p#busfw_t_uitabpage t set t.hidebtns='新增,修改,删除,送审,取消送审,选择案例,导入案例指标' where t.key in('/pmkpi/setting/case/list') and t.code='alldeals';
