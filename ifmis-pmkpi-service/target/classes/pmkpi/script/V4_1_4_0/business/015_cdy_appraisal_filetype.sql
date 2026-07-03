begin
  
delete from perf_filetype a where a.bustype='appraisalfile';
insert into perf_filetype (GUID, CODE, NAME, REMARK, SUPERID, LEVELNO, ISLEAF, ORDERNUM, STATUS, BUSTYPE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('fileguid1appraisalfile', '001001', '基础工作', null, 'fileguid0appraisalfile', 2, 1, 2, 1, 'appraisalfile', null, null, 2016, '87');

insert into perf_filetype (GUID, CODE, NAME, REMARK, SUPERID, LEVELNO, ISLEAF, ORDERNUM, STATUS, BUSTYPE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('fileguid2appraisalfile', '001002', '事前绩效评估', null, 'fileguid0appraisalfile', 2, 1, 3, 1, 'appraisalfile', null, null, 2016, '87');

insert into perf_filetype (GUID, CODE, NAME, REMARK, SUPERID, LEVELNO, ISLEAF, ORDERNUM, STATUS, BUSTYPE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('fileguid3appraisalfile', '001003', '绩效目标管理', null, 'fileguid0appraisalfile', 2, 1, 4, 1, 'appraisalfile', null, null, 2016, '87');

insert into perf_filetype (GUID, CODE, NAME, REMARK, SUPERID, LEVELNO, ISLEAF, ORDERNUM, STATUS, BUSTYPE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('fileguid4appraisalfile', '001004', '绩效运行监控', null, 'fileguid0appraisalfile', 2, 1, 5, 1, 'appraisalfile', null, null, 2016, '87');

insert into perf_filetype (GUID, CODE, NAME, REMARK, SUPERID, LEVELNO, ISLEAF, ORDERNUM, STATUS, BUSTYPE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('fileguid5appraisalfile', '001005', '绩效评价管理', null, 'fileguid0appraisalfile', 2, 1, 6, 1, 'appraisalfile', null, null, 2016, '87');

insert into perf_filetype (GUID, CODE, NAME, REMARK, SUPERID, LEVELNO, ISLEAF, ORDERNUM, STATUS, BUSTYPE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('fileguid6appraisalfile', '001006', '评价结果应用', null, 'fileguid0appraisalfile', 2, 1, 7, 1, 'appraisalfile', null, null, 2016, '87');

insert into perf_filetype (GUID, CODE, NAME, REMARK, SUPERID, LEVELNO, ISLEAF, ORDERNUM, STATUS, BUSTYPE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('fileguid7appraisalfile', '001007', '绩效信息公开', null, 'fileguid0appraisalfile', 2, 1, 8, 1, 'appraisalfile', null, null, 2016, '87');

insert into perf_filetype (GUID, CODE, NAME, REMARK, SUPERID, LEVELNO, ISLEAF, ORDERNUM, STATUS, BUSTYPE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('fileguid8appraisalfile', '001008', '绩效管理工作亮点', null, 'fileguid0appraisalfile', 2, 1, 9, 1, 'appraisalfile', null, null, 2016, '87');

insert into perf_filetype (GUID, CODE, NAME, REMARK, SUPERID, LEVELNO, ISLEAF, ORDERNUM, STATUS, BUSTYPE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('fileguid0appraisalfile', '001', '绩效考核', null, '#', 1, 0, 1, 1, 'appraisalfile', null, null, 2016, '87');
