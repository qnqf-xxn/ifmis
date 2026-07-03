begin
  
delete from bus_t_pageconsole where url ='/pmkpi/rectification/dept/index';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/rectification/dept/index', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.rectification.dept.RectificationDeptPage', 'index', '{header:[header],left:lefttree,main:[toolbutton,queryform,tabpage,datatable]}', null, null, 0);

delete from bus_t_pageconsolecomconfig where url ='/pmkpi/rectification/dept/index';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/dept/index', 'pmkpi_deptrectification', '{}', 'deptrectification', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/dept/index', 'busfw.dataexport', '{}', 'dataexport', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/dept/index', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/dept/index', 'busuidatatable', '{key:''/pmkpi/rectification/index'',name:''整改通知下达'',checkbox:true,title:''整改通知下达'',edit:false,addrow:false,autofullwidth:true}', 'datatable', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/dept/index', 'header', '{}', 'header', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/dept/index', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/dept/index', 'busdclefttree', '{}', 'lefttree', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/dept/index', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);


delete from bus_t_pagecomponent where id ='pmkpi_deptrectification';
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_deptrectification', '部门整改下达', null, '部门整改下达', '/pmkpi/rectification/rectificationDeptIndex.js', 'Ext.lt.pmkpi.rectification.deptIndex', 'pmkpi', 'pmkpi.rectification.dept.RectificationDeptService');


delete from p#busfw_t_uitabpage where key ='/pmkpi/rectification/dept/index';
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('DBA8064237942B6AE0533315A8C0C3D0', 'pmkpi', '/pmkpi/rectification/dept/index', '未下达', 'waitaudit', 1, 1, 'choosed', 'deptrectification.clickTabpage', 0, '显示未处理', null, '取消下达', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('DBA8064237952B6AE0533315A8C0C3D0', 'pmkpi', '/pmkpi/rectification/dept/index', '已下达', 'alreadyaudit', 1, 2, 'nomal', 'deptrectification.clickTabpage', 0, '显示已处理', null, '选择项目,删除,起草/修改,下达', '{}', null, '0', null, null, null, null, null, null, null);

delete from p#busfw_t_uifunction where key ='/pmkpi/rectification/dept/index';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('DBA414BA8CEF75CFE0533315A8C0BF00', '/pmkpi/rectification/dept/index', '下达', 1, 1, 'addaction', 'deptrectification.send', null, '下达', 'pmkpi', 'sendaudit', null, null);
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('DBA414BA8CED75CFE0533315A8C0BF00', '/pmkpi/rectification/dept/index', '取消下达', 1, 3, 'addaction', 'deptrectification.cancelsend', null, '取消下达', 'pmkpi', 'cancelsendaudit', null, null);
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('DBA414BA8CF075CFE0533315A8C0BF00', '/pmkpi/rectification/dept/index', '查看明细', 1, 4, 'addaction', 'deptrectification.detailed', null, '查看明细', 'pmkpi', 'detailed', null, null);
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('DBA414BA8CF175CFE0533315A8C0BF00', '/pmkpi/rectification/dept/index', '查看项目', 1, 5, null, 'deptrectification.showProjView', null, '查看项目', 'pmkpi', 'showProjView', null, null);
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('DBA414BA8CEE75CFE0533315A8C0BF00', '/pmkpi/rectification/dept/index', '导出列表', 0, 7, 'addaction', 'Ext.lt.pmkpi.expdata', null, '导出列表', 'pmkpi', 'export', null, '{}');

--左侧树页签
delete from perf_t_treetab where key ='/pmkpi/rectification/dept/index';
insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values ('DA2B705B99512100E0533315A8C01D6A', '/pmkpi/rectification/dept/index', 'dept', '部门整体', 0, '查看项目', 2, '2016', '87', '{rectifytrace:''D7F6D15AB0E37ECFE0533315A8C04610'',rectifyperfself:''D7F6D15AB0E17ECFE0533315A8C04610'',rectifyfinancialeval:''D7F6D15AB0E57ECFE0533315A8C04610'',rectifydepteval:''D7F6D15AB0E77ECFE0533315A8C04610''}', 'deptrectifydepthide');
insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values ('DA2B705B99522100E0533315A8C01D6A', '/pmkpi/rectification/dept/index', 'program', '项目支出', 1, null, 1, '2016', '87', '{rectifytrace:''D7F6D15AB0E27ECFE0533315A8C04610'',rectifyperfself:''D7F6D15AB0E07ECFE0533315A8C04610'',rectifyfinancialeval:''D7F6D15AB0E47ECFE0533315A8C04610'',rectifydepteval:''D7F6D15AB0E67ECFE0533315A8C04610''}', 'programrectifydepthide');

--表字段注册
delete from bus_t_diccolumn where tablecode ='PERF_T_RECTIFY' and COLUMNCODE ='SXSTATE';
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'SXSTATE', '1', null, null, '234F5188EE963C82DE4693C56DC2148C', 'SXSTATE', 'PERF_T_RECTIFY', null, 'S', '40', null, null, 1, null,sysdate);
