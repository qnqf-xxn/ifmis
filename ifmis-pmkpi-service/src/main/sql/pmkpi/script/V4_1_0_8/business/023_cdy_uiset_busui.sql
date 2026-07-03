begin
  
delete from p#busfw_t_uifunction t where t.key in('/pmkpi/set/uifunctioncols/edit') and t.code in('queryexpdoc');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/set/uifunctioncols/edit', '查看导出模版配置', 1, 2, 'Keepicon', 'pmkpiuiset.queryexpdoc', null, '查看导出模版配置', 'pmkpi', 'queryexpdoc', null, null, null, null);
