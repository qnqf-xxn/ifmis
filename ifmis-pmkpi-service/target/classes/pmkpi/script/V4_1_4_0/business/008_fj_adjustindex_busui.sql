begin
  
delete from bus_t_diccolumn where tablecode = 'PERF_T_ADJUSTINDEX' and columncode in ('ISALLOWEDIT','ONLYSELF');
  
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'VD00001', null, '1', 'ISALLOWEDIT', '1', '2016', '87', sys_guid(), 'ISALLOWEDIT', 'PERF_T_ADJUSTINDEX', '是否允许编辑', 'N', '1', null, 1, 1, null, sysdate);
  
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'VD00001', null, '1', 'ONLYSELF', '1', '2016', '87', sys_guid(), 'ONLYSELF', 'PERF_T_ADJUSTINDEX', '仅本级适用', 'N', '1', null, 1, 1, null, sysdate);



