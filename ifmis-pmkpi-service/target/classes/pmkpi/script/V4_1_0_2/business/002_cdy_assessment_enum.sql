begin

delete from perf_enum t where elementcode = 'PERFASSESSMENTTYPE';
insert into v_perf_enum (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE, VERSION, APPID, SUPERID, LEVELNO, ISLEAF, REMARK, CREATER, ORDERNUM, SUPERGUID)
values ('program', '01', 'PERFASSESSMENTTYPE', '项目类', '1', null, null, '2016', '87', null, 'pmkpi', '0', 1, 1, null, null, 1, '0');

insert into v_perf_enum (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE, VERSION, APPID, SUPERID, LEVELNO, ISLEAF, REMARK, CREATER, ORDERNUM, SUPERGUID)
values ('policy', '02', 'PERFASSESSMENTTYPE', '政策类', '1', null, null, '2016', '87', null, 'pmkpi', '0', 1, 1, null, null, 2, '0');
