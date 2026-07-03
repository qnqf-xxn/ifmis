begin

delete from perf_t_datasource t where t.elementcode in('perftask','taskstage');

insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE, ORDERNUM)
values ('trace', '01', '运行监控', null, '00', 1, 0, 'perftask', 1, '20201204', '20201204', 2020, '87', 1);

insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE, ORDERNUM)
values ('protrace', '0101', '项目支出', null, 'trace', 2, 1, 'perftask', 1, '20201204', '20201204', 2020, '87', 2);

insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE, ORDERNUM)
values ('policytrace', '0102', '重大政策', null, 'trace', 2, 1, 'perftask', 1, '20201204', '20201204', 2020, '87', 3);

insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE, ORDERNUM)
values ('depttrace', '0103', '部门整体', null, 'trace', 2, 1, 'perftask', 1, '20201204', '20201204', 2020, '87', 4);

insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE, ORDERNUM)
values ('evaluate', '02', '事后评价', null, '00', 1, 0, 'perftask', 1, '20201204', '20201204', 2020, '87', 5);

insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE, ORDERNUM)
values ('proevaluate', '0201', '项目支出', null, 'evaluate', 2, 1, 'perftask', 1, '20201204', '20201204', 2020, '87', 6);

insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE, ORDERNUM)
values ('policyevaluate', '0202', '重大政策', null, 'evaluate', 2, 1, 'perftask', 1, '20201204', '20201204', 2020, '87', 7);

insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE, ORDERNUM)
values ('deptevaluate', '0203', '部门整体', null, 'evaluate', 2, 1, 'perftask', 1, '20201204', '20201204', 2020, '87', 8);

insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE, ORDERNUM)
values ('govevaluate', '0204', '政府绩效', null, 'evaluate', 2, 1, 'perftask', 1, '20201204', '20201204', 2020, '87', 9);

insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE, ORDERNUM)
values ('1', '1', '1~1月', null, null, null, null, 'taskstage', 1, '20201204', '20201204', 2020, '87', 1);

insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE, ORDERNUM)
values ('2', '2', '1~2月', null, null, null, null, 'taskstage', 1, '20201204', '20201204', 2020, '87', 2);

insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE, ORDERNUM)
values ('3', '3', '1~3月', null, null, null, null, 'taskstage', 1, '20201204', '20201204', 2020, '87', 3);

insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE, ORDERNUM)
values ('4', '4', '1~4月', null, null, null, null, 'taskstage', 1, '20201204', '20201204', 2020, '87', 4);

insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE, ORDERNUM)
values ('5', '5', '1~5月', null, null, null, null, 'taskstage', 1, '20201204', '20201204', 2020, '87', 5);

insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE, ORDERNUM)
values ('6', '6', '1~6月', null, null, null, null, 'taskstage', 1, '20201204', '20201204', 2020, '87', 6);

insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE, ORDERNUM)
values ('7', '7', '1~7月', null, null, null, null, 'taskstage', 1, '20201204', '20201204', 2020, '87', 7);

insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE, ORDERNUM)
values ('8', '8', '1~8月', null, null, null, null, 'taskstage', 1, '20201204', '20201204', 2020, '87', 8);

insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE, ORDERNUM)
values ('9', '9', '1~9月', null, null, null, null, 'taskstage', 1, '20201204', '20201204', 2020, '87', 9);

insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE, ORDERNUM)
values ('10', '10', '1~10月', null, null, null, null, 'taskstage', 1, '20201204', '20201204', 2020, '87', 10);

insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE, ORDERNUM)
values ('11', '11', '1~11月', null, null, null, null, 'taskstage', 1, '20201204', '20201204', 2020, '87', 11);

insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE, ORDERNUM)
values ('12', '12', '1~12月', null, null, null, null, 'taskstage', 1, '20201204', '20201204', 2020, '87', 12);

