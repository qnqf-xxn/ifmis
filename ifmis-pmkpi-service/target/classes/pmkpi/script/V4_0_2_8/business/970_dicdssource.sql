begin

delete from fasp_t_dicdssource t where t.elementcode in('PERFGXCLASSIFICATION','PERFVALUECHANGE','PERFDATATYPE');
insert into fasp_t_dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('PERFGXCLASSIFICATION', 'PERFGXCLASSIFICATION', 'PERFGXCLASSIFICATION', '广西案例分类', '1', null, null, null, '2022', '87', null, null, null, '2', 'select t.*,t.superid superguid from v_perf_enum t where t.elementcode=''PERFGXCLASSIFICATION'' order by ordernum', null, 1, 'pmkpi');

insert into fasp_t_dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('PERFVALUECHANGE', 'PERFVALUECHANGE', 'PERFVALUECHANGE', '指标值变动情况', '1', null, null, null, '2022', '87', null, null, null, '2', 'select t.* from perf_t_datasource t where t.elementcode=''PERFVALUECHANGE'' order by ordernum', null, 1, 'pmkpi');

insert into fasp_t_dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('PERFDATATYPE', 'PERFDATATYPE', 'PERFDATATYPE', '数据状态', '1', null, null, null, '2020', '87', null, null, null, '2', 'select t.* from perf_t_datasource t where t.elementcode=''perfdatatype'' order by ordernum', null, 1, 'pmkpi');
