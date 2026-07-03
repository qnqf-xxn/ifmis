begin
  
delete from p#busfw_t_uifunction t where t.key in('/pmkpi/yearprogram/query/list','/pmkpi/deptperformance/query/index') and code in('nxexp') and province='87' and year='2016';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/deptperformance/query/index', '导出目标表（宁夏）', 0, 8, 'searchicon', 'Ext.lt.pmkpi.expdoc', null, '导出目标表（宁夏）', 'pmkpi', 'nxexp', null, '{tempatecode:''nxbmjxmbsbb''}', '87', '2016', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/yearprogram/query/list', '导出目标表（宁夏）', 0, 8, 'searchicon', 'Ext.lt.pmkpi.expdoc', null, '导出目标表（宁夏）', 'pmkpi', 'nxexp', null, '{tempatecode:''nxxmjxmbsbb''}', '87', '2016', null, null);
