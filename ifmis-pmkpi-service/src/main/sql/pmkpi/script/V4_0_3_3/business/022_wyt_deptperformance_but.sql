begin
  --导出按钮注册
delete from p#busfw_t_uifunction where key ='/pmkpi/deptperformance/query/index' and guid ='EF9D2EB142887CCDE0533315A8C04CFB';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, ISEDITCTRL, EDITCTRLMSG)
values ('EF9D2EB142887CCDE0533315A8C04CFB', '/pmkpi/deptperformance/query/index', '导出报告(江西)', 0, 6, 'searchicon', 'Ext.lt.pmkpi.expdoc', null, '导出报告(江西)', 'pmkpi', 'expxls', null, '{tempatecode:''jxbmztmbb''}', null, null);
