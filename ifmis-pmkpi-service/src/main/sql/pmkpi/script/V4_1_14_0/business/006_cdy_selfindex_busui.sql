begin
  
delete from p#busfw_t_uifunction t where t.key in('/pmkpi/perfself/apply/edit/selfindex') and code in('impdata');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/perfself/apply/edit/selfindex', '导入', 0, 9, 'searchicon', 'selfindex.impdata', null, '导入', 'pmkpi', 'impdata', null, '{program:''selfprogram'',dept:''selfdept'',programexpname:''项目支出绩效自评指标完成情况导入模板@sysdate@.xls'',deptexpname:''部门整体绩效自评指标完成情况导入模板@sysdate@.xls''}', '87', '2016', null, null);