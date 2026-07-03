begin

--部门指标查询 （同财政绩效指标查询）
delete from p#busfw_t_uifunction where key = '/pmkpi/index/query' and code = 'detailed';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/index/query', '查看明细', 1, 1, 'searchicon', 'indexquery.detailed', null, '查看明细', 'pmkpi', 'detailed', null, '{}', null, null);

--部门指标确认
delete from p#busfw_t_uifunction where key = '/pmkpi/index/audit' and code = 'detailed';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/index/audit', '查看明细', 1, 1, 'searchicon', 'indexaudit.detailed', null, '查看明细', 'pmkpi', 'detailed', null, '{}', null, null);



