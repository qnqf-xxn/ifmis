begin 

delete from perf_t_datasource where elementcode = 'perfconreview';
insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('1', '001', '项目各年度整改', null, null, null, null, 1, 'perfconreview', 1, '20201229', '20201229', 2016, '87');
insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('2', '002', '项目预算调整', null, null, null, null, 2, 'perfconreview', 1, '20201229', '20201229', 2016, '87');
insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('3', '003', '项目暂停拨款', null, null, null, null, 3, 'perfconreview', 1, '20201229', '20201229', 2016, '87');
insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('4', '003', '项目暂缓实施', null, null, null, null, 4, 'perfconreview', 1, '20201229', '20201229', 2016, '87');
insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('5', '003', '项目无问题', null, null, null, null, 5, 'perfconreview', 1, '20201229', '20201229', 2016, '87');
