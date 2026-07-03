begin

delete from bus_t_diccolumn t where t.tablecode='PERF_PROJECT_INFO' and t.dbcolumncode in('CREATER');
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, '61006100UEw5VQ8y', null, '0', 'CREATER', '1', null, null, 'B61B314BC2145271E0530100007F17EC', 'CREATER', 'PERF_PROJECT_INFO', 'Ω®µ•»À', 'S', '32', null, 1, 1, null, sysdate);
