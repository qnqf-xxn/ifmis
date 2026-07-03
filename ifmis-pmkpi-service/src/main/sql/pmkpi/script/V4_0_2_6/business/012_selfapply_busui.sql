begin

--自评填报-添加按钮
delete from p#busfw_t_uifunction where guid in('DEDFA1634AE07072E0533315A8C0F03B','DF2F12B41B1D1C01E0533315A8C00A01','DF691A927FDC35B5E0533315A8C0811B');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('DEDFA1634AE07072E0533315A8C0F03B', '/pmkpi/perfself/apply/index', '安徽自评模板导出', 0, 20, 'searchicon', 'perfselfapply.expdoc', null, '安徽自评模板导出', 'pmkpi', 'expdoc', null, '{protempatecode:''ahxmzczpmb'',depttempatecode:''ahbmztzpmb'',proexptype:''ahprogram'',deptexptype:''ahdept''}');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('DF2F12B41B1D1C01E0533315A8C00A01', '/pmkpi/perfself/apply/index', '安徽自评导入', 0, 21, 'searchicon', 'perfselfapply.impdoc', null, '安徽自评导入', 'pmkpi', 'impdoc', null, '{impServicetype:''impreport'',protempatecode:''ahxmzczpmb'',depttempatecode:''ahbmztzpmb''}');
--自评查询-添加按钮
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('DF691A927FDC35B5E0533315A8C0811B', '/pmkpi/perfself/query/index', '安徽自评模板导出', 0, 20, 'searchicon', 'perfselfquery.expdoc', null, '安徽自评模板导出', 'pmkpi', 'expdoc', null, '{protempatecode:''ahxmzczpmb'',depttempatecode:''ahbmztzpmb'',proexptype:''ahprogram'',deptexptype:''ahdept''}');

--填报菜单-页签隐藏按钮(安徽自评导入,安徽自评模板导出)
delete from p#busfw_t_uitabpage where key in('/pmkpi/perfself/apply');
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('17C15713129F464FE0533315A8C0A90F', 'pmkpi', '/pmkpi/perfself/apply', '被退回', 'back', 1, 3, 'nomal', 'perfselfapply.clickTabpage', null, '被退回', null, '取消送审,安徽自评导入,安徽自评模板导出', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('37C15713129D464FE0533315A8C0A90F', 'pmkpi', '/pmkpi/perfself/apply', '已送审', 'alreadyaudit', 1, 2, 'nomal', 'perfselfapply.clickTabpage', null, '已送审', null, '填报/修改,删除,送审,安徽自评导入,安徽自评模板导出', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('57C15713129E464FE0533315A8C0A90F', 'pmkpi', '/pmkpi/perfself/apply', '曾经办', 'alldeals', 1, 4, 'nomal', 'perfselfapply.clickTabpage', null, '曾经办', null, '填报/修改,删除,送审,取消送审,安徽自评导入,安徽自评模板导出', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('77C15713129F464FE0533315A8C0A90F', 'pmkpi', '/pmkpi/perfself/apply', '未送审', 'waitaudit', 1, 1, 'choosed', 'perfselfapply.clickTabpage', null, '未送审', null, '取消送审', '{}', null, '0', null, null, null, null, null, null, null);
