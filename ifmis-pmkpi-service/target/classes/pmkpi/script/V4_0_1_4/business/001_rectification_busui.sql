begin
--监控整改情况编制01
--SELECT global_multyear_cz.Secu_f_GLOBAL_SetPARM('','340000000','2021','') FROM dual; 
--整改通知-项目支出-监控整改情况编制，待送审增加【取消下达】
--将页签改为待下达，已下达和曾经办。
--1.按钮注册
delete from p#busfw_t_uifunction where key  ='/pmkpi/rectification/index' and guid = '00F7DF1F9B604C88ABDBFC20277BEE58';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('00F7DF1F9B604C88ABDBFC20277BEE58', '/pmkpi/rectification/index', '取消下达', 1, 10, 'addaction', 'rectification.wfAudit', null, '取消下达', 'pmkpi', 'cancelsendaudit', null, null);

--2.页签注册
delete from p#busfw_t_uitabpage t where  key ='/pmkpi/rectification/index' and guid in('6C0FFE236BBB497009F7FEEAEFB1FC68','D3B88EFE90560B0E6E2E5E185E68BA02','1AA395D7674CFE0CD1D394DD7A6BAFD4');
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('6C0FFE236BBB497009F7FEEAEFB1FC68', 'pmkpi', '/pmkpi/rectification/index', '已下达', 'alreadyaudit', 1, 2, 'nomal', 'rectification.clickTabpage', 0, '显示已处理', null, '选择项目,删除,起草/修改,下达', '{}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D3B88EFE90560B0E6E2E5E185E68BA02', 'pmkpi', '/pmkpi/rectification/index', '待下达', 'waitaudit', 1, 1, 'choosed', 'rectification.clickTabpage', 0, '显示未处理', null, '取消下达', '{}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('1AA395D7674CFE0CD1D394DD7A6BAFD4', 'pmkpi', '/pmkpi/rectification/index', '曾经办', 'alldeals', 1, 3, 'nomal', 'rectification.clickTabpage', 0, '显示已处理', null, '选择项目,删除,起草/修改,下达,取消下达', '{}', null, '0', null, null, null, null, null, null, null);
