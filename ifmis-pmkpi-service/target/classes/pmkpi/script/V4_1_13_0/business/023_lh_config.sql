begin



delete from perf_t_datasource t where t.guid='deptscore';
insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('deptscore', '002005', '本级部门绩效考核', null, 'workscore', 1, 1, 8, 'scoretype', 1, '20201204', '20201204', 2020, '87');




