begin
  
delete from p#busfw_t_uifunction where key = '/pmkpi/randomcomment/object/index' and code = 'import';

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/randomcomment/object/index', '导入抽评对象', 1, 8, 'searchicon', 'randomcommentobject.import', null, '导入抽评对象', 'pmkpi', 'import', null, '{}', '87', '2016', null, null);
