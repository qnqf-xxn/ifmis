begin
  
delete from p#busfw_t_uitabpage where key = '/pmkpi/yearprogram/query/tablist';
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), 'pmkpi', '/pmkpi/yearprogram/query/tablist', '全部项目数据', 'alldatas', 1, 4, 'nomal', 'yearprogramquery.clickTabpage', 0, '全部项目数据', null, null, '{tablecode:''V_PERF_PROJECT_YEAR''}', null, '0', null, null, null, null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), 'pmkpi', '/pmkpi/yearprogram/query/tablist', '部门预算', 'bmys', 1, 1, 'choosed', 'yearprogramquery.clickTabpage', 0, '部门预算', null, null, '{tablecode:''V_PERF_PROJECT_YEAR''}', null, '0', null, null, null, null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), 'pmkpi', '/pmkpi/yearprogram/query/tablist', '年中追加', 'midprogram', 1, 3, 'nomal', 'yearprogramquery.clickTabpage', 0, '年中追加', null, null, '{tablecode:''V_PERF_PROJECT_YEAR''}', null, '0', null, null, null, null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), 'pmkpi', '/pmkpi/yearprogram/query/tablist', '转移支付', 'transfer', 1, 2, 'nomal', 'yearprogramquery.clickTabpage', 0, '转移支付', null, null, '{tablecode:''V_PERF_PROJECT_YEAR''}', null, '0', null, null, null, null, null, null, null, null, null);

--湖北绩效目标调整指标名称不可修改
update p#busfw_t_uicolumn set isedit = '0' where key = '/pmkpi/adjust/report/proedit/hbtreeindex' and columncode = 'NAME';