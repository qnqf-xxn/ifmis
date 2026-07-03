begin
  --年中追加审核页面  添加修改按钮默认隐藏
delete from p#busfw_t_uifunction t where key ='/pmkpi/midprogram/report/audit' and t.code ='update';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('DA2B705B994A2100E0533315A8C01D6A', '/pmkpi/midprogram/report/audit', '修改', 0, 9, 'searchicon', 'midprogramaudit.update', null, '修改', 'pmkpi', 'update', null, '{}');
--页签隐藏修改按钮
delete from p#busfw_t_uitabpage where key ='/pmkpi/midprogram/report/audit';
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D4D3D3E37913274CE0533315A8C0ACDD', 'pmkpi', '/pmkpi/midprogram/report/audit', '被退回', 'back', 1, 3, 'nomal', 'midprogramaudit.clickTabpage', null, '被退回', null, '取消审核,审核信息', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D4D3D3E37914274CE0533315A8C0ACDD', 'pmkpi', '/pmkpi/midprogram/report/audit', '待审核', 'waitaudit', 1, 1, 'choosed', 'midprogramaudit.clickTabpage', null, '待审核', null, '取消审核,审核信息', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D4D3D3E3791A274CE0533315A8C0ACDD', 'pmkpi', '/pmkpi/midprogram/report/audit', '已审核', 'alreadyaudit', 1, 2, 'nomal', 'midprogramaudit.clickTabpage', null, '已审核', null, '审核,批量审核,修改,批量退回', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D4D3D3E3791C274CE0533315A8C0ACDD', 'pmkpi', '/pmkpi/midprogram/report/audit', '曾经办', 'alldeals', 1, 4, 'nomal', 'midprogramaudit.clickTabpage', null, '曾经办', null, '审核,取消审核,批量审核,修改,批量退回', '{}', null, '0', null, null, null, null, null, null, null);


--目标调整审核页面  添加修改按钮默认隐藏
delete from p#busfw_t_uifunction t where key ='/pmkpi/adjust/audit' and t.code ='update';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('DA2B705B994B2100E0533315A8C01D6A', '/pmkpi/adjust/audit', '修改', 0, 8, 'searchicon', 'adjustaudit.update', null, '修改', 'pmkpi', 'update', null, null);
--页签隐藏修改按钮
delete from p#busfw_t_uitabpage where key ='/pmkpi/adjust/audit';
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D7F6D15AB0F47ECFE0533315A8C04610', 'pmkpi', '/pmkpi/adjust/audit', '待审核', 'waitaudit', 1, 1, 'choosed', 'adjustaudit.clickTabpage', 0, '待审核', 'wfstatus <> ''000''', '取消审核', '{programfilter:"(wfstatus <> ''000'' or wfstatus <> ''01'')",deptfilter:"wfstatus <> ''000''"}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D7F6D15AB0F57ECFE0533315A8C04610', 'pmkpi', '/pmkpi/adjust/audit', '已审核', 'alreadyaudit', 1, 2, 'nomal', 'adjustaudit.clickTabpage', 0, '已审核', null, '审核,批量审核,批量退回,修改', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D7F6D15AB0F67ECFE0533315A8C04610', 'pmkpi', '/pmkpi/adjust/audit', '被退回', 'back', 1, 3, 'nomal', 'adjustaudit.clickTabpage', 0, '被退回', null, '取消审核', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D7F6D15AB0F77ECFE0533315A8C04610', 'pmkpi', '/pmkpi/adjust/audit', '曾经办', 'alldeals', 1, 4, 'nomal', 'adjustaudit.clickTabpage', 0, '曾经办', null, '审核,取消审核,批量审核,批量退回,修改', '{}', null, '0', null, null, null, null, null, null, null);


--绩效监控审核页面  修改按钮默认隐藏
delete from p#busfw_t_uifunction t where key ='/pmkpi/program/trace/audit' and t.code ='addOredit';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('D4D3D3E36B49274CE0533315A8C0ACDD', '/pmkpi/program/trace/audit', '修改', 0, 9, 'searchicon', 'protraceaudit.addOredit', null, '修改', 'pmkpi', 'addOredit', null, '{}');
--页签隐藏修改按钮
delete from p#busfw_t_uitabpage where key ='/pmkpi/program/trace/audit';
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D4D3D3E379D1274CE0533315A8C0ACDD', 'pmkpi', '/pmkpi/program/trace/audit', '待审核', 'waitaudit', 1, 1, 'choosed', 'protraceaudit.clickTabpage', null, '待审核', null, '取消审核', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D4D3D3E379D2274CE0533315A8C0ACDD', 'pmkpi', '/pmkpi/program/trace/audit', '已审核', 'alreadyaudit', 1, 2, 'nomal', 'protraceaudit.clickTabpage', null, '已审核', null, '审核,批量审核,批量退回,修改', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D4D3D3E379D3274CE0533315A8C0ACDD', 'pmkpi', '/pmkpi/program/trace/audit', '曾经办', 'alldeals', 1, 4, 'nomal', 'protraceaudit.clickTabpage', null, '曾经办', null, '审核,取消审核,批量审核,批量退回,修改', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D4D3D3E379D4274CE0533315A8C0ACDD', 'pmkpi', '/pmkpi/program/trace/audit', '被退回', 'back', 1, 3, 'nomal', 'protraceaudit.clickTabpage', null, '被退回', null, '取消审核', '{}', null, '0', null, null, null, null, null, null, null);


--自评审核页面  修改按钮默认隐藏
delete from p#busfw_t_uifunction t where key ='/pmkpi/perfself/audit/index' and t.code ='update';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('DA2B705B994C2100E0533315A8C01D6A', '/pmkpi/perfself/audit/index', '修改', 0, 13, 'searchicon', 'perfselfaudit.update', null, '修改', 'pmkpi', 'update', null, null);
--页签隐藏修改按钮
delete from p#busfw_t_uitabpage where key ='/pmkpi/perfself/audit';
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D4D3D3E3792F274CE0533315A8C0ACDD', 'pmkpi', '/pmkpi/perfself/audit', '被退回', 'back', 1, 3, 'nomal', 'perfselfaudit.clickTabpage', null, '被退回', null, '取消审核,审核信息', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D4D3D3E37930274CE0533315A8C0ACDD', 'pmkpi', '/pmkpi/perfself/audit', '已审核', 'alreadyaudit', 1, 2, 'nomal', 'perfselfaudit.clickTabpage', null, '已审核', null, '审核,批量审核,批量退回,修改', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D4D3D3E37932274CE0533315A8C0ACDD', 'pmkpi', '/pmkpi/perfself/audit', '曾经办', 'alldeals', 1, 4, 'nomal', 'perfselfaudit.clickTabpage', null, '曾经办', null, '审核,取消审核,批量审核,批量退回,修改', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D4D3D3E37933274CE0533315A8C0ACDD', 'pmkpi', '/pmkpi/perfself/audit', '待审核', 'waitaudit', 1, 1, 'choosed', 'perfselfaudit.clickTabpage', null, '待审核', null, '取消审核,审核信息', '{}', null, '0', null, null, null, null, null, null, null);


--绩效目标修订审核页面  修改按钮默认隐藏
delete from p#busfw_t_uifunction t where key ='/pmkpi/prorevision/audit' and t.code ='update';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('DA2B705B994E2100E0533315A8C01D6A', '/pmkpi/prorevision/audit', '修改', 0, 7, 'searchicon', 'prorevisionaudit.update', null, '修改', 'pmkpi', 'update', null, null);
--页签隐藏修改按钮
delete from p#busfw_t_uitabpage where key ='/pmkpi/prorevision/audit';
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D4D3D3E37979274CE0533315A8C0ACDD', 'pmkpi', '/pmkpi/prorevision/audit', '曾经办', 'alldeals', 1, 4, 'nomal', 'prorevisionaudit.clickTabpage', 0, '曾经办', null, '审核,取消审核,批量审核,批量退回,修改', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D4D3D3E379CA274CE0533315A8C0ACDD', 'pmkpi', '/pmkpi/prorevision/audit', '已审核', 'alreadyaudit', 1, 2, 'nomal', 'prorevisionaudit.clickTabpage', 0, '已审核', null, '审核,批量审核,批量退回,修改', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D4D3D3E379CB274CE0533315A8C0ACDD', 'pmkpi', '/pmkpi/prorevision/audit', '待审核', 'waitaudit', 1, 1, 'choosed', 'prorevisionaudit.clickTabpage', 0, '待审核', null, '取消审核', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D4D3D3E379CC274CE0533315A8C0ACDD', 'pmkpi', '/pmkpi/prorevision/audit', '被退回', 'back', 1, 3, 'nomal', 'prorevisionaudit.clickTabpage', 0, '被退回', null, '取消审核', '{}', null, '0', null, null, null, null, null, null, null);


--部门申报审核页面  修改按钮默认隐藏
delete from p#busfw_t_uifunction t where key ='/pmkpi/deptperformance/audit/index' and t.code ='save';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('D4D3D3E36A37274CE0533315A8C0ACDD', '/pmkpi/deptperformance/audit/index', '修改', 0, 2, 'searchicon', 'deptperformanceaudit.addOredit', null, '修改', 'pmkpi', 'save', null, '{}');
--页签隐藏修改按钮
delete from p#busfw_t_uitabpage where key ='/pmkpi/deptperformance/audit/index';
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D4D3D3E37963274CE0533315A8C0ACDD', 'pmkpi', '/pmkpi/deptperformance/audit/index', '被退回', 'back', 1, 3, 'nomal', 'deptperformanceaudit.clickTabpage', null, '被退回', null, '取消审核,审核信息', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D4D3D3E37964274CE0533315A8C0ACDD', 'pmkpi', '/pmkpi/deptperformance/audit/index', '曾经办', 'alldeals', 1, 4, 'nomal', 'deptperformanceaudit.clickTabpage', null, '曾经办', null, '审核,取消审核,修改,批量审核,批量退回', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D4D3D3E37965274CE0533315A8C0ACDD', 'pmkpi', '/pmkpi/deptperformance/audit/index', '已审核', 'alreadyaudit', 1, 2, 'nomal', 'deptperformanceaudit.clickTabpage', null, '已审核', null, '审核,修改,批量审核,批量退回', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D4D3D3E37978274CE0533315A8C0ACDD', 'pmkpi', '/pmkpi/deptperformance/audit/index', '待审核', 'waitaudit', 1, 1, 'choosed', 'deptperformanceaudit.clickTabpage', null, '待审核', null, '取消审核,审核信息', '{}', null, '0', null, null, null, null, null, null, null);
