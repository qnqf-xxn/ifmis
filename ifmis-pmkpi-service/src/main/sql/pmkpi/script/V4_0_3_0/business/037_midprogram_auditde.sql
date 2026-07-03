begin

--年中追加审核定义
delete from perf_t_auditdefinemenu where superid =  'BEA7B41C9DC8228EE053B11FA8C08541';
insert into perf_t_auditdefinemenu (GUID, CODE, NAME, REMARK, SUPERID, LEVELNO, ISLEAF, ORDERNUM, STATUS, CREATETIME, UPDATETIME, CREATER, PROVINCE, YEAR)
values ('E9A5FB00AA4066C5E0533315A8C0D097', '1', '年度绩效目标审核定义', null, 'BEA7B41C9DC8228EE053B11FA8C08541', 3, null, 4, 1, '1', '20210517153244', null, '87', 2016);
insert into perf_t_auditdefinemenu (GUID, CODE, NAME, REMARK, SUPERID, LEVELNO, ISLEAF, ORDERNUM, STATUS, CREATETIME, UPDATETIME, CREATER, PROVINCE, YEAR)
values ('E9A5FB00AA4166C5E0533315A8C0D097', '2', '年度绩效指标审核定义', null, 'BEA7B41C9DC8228EE053B11FA8C08541', 3, null, 4, 1, '1', '20210517153244', null, '87', 2016);
--更改busguid
delete from p#busfw_t_uitabpage where key = '/pmkpi/midprogram/report/edit' and code in('yeargoal','yearindex');
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values (sys_guid(), 'pmkpi', '/pmkpi/midprogram/report/edit', '年度绩效目标', 'yeargoal', 1, 2, 'nomal', 'tabfreamedit.clickTabpage', null, '年度绩效目标', null, null, '{url:''/pmkpi/program/report/protabgoal.page?showtab=1'||chr(38)||'isprogramiframe=1'||chr(38)||'isedittotal=1'',action:''tlprotabgoal.save'',busguid:''E9A5FB00AA4066C5E0533315A8C0D097''}', null, '0', 'goaliframe', null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values (sys_guid(), 'pmkpi', '/pmkpi/midprogram/report/edit', '年度绩效指标', 'yearindex', 1, 3, 'nomal', 'tabfreamedit.clickTabpage', null, '年度绩效指标', null, null, '{url:''/pmkpi/program/report/treeindex.page?showtab=1'||chr(38)||'isprogramiframe=1'||chr(38)||'isedittotal=1'',action:''prjtreeindex.save'',busguid:''E9A5FB00AA4166C5E0533315A8C0D097''}', null, '0', 'indextableiframe', null, null, null, null, null, null);



