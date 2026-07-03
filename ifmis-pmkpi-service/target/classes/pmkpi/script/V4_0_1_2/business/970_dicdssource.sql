begin

DELETE FROM Fasp_t_Dicdssource t where t.guid in ('PMKPIASSESSMENTBYOBJ','PMKPIASSESSMENTBYYEAR','PMKPIEVALUATETASKTYPE','WORKEXPERIE');
insert into Fasp_t_Dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('PMKPIASSESSMENTBYOBJ', 'PMKPIASSESSMENTBYOBJ', 'PMKPIASSESSMENTBYOBJ', '任务类型', '1', '20201116221721795', '20101116', null, '2016', '87', null, null, null, '2', 'SELECT t.*,t.SUPERID as superguid FROM v_perf_enum t where t.elementcode=''PMKPIASSESSMENTBYOBJ'' order by t.ordernum', null, 1, 'pmkpi');

insert into Fasp_t_Dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('PMKPIASSESSMENTBYYEAR', 'PMKPIASSESSMENTBYYEAR', 'PMKPIASSESSMENTBYYEAR', '考核年度', '1', '20201116221721795', '20101116', null, '2016', '87', null, null, null, '2', 'SELECT * FROM perf_t_datasource t where t.elementcode=''PMKPIASSESSMENTBYYEAR'' order by t.ordernum', null, 1, 'pmkpi');

insert into Fasp_t_Dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('PMKPIEVALUATETASKTYPE', 'PMKPIEVALUATETASKTYPE', 'PMKPIEVALUATETASKTYPE', '考核对象', '1', '20201116221721795', '20101116', null, '2016', '87', null, null, null, '2', 'SELECT * FROM perf_t_datasource t where t.elementcode=''PMKPIEVALUATETASKTYPE'' order by t.ordernum', null, 1, 'pmkpi');

insert into fasp_t_dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('WORKEXPERIE', 'WORKEXPERIE', 'WORKEXPERIE', '工作经验', '1', null, null, null, '2016', '87', null, null, null, '2', 'SELECT * FROM v_perf_enum t where t.elementcode=''WORKEXPERIE'' order by t.ordernum', null, null, 'pmkpi');


delete from fasp_t_dicdssource where guid ='ISLEAF';
insert into fasp_t_dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('ISLEAF', 'ISLEAF', 'ISLEAF', '是否末节点', '1', '20210518113621631', '20150901', null, '2016', '87', null, null, null, '1', '[{guid:"0",code:"0",name:"否"},{guid:"1",code:"1",name:"是"}]', null, 1, 'pmkpi');

delete from fasp_t_dicdssource where guid ='BUSSTYPE';
insert into fasp_t_dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('BUSSTYPE', 'BUSSTYPE', 'BUSSTYPE', '业务类型', '1', '20210518113621631', '20150901', null, '2016', '87', null, null, null, '1', '[{guid:"0",code:"0",name:"项目"},{guid:"1",code:"1",name:"部门"}]', null, 1, 'pmkpi');

