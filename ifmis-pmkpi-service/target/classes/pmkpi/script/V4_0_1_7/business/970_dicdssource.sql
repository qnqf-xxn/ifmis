begin
-- 整改类型  
delete from fasp_t_dicdssource where elementcode = 'RECTYPE';
insert into fasp_t_dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('RECTYPE', 'RECTYPE', 'RECTYPE', '整改类型', '1', '20160106155820402', '20160106', null, '2016', '87', null, null, null, '1', '[{guid:"1",code:"1",name:"整改"},{guid:"2",code:"2",name:"自评-整改"},{guid:"3",code:"3",name:"监控-整改"}]]', null, 1, null);

--导出模板配置-新增/修改按钮-表字段数据源
delete from fasp_t_dicdssource where code = 'PMKPIDICTABLE';
insert into fasp_t_dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('PMKPIDICTABLE', 'PMKPIDICTABLE', 'PMKPIDICTABLE', '绩效模板表表名', '1', '20210901113621631', '20150901', null, '2016', '87', null, null, '1', '2', 'select tablecode as guid,name, tablecode as code,status,'''' as superguid  from bus_t_dictable where appid = ''pmkpi'' and status = ''1''', null, 1, 'pmkpi');

--导出模板配置-列配置-表字段数据源
delete from fasp_t_dicdssource where code in('PMKPICOLUMNCODES', 'PMKPICOLUMNTYPES','PMKPICSIDS');
insert into fasp_t_dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('PMKPICOLUMNTYPES', 'PMKPICOLUMNTYPES', 'PMKPICOLUMNTYPES', '数据类型', '1', '20210901113621631', '20150901', null, '2016', '87', null, null, null, '2', 'select t.* from perf_t_datasource t where t.elementcode=''PMKPICOLUMNTYPES'' order by ordernum', null, 1, 'pmkpi');
insert into fasp_t_dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('PMKPICSIDS', 'PMKPICSIDS', 'PMKPICSIDS', '数据源', '1', '20210901113621631', '20150901', null, '2016', '87', null, null, null, '2', 'select * from  fasp_t_dicdssource where appid = ''pmkpi''', null, 1, 'pmkpi');
insert into fasp_t_dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('PMKPICOLUMNCODES', 'PMKPICOLUMNCODES', 'PMKPICOLUMNCODES', '表字段', '1', null, null, null, '2016', '87', null, null, null, '2', 'select distinct t.columncode as guid, t.columncode as code, t.name, ''1'' as status from FASP_T_DICCOLUMN t ', null, 1, 'pmkpi');

--审核结论
delete FROM fasp_t_dicdssource t where t.code='PMKPICONCLUSION';
insert into fasp_t_dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('PMKPICONCLUSION', 'PMKPICONCLUSION', 'PMKPICONCLUSION', '评审结论', '1', '20200613113621631', '20200613113621631', null, '2020', '87', null, null, '1', '2', 'select t.* from perf_t_datasource t where t.elementcode =''PMKPICONCLUSION''', null, 1, 'pmkpi');


--审核定义业务配置  选择审核定义数据源
delete from fasp_t_dicdssource where elementcode  ='AUDITDEFINE';
insert into fasp_t_dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('AUDITDEFINE', 'AUDITDEFINE', 'AUDITDEFINE', '选择审核定义', '1', null, null, null, '2016', '87', null, null, '1', '2', 'select t.guid,t.name,t.code,t.status from V_PERF_T_AUDITDEFINE t',sysdate, 1, 'pmkpi');

--部门数据源进行修改
delete from fasp_t_dicdssource t where t.elementcode='PMKPIDEPT';
insert into fasp_t_dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('PMKPIDEPT', 'PMKPIDEPT', 'PMKPIDEPT', '部门', '1', '20180613113621631', '20180101', null, '2016', '87', null, '201901', '1', '2', 'select * from PMKPI_FASP_T_PUBAGENCY where isleaf = 0 and length(guid)=3', sysdate, 1, 'pmkpi');
