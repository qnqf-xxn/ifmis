begin

delete from bus_t_diccolumn t where t.tablecode='PERF_T_RECTIFY' and t.columncode in('PRO_LEV');
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'PRO_LEV', '1', '2016', '87', 'F93579FFE983708EE0533315A8C0411D', 'PRO_LEV', 'PERF_T_RECTIFY', '项目级次', 'S', '20', null, null, 1, null, sysdate);
