begin
  
delete from p#busfw_t_uifunction t where t.key in('/pmkpi/perfset/component') and code in('clearsave');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, ISEDITCTRL, EDITCTRLMSG)
values ('F997C782A71E242FE0533315A8C015D0', '/pmkpi/perfset/component', '清除组件配置', 1, 4, null, 'Ext.lt.drtemplate.clearsave', null, '清除组件配置', 'pmkpi', 'clearsave', null, null, null, null);

update p#busfw_t_uicolumn t set t.columncode='COLNAME' where t.key in('/pmkpi/perfset/component') and t.columncode='NAME';
