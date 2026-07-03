begin
  
delete from bus_t_diccolumn t where t.tablecode='PERF_T_SELFPERFDESC' and t.columncode in('BGTRATE','BGTREMARK');
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'BGTRATE', '1', '2021', '87', '4FDF2DBE92F15132E063030011AC1AC6', 'BGTRATE', 'PERF_T_SELFPERFDESC', '预算调整率', 'N', '8', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'BGTREMARK', '1', '2021', '87', '5007A1AED1F40E1BE063030011AC778E', 'BGTREMARK', 'PERF_T_SELFPERFDESC', '预算调整超30%原因说明', 'S', '4000', null, 1, 1, null, sysdate);


delete from p#busfw_t_uieditform t where t.key in('/pmkpi/perfself/apply/edit/selfdesc') and t.columncode in('BGTRATE','BGTREMARK');
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR, HEAD, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/perfself/apply/edit/selfdesc', 'V_PERF_T_SELFPERFDESC', 's', '预算调整率（%）', 'BGTRATE', 0, null, 0, null, 3, null, null, 'pmkpi', 0, null, '{}', null, null, null, '87', '2016', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR, HEAD, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/perfself/apply/edit/selfdesc', 'V_PERF_T_SELFPERFDESC', 'textarea', '预算调整超30%原因说明', 'BGTREMARK', 0, null, 0, null, 9, 3, '4', 'pmkpi', 1, null, '{}', null, null, null, '87', '2016', null, null, null);
