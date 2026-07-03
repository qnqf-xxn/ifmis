begin
  --监控审核页面  附件类型
delete from perf_filetype where bustype ='traceaudit';
insert into perf_filetype (GUID, CODE, NAME, REMARK, SUPERID, LEVELNO, ISLEAF, ORDERNUM, STATUS, BUSTYPE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('EBC360C187D273DCE0533315A8C0CDA4', '001', '监控审核附件', null, '#', 1, 0, 1, 1, 'traceaudit', null, null, 2016, '87');

insert into perf_filetype (GUID, CODE, NAME, REMARK, SUPERID, LEVELNO, ISLEAF, ORDERNUM, STATUS, BUSTYPE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('EBC360C187D373DCE0533315A8C0CDA4', '001001', '附件材料', null, 'EBC360C187D273DCE0533315A8C0CDA4', 2, 1, 2, 1, 'traceaudit', null, null, 2016, '87');

