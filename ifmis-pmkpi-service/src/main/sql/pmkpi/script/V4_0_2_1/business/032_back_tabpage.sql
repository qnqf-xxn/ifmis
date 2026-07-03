begin
--整改通知编制、审核
delete from p#busfw_t_uitabpage where key in('/pmkpi/rectification/index','/pmkpi/rectification/audit/index');
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('2AA395D7674CFE0CD1D394DD7A6BAFD4', 'pmkpi', '/pmkpi/rectification/audit/index', '被退回', 'back', 1, 3, 'nomal', 'rectificationaudit.clickTabpage', null, '被退回', null, '退回', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BAF217043BF56952789CB44851073CE6', 'pmkpi', '/pmkpi/rectification/audit/index', '曾经办', 'alldeals', 1, 4, 'nomal', 'rectificationaudit.clickTabpage', null, '曾经办', null, '下发,退回', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('1A0D3885BCE074CFD57E0DD729A1B3FC', 'pmkpi', '/pmkpi/rectification/audit/index', '已审核', 'alreadyaudit', 1, 2, 'nomal', 'rectificationaudit.clickTabpage', null, '已审核', 'WFSTATUS <>''011''', '下发,退回', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('E0E2E3D020AD1A6262A16EAF27480697', 'pmkpi', '/pmkpi/rectification/audit/index', '待审核', 'waitaudit', 1, 1, 'choosed', 'rectificationaudit.clickTabpage', null, '待审核', null, '', '{}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('6C0FFE236BBB497009F7FEEAEFB1FC68', 'pmkpi', '/pmkpi/rectification/index', '已下达', 'alreadyaudit', 1, 2, 'nomal', 'rectification.clickTabpage', 0, '显示已处理', 'WFSTATUS <>''011''', '选择项目,删除,起草/修改,下达', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D3B88EFE90560B0E6E2E5E185E68BA02', 'pmkpi', '/pmkpi/rectification/index', '待下达', 'waitaudit', 1, 1, 'choosed', 'rectification.clickTabpage', 0, '显示未处理', null, '取消下达', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('1AA395D7674CFE0CD1D394DD7A6BAFD4', 'pmkpi', '/pmkpi/rectification/index', '曾经办', 'alldeals', 1, 4, 'nomal', 'rectification.clickTabpage', 0, '显示已处理', null, '选择项目,删除,起草/修改,下达,取消下达', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('2AA395D7674CFE0CD1D394DD7A6BAFD0', 'pmkpi', '/pmkpi/rectification/index', '被退回', 'back', 1, 3, 'nomal', 'rectification.clickTabpage', 0, '显示已处理', null, '选择项目,取消下达', '{}', null, '0', null, null, null, null, null, null, null);


--整改情况反馈填报、审核
delete from p#busfw_t_uitabpage where key in('/pmkpi/rectification/feedback/index','/pmkpi/rectification/feedback/audit/index');
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('B71F832B8AEC03B0E0530100007FA9FF', 'pmkpi', '/pmkpi/rectification/feedback/index', '被退回', 'back', 1, 3, 'nomal', 'feedback.clickTabpage', null, '被退回', null, '取消送审', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('26333A6799CF2C38E7F7F1CF604745F4', 'pmkpi', '/pmkpi/rectification/feedback/index', '待送审', 'waitaudit', 1, 1, 'choosed', 'feedback.clickTabpage', null, '待送审', null, '取消送审', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('0DF6CC35CCFE3C543DACA385CD25B26A', 'pmkpi', '/pmkpi/rectification/feedback/index', '已送审', 'alreadyaudit', 1, 2, 'nomal', 'feedback.clickTabpage', null, '已送审', 'WFSTATUS <>''011''', '填报/修改,送审', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('6F2CFA4806E89730F9E5CD61E9278C36', 'pmkpi', '/pmkpi/rectification/feedback/index', '曾经办', 'alldeals', 1, 4, 'nomal', 'feedback.clickTabpage', null, '曾经办', null, '填报/修改,送审,取消送审', '{}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('B71F832B8AEC03B0E0530100007FA0FF', 'pmkpi', '/pmkpi/rectification/feedback/audit/index', '被退回', 'back', 1, 3, 'nomal', 'feedbackAudit.clickTabpage', null, '被退回', null, '取消审核,审核信息', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('A29C4F477B69E77F09501150DC5D3618', 'pmkpi', '/pmkpi/rectification/feedback/audit/index', '待审核', 'waitaudit', 1, 1, 'choosed', 'feedbackAudit.clickTabpage', null, '待审核', null, '取消审核,审核信息', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('916576D530E9FC995D911162E28F4C2B', 'pmkpi', '/pmkpi/rectification/feedback/audit/index', '已审核', 'alreadyaudit', 1, 2, 'nomal', 'feedbackAudit.clickTabpage', null, '已审核', null, '审核,审核信息', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('06AB75D352DAFA8B47CBFA7F26DDD757', 'pmkpi', '/pmkpi/rectification/feedback/audit/index', '曾经办', 'alldeals', 1, 4, 'nomal', 'feedbackAudit.clickTabpage', null, '曾经办', null, '审核,取消审核,审核信息', '{}', null, '0', null, null, null, null, null, null, null);


--监控填报、审核
delete from p#busfw_t_uitabpage where key in('/pmkpi/program/trace/report','/pmkpi/program/trace/audit');
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('071F832B8AE903B0E0530100007FA9FF', 'pmkpi', '/pmkpi/program/trace/report', '已送审', 'alreadyaudit', 1, 2, 'nomal', 'protaskreport.clickTabpage', null, '已送审', null, '填报/修改,删除,送审', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('171F832B8AEA03B0E0530100007FA9FF', 'pmkpi', '/pmkpi/program/trace/report', '待送审', 'waitaudit', 1, 1, 'choosed', 'protaskreport.clickTabpage', null, '待送审', null, '取消送审', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('271F832B8AEB03B0E0530100007FA9FF', 'pmkpi', '/pmkpi/program/trace/report', '曾经办', 'alldeals', 1, 4, 'nomal', 'protaskreport.clickTabpage', null, '曾经办', null, '填报/修改,删除,送审,取消送审', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('371F832B8AEC03B0E0530100007FA9FF', 'pmkpi', '/pmkpi/program/trace/report', '被退回', 'back', 1, 3, 'nomal', 'protaskreport.clickTabpage', null, '被退回', null, '取消送审', '{}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('67A11C351FA349CBE0530100007F4B66', 'pmkpi', '/pmkpi/program/trace/audit', '待审核', 'waitaudit', 1, 1, 'choosed', 'protraceaudit.clickTabpage', null, '待审核', null, '取消审核', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('87A11C351FA449CBE0530100007F4B66', 'pmkpi', '/pmkpi/program/trace/audit', '已审核', 'alreadyaudit', 1, 2, 'nomal', 'protraceaudit.clickTabpage', null, '已审核', null, '审核', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('07A11C351FA549CBE0530100007F4B66', 'pmkpi', '/pmkpi/program/trace/audit', '曾经办', 'alldeals', 1, 4, 'nomal', 'protraceaudit.clickTabpage', null, '曾经办', null, '审核,取消审核', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('97A11C351FA649CBE0530100007F4B66', 'pmkpi', '/pmkpi/program/trace/audit', '被退回', 'back', 1, 3, 'nomal', 'protraceaudit.clickTabpage', null, '被退回', null, '取消审核', '{}', null, '0', null, null, null, null, null, null, null);




--年中追加填报、审核
delete from p#busfw_t_uitabpage where key in('/pmkpi/midprogram/report/list','/pmkpi/midprogram/report/audit');
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('midprogram/report/list/tabpage03', 'pmkpi', '/pmkpi/midprogram/report/list', '曾经办', 'alldeals', 1, 4, 'nomal', 'pmkpimidreport.clickTabpage', 0, '曾经办', null, '选择项目,删除,送审,新增,修改,取消送审', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('midprogram/report/list/tabpage02', 'pmkpi', '/pmkpi/midprogram/report/list', '已送审', 'alreadyaudit', 1, 2, 'nomal', 'pmkpimidreport.clickTabpage', 0, '已送审', null, '选择项目,删除,送审,新增,修改', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('midprogram/report/list/tabpage01', 'pmkpi', '/pmkpi/midprogram/report/list', '未送审', 'waitaudit', 1, 1, 'choosed', 'pmkpimidreport.clickTabpage', 0, '未送审', null, '取消送审', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('midprogram/report/list/tabpage04', 'pmkpi', '/pmkpi/midprogram/report/list', '被退回', 'back', 1, 3, 'nomal', 'pmkpimidreport.clickTabpage', 0, '被退回', null, '选择项目,新增,取消送审', '{}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('6DF3B890674041POO0D99664D59EAAE2', 'pmkpi', '/pmkpi/midprogram/report/audit', '被退回', 'back', 1, 3, 'nomal', 'midprogramaudit.clickTabpage', null, '被退回', null, '取消审核,审核信息', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('E339E58352B644APA711A4B4BPO4380', 'pmkpi', '/pmkpi/midprogram/report/audit', '待审核', 'waitaudit', 1, 1, 'choosed', 'midprogramaudit.clickTabpage', null, '待审核', null, '取消审核,审核信息', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('6F55700063D44580PLL38EC1D7069D77', 'pmkpi', '/pmkpi/midprogram/report/audit', '已审核', 'alreadyaudit', 1, 2, 'nomal', 'midprogramaudit.clickTabpage', null, '已审核', null, '审核', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('6DF3B890674042POO0D99664D29EAA02', 'pmkpi', '/pmkpi/midprogram/report/audit', '曾经办', 'alldeals', 1, 4, 'nomal', 'midprogramaudit.clickTabpage', null, '曾经办', null, '审核,取消审核', '{}', null, '0', null, null, null, null, null, null, null);



--项目绩效目标申报、审核
delete from p#busfw_t_uitabpage where key in('/pmkpi/program/report/list','/pmkpi/program/report/audit');
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('program/report/list/uitabpage04', 'pmkpi', '/pmkpi/program/report/list', '被退回', 'back', 1, 3, 'nomal', 'pmkpitlproreport.clickTabpage', null, '被退回', null, '选择项目,新增,取消送审', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('program/report/list/uitabpage03', 'pmkpi', '/pmkpi/program/report/list', '曾经办', 'alldeals', 1, 4, 'nomal', 'pmkpitlproreport.clickTabpage', 0, '曾经办', null, '选择项目,删除,送审,新增,修改,取消送审', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('program/report/list/uitabpage02', 'pmkpi', '/pmkpi/program/report/list', '已送审', 'alreadyaudit', 1, 2, 'nomal', 'pmkpitlproreport.clickTabpage', 0, '已送审', null, '选择项目,删除,送审,新增,修改', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('program/report/list/uitabpage01', 'pmkpi', '/pmkpi/program/report/list', '未送审', 'waitaudit', 1, 1, 'choosed', 'pmkpitlproreport.clickTabpage', 0, '未送审', null, '取消送审', '{}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('6DF3B8906740429A90D99664D29EAAE1', 'pmkpi', '/pmkpi/program/report/audit', '被退回', 'back', 1, 3, 'nomal', 'tlprogramaudit.clickTabpage', null, '被退回', null, '取消审核,审核信息', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('E339E58352B644A8A711A4B4B5F743D0', 'pmkpi', '/pmkpi/program/report/audit', '待审核', 'waitaudit', 1, 1, 'choosed', 'tlprogramaudit.clickTabpage', null, '待审核', null, '取消审核,审核信息', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('6F55700063D445809C438EC1D7069D37', 'pmkpi', '/pmkpi/program/report/audit', '已审核', 'alreadyaudit', 1, 2, 'nomal', 'tlprogramaudit.clickTabpage', null, '已审核', null, '审核', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('6DF3B8906740429A90D99664D29EAAE2', 'pmkpi', '/pmkpi/program/report/audit', '曾经办', 'alldeals', 1, 4, 'nomal', 'tlprogramaudit.clickTabpage', null, '曾经办', null, '审核,取消审核', '{}', null, '0', null, null, null, null, null, null, null);



--部门评价项目申报、审核
delete from p#busfw_t_uitabpage where key in('/pmkpi/evaluation/dept/report','/pmkpi/evaluation/dept/audit');
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('PP25F32C9EBD77B9E053B11FA8C04010', 'pmkpi', '/pmkpi/evaluation/dept/report', '已确认', 'alreadyaudit', 1, 2, 'nomal', 'deptproconfirm.clickTabpage', 0, '已确认', null, '送审,选择项目,删除项目', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('PP25F32C9EBE77B9E053B11FA8C04000', 'pmkpi', '/pmkpi/evaluation/dept/report', '曾经办', 'allconfirm', 1, 4, 'nomal', 'deptproconfirm.clickTabpage', 0, '曾经办', null, '送审,取消提交,选择项目,删除项目', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('PP25F32C9EBC77B9E053B11FA8C04100', 'pmkpi', '/pmkpi/evaluation/dept/report', '待确认', 'waitaudit', 1, 1, 'choosed', 'deptproconfirm.clickTabpage', 0, '待确认', null, '取消送审', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('PP26F32C9EBC77B9E053B11FA8C041F0', 'pmkpi', '/pmkpi/evaluation/dept/report', '被退回', 'back', 1, 3, 'nomal', 'deptproconfirm.clickTabpage', 0, '被退回', null, '选择项目,取消送审', '{}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('PPPB52A3C9BE2407E053B11FA8C01738', 'pmkpi', '/pmkpi/evaluation/dept/audit', '待审核', 'waitaudit', 1, 1, 'choosed', 'deptaudit.clickTabpage', 0, '待审核', null, '取消审核', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('PPPB52A3C9BF2407E053B11FA8C01737', 'pmkpi', '/pmkpi/evaluation/dept/audit', '已审核', 'alreadyaudit', 1, 2, 'nomal', 'deptaudit.clickTabpage', 0, '已审核', null, '审核,退回', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('PPPB52A3C9C02407E053B11FA8C01736', 'pmkpi', '/pmkpi/evaluation/dept/audit', '曾经办', 'allconfirm', 1, 4, 'nomal', 'deptaudit.clickTabpage', 0, '曾经办', null, '审核,取消审核,退回', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('PPPB52A3C9BE2407E053B11FA8C01005', 'pmkpi', '/pmkpi/evaluation/dept/audit', '被退回', 'back', 1, 3, 'nomal', 'deptaudit.clickTabpage', 0, '被退回', null, '取消审核', '{}', null, '0', null, null, null, null, null, null, null);


--部门评价成果申报、审核
delete from p#busfw_t_uitabpage where key in('/pmkpi/evaluation/dept/result','/pmkpi/evaluation/dept/resultaudit');
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('PPP3D19B02702359E053B11FA8C0BCA4', 'pmkpi', '/pmkpi/evaluation/dept/result', '待提交', 'waitaudit', 1, 1, 'choosed', 'deptevaluationresult.clickTabpage', 0, '待提交', null, '取消送审', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('PPP3D19B02712359E053B11FA8C0BCA3', 'pmkpi', '/pmkpi/evaluation/dept/result', '已提交', 'alreadyaudit', 1, 2, 'nomal', 'deptevaluationresult.clickTabpage', 0, '已提交', null, '评价成果上传,送审', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('PPP3D19B02722359E053B11FA8C0BCA1', 'pmkpi', '/pmkpi/evaluation/dept/result', '曾经办', 'allconfirm', 1, 4, 'nomal', 'deptevaluationresult.clickTabpage', 0, '曾经办', null, '评价成果上传,送审,取消送审', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('PPP3D19B02702359E053B11FA8C0BC12', 'pmkpi', '/pmkpi/evaluation/dept/result', '被退回', 'back', 1, 3, 'nomal', 'deptevaluationresult.clickTabpage', 0, '被退回', null, '取消送审', '{}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BD53D19B03142359E053B11FA8C0B00p', 'pmkpi', '/pmkpi/evaluation/dept/resultaudit', '待审核', 'waitaudit', 1, 1, 'choosed', 'deptevaluationresult.clickTabpage', 0, '待审核', null, '取消审核', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BD53D19B03152359E053B11FA8C0BpKK', 'pmkpi', '/pmkpi/evaluation/dept/resultaudit', '已审核', 'alreadyaudit', 1, 2, 'nomal', 'deptevaluationresult.clickTabpage', 0, '已审核', null, '审核,退回', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BD53D19B03162359E053B11FA8C0BppP', 'pmkpi', '/pmkpi/evaluation/dept/resultaudit', '曾经办', 'allconfirm', 1, 4, 'nomal', 'deptevaluationresult.clickTabpage', 0, '曾经办', null, '审核,取消审核,退回', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BD53D19B03142359E053B11FA8C0BPPO', 'pmkpi', '/pmkpi/evaluation/dept/resultaudit', '被退回', 'back', 1, 3, 'nomal', 'deptevaluationresult.clickTabpage', 0, '被退回', null, '取消审核', '{}', null, '0', null, null, null, null, null, null, null);



--财政评价项目确定、审核
delete from p#busfw_t_uitabpage where key in('/pmkpi/evaluation/financial/proconfirm','/pmkpi/evaluation/financial/audit');
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BD25F32C9EBC77B9E053B11FA8C041F8', 'pmkpi', '/pmkpi/evaluation/financial/proconfirm', '被退回', 'back', 1, 3, 'nomal', 'finproconfirm.clickTabpage', 0, '被退回', null, '选择项目,新增项目,取消提交', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BD25F32C9EBC77B9E053B11FA8C041F7', 'pmkpi', '/pmkpi/evaluation/financial/proconfirm', '待确认', 'waitaudit', 1, 1, 'choosed', 'finproconfirm.clickTabpage', 0, '待确认', null, '取消提交', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BD25F32C9EBD77B9E053B11FA8C041F6', 'pmkpi', '/pmkpi/evaluation/financial/proconfirm', '已确认', 'alreadyaudit', 1, 2, 'nomal', 'finproconfirm.clickTabpage', 0, '已确认', null, '提交,选择项目,新增项目,修改项目,删除项目', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BD25F32C9EBE77B9E053B11FA8C041F0', 'pmkpi', '/pmkpi/evaluation/financial/proconfirm', '曾经办', 'allconfirm', 1, 4, 'nomal', 'finproconfirm.clickTabpage', 0, '曾经办', null, '提交,取消提交,选择项目,新增项目,修改项目,删除项目', '{}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BD3B52A3C9BE2407E053B11FA8C01731', 'pmkpi', '/pmkpi/evaluation/financial/audit', '被退回', 'back', 1, 3, 'nomal', 'finevalaudit.clickTabpage', 0, '被退回', null, '取消审核', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BD3B52A3C9BE2407E053B11FA8C01732', 'pmkpi', '/pmkpi/evaluation/financial/audit', '待审核', 'waitaudit', 1, 1, 'choosed', 'finevalaudit.clickTabpage', 0, '待审核', null, '取消审核', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BD3B52A3C9BF2407E053B11FA8C01733', 'pmkpi', '/pmkpi/evaluation/financial/audit', '已审核', 'alreadyaudit', 1, 2, 'nomal', 'finevalaudit.clickTabpage', 0, '已审核', null, '审核,指派中介,指派专家', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BD3B52A3C9C02407E053B11FA8C01734', 'pmkpi', '/pmkpi/evaluation/financial/audit', '曾经办', 'allconfirm', 1, 4, 'nomal', 'finevalaudit.clickTabpage', 0, '曾经办', null, '审核,取消审核,指派中介,指派专家', '{}', null, '0', null, null, null, null, null, null, null);


--财政评价成果上传、审核
delete from p#busfw_t_uitabpage where key in('/pmkpi/evaluation/financial/resultupload','/pmkpi/evaluation/financial/resultaudit');
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('6D53D19B02702359E053B11FA8C0BCA2', 'pmkpi', '/pmkpi/evaluation/financial/resultupload', '被退回', 'back', 1, 3, 'nomal', 'finevaluationresult.clickTabpage', 0, '被退回', null, '取消提交', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('5D53D19B02702359E053B11FA8C0BCA2', 'pmkpi', '/pmkpi/evaluation/financial/resultupload', '待提交', 'waitaudit', 1, 1, 'choosed', 'finevaluationresult.clickTabpage', 0, '待提交', null, '取消提交', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('4D53D19B02712359E053B11FA8C0BCA2', 'pmkpi', '/pmkpi/evaluation/financial/resultupload', '已提交', 'alreadyaudit', 1, 2, 'nomal', 'finevaluationresult.clickTabpage', 0, '已提交', null, '上传成果,提交', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('3D53D19B02722359E053B11FA8C0BCA2', 'pmkpi', '/pmkpi/evaluation/financial/resultupload', '曾经办', 'allconfirm', 1, 4, 'nomal', 'finevaluationresult.clickTabpage', 0, '曾经办', null, '上传成果,提交,取消提交', '{}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('0D53D19B03142359E053B11FA8C0BCA0', 'pmkpi', '/pmkpi/evaluation/financial/resultaudit', '被退回', 'back', 1, 3, 'nomal', 'finevaluationresult.clickTabpage', 0, '被退回', null, '取消审核,下达整改通知', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('9D53D19B03142359E053B11FA8C0BCA2', 'pmkpi', '/pmkpi/evaluation/financial/resultaudit', '待审核', 'waitaudit', 1, 1, 'choosed', 'finevaluationresult.clickTabpage', 0, '待审核', null, '取消审核,下达整改通知', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('8D53D19B03152359E053B11FA8C0BCA2', 'pmkpi', '/pmkpi/evaluation/financial/resultaudit', '已审核', 'alreadyaudit', 1, 2, 'nomal', 'finevaluationresult.clickTabpage', 0, '已审核', null, '审核,评价成果修改', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('7D53D19B03162359E053B11FA8C0BCA2', 'pmkpi', '/pmkpi/evaluation/financial/resultaudit', '曾经办', 'allconfirm', 1, 4, 'nomal', 'finevaluationresult.clickTabpage', 0, '曾经办', null, '审核,取消审核,评价成果修改,下达整改通知', '{}', null, '0', null, null, null, null, null, null, null);



--部门申报填报、审核
delete from p#busfw_t_uitabpage where key in('/pmkpi/deptperformance/report/index','/pmkpi/deptperformance/audit/index');
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('82C6CD4B7B79451A87DC622477C5C435', 'pmkpi', '/pmkpi/deptperformance/report/index', '被退回', 'back', 1, 3, 'nomal', 'tabfreamlist.clickTabpage', 1, '被退回', null, '取消送审', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('2B2B30B02D93405EBEFBAF9CEE879E47', 'pmkpi', '/pmkpi/deptperformance/report/index', '已送审', 'alreadyaudit', 1, 2, 'nomal', 'tabfreamlist.clickTabpage', 1, '已送审', null, '填报/修改,删除,送审', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('CB4B8BC284E545E281404F19A9BD1335', 'pmkpi', '/pmkpi/deptperformance/report/index', '曾经办', 'alldeals', 1, 4, 'nomal', 'tabfreamlist.clickTabpage', 1, '曾经办', null, '填报/修改,删除,送审,取消送审', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('02C6CD4B7B79451A87DC622477C5C435', 'pmkpi', '/pmkpi/deptperformance/report/index', '待送审', 'waitaudit', 1, 1, 'choosed', 'tabfreamlist.clickTabpage', 1, '待送审', null, '取消送审', '{}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('ab7720915e55c73f4ba720caab5d5ab6', 'pmkpi', '/pmkpi/deptperformance/audit/index', '被退回', 'back', 1, 3, 'nomal', 'deptperformanceaudit.clickTabpage', null, '被退回', null, '取消审核,审核信息', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('a59e8259527ead79e03b6e5d10689458', 'pmkpi', '/pmkpi/deptperformance/audit/index', '曾经办', 'alldeals', 1, 4, 'nomal', 'deptperformanceaudit.clickTabpage', null, '曾经办', null, '审核,取消审核，修改', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('ba87cd283f74364537db556a2923b794', 'pmkpi', '/pmkpi/deptperformance/audit/index', '已审核', 'alreadyaudit', 1, 2, 'nomal', 'deptperformanceaudit.clickTabpage', null, '已审核', null, '审核,修改', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('cb7720915e55c73f4ba720caab5d5ab6', 'pmkpi', '/pmkpi/deptperformance/audit/index', '待审核', 'waitaudit', 1, 1, 'choosed', 'deptperformanceaudit.clickTabpage', null, '待审核', null, '取消审核,审核信息', '{}', null, '0', null, null, null, null, null, null, null);



--绩效自评填报、审核
delete from p#busfw_t_uitabpage where key in('/pmkpi/perfself/apply','/pmkpi/perfself/audit');
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('17C15713129F464FE0533315A8C0A90F', 'pmkpi', '/pmkpi/perfself/apply', '被退回', 'back', 1, 3, 'nomal', 'perfselfapply.clickTabpage', null, '被退回', null, '取消送审', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('37C15713129D464FE0533315A8C0A90F', 'pmkpi', '/pmkpi/perfself/apply', '已送审', 'alreadyaudit', 1, 2, 'nomal', 'perfselfapply.clickTabpage', null, '已送审', null, '填报/修改,删除,送审', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('57C15713129E464FE0533315A8C0A90F', 'pmkpi', '/pmkpi/perfself/apply', '曾经办', 'alldeals', 1, 4, 'nomal', 'perfselfapply.clickTabpage', null, '曾经办', null, '填报/修改,删除,送审,取消送审', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('77C15713129F464FE0533315A8C0A90F', 'pmkpi', '/pmkpi/perfself/apply', '未送审', 'waitaudit', 1, 1, 'choosed', 'perfselfapply.clickTabpage', null, '未送审', null, '取消送审', '{}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('30F28592F09140409A956B692C8AA06B', 'pmkpi', '/pmkpi/perfself/audit', '被退回', 'back', 1, 3, 'nomal', 'perfselfaudit.clickTabpage', null, '被退回', null, '取消审核,审核信息', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('A413F308AE8B4BA097F39E769E2143C9', 'pmkpi', '/pmkpi/perfself/audit', '已审核', 'alreadyaudit', 1, 2, 'nomal', 'perfselfaudit.clickTabpage', null, '已审核', null, '审核', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('2FC387D05EF04635BE5FE816DC091BA6', 'pmkpi', '/pmkpi/perfself/audit', '曾经办', 'alldeals', 1, 4, 'nomal', 'perfselfaudit.clickTabpage', null, '曾经办', null, '审核,取消审核', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('A0F28592F09140409A956B692C8AA060', 'pmkpi', '/pmkpi/perfself/audit', '待审核', 'waitaudit', 1, 1, 'choosed', 'perfselfaudit.clickTabpage', null, '待审核', null, '取消审核,审核信息', '{}', null, '0', null, null, null, null, null, null, null);



--部门综合评价填报、审核
delete from p#busfw_t_uitabpage where key in('/pmkpi/deptoverallmerit/report/index','/pmkpi/deptoverallmerit/audit/index');
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('DBDA3DBBA5B24DA0B3F8BEC3880D4287', 'pmkpi', '/pmkpi/deptoverallmerit/report/index', '已送审', 'alreadyaudit', 1, 2, 'nomal', 'deptoverallmeritreport.clickTabpage', null, '已送审', 'REPORTSTATUS in (''1'',''2'')', '填报/修改,删除,送审', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('DA179799E955498B8564F5D994029D06', 'pmkpi', '/pmkpi/deptoverallmerit/report/index', '曾经办', 'alldeals', 0, 4, 'nomal', 'deptoverallmeritreport.clickTabpage', null, '曾经办', null, '填报/修改,删除,送审,取消送审', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('DE5AB9438DA14BFE9F8085624AED19A5', 'pmkpi', '/pmkpi/deptoverallmerit/report/index', '未送审', 'waitaudit', 1, 1, 'choosed', 'deptoverallmeritreport.clickTabpage', null, '未送审', 'REPORTSTATUS=''0''', '取消送审', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('DE5AB9430DA14BFE9F8085624AED19A4', 'pmkpi', '/pmkpi/deptoverallmerit/report/index', '被退回', 'back', 1, 3, 'nomal', 'deptoverallmeritreport.clickTabpage', null, '被退回', null, '取消送审', '{}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('DR5AB9438DA14BFE9F8085624AED19A0', 'pmkpi', '/pmkpi/deptoverallmerit/audit/index', '被退回', 'back', 1, 3, 'nomal', 'deptoverallmeritreport.clickTabpage', null, '被退回', null, '取消提交', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('DE179799E955498B8564F5D994029D03', 'pmkpi', '/pmkpi/deptoverallmerit/audit/index', '曾经办', 'alldeals', 1, 4, 'nomal', 'deptoverallmeritreport.clickTabpage', null, '曾经办', null, '填报/修改,提交,取消提交', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('DR5AB9438DA14BFE9F8085624AED19A2', 'pmkpi', '/pmkpi/deptoverallmerit/audit/index', '未送审', 'waitaudit', 1, 1, 'choosed', 'deptoverallmeritreport.clickTabpage', null, '未送审', 'REPORTSTATUS=''1''', '取消提交', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('DTDA3DBBA5B24DA0B3F8BEC3880D4281', 'pmkpi', '/pmkpi/deptoverallmerit/audit/index', '已送审', 'alreadyaudit', 1, 2, 'nomal', 'deptoverallmeritreport.clickTabpage', null, '已送审', 'REPORTSTATUS=''2''', '填报/修改,提交', '{}', null, '0', null, null, null, null, null, null, null);



--省、市级工作管理考核申报、审核
delete from p#busfw_t_uitabpage where key in('/pmkpi/workevaluate/report/list','/pmkpi/workevaluate/audit/list');
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('C3372D3FF1945B5CE053B11FA8C07208', 'pmkpi', '/pmkpi/workevaluate/report/list', '已送审', 'alreadyaudit', 1, 2, 'nomal', 'workevalreport.clickTabpage', null, '已送审', null, '填报/修改,送审', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('C3372D3FF1955B5CE053B11FA8C07207', 'pmkpi', '/pmkpi/workevaluate/report/list', '待送审', 'waitaudit', 1, 1, 'choosed', 'workevalreport.clickTabpage', null, '待送审', null, '取消送审', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('C3372D3FF1965B5CE053B11FA8C07206', 'pmkpi', '/pmkpi/workevaluate/report/list', '曾经办', 'alldeals', 1, 4, 'nomal', 'workevalreport.clickTabpage', null, '曾经办', null, '填报/修改,送审,取消送审', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('C3372D3FF1965B5CE053B11FA8C07205', 'pmkpi', '/pmkpi/workevaluate/report/list', '被退回', 'back', 1, 3, 'nomal', 'workevalreport.clickTabpage', null, '被退回', null, '取消送审', '{}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('C37063D848185B21E053B11FA8C06DF1', 'pmkpi', '/pmkpi/workevaluate/audit/list', '待审核', 'waitaudit', 1, 1, 'choosed', 'workevalaudit.clickTabpage', 0, '已审核', null, '取消审核', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('C37063D848175B21E053B11FA8C06DF2', 'pmkpi', '/pmkpi/workevaluate/audit/list', '已审核', 'alreadyaudit', 1, 2, 'nomal', 'workevalaudit.clickTabpage', 0, '已审核', null, '审核', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('C37063D848165B21E053B11FA8C06DF3', 'pmkpi', '/pmkpi/workevaluate/audit/list', '曾经办', 'alldeals', 1, 4, 'nomal', 'workevalaudit.clickTabpage', 0, '曾经办', null, '审核,取消审核', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('C37063D848165B21E053B11FA8C06DF4', 'pmkpi', '/pmkpi/workevaluate/audit/list', '被退回', 'back', 1, 3, 'nomal', 'workevalaudit.clickTabpage', 0, '被退回', null, '取消审核', '{}', null, '0', null, null, null, null, null, null, null);



-- 绩效目标调整申报、审核
delete from p#busfw_t_uitabpage where key in('/pmkpi/adjust/report','/pmkpi/adjust/audit');
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('B98F5984662DB918E053B11FA8C08311', 'pmkpi', '/pmkpi/adjust/report', '未送审', 'waitaudit', 1, 1, 'choosed', 'adjustreport.clickTabpage', 1, '未送审', null, '取消送审', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('B98F5984662CB918E053B11FA8C08312', 'pmkpi', '/pmkpi/adjust/report', '已送审', 'alreadyaudit', 1, 2, 'nomal', 'adjustreport.clickTabpage', 1, '已送审', null, '调整,送审,删除项目,选择项目', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('B98F5984662BB918E053B11FA8C08313', 'pmkpi', '/pmkpi/adjust/report', '曾经办', 'alldeals', 1, 4, 'nomal', 'adjustreport.clickTabpage', 1, '曾经办', null, '调整,送审,取消送审,删除项目,选择项目', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('B98F5984662BB918E053B11FA8C08314', 'pmkpi', '/pmkpi/adjust/report', '被退回', 'back', 1, 3, 'nomal', 'adjustreport.clickTabpage', 1, '被退回', null, '取消送审,选择项目', '{}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('B98F5984662DB918E053B11FA8C08315', 'pmkpi', '/pmkpi/adjust/audit', '被退回', 'back', 1, 3, 'nomal', 'adjustaudit.clickTabpage', 0, '被退回', null, '取消审核', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('B98F5984662BB918E053B11FA8C08316', 'pmkpi', '/pmkpi/adjust/audit', '曾经办', 'alldeals', 1, 4, 'nomal', 'adjustaudit.clickTabpage', 0, '曾经办', null, '审核,取消审核', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('B98F5984662CB918E053B11FA8C08317', 'pmkpi', '/pmkpi/adjust/audit', '已审核', 'alreadyaudit', 1, 2, 'nomal', 'adjustaudit.clickTabpage', 0, '已审核', null, '审核', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('B98F5984662DB918E053B11FA8C08318', 'pmkpi', '/pmkpi/adjust/audit', '待审核', 'waitaudit', 1, 1, 'choosed', 'adjustaudit.clickTabpage', 0, '待审核', null, '取消审核', '{}', null, '0', null, null, null, null, null, null, null);



--绩效目标修订填报、审核
delete from p#busfw_t_uitabpage where key in('/pmkpi/prorevision/report','/pmkpi/prorevision/audit');
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('198F5984662BB918E053B11FA8C0831D', 'pmkpi', '/pmkpi/prorevision/report', '曾经办', 'alldeals', 1, 4, 'nomal', 'revisionreport.clickTabpage', 1, '曾经办', 'wfstatus in(''008'',''011'')', '修订,送审,取消送审,删除项目,选择项目', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('228F5984662CB918E053B11FA8C0831D', 'pmkpi', '/pmkpi/prorevision/report', '已送审', 'alreadyaudit', 1, 2, 'nomal', 'revisionreport.clickTabpage', 1, '已送审', 'wfstatus in(''008'')', '修订,送审,删除项目,选择项目', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('398F5984662DB918E053B11FA8C0831D', 'pmkpi', '/pmkpi/prorevision/report', '未送审', 'waitaudit', 1, 1, 'choosed', 'revisionreport.clickTabpage', 1, '未送审', 'wfstatus in(''000'')', '取消送审', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('498F5984662DB918E053B11FA8C0831D', 'pmkpi', '/pmkpi/prorevision/report', '被退回', 'waitaudit', 1, 3, 'nomal', 'revisionreport.clickTabpage', 1, '被退回', null, '取消送审,选择项目', '{}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('598F5984662BB918E053B11FA8C0831D', 'pmkpi', '/pmkpi/prorevision/audit', '曾经办', 'alldeals', 1, 4, 'nomal', 'prorevisionaudit.clickTabpage', 0, '曾经办', 'wfstatus in(''011'')', '审核,取消审核', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('698F5984662CB918E053B11FA8C0831D', 'pmkpi', '/pmkpi/prorevision/audit', '已审核', 'alreadyaudit', 1, 2, 'nomal', 'prorevisionaudit.clickTabpage', 0, '已审核', 'wfstatus in(''011'')', '审核', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('798F5984662DB918E053B11FA8C0831D', 'pmkpi', '/pmkpi/prorevision/audit', '待审核', 'waitaudit', 1, 1, 'choosed', 'prorevisionaudit.clickTabpage', 0, '待审核', 'wfstatus in(''008'')', '取消审核', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('898F5984662DB918E053B11FA8C0831D', 'pmkpi', '/pmkpi/prorevision/audit', '被退回', 'back', 1, 3, 'nomal', 'prorevisionaudit.clickTabpage', 0, '被退回', null, '取消审核', '{}', null, '0', null, null, null, null, null, null, null);

