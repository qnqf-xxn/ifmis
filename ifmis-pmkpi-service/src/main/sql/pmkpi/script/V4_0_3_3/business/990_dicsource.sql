begin
  
--自评指标，实际完成值数据源
delete from fasp_t_dicdssource t where t.guid='PMKPISELFINDEXVAL';
insert into fasp_t_dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('PMKPISELFINDEXVAL', 'PMKPISELFINDEXVAL', 'PMKPISELFINDEXVAL', '绩效自评指标完成情况', '1', '20180424221721795', '20180424', null, '2019', '653100', null, null, null, '2', 'select t.* from v_perf_enum t where t.elementcode=''PMKPISELFINDEXVAL'' order by ordernum', null, 1, 'pmkpi');
