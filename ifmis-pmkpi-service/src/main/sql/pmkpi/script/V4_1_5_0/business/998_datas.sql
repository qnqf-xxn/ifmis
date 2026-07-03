begin
  
delete from fasp_t_dicdssource t where t.guid in('PERFINDEXSUMTYPE');
insert into fasp_t_dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('PERFINDEXSUMTYPE', 'PERFINDEXSUMTYPE', 'PERFINDEXSUMTYPE', '绩效指标汇总方式', '1', '20240722000000000', '20240722000000000', null, '2020', '87', null, null, '1', '2', 'SELECT t.* FROM perf_t_datasource t where t.elementcode=''PERFINDEXSUMTYPE'' order by t.ordernum', sysdate, 1, 'pmkpi');

delete from perf_t_datasource t where t.elementcode='PERFINDEXSUMTYPE';
insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('1', '1', '相加', null, '0', 1, 1, 1, 'PERFINDEXSUMTYPE', 1, '20201204', '20201204', 2016, '87');

insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('2', '2', '不相加', null, '0', 1, 1, 2, 'PERFINDEXSUMTYPE', 1, '20201204', '20201204', 2016, '87');

insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('3', '3', '叠加', null, '0', 1, 1, 3, 'PERFINDEXSUMTYPE', 1, '20201204', '20201204', 2016, '87');

insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('4', '4', '加权相加', null, '0', 1, 1, 4, 'PERFINDEXSUMTYPE', 1, '20201204', '20201204', 2016, '87');

--问题整改情况反馈-项目库查看
delete from perf_t_pagemenu t where t.uikey='/pmkpi/rectification/programquery';
insert into perf_t_pagemenu (GUID, CODE, NAME, UIKEY, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, STATUS, CREATETIME, UPDATETIME, CREATER, PROVINCE, YEAR)
values ('156B3D9078D5ED60321B9F9A99C85BF5', '1', '整改情况明细（项目库查看）', '/pmkpi/rectification/programquery', 'D64BACE27CB268B8E0533315A8C0D95E', 4, 1, 1, 1, '20241018133750', '20241018133750', '2ABB1E119E395E6EEC48EFA9D6ABB0CD', '87', '2016');
