begin

delete from fasp_t_dicdssource t where t.elementcode in('PERFIYESORNO','PMKPIBOOLTYPE','PMKPIPROTRACEINDEX');
insert into fasp_t_dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('PERFIYESORNO', 'PERFIYESORNO', 'PERFIYESORNO', '是/否', '1', '20230423145546213', '20230423145546213', null, '2023', '87', null, null, null, '2', 'select * from perf_t_datasource t where elementcode=''ISCHECKTAB''', sysdate, 1, 'pmkpi');

insert into fasp_t_dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('PMKPIPROTRACEINDEX', 'PMKPIPROTRACEINDEX', 'PMKPIPROTRACEINDEX', '监控定性指标实际完成值', '1', '20230423180100000', '20230423180100000', null, '2023', '87', null, null, null, '2', 'select t.* from perf_t_datasource t where t.elementcode =''protraceindex'' order by ordernum', sysdate, 1, 'pmkpi');


delete from fasp_t_dicdssource t where t.elementcode in('PMKPIADJUSTADVICE');
insert into fasp_t_dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('PMKPIADJUSTADVICE', 'PMKPIADJUSTADVICE', 'PMKPIADJUSTADVICE', '整改反馈预算调整建议', '1', null, null, null, '2016', '87', null, null, null, '2', 'select t.* from v_perf_enum t where t.elementcode=''PMKPIADJUSTADVICE'' order by ordernum', sysdate, 1, 'pmkpi');

