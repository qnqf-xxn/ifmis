begin

delete from fasp_t_dicdssource t where t.guid in('PMKPIPERFTASK','PMKPITASKSTAGE');
insert into fasp_t_dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('PMKPIPERFTASK', 'PMKPIPERFTASK', 'PMKPIPERFTASK', '绩效任务类型', '1', null, null, null, '2020', '87', null, null, null, '2', 'select t.* from perf_t_datasource t where t.elementcode=''perftask'' order by ordernum', null, 1, 'pmkpi');

insert into fasp_t_dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('PMKPITASKSTAGE', 'PMKPITASKSTAGE', 'PMKPITASKSTAGE', '绩效任务阶段', '1', null, null, null, '2020', '87', null, null, null, '2', 'select t.* from perf_t_datasource t where t.elementcode=''taskstage'' order by ordernum', null, 1, 'pmkpi');

delete from fasp_t_dicdssource t where t.guid in('PMKPICOMPLETEANALYSIS','PMKPIDEVIATIONANALYSIS');
insert into fasp_t_dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('PMKPICOMPLETEANALYSIS', 'PMKPICOMPLETEANALYSIS', 'PMKPICOMPLETEANALYSIS', '绩效监控完成可行性分析', '1', null, null, null, '2020', '87', null, null, null, '2', 'select t.* from perf_t_datasource t where t.elementcode=''completeanalysis'' order by ordernum', null, 1, 'pmkpi');

insert into fasp_t_dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('PMKPIDEVIATIONANALYSIS', 'PMKPIDEVIATIONANALYSIS', 'PMKPIDEVIATIONANALYSIS', '绩效监控偏差原因分析', '1', null, null, null, '2020', '87', null, null, null, '2', 'select t.* from perf_t_datasource t where t.elementcode=''dviationanalysis'' order by ordernum', null, 1, 'pmkpi');




DELETE FROM Fasp_t_Dicdssource t where t.guid in ('TYPE','RELEASESTATUS','PROBLEMTYPE','ISIMPORTANT',
'INSTITUTIONAL','CREDITNO','SCOPEBUSINESS','CATEGORY','POLITICAL','EDUCATION','NATION',
'PROFESSIONAL','WORKEXPERIE','FILETYPE');
insert into Fasp_t_Dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('TYPE', 'TYPE', 'TYPE', '标准类型', '1', null, null, null, '2021', '87', null, null, null, '2', 'SELECT * FROM perf_enum t where t.elementcode=''TYPE'' order by t.ordernum', null, null, 'pmkpi');

insert into Fasp_t_Dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('RELEASESTATUS', 'RELEASESTATUS', 'RELEASESTATUS', '发布状态', '1', null, null, null, '2021', '87', null, null, null, '2', 'SELECT * FROM perf_enum t where t.elementcode=''RELEASESTATUS'' order by t.ordernum', null, null, 'pmkpi');

insert into Fasp_t_Dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('PROBLEMTYPE', 'PROBLEMTYPE', 'PROBLEMTYPE', '问题类型', '1', null, null, null, '2021', '87', null, null, null, '2', 'SELECT * FROM perf_enum t where t.elementcode=''PROBLEMTYPE'' order by t.ordernum', null, null, 'pmkpi');

insert into Fasp_t_Dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('ISIMPORTANT', 'ISIMPORTANT', 'ISIMPORTANT', '是否重要', '1', null, null, null, '2021', '87', null, null, null, '2', 'SELECT * FROM perf_enum t where t.elementcode=''ISIMPORTANT'' order by t.ordernum', null, null, 'pmkpi');

insert into Fasp_t_Dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('INSTITUTIONAL', 'INSTITUTIONAL', 'INSTITUTIONAL', '机构性质', '1', null, null, null, '2021', '87', null, null, null, '2', 'SELECT * FROM perf_enum t where t.elementcode=''INSTITUTIONAL''', null, 1, 'pmkpi');

insert into Fasp_t_Dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('CREDITNO', 'CREDITNO', 'CREDITNO', '信用等级', '1', null, null, null, '2021', '87', null, null, null, '2', 'SELECT * FROM perf_enum t where t.elementcode=''CREDITNO''', null, 1, 'pmkpi');

insert into Fasp_t_Dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('SCOPEBUSINESS', 'SCOPEBUSINESS', 'SCOPEBUSINESS', '业务范围', '1', null, null, null, '2021', '87', null, null, null, '2', 'SELECT * FROM perf_enum t where t.elementcode=''SCOPEBUSINESS''', null, 1, 'pmkpi');

insert into Fasp_t_Dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('CATEGORY', 'CATEGORY', 'CATEGORY', '专家类别', '1', null, null, null, '2021', '87', null, null, null, '2', 'SELECT * FROM perf_enum t where t.elementcode=''CATEGORY'' order by t.ordernum', null, null, 'pmkpi');

insert into Fasp_t_Dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('POLITICAL', 'POLITICAL', 'POLITICAL', '政治面貌', '1', null, null, null, '2021', '87', null, null, null, '2', 'SELECT * FROM perf_enum t where t.elementcode=''POLITICAL'' order by t.ordernum', null, null, 'pmkpi');

insert into Fasp_t_Dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('EDUCATION', 'EDUCATION', 'EDUCATION', '学历', '1', null, null, null, '2021', '87', null, null, null, '2', 'SELECT * FROM perf_enum t where t.elementcode=''EDUCATION'' order by t.ordernum', null, null, 'pmkpi');

insert into Fasp_t_Dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('NATION', 'NATION', 'NATION', '民族', '1', null, null, null, '2021', '87', null, null, null, '2', 'SELECT * FROM perf_enum t where t.elementcode=''NATION'' order by t.ordernum', null, null, 'pmkpi');

insert into Fasp_t_Dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('PROFESSIONAL', 'PROFESSIONAL', 'PROFESSIONAL', '专业技术职称', '1', null, null, null, '2021', '87', null, null, null, '2', 'SELECT * FROM perf_enum t where t.elementcode=''PROFESSIONAL'' order by t.ordernum', null, null, 'pmkpi');

insert into Fasp_t_Dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('WORKEXPERIE', 'WORKEXPERIE', 'WORKEXPERIE', '工作经验', '1', null, null, null, '2021', '87', null, null, null, '2', 'SELECT * FROM perf_enum t where t.elementcode=''WORKEXPERIE'' order by t.ordernum', null, null, 'pmkpi');

insert into Fasp_t_Dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('FILETYPE', 'FILETYPE', 'FILETYPE', '文件类型', '1', null, null, null, '2021', '87', null, null, null, '2', 'SELECT * FROM perf_enum t where t.elementcode=''FILETYPE'' order by t.ordernum', null, null, 'pmkpi');

delete from fasp_t_dicdssource t where t.code in('PMKPIDATATYPE');
insert into fasp_t_dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('PMKPIDATATYPE', 'PMKPIDATATYPE', 'PMKPIDATATYPE', '数据状态', '1', null, null, null, '2020', '87', null, null, null, '2', 'select t.* from perf_t_datasource t where t.elementcode=''datatype'' order by ordernum', null, 1, 'pmkpi');

delete from fasp_t_dicdssource t where t.code in('REVIEW');
insert into Fasp_t_Dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('REVIEW', 'REVIEW', 'REVIEW', '评审等级', '1', '20201116221721795', '20101116', null, '2016', '87', null, null, null, '2', 'SELECT * FROM perf_enum t where t.elementcode=''REVIEWOPINION'' order by t.ordernum', null, 1, 'pmkpi');

delete from fasp_t_dicdssource t where t.code in('ISAUDIT','AUDITTYPE','OLDOPINION');
insert into Fasp_t_Dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('ISAUDIT', 'ISAUDIT', 'ISAUDIT', '是否第三方参与审核', '1', null, null, null, '2016', '87', null, null, null, '2', 'SELECT * FROM perf_enum t where t.elementcode=''ISAUDIT'' order by t.ordernum', null, 1, 'pmkpi');

insert into Fasp_t_Dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('AUDITTYPE', 'AUDITTYPE', 'AUDITTYPE', '审核类型', '1', null, null, null, '2016', '87', null, null, null, '2', 'SELECT * FROM perf_enum t where t.elementcode=''AUDITTYPE'' order by t.ordernum', null, 1, 'pmkpi');

insert into Fasp_t_Dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('OLDOPINION', 'OLDOPINION', 'OLDOPINION', '历史建议', '1', null, null, null, '2016', '87', null, null, null, '2', 'SELECT * FROM perf_enum t where t.elementcode=''OLDOPINION'' order by t.ordernum', null, 1, 'pmkpi');

delete from fasp_t_dicdssource t where t.code in('ISGROUP');
insert into Fasp_t_Dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('ISGROUP', 'ISGROUP', 'ISGROUP', '是否分组', '1', '20151015095618892', '20151015', null, '2016', '87', 'f06', '200100', '1', '1', '[{guid:"1",code:"1",name:"是"},{guid:"0",code:"0",name:"否"}]', null, 1, 'pmkpi');
