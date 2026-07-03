begin
delete FROM p#Busfw_t_Uitabpage t where t.key in 
('/pmkpi/perfselftaskmanage/index','/pmkpi/perfself/apply/index','/pmkpi/perfself/apply/edit',
'/pmkpi/perfself/audit/index');
insert into Busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('41FAB37893334125ACF423C66CFC4BB0', 'pmkpi', '/pmkpi/perfself/apply/edit', '自评补充信息', 'selfdesc', 1, 4, 'nomal', 'tabfreamedit.clickTabpage', null, '自评分析', null, null, '{url:''/pmkpi/perfself/apply/edit/selfdesc.page'',action:''selfdesc.save''}', null, '0', 'desciframe', null, null, null, null, null, null);

insert into Busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BD53C1BDAE7C5511E053B11FA8C098E1', 'pmkpi', '/pmkpi/perfself/apply/edit', '预算执行情况', 'bdgpay', 1, 2, 'nomal', 'tabfreamedit.clickTabpage', null, '预算执行情况', null, null, '{url:''/pmkpi/perfself/apply/edit/bdgpay.page''}', null, '0', 'bdgpayiframe', null, null, null, null, null, null);

insert into Busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('2C0D19E2DD734500851D188038A05981', 'pmkpi', '/pmkpi/perfself/apply/edit', '指标完成情况', 'selfindex', 1, 3, 'nomal', 'tabfreamedit.clickTabpage', null, '指标完成情况', null, null, '{url:''/pmkpi/perfself/apply/edit/selfindex.page'',action:''selfindex.save''}', null, '0', 'indexiframe', null, null, null, null, null, null);

insert into Busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('767345D59B9B4FC39A485871C4B055FC', 'pmkpi', '/pmkpi/perfself/apply/edit', '预算执行情况', 'selffund', 0, 2, 'nomal', 'tabfreamedit.clickTabpage', null, '预算执行情况1', null, null, '{url:''/pmkpi/perfself/apply/edit/selffund.page''}', null, '0', 'fundiframe', null, null, null, null, null, null);

insert into Busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('1AA2EE3E07A249DDB79B75A45310303E', 'pmkpi', '/pmkpi/perfself/apply/edit', '项目基本信息', 'projinfo', 1, 1, 'choosed', 'tabfreamedit.clickTabpage', null, '项目基本信息', null, null, '{url:''/pmkpi/perfself/apply/edit/projinfo.page'',action:''projinfo.save''}', null, '0', 'projiframe', null, null, null, null, null, null);

insert into Busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('PA179799E955498B8564F5D994029D02', 'pmkpi', '/pmkpi/perfself/apply/index', '曾经办', 'alldeals', 1, 3, 'nomal', 'perfselfapply.clickTabpage', null, '曾经办', null, '填报/修改,删除,送审,取消送审', '{}', null, '0', null, null, null, null, null, null, null);

insert into Busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('PE5AB9438DA14BFE9F8085624AED19A2', 'pmkpi', '/pmkpi/perfself/apply/index', '未送审', 'waitaudit', 1, 1, 'choosed', 'perfselfapply.clickTabpage', null, '未送审', null, '取消送审', '{}', null, '0', null, null, null, null, null, null, null);

insert into Busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('PBDA3DBBA5B24DA0B3F8BEC3880D4282', 'pmkpi', '/pmkpi/perfself/apply/index', '已送审', 'alreadyaudit', 1, 2, 'nomal', 'perfselfapply.clickTabpage', null, '已送审', null, '填报/修改,删除,送审', '{}', null, '0', null, null, null, null, null, null, null);

insert into Busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('SBDA3DBBA5B24DA0B3F8BEC3880D4282', 'pmkpi', '/pmkpi/perfself/audit/index', '已审核', 'alreadyaudit', 1, 2, 'nomal', 'perfselfaudit.clickTabpage', null, '已审核', null, '审核', '{}', null, '0', null, null, null, null, null, null, null);

insert into Busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('SA179799E955498B8564F5D994029D02', 'pmkpi', '/pmkpi/perfself/audit/index', '曾经办', 'alldeals', 1, 3, 'nomal', 'perfselfaudit.clickTabpage', null, '曾经办', null, '审核,取消审核', '{}', null, '0', null, null, null, null, null, null, null);

insert into Busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('SE5AB9438DA14BFE9F8085624AED19A2', 'pmkpi', '/pmkpi/perfself/audit/index', '待审核', 'waitaudit', 1, 1, 'choosed', 'perfselfaudit.clickTabpage', null, '待审核', null, '取消审核,审核信息', '{}', null, '0', null, null, null, null, null, null, null);

insert into Busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('PE5AB9438DA14BFE9F8085624AED19A4', 'pmkpi', '/pmkpi/perfselftaskmanage/index', '未下达', 'create', 1, 1, 'choosed', 'perfselfmanage.clickTabpage', null, '未下达', 'not exists(select 1 from v_perf_t_selfevaltask d where t.projguid = d.perfgoalguid)', '取消下达', '{tablecode:''v_perf_v_selfevalprograms''}', null, '0', null, null, null, null, null, null, null);

insert into Busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('PA179799E955498B8564F5D994029D01', 'pmkpi', '/pmkpi/perfselftaskmanage/index', '已完成', 'alldeals', 1, 3, 'nomal', 'perfselfmanage.clickTabpage', null, '已完成', 't.evalstatus =2', '任务下达,取消下达', '{tablecode:''v_perf_v_selfevalprograms''}', null, '0', null, null, null, null, null, null, null);

insert into Busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('PBDA3DBBA5B24DA0B3F8BEC3880D4286', 'pmkpi', '/pmkpi/perfselftaskmanage/index', '已下达', 'alreday', 1, 2, 'nomal', 'perfselfmanage.clickTabpage', null, '已下达', 't.evalstatus =1', '任务下达', '{tablecode:''v_perf_v_selfevalprograms''}', null, '0', null, null, null, null, null, null, null);

