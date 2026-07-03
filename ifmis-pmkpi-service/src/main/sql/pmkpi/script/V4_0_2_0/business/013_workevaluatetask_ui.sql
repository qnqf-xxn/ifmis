begin

DELETE FROM P#busfw_t_Uitabpage t where t.key='/pmkpi/workevaluate/assign/provincelist';
insert into busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('C339A89F78224FB0E053B11FA8C05AC1', 'pmkpi', '/pmkpi/workevaluate/assign/provincelist', '已下达县（市）区、开发区', 'already', 1, 2, 'nomal', 'pmkpitaskassign.clickTabpage', null, '已下达县（市）区、开发区', null, '下达', '{tablecode:''V_PERF_T_WORKTASKASSIGN''}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('C339A89F78174FB0E053B11FA8C05AC1', 'pmkpi', '/pmkpi/workevaluate/assign/provincelist', '待下达县（市）区、开发区', 'wait', 1, 1, 'choosed', 'pmkpitaskassign.clickTabpage', null, '待下达县（市）区、开发区', null, '取消下达', '{tablecode:''V_ELE_VD08001''}', null, '0', null, null, null, null, null, null, null);
