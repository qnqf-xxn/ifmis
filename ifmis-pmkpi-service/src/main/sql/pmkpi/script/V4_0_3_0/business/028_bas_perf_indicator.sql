begin
--部门指标页面 新增 “选择调整”按钮
delete from p#busfw_t_uifunction where key ='/pmkpi/indexlib/deptlist' and code ='check';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/indexlib/deptlist', '选择调整', 1, 2, 'searchicon', 'indexlib.check', null, '选择调整', 'pmkpi', 'check', null, '{}');

--部门指标页面 新增 “数据状态”字段
delete from p#busfw_t_uicolumn where key ='/pmkpi/indexlib/deptlist' and columncode ='ADJUSTSTATUS';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D4D3D3E323BB274CE0533315A8C0AC00', '/pmkpi/indexlib/deptlist', 'ADJUSTSTATUS', '数据状态', 1, 1, 0, null, null, null, 1, null, '#name', null, null, null, 1, 'tree', '{}', null);


--部门指标页签 过滤按钮
delete from p#busfw_t_uitabpage where key ='/pmkpi/indexlib/deptlist';
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values (sys_guid(), 'pmkpi', '/pmkpi/indexlib/deptlist', '曾经办', 'alldeals', 1, 3, 'nomal', 'indexlib.clickTabpage', null, '曾经办', null, '新增,修改,删除,送审,取消送审,选择调整', '{}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values (sys_guid(), 'pmkpi', '/pmkpi/indexlib/deptlist', '待送审', 'waitaudit', 1, 1, 'choosed', 'indexlib.clickTabpage', null, '待审核', null, '取消送审', '{}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values (sys_guid(), 'pmkpi', '/pmkpi/indexlib/deptlist', '已送审', 'alreadyaudit', 1, 2, 'nomal', 'indexlib.clickTabpage', null, '已审核', null, '新增,修改,删除,送审,选择调整', '{}', null, '0', null, null, null, null, null, null, null);


--表注册增加字段
delete from bus_t_diccolumn where columncode in('ADJUSTGUID','ADJUSTSTATUS');
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'ADJUSTGUID', '1', '2016', '87', '69DFF0DC487F4CF59FDF698738B8BA2D', 'ADJUSTGUID', 'BAS_PERF_INDICATOR', '调整前guid', 'S', '1', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'PERFDATATYPE', null, '1', 'ADJUSTSTATUS', '1', '2016', '87', '07DFF0DC487F4CF59FDF698738B8BA2D', 'ADJUSTSTATUS', 'BAS_PERF_INDICATOR', '数据调整状态', 'S', '1', null, 1, 1, null, sysdate);

