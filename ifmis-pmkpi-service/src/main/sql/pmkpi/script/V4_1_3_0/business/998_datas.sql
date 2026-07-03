begin
  
delete from fasp_t_dicdssource t where t.guid in('PERFYEAR','PERFENDVALTYPE','INDEXSTANDARDS','PERFENDVALTYPE');
insert into fasp_t_dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('INDEXSTANDARDS', 'INDEXSTANDARDS', 'INDEXSTANDARDS', '行业标准', '1', '20240722000000000', '20240722000000000', null, '2020', '87', null, null, '1', '2', 'select * from v_perf_enum where elementcode = ''INDEXSTANDARDS'' order by ordernum', sysdate, 1, 'pmkpi');

insert into fasp_t_dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('PERFENDVALTYPE', 'PERFENDVALTYPE', 'PERFENDVALTYPE', '完成值取值方式', '1', '20240722000000000', '20240722000000000', null, '2020', '87', null, null, '1', '2', 'select * from v_perf_enum where elementcode = ''PERFENDVALTYPE'' order by ordernum', sysdate, 1, 'pmkpi');

insert into fasp_t_dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('PERFYEAR', 'PERFYEAR', 'PERFYEAR', '年度', '1', null, null, null, '2016', '87', null, null, null, '2', 'SELECT t.* FROM perf_t_datasource t where t.elementcode=''PERFYEAR'' order by t.ordernum', sysdate, 1, 'pmkpi');

delete from perf_t_datasource t where t.elementcode='PERFYEAR';
insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('2024', '2024', '2024年', null, '0', 1, 1, 1, 'PERFYEAR', 1, '20201204', '20201204', 2016, '87');

insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('2025', '2025', '2025年', null, '0', 1, 1, 2, 'PERFYEAR', 1, '20201204', '20201204', 2016, '87');

insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('2026', '2026', '2026年', null, '0', 1, 1, 3, 'PERFYEAR', 1, '20201204', '20201204', 2016, '87');

insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('2027', '2027', '2027年', null, '0', 1, 1, 4, 'PERFYEAR', 1, '20201204', '20201204', 2016, '87');

insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('2028', '2028', '2028年', null, '0', 1, 1, 5, 'PERFYEAR', 1, '20201204', '20201204', 2016, '87');
