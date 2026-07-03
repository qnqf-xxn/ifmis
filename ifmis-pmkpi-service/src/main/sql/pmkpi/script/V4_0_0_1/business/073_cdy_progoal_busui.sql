begin


delete from busfw_t_uitabpage t where key in('/pmkpi/program/report/edit');
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('program/report/edittab005', 'pmkpi', '/pmkpi/program/report/edit', '绩效目标', 'yeargoal', 0, 3, 'nomal', 'pmkpitlprogramedit.clickTabpage', null, '绩效目标', null, null, '{url:"/pmkpi/program/report/progoal.page",action:''pmkpitlproindex.save'',busguid:''FDDCF71C312941CD9D3408ACC958DBAB''}', null, '0', 'iframegoaltable', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('program/report/edittab004', 'pmkpi', '/pmkpi/program/report/edit', '年度绩效目标', 'yearindex', 1, 4, 'nomal', 'pmkpitlprogramedit.clickTabpage', null, '年度绩效目标', null, null, '{url:"/pmkpi/program/report/proindex.page",action:''pmkpitlproindex.save'',busguid:''2AA2F7C3AA54442AB529CEBA1DABAF96''}', null, '0', 'iframeindextable', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('program/report/edittab001', 'pmkpi', '/pmkpi/program/report/edit', '附件管理', 'file', 1, 5, 'nomal', 'pmkpitlprogramedit.clickTabpage', null, '附件管理', null, '保存', '{url:''/pmkpi/file/index.page''}', null, '0', 'iframemance', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('program/report/edittab002', 'pmkpi', '/pmkpi/program/report/edit', '项目基本信息', 'proinfo', 1, 1, 'choosed', 'pmkpitlprogramedit.clickTabpage', null, '项目基本信息', null, null, '{busguid:''8DB78FE7219440ADA2DD4D8B93384D2A''}', null, '0', 'editform', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('program/report/edittab003', 'pmkpi', '/pmkpi/program/report/edit', '预算支出明细', 'mxdatatable', 1, 2, 'nomal', 'pmkpitlprogramedit.clickTabpage', null, '预算支出明细', null, null, '{busguid:''B54067D4212C4D89972CE3984FC17DE0''}', null, '0', 'mxdatatable', null, null, null, null, null, null);

