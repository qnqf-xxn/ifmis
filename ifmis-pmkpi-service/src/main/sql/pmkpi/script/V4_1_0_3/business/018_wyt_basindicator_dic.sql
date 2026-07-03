begin
  --部门指标库注册字段
delete from bus_t_diccolumn where COLUMNCODE in('PRO_LEV','PRO_PARENT') and tablecode ='BAS_PERF_INDICATOR';
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'PMKPIPROLEV', null, '0', 'PRO_LEV', '1', '2016', '87', '0809F8ECBA484DB9E0630A64A8C071B2', 'PRO_LEV', 'BAS_PERF_INDICATOR', '项目级次', 'S', '40', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'PMKPIPARENTPRO', null, '0', 'PRO_PARENT', '1', '2016', '87', '0809F8ECBA494DB9E0630A64A8C071B2', 'PRO_PARENT', 'BAS_PERF_INDICATOR', '上级项目', 'S', '2000', null, 1, 1, null, sysdate);

--上级项目数据源注册
delete from fasp_t_dicdssource where guid = 'PMKPIPARENTPRO';
insert into fasp_t_dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('PMKPIPARENTPRO', 'PMKPIPARENTPRO', 'PMKPIPARENTPRO', '上级项目名称', '1', null, null, null, '2016', '87', null, null, null, '2', 'select t.* from v_perf_t_indexcomfunc t where t.superid in(''01'',''021'',''022'',''023'')', null, 1, 'pmkpi');
