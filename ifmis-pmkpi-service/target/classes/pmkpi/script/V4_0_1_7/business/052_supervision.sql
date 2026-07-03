begin

delete from bus_t_diccolumn where tablecode = 'PERF_T_SUPERVISION' and columncode = 'PROTYPE';

insert into bus_t_diccolumn (COLUMNID, DBCOLUMNCODE, COLUMNCODE, NAME, TABLECODE, DATATYPE, DATALENGTH,SCALE, NULLABLE, DEFAULTVALUE, DEID, CSID, ISSYS, ISUSES, VERSION)
values ('50E7AEB20E9E44DA8C0808FE95D25034', 'PROTYPE', 'PROTYPE', '监审类型', 'PERF_T_SUPERVISION', 'S', '32', null, 1, '', '', '', '0', '1', null);

delete from bus_t_diccolumn where tablecode = 'PERF_T_SUPERVISION' and columncode = 'INDEXGUID';

insert into bus_t_diccolumn (COLUMNID, DBCOLUMNCODE, COLUMNCODE, NAME, TABLECODE, DATATYPE, DATALENGTH,SCALE, NULLABLE, DEFAULTVALUE, DEID, CSID, ISSYS, ISUSES, VERSION)
values ('50E7AEB20E9E44DA8C0808FE95D25038', 'INDEXGUID', 'INDEXGUID', '指标ID', 'PERF_T_SUPERVISION', 'S', '32', null, 1, '', '', '', '0', '1', null);

delete from bus_t_diccolumn where tablecode = 'PERF_T_SUPERVISION' and columncode = 'ISADJ';

insert into bus_t_diccolumn (COLUMNID, DBCOLUMNCODE, COLUMNCODE, NAME, TABLECODE, DATATYPE, DATALENGTH,SCALE, NULLABLE, DEFAULTVALUE, DEID, CSID, ISSYS, ISUSES, VERSION)
values ('50E7AEB20E9E44DA8C0808FE95D25398', 'ISADJ', 'ISADJ', '指标调整状态', 'PERF_T_SUPERVISION', 'S', '32', null, 1, '', '', '', '0', '1', null);

delete from bus_t_diccolumn where tablecode = 'PERF_T_SUPERVISION' and columncode = 'ISADD';

insert into bus_t_diccolumn (COLUMNID, DBCOLUMNCODE, COLUMNCODE, NAME, TABLECODE, DATATYPE, DATALENGTH,SCALE, NULLABLE, DEFAULTVALUE, DEID, CSID, ISSYS, ISUSES, VERSION)
values ('50E7AEB20E9E44DA8C0808FE95D253AS', 'ISADD', 'ISADD', '指标是否新增', 'PERF_T_SUPERVISION', 'S', '32', null, 1, '', '', '', '0', '1', null);

delete from bus_t_diccolumn where tablecode = 'PERF_T_SUPERVISION' and columncode = 'TASKGUID';

insert into bus_t_diccolumn (COLUMNID, DBCOLUMNCODE, COLUMNCODE, NAME, TABLECODE, DATATYPE, DATALENGTH,SCALE, NULLABLE, DEFAULTVALUE, DEID, CSID, ISSYS, ISUSES, VERSION)
values ('50E7AEB20E9E44DA8C0808FE95D253AA', 'TASKGUID', 'TASKGUID', '一上二上任务ID', 'PERF_T_SUPERVISION', 'S', '32', null, 1, '', '', '', '0', '1', null);
