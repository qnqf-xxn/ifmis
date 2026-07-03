begin

--更新监控审核类型-浙江
update bus_T_diccolumn set csid = 'perfconreview' where tablecode = 'PERF_T_PROMONITOR' and dbcolumncode = 'AUDITTYPE'


delete from fasp_t_dicdssource a where a.guid in('perfconreview');
insert into fasp_t_dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('perfconreview', 'perfconreview', 'perfconreview', '监控审核类型', '1', null, null, null, '2016', '87', null, null, null, '2', 'SELECT * FROM perf_t_datasource t where t.elementcode=''perfconreview'' order by t.ordernum', null, 1, 'pmkpi');
