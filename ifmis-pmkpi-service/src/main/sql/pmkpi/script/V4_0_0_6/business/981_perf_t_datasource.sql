begin

--项目绩效监控数据来源
delete from perf_t_datasource t where t.elementcode in('dviationanalysis','indexval','completeanalysis');

delete from perf_t_datasource t where t.elementcode in('datatype');

insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('dviationanalysis1', '1', '人员原因', null, null, null, null, 1, 'dviationanalysis', 1, '20201229', '20201229', 2020, '87');

insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('dviationanalysis2', '2', '制度原因', null, null, null, null, 2, 'dviationanalysis', 1, '20201229', '20201229', 2020, '87');

insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('dviationanalysis3', '3', '经费原因', null, null, null, null, 3, 'dviationanalysis', 1, '20201229', '20201229', 2020, '87');

insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('dviationanalysis10', '10', '其他原因', null, null, null, null, 10, 'dviationanalysis', 1, '20201229', '20201229', 2020, '87');

insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('completeanalysis1', '1', '确定能', null, null, null, null, 1, 'completeanalysis', 1, '20201224', '20201224', 2020, '87');

insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('completeanalysis2', '2', '有可能', null, null, null, null, 2, 'completeanalysis', 1, '20201224', '20201224', 2020, '87');

insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('completeanalysis3', '3', '完全不可能', null, null, null, null, 3, 'completeanalysis', 1, '20201224', '20201224', 2020, '87');

insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('达成目标', '1', '达成目标', null, null, null, null, 1, 'indexval', 1, '20201224', '20201224', 2020, '87');

insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('部分达成目标并具有一定效果', '2', '部分达成目标并具有一定效果', null, null, null, null, 2, 'indexval', 1, '20201224', '20201224', 2020, '87');

insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('未达成目标且效果较差', '3', '未达成目标且效果较差', null, null, null, null, 3, 'indexval', 1, '20201224', '20201224', 2020, '87');

insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('1', '1', '删除', null, null, null, null, 1, 'datatype', 1, '20210127', '20210127', 2021, '87');

insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('2', '2', '修改', null, null, null, null, 2, 'datatype', 1, '20210127', '20210127', 2021, '87');

insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('3', '3', '新增', null, null, null, null, 3, 'datatype', 1, '20210127', '20210127', 2021, '87');
