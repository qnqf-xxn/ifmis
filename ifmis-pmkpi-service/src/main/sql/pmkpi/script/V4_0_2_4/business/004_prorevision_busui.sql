  i number;
begin

--busui
delete from p#busfw_t_uitabpage where key ='/pmkpi/prorevision/power';
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D4D3D3E37999274CE0533315A8C0ACDD', 'pmkpi', '/pmkpi/prorevision/power', '未授权', 'waitpower', 1, 1, 'choosed', 'revisionpower.clickTabpage', null, '未授权', null, '取消授权', '{tablecode:''PMKPI_FASP_T_PUBAGENCY''}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D4D3D3E3799A274CE0533315A8C0ACDD', 'pmkpi', '/pmkpi/prorevision/power', '已授权', 'alreadypower', 1, 2, 'nomal', 'revisionpower.clickTabpage', null, '已授权', null, '授权', '{tablecode:''V_PERF_PROREVISION_AGENCY''}', null, '0', null, null, null, null, null, null, null);
