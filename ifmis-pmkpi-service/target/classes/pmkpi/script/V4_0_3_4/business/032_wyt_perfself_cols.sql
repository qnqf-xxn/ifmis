begin
  --自评任务布置列表加字段
delete from bus_t_diccolumn where tablecode ='PERF_T_SELFEVALTASK' and columncode in('BGTAMT','PRO_TOTAL_AMT');
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'BGTAMT', '1', '2021', '87', 'F3C5A7A4AC683AE1E0533315A8C012C1', 'BGTAMT', 'PERF_T_SELFEVALTASK', '当年预算金额', 'N', '20', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'PRO_TOTAL_AMT', '1', '2021', '87', 'F3C5A7A4AC673AE1E0533315A8C012C1', 'PRO_TOTAL_AMT', 'PERF_T_SELFEVALTASK', '项目总额', 'N', '20', null, 1, 1, null, sysdate);




delete from p#busfw_t_uicolumn where key ='/pmkpi/perfself/taskmanage' and columncode in('BGTAMT','PRO_TOTAL_AMT');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,  ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/perfself/taskmanage', 'PRO_TOTAL_AMT', '项目总金额', 13, 1, 0, 0, null, 0, 1, null, null, null, null, 100, 0, 's', '{type:"program"}', null,  null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,  ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/perfself/taskmanage', 'BGTAMT', '当年预算金额', 14, 1, 0, 0, null, 0, 1, null, null, null, null, 100, 0, 's', '{type:"program"}', null,  null, null);

