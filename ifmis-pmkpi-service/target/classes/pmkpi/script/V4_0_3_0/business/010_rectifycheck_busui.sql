begin

--整改通知编制-选择项目
--项目支出-按钮
delete from p#busfw_t_uifunction where key ='/pmkpi/rectification/check/proj';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/rectification/check/proj', '确定(批量)', 1, 2, 'addaction', 'rectificationcheck.add', null, '确定(批量)', 'pmkpi', '确定(批量)', null, '{checkbox:true}');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/rectification/check/proj', '确定(单个)', 1, 3, 'addaction', 'rectificationcheck.add', null, '确定(单个)', 'pmkpi', '确定(单个)', null, '{checkbox:false}');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/rectification/check/proj', '关闭', 1, 4, 'addaction', 'Ext.lt.ui.closeModalWindow', null, '关闭', 'pmkpi', '关闭', null, null);
--部门整体-按钮
delete from p#busfw_t_uifunction where key ='/pmkpi/rectification/check/deptproj';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/rectification/check/deptproj', '确定(批量)', 1, 2, 'addaction', 'rectificationcheck.add', null, '确定(批量)', 'pmkpi', '确定(批量)', null, '{checkbox:true}');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/rectification/check/deptproj', '确定(单个)', 1, 3, 'addaction', 'rectificationcheck.add', null, '确定(单个)', 'pmkpi', '确定(单个)', null, '{checkbox:false}');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/rectification/check/deptproj', '关闭', 1, 4, 'addaction', 'Ext.lt.ui.closeModalWindow', null, '关闭', 'pmkpi', '关闭', null, null);
--批量新增-按钮
delete from busfw_t_uifunction where key = '/pmkpi/rectification/addBatch';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/rectification/addBatch', '保存', 1, 1, null, 'addprogram.save', null, '保存', 'pmkpi', 'save', null, '{}');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/rectification/addBatch', '保存并下发', 1, 2, null, 'addprogram.saveaudit', null, '保存并下发', 'pmkpi', 'audit', null, '{}');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/rectification/addBatch', '返回', 1, 3, null, 'addprogram.back', null, '返回', 'pmkpi', 'close', null, '{}');
--批量新增-页签
delete from busfw_t_uitabpage where key ='/pmkpi/rectification/addBatch';
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values (sys_guid(), 'pmkpi', '/pmkpi/rectification/addBatch', '整改内容', 'file', 1, 3, 'nomal', 'addprogram.clickTabpage', null, '整改内容', null, null, '{filebustype:''rectification'',url:''/pmkpi/rectification/reftifycont.page'',action:''reftifyfile.save''}', null, '0', 'manceiframe', null, null, null, null, null, null);
--批量新增-页签-整改内容-编辑区
delete from busfw_t_uieditform where key = '/pmkpi/rectification/reftifycont';
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, HEAD)
values (sys_guid(), '/pmkpi/rectification/reftifycont', 'V_PERF_T_RECTIFY', 'textarea', '整改内容', 'RECTIFYDESC', 1, null, 1, null, 1, 3, '3', 'pmkpi', 1, null, '{}', null, null, null, null);
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, HEAD)
values (sys_guid(), '/pmkpi/rectification/reftifycont', 'V_PERF_T_RECTIFY', 's', '主键ID', 'GUID', 0, null, 0, null, 0, null, null, 'pmkpi', 0, null, '{}', null, null, null, null);
