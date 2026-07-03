  i number;
begin

--dic
delete from Bus_t_Diccolumn where tablecode = 'PERF_T_EVALUATETEMP' and columncode = 'EVALUATIONRULE';
insert into Bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'EVALUATIONRULE', '1', '2016', '87', 'D613341C954E1822E0533315A8C006A3', 'EVALUATIONRULE', 'PERF_T_EVALUATETEMP', '∆¿ø€∑÷œ∏‘Ú', 'S', '255', null, 1, 1, null, sysdate);
