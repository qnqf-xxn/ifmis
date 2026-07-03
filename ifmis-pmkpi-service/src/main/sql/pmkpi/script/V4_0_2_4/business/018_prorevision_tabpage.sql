begin
delete from p#busfw_t_uitabpage where key ='/pmkpi/prorevision/report';
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D8C19C25C4B432BBE0533315A8C00BE2', 'pmkpi', '/pmkpi/prorevision/report', '曾经办', 'alldeals', 1, 4, 'nomal', 'revisionreport.clickTabpage', 1, '曾经办', null, '修订,送审,取消送审,删除项目,选择项目', '{}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D8C19C25C4B532BBE0533315A8C00BE2', 'pmkpi', '/pmkpi/prorevision/report', '已送审', 'alreadyaudit', 1, 2, 'nomal', 'revisionreport.clickTabpage', 1, '已送审', null, '修订,送审,删除项目,选择项目', '{}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D8C19C25C4B632BBE0533315A8C00BE2', 'pmkpi', '/pmkpi/prorevision/report', '未送审', 'waitaudit', 1, 1, 'choosed', 'revisionreport.clickTabpage', 1, '未送审', null, '取消送审', '{}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D8C19C25C4B732BBE0533315A8C00BE2', 'pmkpi', '/pmkpi/prorevision/report', '被退回', 'back', 1, 3, 'nomal', 'revisionreport.clickTabpage', 1, '被退回', null, '取消送审,选择项目', '{}', null, '0', null, null, null, null, null, null, null);

