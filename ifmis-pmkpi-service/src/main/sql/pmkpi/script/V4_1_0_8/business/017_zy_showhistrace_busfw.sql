begin
  
delete from p#busfw_t_uifunction where key = '/pmkpi/audit/view' and code = 'showhistrace';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/audit/view', '查看历史监控记录', 1, 5, 'searchicon', 'audit.showhistrace', null, '查看历史监控记录', 'pmkpi', 'showhistrace', null, null, null, null);


delete from p#busfw_t_uifunction where key = '/pmkpi/audit/program/showhistrace';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/audit/program/showhistrace', '查看明细', 1, 1, 'searchicon', 'showhistrace.detailed', null, '查看明细', 'pmkpi', 'detailed', null, '{}', null, null);
