begin
  --整改列表任务名称翻译字段
delete from p#busfw_t_uicolumn where key ='/pmkpi/rectification/index' and (columncode ='TASKNAME' or columncode ='TASKGUID');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG)
values ('D4D3D3E32DA4274CE0533315A8C0ACDD', '/pmkpi/rectification/index', 'TASKGUID', '任务名称', 7, 1, 0, 0, '0', 0, 1, null, '#name', null, 0, 150, 1, 'tree', null, null, null, null);

--审核状态字段
delete from p#busfw_t_uicolumn where key ='/pmkpi/rectification/index' and columncode ='WFSTATUS';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG)
values ('D4D3D3E32C1C274CE0533315A8C0ACDD', '/pmkpi/rectification/index', 'WFSTATUS', '审核状态', 2, 1, 0, 0, '0', 0, 1, null, '#name', null, 0, 100, 1, 'tree', null, null, null, null);



--整改-选择项目列表
delete from p#busfw_t_uicolumn where key in('/pmkpi/rectification/check/proj','/pmkpi/rectification/check/deptproj') and columncode ='TASKGUID';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG)
values ('D4D3D3E32C75274CE0533315A8C0ACDD', '/pmkpi/rectification/check/proj', 'TASKGUID', '任务名称', 8, 1, 0, 0, '0', 0, 1, null, '#name', null, 0, 100, 1, 'tree', '{isjk:1}', null, null, null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG)
values ('D4D3D3E32C79274CE0533315A8C0ACDD', '/pmkpi/rectification/check/deptproj', 'TASKGUID', '任务名称', 4, 1, 0, 0, null, 0, 1, null, '#name', null, null, 100, 1, 'tree', '{isjk:1}', null, null, null);



delete from bus_t_diccolumn where tablecode ='PERF_T_RECTIFY' and columncode ='TASKGUID';
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'PMKPITRACETASK', null, '0', 'TASKGUID', '1', null, null, '22ECED2DB35ECA7145F1A2EDCE17AA64', 'TASKGUID', 'PERF_T_RECTIFY', '任务guid', 'S', '4', null, null, 1, null, sysdate);


delete from bus_t_diccolumn where tablecode ='PERF_V_PROJECT_INFO' and columncode ='TASKGUID';
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'PMKPITRACETASK', null, '0', 'TASKGUID', '1', null, null, '22ECED2DB35ECA7145F1A2EDCE17AA76', 'TASKGUID', 'PERF_V_PROJECT_INFO', '任务名称', 'S', null, null, null, 1, null, sysdate);


delete from bus_t_diccolumn where tablecode ='V_PERF_V_DEPTPERFDECLARE' and columncode ='TASKGUID';
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'PMKPITRACETASK', null, '0', 'TASKGUID', '1', '2016', '87', 'B74F832B8B6603B0E0530100007FA999', 'TASKGUID', 'V_PERF_V_DEPTPERFDECLARE', '任务guid', 'S', '40', null, 1, 1, null, sysdate);



