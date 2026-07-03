begin

delete from bus_t_diccolumn t where t.tablecode='PM_PERF_GOAL_INFO' and t.columncode in('STATUS');
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'STATUS', '1', '2016', '87', 'E524C30FC520797BE0533315A8C03033', 'STATUS', 'PM_PERF_GOAL_INFO', 'STATUS', 'N', '1', null, 1, 1, null, sysdate);
