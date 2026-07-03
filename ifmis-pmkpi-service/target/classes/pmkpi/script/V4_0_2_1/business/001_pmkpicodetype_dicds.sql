begin

--数据源脚本修改
delete from fasp_t_dicdssource where guid = 'PMKPI_CODETYPE';
insert into fasp_t_dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('PMKPI_CODETYPE', 'PMKPI_CODETYPE', 'PMKPI_CODETYPE', '字段类型', '1', '20151015095618892', '20151015', null, '2016', '87', null, null, null, '2', 'SELECT * FROM perf_t_datasource t where t.elementcode=''PMKPI_CODETYPE'' order by t.ordernum
', null, 1, 'pmkpi');

--数据源枚举修改
delete from perf_t_datasource where elementcode='PMKPI_CODETYPE';
insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('s', 's', 's', null, '1', null, null, 1, 'PMKPI_CODETYPE', 1, '20201229', '20201229', 2016, '87');
insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('tree', 'tree', 'tree', null, '1', null, null, 2, 'PMKPI_CODETYPE', 1, '20201229', '20201229', 2016, '87');
insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('amt', 'amt', 'amt', null, '1', null, null, 3, 'PMKPI_CODETYPE', 1, '20201229', '20201229', 2016, '87');
insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('i', 'i', 'i', null, '1', null, null, 4, 'PMKPI_CODETYPE', 1, '20201229', '20201229', 2016, '87');
insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('f', 'f', 'f', null, '1', null, null, 5, 'PMKPI_CODETYPE', 1, '20201229', '20201229', 2016, '87');
insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('d', 'd', 'd', null, '1', null, null, 6, 'PMKPI_CODETYPE', 1, '20201229', '20201229', 2016, '87');
insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('n', 'n', 'n', null, '1', null, null, 8, 'PMKPI_CODETYPE', 1, '20201229', '20201229', 2016, '87');



