begin

--增加各菜单部门整体页签
delete from perf_t_treetab where key ='/pmkpi/evaluation/dept/report' and code ='dept';

insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID, CONFIG)
values (sys_guid(), '/pmkpi/evaluation/dept/report', 'dept', '部门整体', 1, '查看项目明细', 2, '2016', '87', 'BE2FB8A81CF40A3DE053B11FA8C0BF96', 'deptdeptevaluationreporthide', null);

delete from perf_t_treetab where key ='/pmkpi/evaluation/dept/audit' and code ='dept';

insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID, CONFIG)
values (sys_guid(), '/pmkpi/evaluation/dept/audit', 'dept', '部门整体', 1, '查看项目明细,发起整改,查看未选择项目', 2, '2016', '87', 'BE2FB8A81CF40A3DE053B11FA8C0BF96', 'deptdeptevaluationaudithide', null);

delete from perf_t_treetab where key ='/pmkpi/evaluation/dept/result' and code ='dept';

insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID, CONFIG)
values (sys_guid(), '/pmkpi/evaluation/dept/result', 'dept', '部门整体', 1, '查看项目明细', 2, '2016', '87', 'BE2FB8A81CF40A3DE053B11FA8C0BF96', 'deptdeptevaluationresulthide', null);

delete from perf_t_treetab where key ='/pmkpi/evaluation/dept/resultaudit' and code ='dept';

insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID, CONFIG)
values (sys_guid(), '/pmkpi/evaluation/dept/resultaudit', 'dept', '部门整体', 1, '查看项目明细', 2, '2016', '87', 'BE2FB8A81CF40A3DE053B11FA8C0BF96', 'deptdeptevaluaresultaudithide', null);

delete from perf_t_treetab where key ='/pmkpi/evaluation/dept/resultquery' and code ='dept';

insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID, CONFIG)
values (sys_guid(), '/pmkpi/evaluation/dept/resultquery', 'dept', '部门整体', 1, '查看项目明细', 2, '2016', '87', 'BE2FB8A81CF40A3DE053B11FA8C0BF96', 'deptdeptevaluaresultqueryhide', null);

--修改部门整体部门评价选择项目范围为部门
update p#busfw_t_uitable set defquery = 'isleaf<>1 and levelno=1' where key ='/pmkpi/evaluation/dept/deptcheck';

--部门整体部门评价编辑页页签
delete from p#busfw_t_uitabpage where key ='/pmkpi/evaluation/dept/result/deptedit';

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), 'pmkpi', '/pmkpi/evaluation/dept/result/deptedit', '基本信息', 'info', 1, 1, 'choosed', 'tabfreamedit.clickTabpage', null, '基本信息', null, '保存', '{viewtype:''query''}', null, '0', 'infoeditform', null, null, null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), 'pmkpi', '/pmkpi/evaluation/dept/result/deptedit', '项目附件', 'file', 0, 2, 'nomal', 'tabfreamedit.clickTabpage', null, '项目附件', null, '保存', '{filebustype:''deptevadept'',url:''/pmkpi/upload/file/index.page'',viewtype:''query''}', null, '0', 'manceiframe', null, null, null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), 'pmkpi', '/pmkpi/evaluation/dept/result/deptedit', '评估结论', 'info', 1, 3, 'nomal', 'tabfreamedit.clickTabpage', null, '评估结论', null, null, '{busguid:''BD53D19B028A2359E053B11FA8C0BCA2''}', null, '0', 'editform', null, null, null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), 'pmkpi', '/pmkpi/evaluation/dept/result/deptedit', '评价成果', 'file', 1, 4, 'nomal', 'tabfreamedit.clickTabpage', null, '评价成果', null, '保存', '{filebustype:''deptevadeptresult'',url:''/pmkpi/upload/file/index.page''}', null, '0', 'manceiframe', null, null, null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), 'pmkpi', '/pmkpi/evaluation/dept/result/deptedit', '第三方信息', 'thirdparty', 1, 5, 'nomal', 'tabfreamedit.clickTabpage', null, '第三方信息', null, null, '{url:''/pmkpi/evaluation/dept/thirdparty.page'',action:''thirdparty.save''}', null, '0', 'thirdpartyiframe', null, null, null, null, null, null, null, null);

--部门整体部门评价编辑页基本信息页签
delete from p#busfw_t_uieditform where key ='/pmkpi/evaluation/deptreport/deptedit' and columncode = 'FININTORGGUID';

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, HEAD, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/evaluation/deptreport/deptedit', 'V_PERF_T_DEPTEVALUATION', 'tree', '主管处室', 'FININTORGGUID', 1, null, 1, null, 5, null, null, 'pmkpi', 1, 0, '{}', 0, 0, 0, null, null, null);


--选择项目查询区页面配置
delete from bus_t_pageconsolecomconfig where url ='/pmkpi/evaluation/dept/deptcheck' and id ='queryform';

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/dept/deptcheck', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''table'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);
