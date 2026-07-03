begin

delete from bus_t_diccolumn t where t.tablecode='PERF_T_MODEL' and t.columncode='IS_DELETED';
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'IS_DELETED', '1', '2016', '87', 'E37F581A54202C17E0533315A8C0BDDA', 'IS_DELETED', 'PERF_T_MODEL', 'ÊÇ·ñÉ¾³ý', 'N', '1', null, 1, 1, null, sysdate);
