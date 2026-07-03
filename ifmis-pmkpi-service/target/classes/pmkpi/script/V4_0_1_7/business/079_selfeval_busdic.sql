begin

--自评布置-项目
--select * from Bus_t_Diccolumn where COLUMNID = 'BCB59A7C05F2A02F4053B11FA8C0D3A3';
delete from Bus_t_Diccolumn where COLUMNID = 'BCB59A7C05F2A02F4053B11FA8C0D3A3';
insert into Bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'PRO_CODE', '1', '2016', '87', 'BCB59A7C05F2A02F4053B11FA8C0D3A3', 'PRO_CODE', 'V_PERF_V_SELFEVALPROGRAMS', '项目编码', 'S', '200', null, 1, 1, null, sysdate);

--自评布置-部门
--select t.rowid,t.* from  Bus_t_Diccolumn t where tablecode = 'V_PERF_V_SELFEVALDEPT' and columncode =  'PRO_CODE';
--select * from Bus_t_Diccolumn where COLUMNID = 'PERFSELFEVALDEPT013';
delete from Bus_t_Diccolumn where COLUMNID = 'PERFSELFEVALDEPT013';
insert into Bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'PRO_CODE', '1', '2016', '87', 'PERFSELFEVALDEPT013', 'PRO_CODE', 'V_PERF_V_SELFEVALDEPT', '项目编码', 'S', '200', null, 1, 1, null, sysdate);

--自评查询、填报、审核列表
--select * from Bus_t_Diccolumn where tablecode = 'PERF_T_SELFEVALTASK' and columncode = 'PRO_CODE';
delete from Bus_t_Diccolumn where tablecode = 'PERF_T_SELFEVALTASK' and columncode = 'PRO_CODE';
insert into Bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'PRO_CODE', '1', '2016', '87', 'CA4AF3E280E96552E0533315A8C0B212', 'PRO_CODE', 'PERF_T_SELFEVALTASK', '项目编码', 'S', '200', null, 1, 1, null, sysdate);

--1.绩效自评指标
--select * from Bus_t_Diccolumn where tablecode = 'PERF_T_SELFPERFINDEX' and columncode = 'PRO_CODE';
delete from Bus_t_Diccolumn where tablecode = 'PERF_T_SELFPERFINDEX' and columncode = 'PRO_CODE';
insert into Bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'PRO_CODE', '1', '2016', '87', 'CA5A679FE6B73029E0533315A8C03B10', 'PRO_CODE', 'PERF_T_SELFPERFINDEX', '项目编码', 'S', '200', null, 1, 1, null, sysdate);

--2.自评补充信息表
--select * from Bus_t_Diccolumn where tablecode = 'PERF_T_SELFPERFDESC' and columncode = 'PRO_CODE';
delete from Bus_t_Diccolumn where tablecode = 'PERF_T_SELFPERFDESC' and columncode = 'PRO_CODE';
insert into Bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'PRO_CODE', '1', '2016', '87', 'CA5A8996C5ED3561E0533315A8C0150D', 'PRO_CODE', 'PERF_T_SELFPERFDESC', '项目编码', 'S', '200', null, 1, 1, null, sysdate);
























