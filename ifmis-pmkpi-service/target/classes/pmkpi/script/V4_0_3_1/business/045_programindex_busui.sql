begin

delete from p#busfw_t_uifunction t where t.key in('/pmkpi/program/report/treeindex') and t.code='calendarindex';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/program/report/treeindex', '参考历年指标', 1, 13, 'keepicon', 'prjtreeindex.calendarindex', null, '参考历年指标', 'pmkpi', 'calendarindex', null, null);

update p#busfw_t_uitabpage t set t.hidebtns='查看评审意见,复制总体绩效指标,复制上年指标,参考历年指标' where t.key in('/pmkpi/program/report/treeindex') and t.code='total';
