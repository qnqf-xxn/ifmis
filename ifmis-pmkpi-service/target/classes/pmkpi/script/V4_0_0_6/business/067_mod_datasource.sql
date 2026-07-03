begin
delete FROM Fasp_t_Dicdssource t where t.elementcode = 'IDEXCOMCLS';
insert into Fasp_t_Dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('IDEXCOMCLS', 'IDEXCOMCLS', 'IDEXCOMCLS', '共性指标项目分类', '1', '20180613113621631', '20180613113621631', null, '2020', '87', null, null, '1', '2', 'select * from v_perf_enum where elementcode = ''IDEXCOMCLS'' order by ordernum', null, 1, 'pmkpi');

update Bus_t_Diccolumn t set t.csid = 'INDEXSTANDARDS' where t.tablecode = 'BAS_PERF_INDICATOR' and t.COLUMNCODE = 'INDEXSTANDARDS';

delete FROM Fasp_t_Dicdssource t where t.elementcode = 'PMKPIFRAME';

insert into Fasp_t_Dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('PMKPIFRAME', 'PMKPIFRAME', 'PMKPIFRAME', '共性指标层次分类', '1', '20190508135902672', '20161208', null, '2016', '87', null, null, null, '2', 'select t.guid,code,name ,t.superid superguid,t.levelno levelno,t.isleaf isleaf,t.status,t.frametype from v_perf_t_frame t', sysdate, 1, 'pmkpi');

update P#Busfw_t_Uieditform t set t.type = 's' where t.key = '/pmkpi/indexlib/edit' and t.columncode in ('INDUSTRYCATEGORY','INDEXCATEGORIES','');
