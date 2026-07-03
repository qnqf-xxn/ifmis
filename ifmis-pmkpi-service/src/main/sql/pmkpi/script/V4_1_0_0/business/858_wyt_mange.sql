begin

--绩效工作管理考核任务类型数据源
DELETE FROM Fasp_t_Dicdssource t where t.guid in ('PMKPIASSESSMENTBYOBJ');
insert into Fasp_t_Dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('PMKPIASSESSMENTBYOBJ', 'PMKPIASSESSMENTBYOBJ', 'PMKPIASSESSMENTBYOBJ', '任务类型', '1', '20201116221721795', '20101116', null, '2016', '87', null, null, null, '2', 'SELECT t.* FROM v_perf_enum t where t.elementcode=''PMKPIASSESSMENTBYOBJ'' order by t.ordernum', null, 1, 'pmkpi');
