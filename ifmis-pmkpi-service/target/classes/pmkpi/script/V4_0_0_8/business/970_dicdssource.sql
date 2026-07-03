begin

delete from fasp_t_dicdssource t where t.code in('AUDITTYPE','CATEGORY','CREDITNO','EDUCATION',
'FILETYPE','INSTITUTIONAL','ISAUDIT','ISIMPORTANT','NATION','OLDOPINION','POLITICAL','PROBLEMTYPE',
'PROFESSIONAL','RELEASESTATUS','REVIEW','SCOPEBUSINESS','TYPE','WORKEXPERIE','PMKPIZBXS');

insert into Fasp_t_Dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('PMKPIZBXS', 'PMKPIZBXS', 'PMKPIZBXS', '计算符号', '1', '20180424221721795', '20180424', null, '2019', '653100', null, null, null, '2', 'SELECT t.code as guid,t.code ,t.name,t.status FROM v_perf_enum t where t.elementcode=''PMKPIZBXS'' order by t.ordernum', null, 1, 'pmkpi');

insert into Fasp_t_Dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('AUDITTYPE', 'AUDITTYPE', 'AUDITTYPE', '审核类型', '1', null, null, null, '2016', '87', null, null, null, '2', 'SELECT * FROM v_perf_enum t where t.elementcode=''AUDITTYPE'' order by t.ordernum', null, 1, 'pmkpi');

insert into Fasp_t_Dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('CATEGORY', 'CATEGORY', 'CATEGORY', '专家类别', '1', null, null, null, '2021', '87', null, null, null, '2', 'SELECT * FROM v_perf_enum t where t.elementcode=''CATEGORY'' order by t.ordernum', null, null, 'pmkpi');

insert into Fasp_t_Dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('CREDITNO', 'CREDITNO', 'CREDITNO', '信用等级', '1', null, null, null, '2021', '87', null, null, null, '2', 'SELECT * FROM v_perf_enum t where t.elementcode=''CREDITNO''', null, 1, 'pmkpi');

insert into Fasp_t_Dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('EDUCATION', 'EDUCATION', 'EDUCATION', '学历', '1', null, null, null, '2021', '87', null, null, null, '2', 'SELECT * FROM v_perf_enum t where t.elementcode=''EDUCATION'' order by t.ordernum', null, null, 'pmkpi');

insert into Fasp_t_Dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('FILETYPE', 'FILETYPE', 'FILETYPE', '文件类型', '1', null, null, null, '2021', '87', null, null, null, '2', 'SELECT * FROM v_perf_enum t where t.elementcode=''FILETYPE'' order by t.ordernum', null, null, 'pmkpi');

insert into Fasp_t_Dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('INSTITUTIONAL', 'INSTITUTIONAL', 'INSTITUTIONAL', '机构性质', '1', null, null, null, '2021', '87', null, null, null, '2', 'SELECT * FROM v_perf_enum t where t.elementcode=''INSTITUTIONAL''', null, 1, 'pmkpi');

insert into Fasp_t_Dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('ISAUDIT', 'ISAUDIT', 'ISAUDIT', '是否第三方参与审核', '1', null, null, null, '2016', '87', null, null, null, '2', 'SELECT * FROM v_perf_enum t where t.elementcode=''ISAUDIT'' order by t.ordernum', null, 1, 'pmkpi');

insert into Fasp_t_Dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('ISIMPORTANT', 'ISIMPORTANT', 'ISIMPORTANT', '是否重要', '1', null, null, null, '2021', '87', null, null, null, '2', 'SELECT * FROM v_perf_enum t where t.elementcode=''ISIMPORTANT'' order by t.ordernum', null, null, 'pmkpi');

insert into Fasp_t_Dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('NATION', 'NATION', 'NATION', '民族', '1', null, null, null, '2021', '87', null, null, null, '2', 'SELECT * FROM v_perf_enum t where t.elementcode=''NATION'' order by t.ordernum', null, null, 'pmkpi');

insert into Fasp_t_Dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('OLDOPINION', 'OLDOPINION', 'OLDOPINION', '历史建议', '1', null, null, null, '2016', '87', null, null, null, '2', 'SELECT * FROM v_perf_enum t where t.elementcode=''OLDOPINION'' order by t.ordernum', null, 1, 'pmkpi');

insert into Fasp_t_Dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('POLITICAL', 'POLITICAL', 'POLITICAL', '政治面貌', '1', null, null, null, '2021', '87', null, null, null, '2', 'SELECT * FROM v_perf_enum t where t.elementcode=''POLITICAL'' order by t.ordernum', null, null, 'pmkpi');

insert into Fasp_t_Dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('PROBLEMTYPE', 'PROBLEMTYPE', 'PROBLEMTYPE', '问题类型', '1', null, null, null, '2021', '87', null, null, null, '2', 'SELECT * FROM v_perf_enum t where t.elementcode=''PROBLEMTYPE'' order by t.ordernum', null, null, 'pmkpi');

insert into Fasp_t_Dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('PROFESSIONAL', 'PROFESSIONAL', 'PROFESSIONAL', '专业技术职称', '1', null, null, null, '2021', '87', null, null, null, '2', 'SELECT * FROM v_perf_enum t where t.elementcode=''PROFESSIONAL'' order by t.ordernum', null, null, 'pmkpi');

insert into Fasp_t_Dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('RELEASESTATUS', 'RELEASESTATUS', 'RELEASESTATUS', '发布状态', '1', null, null, null, '2021', '87', null, null, null, '2', 'SELECT * FROM v_perf_enum t where t.elementcode=''RELEASESTATUS'' order by t.ordernum', null, null, 'pmkpi');

insert into Fasp_t_Dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('REVIEW', 'REVIEW', 'REVIEW', '评审等级', '1', '20201116221721795', '20101116', null, '2016', '87', null, null, null, '2', 'SELECT * FROM v_perf_enum t where t.elementcode=''REVIEWOPINION'' order by t.ordernum', null, 1, 'pmkpi');

insert into Fasp_t_Dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('SCOPEBUSINESS', 'SCOPEBUSINESS', 'SCOPEBUSINESS', '业务范围', '1', null, null, null, '2021', '87', null, null, null, '2', 'SELECT * FROM v_perf_enum t where t.elementcode=''SCOPEBUSINESS''', null, 1, 'pmkpi');

insert into Fasp_t_Dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('TYPE', 'TYPE', 'TYPE', '标准类型', '1', null, null, null, '2021', '87', null, null, null, '2', 'SELECT * FROM v_perf_enum t where t.elementcode=''TYPE'' order by t.ordernum', null, null, 'pmkpi');

delete from fasp_t_dicdssource t where t.code in('PMKPISJDXZB1');
insert into fasp_t_dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('PMKPISJDXZB1', 'PMKPISJDXZB1', 'PMKPISJDXZB1', '定性指标值1', '1', '20180424221721795', '20180424', null, '2019', '653100', null, null, null, '1', '[{guid:"优",code:"优",name:"优"},{guid:"良",code:"良",name:"良"},{guid:"中",code:"中",name:"中"},{guid:"差",code:"差",name:"差"}]', null, 1, 'pmkpi');
