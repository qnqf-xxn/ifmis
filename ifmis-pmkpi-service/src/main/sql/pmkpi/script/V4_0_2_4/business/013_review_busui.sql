begin

delete from p#busfw_t_uifunction t where t.key in('/pmkpi/review/report/list') and t.code in('back','cancelaudit','unconfirm');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('D882FD707F18757FE0533315A8C02646', '/pmkpi/review/report/list', '退回', 1, 6, 'searchicon', 'pmkpireviewreport.unconfirm', null, '退回', 'pmkpi', 'back', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('D4D3D3E368A1274CE0533315A8C0ACDD', '/pmkpi/review/report/list', '取消确认评审', 1, 11, 'searchicon', 'pmkpireviewreport.unconfirm', null, '取消确认评审', 'pmkpi', 'cancelaudit', null, '{}');

delete from p#busfw_t_uitabpage t where t.key in('/pmkpi/review/report/list');
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D4D3D3E37A77274CE0533315A8C0ACDD', 'pmkpi', '/pmkpi/review/report/list', '待提交', 'waitaudit', 1, 1, 'choosed', 'pmkpireviewreport.clickTabpage', 0, '待提交', null, '取消委托专家,取消确认评审', '{}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D4D3D3E37A78274CE0533315A8C0ACDD', 'pmkpi', '/pmkpi/review/report/list', '已提交', 'alreadyaudit', 1, 2, 'nomal', 'pmkpireviewreport.clickTabpage', 0, '已提交', null, '退回,确认评审,委托专家,修改项目,导入评审意见,批量提交送审', '{}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D882FD707F79757FE0533315A8C02646', 'pmkpi', '/pmkpi/review/report/list', '被退回', 'back', 1, 3, 'nomal', 'pmkpireviewreport.clickTabpage', 0, '被退回', null, '退回,导入评审意见,取消委托专家,委托专家,批量提交送审,取消确认评审', '{}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D4D3D3E37A79274CE0533315A8C0ACDD', 'pmkpi', '/pmkpi/review/report/list', '曾经办', 'allconfirm', 1, 4, 'nomal', 'pmkpireviewreport.clickTabpage', 0, '曾经办', null, '退回,确认评审,取消委托专家,委托专家,修改项目,导入评审意见,批量提交送审,取消确认评审', '{}', null, '0', null, null, null, null, null, null, null);
