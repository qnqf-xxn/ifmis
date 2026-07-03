begin
  
delete from p#busfw_t_uifunction where key = '/pmkpi/audit/view' and code = 'showhistraceyear';

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, ISEDITCTRL, EDITCTRLMSG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/audit/view', '查看历史年度监控记录', 0, 6, 'searchicon', 'audit.showhistrace', null, '查看历史年度监控记录', 'pmkpi', 'showhistraceyear', null, null, null, null, '2016','87');
