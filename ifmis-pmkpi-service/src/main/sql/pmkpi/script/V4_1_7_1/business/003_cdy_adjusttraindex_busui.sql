begin
  
delete from p#busfw_t_uitabpage t where t.key in('/pmkpi/adjust/report/proedit') and t.code='traindex';
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, PROVINCE, YEAR, DEFAULTFILTER, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), 'pmkpi', '/pmkpi/adjust/report/proedit', '细化区域年度绩效', 'traindex', 0, 8, 'nomal', 'tabfreamedit.clickTabpage', null, '转移支付明细指标', null, null, '{url:"/pmkpi/program/adjust/traindex.page",action:"adjtraindex.save"}', null, '0', 'traindexiframe', null, null, null, null, null, '87', '2016', null, null, null);

delete from p#busfw_t_uitabpage t where t.key in('/pmkpi/adjust/protztjedit') and t.code='traindex';
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, PROVINCE, YEAR, DEFAULTFILTER, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), 'pmkpi', '/pmkpi/adjust/protztjedit', '细化区域年度绩效', 'traindex', 0, 8, 'nomal', 'tabfreamedit.clickTabpage', null, '转移支付明细指标', null, null, '{url:"/pmkpi/program/adjust/traindex.page",action:"adjtraindex.save"}', null, '0', 'traindexiframe', null, null, null, null, null, '87', '2016', null, null, null);

delete from p#busfw_t_uifunction t where t.key in('/pmkpi/program/adjust/traindex');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/adjust/traindex', '获取最新调整整体绩效指标', 1, 1, 'searchicon', 'adjtraindex.updaedata', null, '获取最新调整整体绩效指标', 'pmkpi', 'updaedata', null, '{}', '87', '2016', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/adjust/traindex', '导入', 1, 2, 'searchicon', 'adjtraindex.impdata', null, '导入', 'pmkpi', 'impdata', null, '{expfilename:''调整细化区域年度绩效''}', '87', '2016', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/adjust/traindex', '导出', 1, 3, 'searchicon', 'adjtraindex.expdata', null, '导出', 'pmkpi', 'expdata', null, '{expfilename:''调整细化区域年度绩效''}', '87', '2016', null, null);
