begin
  --用户对单位页面添加按钮，默认隐藏
delete from p#busfw_t_uifunction where key ='/pmkpi/setting/uservagency';

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/setting/uservagency', '保存', 1, 1, 'save', 'Ext.lt.uatemplate.save', null, '保存', 'pmkpi', 'save', null, '{}',  null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/setting/uservagency', '同步上年配置', 0, 2, 'copy', 'Ext.lt.uatemplate.copy', null, '同步上年配置', 'pmkpi', 'copy', null, '{}', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/setting/uservagency', '同步', 0, 3, 'copydata', 'Ext.lt.uatemplate.copydata', null, '同步', 'pmkpi', 'copydata', null, '{}', null, null);
