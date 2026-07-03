begin
--绩效目标修订审核页面
delete from p#busfw_t_uitabpage where key in('/pmkpi/prorevision/audit');
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('598F5984662BB918E053B11FA8C0831D', 'pmkpi', '/pmkpi/prorevision/audit', '曾经办', 'alldeals', 1, 4, 'nomal', 'prorevisionaudit.clickTabpage', 0, '曾经办', null, '审核,取消审核', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('698F5984662CB918E053B11FA8C0831D', 'pmkpi', '/pmkpi/prorevision/audit', '已审核', 'alreadyaudit', 1, 2, 'nomal', 'prorevisionaudit.clickTabpage', 0, '已审核', null, '审核', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('798F5984662DB918E053B11FA8C0831D', 'pmkpi', '/pmkpi/prorevision/audit', '待审核', 'waitaudit', 1, 1, 'choosed', 'prorevisionaudit.clickTabpage', 0, '待审核', null, '取消审核', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('898F5984662DB918E053B11FA8C0831D', 'pmkpi', '/pmkpi/prorevision/audit', '被退回', 'back', 1, 3, 'nomal', 'prorevisionaudit.clickTabpage', 0, '被退回', null, '取消审核', '{}', null, '0', null, null, null, null, null, null, null);
