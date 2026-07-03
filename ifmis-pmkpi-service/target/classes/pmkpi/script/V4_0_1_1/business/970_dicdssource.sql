begin

DELETE FROM perf_t_datasource t where t.elementcode='traceaudittype';
insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('2', '001', '委托第三方', null, null, null, null, 1, 'traceaudittype', 1, '20201229', '20201229', 2020, '87');

insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('1', '002', '通过', null, null, null, null, 2, 'traceaudittype', 1, '20201229', '20201229', 2020, '87');

insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('3', '003', '退回', null, null, null, null, 3, 'traceaudittype', 1, '20201229', '20201229', 2020, '87');

