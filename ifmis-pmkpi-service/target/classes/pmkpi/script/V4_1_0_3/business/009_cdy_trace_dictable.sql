begin

delete from bus_t_diccolumn where  tablecode ='PERF_V_PROMONITOR' and COLUMNCODE in('TASKNAME');

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'TASKNAME', '1', null, null, '071D36C3D3264145E0633315A8C0FED1', 'TASKNAME', 'PERF_V_PROMONITOR', 'ÈÎÎñÃû³Æ', 'S', '50', null, null, 1, null,sysdate);
