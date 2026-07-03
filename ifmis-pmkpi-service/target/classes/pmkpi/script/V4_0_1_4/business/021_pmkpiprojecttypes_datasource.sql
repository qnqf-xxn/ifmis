begin
--枚举表-不分区划
delete from perf_t_datasource where ELEMENTCODE = 'PMKPIPROJECTTYPES';
insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE)
values ('1', '1', '人员类', null, null, 1, 0, 1, 'PMKPIPROJECTTYPES');

insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE)
values ('2', '2', '运转类', null, null, 1, 0, 2, 'PMKPIPROJECTTYPES');

insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE)
values ('21', '21', '共用经费', null, '2', 2, 1, 3, 'PMKPIPROJECTTYPES');

insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE)
values ('22', '22', '其它运转类', null, '2', 2, 1, 4, 'PMKPIPROJECTTYPES');

insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE)
values ('3', '3', '特定目标类', null, null, 1, 0, 5, 'PMKPIPROJECTTYPES');

--数据源注册
delete from fasp_t_dicdssource where elementcode = 'PMKPIPROJECTTYPES';
insert into fasp_t_dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('PMKPIPROJECTTYPES', 'PMKPIPROJECTTYPES', 'PMKPIPROJECTTYPES', '支出项目类别', '1', '20210901113621631', '20150901', null, '2016', '87', null, null, null, '2', 'select t.* from perf_t_datasource t where t.elementcode=''PMKPIPROJECTTYPES'' order by ordernum', null, 1, 'pmkpi');
