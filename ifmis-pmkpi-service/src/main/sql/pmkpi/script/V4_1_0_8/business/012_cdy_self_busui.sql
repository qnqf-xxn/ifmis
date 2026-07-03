begin
  
delete from p#busfw_t_uifunction t where t.key in('/pmkpi/perfselftaskmanage/index') and t.code in('province','unprovince');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/perfselftaskmanage/index', '标记重点', 0, 4, null, 'perfselfmanage.provincetask', null, '标记重点', 'pmkpi', 'province', null, null, null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/perfselftaskmanage/index', '取消标记重点', 0, 5, 'searchicon', 'perfselfmanage.provincetask', null, '取消标记重点', 'pmkpi', 'unprovince', null, null, null, null);

delete from p#busfw_t_uicolumn t where t.key in('/pmkpi/perfself/taskmanage') and t.columncode in('PROVINCETASK');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/perfself/taskmanage', 'PROVINCETASK', '重点项目标识', 25, 0, 0, 0, null, 0, 1, null, '#name', null, null, 100, 1, 'tree', '{lefttabtype:''program''}', null, null, null);

update p#busfw_t_uitabpage t set t.hidebtns='任务下达,取消下达,标记重点,取消标记重点' where t.key in('/pmkpi/perfself/taskmanage') and t.code in('alldeals');
update p#busfw_t_uitabpage t set t.hidebtns='取消下达,标记重点,取消标记重点' where t.key in('/pmkpi/perfself/taskmanage') and t.code in('waitaudit');
update perf_t_treetab t set t.hidebtns='查看项目,标记重点,取消标记重点' where key in('/pmkpi/perfself/taskmanage') and t.code='program';

delete from p#busfw_t_uicolumn t where t.key in('/pmkpi/perfself/query') and t.columncode in('PROVINCETASK');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/perfself/query', 'PROVINCETASK', '重点项目标识', 25, 0, 0, 0, null, 0, 1, null, '#name', null, null, 100, 1, 'tree', '{lefttabtype:''program''}', null, null, null);

update p#busfw_t_uicolumn t set t.columncode='ARRANGERCREATER' where t.key='/pmkpi/perfself/taskmanage' and t.columncode='CREATER';

update p#busfw_t_uitable t set t.tablecode='V_PERF_T_SELFEVALTASK' where t.key in('/pmkpi/perfself/taskmanage');