begin
  
delete from p#busfw_t_uifunction t where t.key in('/pmkpi/program/trace/manage/prolist') and t.code in('province','unprovince','delprotask');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/trace/manage/prolist', '标记重点', 0, 2, 'searchicon', 'protaskprolist.addtask', null, '标记重点', 'pmkpi', 'province', null, '{btntype:''province''}', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/trace/manage/prolist', '取消标记重点', 0, 3, 'searchicon', 'protaskprolist.deltask', null, '取消标记重点', 'pmkpi', 'unprovince', null, '{btntype:''province''}', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/trace/manage/prolist', '取消任务(仅标记重点模式时使用)', 0, 10, 'searchicon', 'protaskprolist.deltask', null, '取消任务(仅标记重点模式时使用)', 'pmkpi', 'delprotask', null, '{btntype:''deltask''}', null, null);

update p#busfw_t_uifunction t set t.ordernum=10 where t.key='/pmkpi/program/trace/manage/prolist' and t.code='deltask';
update p#busfw_t_uitabpage t set t.hidebtns='取消任务,标记重点,取消标记重点,取消任务(仅标记重点模式时使用)' where t.key in('/pmkpi/program/trace/manage/prolist') and t.code in('waitaudit');

delete from p#busfw_t_uicolumn t where t.key in('/pmkpi/program/trace/manage/prolist') and t.columncode in('PROVINCETASK');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/trace/manage/prolist', 'PROVINCETASK', '重点项目标识', 25, 0, 0, 0, null, 0, 1, null, '#name', null, null, 100, 1, 'tree', '{lefttabtype:''alreadyaudit''}', null, null, null);