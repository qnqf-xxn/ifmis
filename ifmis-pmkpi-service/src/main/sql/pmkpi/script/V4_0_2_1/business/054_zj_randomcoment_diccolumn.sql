begin
  --抽评委托机构
delete from bus_t_diccolumn where dbcolumncode = 'MEACHNAME' and tablecode = 'PERF_T_RANDOMCOMMENT_PROJ';
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'MEACHGUID', null, '1', 'MEACHNAME', '1', '2016', '87', '6E33D27EE1FPPPBBE053D100A8C03BE3', 'MEACHNAME', 'PERF_T_RANDOMCOMMENT_PROJ', '委托机构', 'S', '40', null, null, 1, null, sysdate);
delete from bus_t_diccolumn where dbcolumncode = 'AGENCYGUID' and tablecode = 'PERF_T_RANDOMCOMMENT_PROJ';
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values ('DE03002', 'VD00010', null, '0', 'AGENCYGUID', '1', '2016', '87', '6DB99313FBB53659E053D100A8C0EE70', 'AGENCYGUID', 'PERF_T_RANDOMCOMMENT_PROJ', '预算单位', 'S', '50', null, null, 1, null, sysdate);

delete from fasp_t_dicdssource where GUID = 'MEACHGUID';
insert into fasp_t_dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('MEACHGUID', 'MEACHGUID', 'MEACHGUID', '委托机构', '1', '20151118132048005', '20151118', null, '2016', '87', 'f378', '200400', '1', '2', 'select guid as guid,guid as code,agencyname as name,''#'' as superguid,1 as levelno,1 as isleaf from PMKPI_V_AGENCY', null, 1, null);

