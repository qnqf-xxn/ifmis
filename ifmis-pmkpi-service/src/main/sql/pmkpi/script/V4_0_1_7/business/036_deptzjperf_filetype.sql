begin
delete FROM perf_filetype t where t.bustype = 'deptzjperformance';
insert into perf_filetype (GUID, CODE, NAME, REMARK, SUPERID, LEVELNO, ISLEAF, ORDERNUM, STATUS, BUSTYPE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('036A13D3883A4B0785B823ECA924F67A', '001', '项目申报附件', null, '#', 1, 0, 1, 1, 'deptzjperformance', null, null, 2016, '87');

insert into perf_filetype (GUID, CODE, NAME, REMARK, SUPERID, LEVELNO, ISLEAF, ORDERNUM, STATUS, BUSTYPE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('036A13D3883A4BABCVB823ECA924F67A', '001001', '附件材料', null, '036A13D3883A4B0785B823ECA924F67A', 2, 1, 2, 1, 'deptzjperformance', null, null, 2016, '87');
