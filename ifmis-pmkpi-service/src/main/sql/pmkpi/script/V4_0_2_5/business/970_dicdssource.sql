begin

DELETE from fasp_t_dicdssource t where t.elementcode='PMKPIREASONTYPE';
insert into fasp_t_dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('PMKPIREASONTYPE', 'PMKPIREASONTYPE', 'PMKPIREASONTYPE', '绩效原因类型', '1', '20201116221721795', '20101116', null, '2016', '87', null, null, null, '2', 'select t.* from perf_t_datasource t where t.elementcode =''REASONTYPE'' order by ordernum', null, 1, 'pmkpi');
