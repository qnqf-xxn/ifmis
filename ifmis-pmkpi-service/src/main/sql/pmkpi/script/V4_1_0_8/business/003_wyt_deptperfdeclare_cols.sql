begin
  --部门申报列表添加金额字段，默认隐藏
delete from p#busfw_t_uicolumn t where key in('/pmkpi/deptperformance/query/index') and columncode ='TASKTOALAMT';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/deptperformance/query/index', 'TASKTOALAMT', '金额', 5, 0, 0, 0, null, 0, 1, null, null, null, null, 100, 0, 'amt', null, null,  null, null);

delete from p#busfw_t_uicolumn t where key in('/pmkpi/deptperformance/audit/index') and columncode ='TASKTOALAMT';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/deptperformance/audit/index', 'TASKTOALAMT', '金额', 5, 0, 0, 0, null, 0, 1, null, null, null, null, 100, 0, 'amt', null, null,  null, null);

delete from p#busfw_t_uicolumn t where key in('/pmkpi/deptperformance/report/index') and columncode ='TASKTOALAMT';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/deptperformance/report/index', 'TASKTOALAMT', '金额', 5, 0, 0, 0, null, 0, 1, null, null, null, null, 100, 0, 'amt', null, null,  null, null);

--表字段注册金额字段
delete from bus_t_diccolumn where tablecode ='PERF_T_DEPTPERFDECLARE' and columncode ='TASKTOALAMT';
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'TASKTOALAMT', '1', '2016', '87', '10DA8DEAA52B14B7E0630A64A8C01F1D', 'TASKTOALAMT', 'PERF_T_DEPTPERFDECLARE', '年度任务总金额', 'N', '20', 5, 1, 1, null, sysdate);

