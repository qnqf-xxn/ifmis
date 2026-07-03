begin

delete from bus_t_diccolumn t where t.tablecode='PERF_T_ASSESSMENT' and t.columncode in('BUSTYPE');
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'PERFASSESSMENTTYPE', null, '1', 'BUSTYPE', '1', '2016', '87', 'FF2BB36799302BF4E0533315A8C0AF97', 'BUSTYPE', 'PERF_T_ASSESSMENT', '类型', 'S', '40', null, 1, 0, null, sysdate);

delete from fasp_t_dicdssource t where t.guid='PERFASSESSMENTTYPE';
insert into fasp_t_dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('PERFASSESSMENTTYPE', 'PERFASSESSMENTTYPE', 'PERFASSESSMENTTYPE', '事前绩效评估类型', '1', null, null, null, '2023', '87', null, null, null, '2', 'select t.*,guid as itemid,''0'' as superitemid from v_perf_enum t where elementcode = ''PERFASSESSMENTTYPE'' order by ordernum', null, 1, 'pmkpi');
