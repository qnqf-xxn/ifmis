begin
  
delete from bus_t_diccolumn t where t.tablecode in('PERF_T_PROMONITOR') and t.columncode='STAGEBGTAMT';
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'STAGEBGTAMT', '1', '2020', '87', '22ED432532F42499E063020011ACC699', 'STAGEBGTAMT', 'PERF_T_PROMONITOR', '½×¶ÎÔ¤ËãÖ´ÐÐÊý', 'N', '20', null, 1, 1, null, sysdate);
