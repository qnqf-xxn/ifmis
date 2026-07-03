begin
  
delete from p#busfw_t_uifunction where key = '/pmkpi/indexlib/deptlist' and code = 'delpro';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/indexlib/deptlist', '删除项目', 0, 11, 'searchicon', 'indexlib.delpro', null, '删除项目', 'pmkpi', 'delpro', null, '{}', null, null);
