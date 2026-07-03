begin

delete from fasp_t_dicdssource a where a.guid in('PMKPIFRAME','PMKPIFRAMESYSTEM');
insert into fasp_t_dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('PMKPIFRAME', 'PMKPIFRAME', 'PMKPIFRAME', '共性指标层次分类', '1', '20190508135902672', '20161208', null, '2016', '87', null, null, null, '2', 'select * from v_perf_t_frame', sysdate, 1, 'pmkpi');

insert into fasp_t_dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('PMKPIFRAMESYSTEM', 'PMKPIFRAMESYSTEM', 'PMKPIFRAMESYSTEM', '绩效指标体系', '1', '20180424221721795', '20180424', null, '2016', '87', null, null, null, '2', 'select t.guid,code,name ,''00'' superguid,1 levelno,1 isleaf from v_perf_t_framesystem t', sysdate, 1, 'pmkpi');

delete from fasp_t_dicdssource t where t.CODE='PMKPIDEPT';

insert into fasp_t_dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('PMKPIDEPT', 'PMKPIDEPT', 'PMKPIDEPT', '部门', '1', '20180613113621631', '20180101', '', '2016', '87', '', '201901', '1', '2', 'select * from PMKPI_FASP_T_PUBAGENCY where isleaf = 0', sysdate,  1, 'pmkpi');

delete from fasp_t_dicdssource where code = 'AUDITDEFINE';

insert into fasp_t_dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('AUDITDEFINE', 'AUDITDEFINE', 'AUDITDEFINE', '选择审核定义', '1', null, null, null, '2016', '87', null, null, '1', '2', 'select t.guid,t.name,t.code from PERF_T_AUDITDEFINE t', sysdate, 1, 'pmkpi');


delete from fasp_t_dicdssource t where t.CODE='VIEWCODE';
insert into fasp_t_dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('VIEWCODE', 'VIEWCODE', 'VIEWCODE', '审核定义视图表', '1', null, null, null, '2016', '87', null, null, '1', '2', 'select t.guid,t.name,t.code from perf_t_customauditview t', sysdate,  1, 'pmkpi');

delete from fasp_t_dicdssource t where t.CODE='PMKPIAUDITTYPECFG';

insert into fasp_t_dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('PMKPIAUDITTYPECFG', 'PMKPIAUDITTYPECFG', 'PMKPIAUDITTYPECFG', '绩效审核流程配置', '1', '', '', '', '2016', '87', '', '', '', '1', '[{guid:"opinion",code:"opinion",name:"意见审核"},{guid:"nature",code:"nature",name:"四性审核"}]', sysdate, null, '');


delete from fasp_t_dicdssource t where t.guid in('PMKPIPERFTASK','PMKPITASKSTAGE');
insert into fasp_t_dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('PMKPIPERFTASK', 'PMKPIPERFTASK', 'PMKPIPERFTASK', '绩效任务类型', '1', null, null, null, '2020', '87', null, null, null, '2', 'select t.* from perf_t_datasource t where t.elementcode=''perftask''', null, 1, 'pmkpi');

insert into fasp_t_dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('PMKPITASKSTAGE', 'PMKPITASKSTAGE', 'PMKPITASKSTAGE', '绩效任务阶段', '1', null, null, null, '2020', '87', null, null, null, '2', 'select t.* from perf_t_datasource t where t.elementcode=''taskstage''', null, 1, 'pmkpi');

delete from fasp_t_dicdssource t where t.code='PMKPIWFSTATUS';
insert into fasp_t_dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('PMKPIWFSTATUS', 'PMKPIWFSTATUS', 'PMKPIWFSTATUS', '工作流状态-绩效', '1', null, null, null, '2020', '87', null, '201901', null, '2', 'select * from pmkpi_t_wfstatus', null, 1, 'pmkpi');

delete from fasp_t_dicdssource t where t.code='PMKPIAGENCYALLPAY';
insert into fasp_t_dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('PMKPIAGENCYALLPAY', 'PMKPIAGENCYALLPAY', 'PMKPIAGENCYALLPAY', '绩效单位', '1', null, null, null, '2020', '87', 'f252', '201901', '2', '3', 'pmkpi_fasp_t_pubagency', null, 1, 'pmkpi');
