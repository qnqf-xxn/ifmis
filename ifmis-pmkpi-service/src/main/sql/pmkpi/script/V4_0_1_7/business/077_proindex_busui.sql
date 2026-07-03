begin

delete from p#busfw_t_uitabpage t where t.key in('/pmkpi/program/report/treeindex');
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('program/report/treeindex001', 'pmkpi', '/pmkpi/program/report/treeindex', '总体绩效指标', 'total', 1, 1, 'choosed', 'prjtreeindex.clickTabpage', 0, '总体绩效指标', null, '查看评审意见,复制总体绩效指标,复制上年指标', '{}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('program/report/treeindex002', 'pmkpi', '/pmkpi/program/report/treeindex', '年度绩效指标', 'year', 1, 2, 'nomal', 'prjtreeindex.clickTabpage', 0, '年度绩效指标', null, '复制年度绩效指标', '{}', null, '0', null, null, null, null, null, null, null);

delete from p#busfw_t_uifunction t where t.key in('/pmkpi/program/report/treeindex') and t.code='copyyearindex';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('CAC0FDA41F3A359BE0533315A8C04817', '/pmkpi/program/report/treeindex', '复制年度绩效指标', 1, 9, 'keepicon', 'Ext.lt.pmkpi.copytotalindex', null, '复制年度绩效指标', 'pmkpi', 'copyyearindex', null, null);
