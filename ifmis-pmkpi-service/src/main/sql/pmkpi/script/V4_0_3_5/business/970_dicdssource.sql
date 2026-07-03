begin

delete from fasp_t_dicdssource t where t.elementcode in('PERFGXCLASSIFICATION');
insert into fasp_t_dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('PERFGXCLASSIFICATION', 'PERFGXCLASSIFICATION', 'PERFGXCLASSIFICATION', '广西案例分类', '1', null, null, null, '2022', '87', null, null, null, '2', 'select t.* from v_perf_enum t where t.elementcode=''PERFGXCLASSIFICATION'' order by ordernum', null, 1, 'pmkpi');