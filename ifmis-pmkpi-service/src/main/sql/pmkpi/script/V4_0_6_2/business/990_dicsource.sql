begin

delete from fasp_t_dicdssource t where t.guid='CONAUDITTYPE';
insert into fasp_t_dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('CONAUDITTYPE', 'CONAUDITTYPE', 'CONAUDITTYPE', '’„Ω≠…Û∫ÀΩ·¬€', '1', null, null, null, '2016', '87', null, null, null, '2', 'select code as guid,code,name,status from v_perf_enum where elementcode = ''PERFCONREVIEW'' order by ordernum', null, 1, 'pmkpi');
